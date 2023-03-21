package com.somg.web.file.generator.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * @author somg
 * @date 2023/1/17 10:54
 * @do 跨域配置
 */

@Configuration
public class CorsConfig implements WebMvcConfigurer {

    @Bean
    CorsConfigurationSource corsConfigurationSource() {

        CorsConfiguration configuration = new CorsConfiguration();

        configuration.addAllowedOriginPattern("*");//修改为添加而不是设置，* 最好改为实际的需要，我这是非生产配置，所以粗暴了一点

        configuration.addAllowedMethod("*");//修改为添加而不是设置

        configuration.addAllowedHeader("*");//这里很重要，起码需要允许 Access-Control-Allow-Origin

        configuration.setAllowCredentials(true);

        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();

        source.registerCorsConfiguration("/**", configuration);

        return source;

    }

}
