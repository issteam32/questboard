package com.questboard.user.service;

import com.questboard.user.dto.UserRegistrationDto;
import com.questboard.user.entity.User;
import com.questboard.user.repository.UserRepository;
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

import javax.ws.rs.core.Response;
import java.util.List;

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

    @Value("${keycloak.client-id}")
    private String clientId;

    @Value("${keycloak.authorization-grant-type}")
    private String grantType;

    @Value("${keycloak.client-secret}")
    private String clientSecret;

    @Value("${keycloak.scope}")
    private String scope;

    @Value("${keycloak.redirect-uri}")
    private String redirectUri;

    @Value("${keycloak.server-uri}")
    private String keycloakServerUri;

    @Value("${keycloak.realm}")
    private String keycloakRealm;

    @Value("${keycloak.register-user-uri}")
    private String keycloakRegisterUserUri;

    @Value("${keycloak.super-username}")
    private String keycloakSuperUsername;

    @Value("${keycloak.super-password}")
    private String keycloakSuperPassword;

    @Value("${keycloak.admin-cli-id}")
    private String keycloakAdminCliClientId;

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    /**
     * login request fire from mobile client to keycloak
     * @param username username
     * @param password password
     * @return access_token
     */
    public Mono<String> login(String username, String password) {
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
     * @param username username
     * @param password password
     * @return access_token
     */
    public Mono<AccessTokenResponse> loginSecure(String username, String password) throws HttpClientErrorException {
        Keycloak keycloak = KeycloakBuilder.builder().serverUrl(keycloakServerUri)
                .realm(keycloakRealm)
                .username(username)
                .password(password)
                .clientId(clientId)
                .clientSecret(clientSecret)
                .build();
        AccessTokenResponse accessToken = keycloak.tokenManager().getAccessToken();
        return Mono.just(accessToken);
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
     * @param userDto
     * @return true / false
     */
    public Mono<Boolean> registerUser(UserRegistrationDto userDto) {
        String realm = keycloakRealm;
        String superUser = keycloakSuperUsername;
        String superPassword = keycloakSuperPassword;
        String adminCliClientId = keycloakAdminCliClientId;
        Keycloak keycloakRealm = Keycloak.getInstance(keycloakServerUri, realm, superUser, superPassword, adminCliClientId);
        UsersResource usersResource = keycloakRealm.realm(realm).users();

        try {
            UserRepresentation userRepresentation = new UserRepresentation();
            userRepresentation.setUsername(userDto.getUserName());
            userRepresentation.setEmail(userDto.getEmail());

            if (!userDto.getPassword().equals(userDto.getPasswordConfirm())) {
                throw new Exception("Password does not match!");
            }
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

            if (response.getStatus() == 201) {
                User user = new User();
                user.setUserName(userDto.getUserName());
                user.setEmail(userDto.getEmail());
                user.setRegisterType(1);
                user.setActive(true);
                if (userResource != null) {
                    if (userResource.toRepresentation() != null) {
                        user.setSsoUid(userResource.toRepresentation().getId());
                    }
                }
                this.userRepo.save(user).subscribe();
            }

            return Mono.just(true);
        } catch (Exception e) {
            logger.error("Error while creating user " + e.getMessage());
            return Mono.error(e);
        }
    }

}
