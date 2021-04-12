package com.questboard.quest.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

import java.util.Objects;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {
    @Autowired
    private Environment env;

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        String jwkSetUri = Objects.requireNonNull(env.getProperty("OAUTH2SERVER_JWKURI"));
        System.out.println("################## user env variable ###################");
        System.out.println(jwkSetUri);
        System.out.println("################## user env variable ###################");
        http.cors()
                .and()
                .authorizeRequests(authorize -> authorize.anyRequest().authenticated())
                .oauth2ResourceServer(oauth2 ->
                        oauth2.jwt(jwt ->
                                jwt.jwkSetUri(jwkSetUri)));
//                                jwt.jwkSetUri("http://192.168.49.1:8090/auth/realms/Questboard/protocol/openid-connect/certs")));
    }
}
