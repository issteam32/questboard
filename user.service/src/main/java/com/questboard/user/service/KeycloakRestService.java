package com.questboard.user.service;

import com.questboard.user.dto.UserRegistrationDto;
import com.questboard.user.dto.UserUpdateDto;
import com.questboard.user.entity.User;
import com.questboard.user.repository.UserRepository;
import org.apache.commons.codec.binary.StringUtils;
import org.keycloak.admin.client.Keycloak;
import org.keycloak.admin.client.KeycloakBuilder;
import org.keycloak.admin.client.resource.UserResource;
import org.keycloak.admin.client.resource.UsersResource;

import org.keycloak.representations.AccessToken;
import org.keycloak.representations.AccessTokenResponse;
import org.keycloak.representations.idm.CredentialRepresentation;
import org.keycloak.representations.idm.UserRepresentation;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.env.Environment;
import org.springframework.data.domain.Example;
import org.springframework.data.domain.ExampleMatcher;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.reactive.function.BodyInserter;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.Exceptions;
import reactor.core.publisher.Mono;
import reactor.core.scheduler.Scheduler;
import reactor.core.scheduler.Schedulers;

import javax.ws.rs.NotAuthorizedException;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Response;
import java.util.HashMap;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.CompletableFuture;

import static org.springframework.data.domain.ExampleMatcher.GenericPropertyMatchers.ignoreCase;

@Service
public class KeycloakRestService {

    @Autowired
    private UserRepository userRepo;

    @Value("${keycloak.token-uri}")
    private String keycloakTokenUri;

    @Value("${keycloak.user-info-uri}")
    private String keycloakUserInfo;

    @Value("${keycloak.logout}")
    private String keycloakLogout;

    @Value("${keycloak.authorization-grant-type}")
    private String grantType;

    @Value("${keycloak.scope}")
    private String scope;

    @Value("${keycloak.redirect-uri}")
    private String redirectUri;

    @Value("${keycloak.register-user-uri}")
    private String keycloakRegisterUserUri;

    @Value("${keycloak.admin-cli-id}")
    private String keycloakAdminCliClientId;

    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private Environment env;
    /**
     * login request fire from mobile client to keycloak
     *
     * @param username username
     * @param password password
     * @return access_token
     */
    public Mono<String> login(String username, String password) {
        String clientId = env.getProperty("KEYCLOAK_CLIENT_ID");
        String clientSecret = env.getProperty("KEYCLOAK_CLIENT_SECRET");
        MultiValueMap<String, String> formMap = new LinkedMultiValueMap<>();
        formMap.add("username", username);
        formMap.add("password", password);
        formMap.add("client_id", clientId);
        formMap.add("client_secret", clientSecret);
        formMap.add("grant_type", grantType);
        formMap.add("scope", scope);

        logger.info("formMap: " + formMap);

        return WebClient.create(keycloakTokenUri).post()
                .contentType(MediaType.APPLICATION_FORM_URLENCODED)
                .body(BodyInserters.fromFormData(formMap))
                .retrieve()
                .bodyToMono(String.class);
    }

    /**
     * login user and get access token thru keycloak admin rest api
     *
     * @param username username
     * @param password password
     * @return access_token
     */
    public Mono<AccessTokenResponse> loginSecure(String username, String password) {
        try {
            String keycloakServerUri = env.getProperty("KEYCLOAK_URI");
            String realm = env.getProperty("KEYCLOAK_REALM");
            String superUser = env.getProperty("KEYCLOAK_ADMIN_USERNAME");
            String superPassword = env.getProperty("KEYCLOAK_ADMIN_PASSWORD");
            String adminCliClientId = "admin-cli";
            String clientId = env.getProperty("KEYCLOAK_CLIENT_ID");
            String clientSecret = env.getProperty("KEYCLOAK_CLIENT_SECRET");
            Keycloak keycloak = KeycloakBuilder.builder().serverUrl(keycloakServerUri)
                    .realm(realm)
                    .username(username)
                    .password(password)
                    .clientId(clientId)
                    .clientSecret(clientSecret)
                    .build();
            AccessTokenResponse accessToken = keycloak.tokenManager().getAccessToken();
            return Mono.just(accessToken);
        } catch (NotAuthorizedException err) {
            logger.error("Unauthorized access: " + err.getMessage());
            err.printStackTrace();
            return Mono.empty();
        } catch (Exception err) {
            logger.error("Unexpected error when login: " + err.getMessage());
            err.printStackTrace();
            return Mono.empty();
        }
    }


    /**
     * register new user to application
     * -----------------------------
     * | register type | desc      |
     * -----------------------------
     * | 1             | normal    |
     * | 2             | sso login |
     * -----------------------------
     * username cannot have special characters
     *
     * @param userDto
     * @return true / false
     */
    public Mono<Boolean> registerUser(UserRegistrationDto userDto) {
        return this.userRepo.existsUserByEmail(userDto.getEmail())
                .flatMap(emailExist -> {
                    logger.info("emailExist: " + emailExist);
                    if (!emailExist) {
                        return this.userRepo.existsUserByUserName(userDto.getUserName());
                    } else {
                        return Mono.just(false);
                    }
                })
                .map(userNameExist -> {
                    logger.info("userNameExist: " + userNameExist);
                    if (!userNameExist) {
                        return this.createKeycloakUser(userDto);
                    } else {
                        return Optional.empty();
                    }
                })
                .flatMap(userResource -> {
                    logger.info("userResource: " + userResource);
                    if (userResource.isPresent()) {
                        User user = new User();
                        user.setUserName(userDto.getUserName());
                        user.setEmail(userDto.getEmail());
                        user.setRegisterType(1);
                        user.setActive(true);
                        UserRepresentation userRs = ((UserResource) userResource.get()).toRepresentation();
                        if (userRs != null) {
                            user.setSsoUid(userRs.getId());
                        }
                        this.userRepo.save(user).subscribe();

                        return Mono.just(true);
                    } else {
                        return Mono.error(new Error("Username or email is already existed. Please check your form input."));
                    }
                });
    }

    private Optional<UserResource> createKeycloakUser(UserRegistrationDto userDto) {
        String keycloakServerUri = env.getProperty("KEYCLOAK_URI");
        String realm = env.getProperty("KEYCLOAK_REALM");
        String superUser = env.getProperty("KEYCLOAK_ADMIN_USERNAME");
        String superPassword = env.getProperty("KEYCLOAK_ADMIN_PASSWORD");
        String adminCliClientId = "admin-cli";
        Keycloak keycloakRealm = Keycloak.getInstance(keycloakServerUri, realm, superUser, superPassword, adminCliClientId);
        UsersResource usersResource = keycloakRealm.realm(realm).users();

        try {
            if (!userDto.getPassword().equals(userDto.getPasswordConfirm())) {
                throw new Exception("Password does not match!");
            }

            UserRepresentation userRepresentation = new UserRepresentation();
            userRepresentation.setUsername(userDto.getUserName());
            userRepresentation.setEmail(userDto.getEmail());

            CredentialRepresentation credentialRepresentation = new CredentialRepresentation();
            credentialRepresentation.setType("password");
            credentialRepresentation.setValue(userDto.getPassword());
            userRepresentation.setCredentials(List.of(credentialRepresentation));
            userRepresentation.setEnabled(true);
            Response response = usersResource.create(userRepresentation);
            logger.info("Keycloak register user response |  Status: {} | Status Info: {}",
                    response.getStatus(),
                    response.getStatusInfo());

            String userKeycloakId = response.getLocation().getPath().replaceAll(".*/([^/]+)$", "$1");
            UserResource userResource = usersResource.get(userKeycloakId);
            if (response.getStatus() >= 200 && response.getStatus() <= 299) {
                return Optional.of(userResource);
            } else {
                throw new Exception("Unable to create new keycloak user, please check the input format");
            }
        } catch (Exception e) {
            logger.error("Error when creating keycloak user: " + e.getMessage());
            e.printStackTrace();
            return Optional.empty();
        }
    }

    public Mono<Boolean> updateUser(UserUpdateDto userDto) {
        logger.info("userDto" + userDto);
        return this.userRepo.findById(userDto.getId())
                .flatMap(user -> {
                    if (user != null) {
                        if (userDto.getEmail() != null) {
                            user.setEmail(userDto.getEmail());
                        }
                        if (userDto.getUpdateActiveStatus()) {
                            user.setActive(userDto.getActive());
                        }
                        this.userRepo.save(user).subscribe();
                        return Mono.just(true);
                    } else {
                        return Mono.just(false);
                    }
                })
                .flatMap(updated -> {
                    if (updated != null) {
                        userDto.setSsoUid(userDto.getSsoUid());
                        return this.updateKeycloakUser(userDto);
                    } else {
                        return Mono.error(new Error("User not found!"));
                    }
                });
    }

    private Mono<Boolean> updateKeycloakUser(UserUpdateDto userDto) {
        String keycloakServerUri = env.getProperty("KEYCLOAK_URI");
        String realm = env.getProperty("KEYCLOAK_REALM");
        String superUser = env.getProperty("KEYCLOAK_ADMIN_USERNAME");
        String superPassword = env.getProperty("KEYCLOAK_ADMIN_PASSWORD");
        String adminCliClientId = "admin-cli";
        Keycloak keycloakRealm = Keycloak.getInstance(keycloakServerUri, realm, superUser, superPassword, adminCliClientId);
        UsersResource usersResource = keycloakRealm.realm(realm).users();

        try {
            UserResource userResource = usersResource.get(userDto.getSsoUid());
            logger.info("userResource" + userResource);
            if (userResource != null) {
                UserRepresentation userRepresentation = userResource.toRepresentation();
                if (userDto.getPassword() != null && userDto.getPasswordConfirm() != null &&
                        userDto.getPasswordConfirm().equals(userDto.getPassword())) {
                    CredentialRepresentation credentialRepresentation = new CredentialRepresentation();
                    credentialRepresentation.setType("password");
                    credentialRepresentation.setValue(userDto.getPassword());
                    userResource.resetPassword(credentialRepresentation);
                }
                if (userDto.getEmail() != null) {
                    userRepresentation.setEmail(userDto.getEmail());
                }
                if (userDto.getUpdateActiveStatus()) {
                    userRepresentation.setEnabled(userDto.getActive());
                }
                userResource.update(userRepresentation);

                return Mono.just(true);
            } else {
                return Mono.error(new Error("Cannot get user from keycloak with uid: " + userDto.getSsoUid()));
            }
        } catch (Exception err) {
            logger.error("Error when updating user in keycloak: " + err.getMessage());
            err.printStackTrace();
            return Mono.error(new Error(err.getMessage()));
        }
    }

}
