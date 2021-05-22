package com.questboard.rs;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cache.annotation.EnableCaching;

@SpringBootApplication
@EnableCaching
public class RsApplication {

	public static void main(String[] args) {
		SpringApplication.run(RsApplication.class, args);
	}

}
