package com.questboard.quest.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

@Configuration
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    protected void configure(HttpSecurity http) throws Exception {
        http.cors()
                .and()
//                .authorizeRequests()
//                .antMatchers(HttpMethod.GET, "/api/q/v1/**")
//                .hasAuthority("SCOPE_read")
//                .antMatchers(HttpMethod.PUT, "/api/q/v1/**")
//                .hasAuthority("SCOPE_write")
//                .antMatchers(HttpMethod.POST, "/api/foos")
//                .hasAuthority("SCOPE_write")
//                .antMatchers(HttpMethod.DELETE, "/api/q/v1/**")
//                .hasAuthority("SCOPE_write")
//                .anyRequest()
//                .authenticated()
//                .and()
                .oauth2ResourceServer()
                .jwt();
    }
}
