package com.somg.web.image.generator;

import com.somg.web.image.generator.cloud.storage.abs.auto.OssProperties;
import com.somg.web.image.generator.cloud.storage.abs.auto.QiniuProperties;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;

@SpringBootApplication
@EnableGlobalMethodSecurity(prePostEnabled = true, securedEnabled = true)
public class WebImageGeneratorApplication {

    public static void main(String[] args) {
        SpringApplication.run(WebImageGeneratorApplication.class, args);
    }

}
