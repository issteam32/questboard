package com.questboard.user.config;

import io.r2dbc.spi.ConnectionFactories;
import io.r2dbc.spi.ConnectionFactory;
import io.r2dbc.spi.ConnectionFactoryOptions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;
import org.springframework.data.r2dbc.config.AbstractR2dbcConfiguration;
import org.springframework.data.r2dbc.repository.config.EnableR2dbcRepositories;

import java.util.Objects;

import static io.r2dbc.pool.PoolingConnectionFactoryProvider.MAX_SIZE;
import static io.r2dbc.spi.ConnectionFactoryOptions.*;

@Configuration
@EnableR2dbcRepositories
public class R2DBCConfig extends AbstractR2dbcConfiguration {

    @Autowired
    private Environment env;

    @Override
    @Bean
    public ConnectionFactory connectionFactory() {
        try {
            System.out.println("################## user env variable ###################");
            System.out.println(env.getProperty("USERSVC_DB_HOST"));
            System.out.println(env.getProperty("USERSVC_DB_PORT"));
            System.out.println(env.getProperty("USERSVC_DB_USER"));
            System.out.println(env.getProperty("USERSVC_DB_PASSWORD"));
            System.out.println(env.getProperty("USERSVC_DB_DATABASE"));
            System.out.println("################## user env variable ###################");
            return ConnectionFactories.get(ConnectionFactoryOptions.builder()
                    .option(DRIVER, "pool")
                    .option(PROTOCOL, "mysql")
                    .option(HOST, Objects.requireNonNull(env.getProperty("USERSVC_DB_HOST")))
                    .option(PORT, Integer.parseInt(Objects.requireNonNull(env.getProperty("USERSVC_DB_PORT"))))
                    .option(USER, Objects.requireNonNull(env.getProperty("USERSVC_DB_USER")))
                    .option(PASSWORD, Objects.requireNonNull(env.getProperty("USERSVC_DB_PASSWORD")))
                    .option(DATABASE, Objects.requireNonNull(env.getProperty("USERSVC_DB_DATABASE")))
                    .option(MAX_SIZE, 20)
                    .build());
        }
        catch (Exception e) {
            System.out.println("Environment variable not set");
            System.out.println(e.getMessage());
            return null;
        }
    }
}
