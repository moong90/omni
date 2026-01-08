package com.brave.thebrave;

import com.ulisesbocchio.jasyptspringboot.annotation.EnableEncryptableProperties;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;
import org.springframework.cache.annotation.EnableCaching;

@SpringBootApplication(exclude = { SecurityAutoConfiguration.class })
@EnableEncryptableProperties
@EnableCaching
public class ThebraveApplication {

	public static void main(String[] args) {
		SpringApplication.run(ThebraveApplication.class, args);
	}

}
