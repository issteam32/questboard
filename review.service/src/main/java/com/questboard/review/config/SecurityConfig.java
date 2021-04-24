package com.questboard.review.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;
import org.springframework.data.r2dbc.repository.config.EnableR2dbcRepositories;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

import java.util.Objects;

@Configuration
@EnableR2dbcRepositories
public class SecurityConfig extends WebSecurityConfigurerAdapter {
    @Autowired
    private Environment env;

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        String jwkSetUri = Objects.requireNonNull(env.getProperty("OAUTH2SERVER_JWKURI"));
        System.out.println("################## review env variable ###################");
        System.out.println(jwkSetUri);
        System.out.println("################## review env variable ###################");
        http.cors()
                .and()
                .csrf().disable()
                .authorizeRequests(authorize -> authorize
                        .antMatchers("/api/review/health-check").permitAll()
                        .antMatchers("/api/**").authenticated()
                )
                .oauth2ResourceServer(oauth2 ->
                        oauth2.jwt(jwt ->
                                jwt.jwkSetUri(jwkSetUri)));
    }
}
