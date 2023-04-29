package com.somg.web.file.generator.handler.security.utils;

import com.alibaba.fastjson.JSON;
import com.somg.web.file.generator.pojo.origin.User;
import com.sun.istack.NotNull;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import lombok.Data;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.HashMap;

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
    public long expireTime = 604800000l;

    // token串加密的是对象的时候的keyName
    public String objectKeyName = "tokenObj";

    // 距离过期30分钟内刷新
    public long refreshTime = 1800000l;

    // 认证token请求头的名字
    public String authHeaderName = "auth";// "Authentication";


    /**
     * 根据单字段生成token
     * @param singleParam 单字段数据
     * @return
     */
    public String createTokenSingleParamAsSub(@NotNull String singleParam) {
        return Jwts.builder()
                .setExpiration(new Date(System.currentTimeMillis() + expireTime))
                .signWith(SignatureAlgorithm.HS256, securityKey)
                .setSubject(singleParam)
                .setIssuedAt(new Date()).compact();
    }


    /**
     * 生成加密对象的token
     * @param obj
     * @return
     */
    public String createTokenObjectAsBody(@NotNull Object obj) {
        HashMap<String, Object> claims = new HashMap<>();
        claims.put(objectKeyName, obj);
        return Jwts.builder()
                .setExpiration(new Date(System.currentTimeMillis() + expireTime))
                .signWith(SignatureAlgorithm.HS256, securityKey)
                .setClaims(claims).compact();
    }

    /**
     * 判断是否刷新
     * @param token
     * @return
     */
    public Boolean refresh(String token){
        Date expiration = Jwts.parser().setSigningKey(securityKey).parseClaimsJws(token).getBody().getExpiration();
        return (expiration.getTime() - new Date().getTime()) <= refreshTime ? true : false;
    }

    /**
     * 刷新单字段token
     * @param token
     * @return
     */
    public String refreshSingleParamToken(String token){
        return createTokenSingleParamAsSub(Jwts.parser().setSigningKey(securityKey).parseClaimsJws(token).getBody().getSubject());
    }

    /**
     * 刷新对象token
     * @param token
     * @return
     */
    public String refreshObjectToken(String token){
        Object obj = Jwts.parser().setSigningKey(securityKey).parseClaimsJws(token).getBody().get(objectKeyName);
        return createTokenObjectAsBody(obj);
    }



    /**
     * 根据token获取单字段数据
     * @param token 前端传递的token
     * @return
     */
    public String parseSingleParamFormToken(@NotNull String token) {
        return Jwts.parser().setSigningKey(securityKey).parseClaimsJws(token).getBody().getSubject();
    }


    /**
     * 根据token获取被加密对象
     * @param token
     * @param type
     * @return
     * @param <T>
     */
    public <T> T parseObject(@NotNull String token, Class<T> type) {
        Object obj = Jwts.parser().setSigningKey(securityKey).parseClaimsJws(token).getBody().get(objectKeyName);
        return JSON.parseObject(JSON.toJSONString(obj), type);
        // return new ObjectMapper().convertValue(obj, type);
    }


}
