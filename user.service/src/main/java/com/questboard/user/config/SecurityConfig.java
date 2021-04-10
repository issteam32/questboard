package com.questboard.user.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.cors()
                .and()
                .csrf().disable()
                .authorizeRequests(authorize -> authorize
                        .antMatchers("/api/u/v1/user/register").permitAll()
                        .antMatchers("/api/u/v1/user/login").permitAll()
                        .antMatchers("/api/**").authenticated()
                )
                .oauth2ResourceServer(oauth2 ->
                        oauth2.jwt(jwt ->
                                jwt.jwkSetUri("keycloak-cluster-ip-svc/auth/realms/Questboard/protocol/openid-connect/certs")));
//                                jwt.jwkSetUri("http://192.168.49.1:8090/auth/realms/Questboard/protocol/openid-connect/certs")));
    }
}
