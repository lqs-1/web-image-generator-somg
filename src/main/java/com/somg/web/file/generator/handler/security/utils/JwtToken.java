package com.somg.web.file.generator.handler.security.utils;

import com.sun.istack.NotNull;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import java.util.Date;

/**
 * @author somg
 * @date 2023/3/18 15:34
 * @do JwtToken工具类
 */
@Component
@Data
@ConfigurationProperties("spring.somg.jwt.token")
public class JwtToken {

    // 设置token的盐(私钥)
    private String securityKey = "somg";

    // 设置过期时间 默认七天
    private long expireTime = 60*60*24*7*1000;


    /**
     * 根据usrName生成token
     * @param userName 用户名
     * @return
     */
    public String createToken(@NotNull String userName) {
        return Jwts.builder()
                .setExpiration(new Date(System.currentTimeMillis() + expireTime))
                .signWith(SignatureAlgorithm.HS256, securityKey)
                .setSubject(userName)
                .setIssuedAt(new Date()).compact();
    }

    /**
     * 根据token获取userName
     * @param token 前端传递的token
     * @return
     */
    public String parseUsernameFormToken(@NotNull String token) {
        return Jwts.parser().setSigningKey(securityKey).parseClaimsJws(token).getBody().getSubject();
    }
}
