package com.somg.web.file.generator.controller;

import com.somg.web.file.generator.handler.security.utils.JwtToken;
import com.somg.web.file.generator.utils.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import redis.clients.jedis.JedisPool;

import javax.servlet.http.HttpServletRequest;
import java.util.Collections;
import java.util.List;

/**
 * @author somg
 * @date 2023/3/10 12:45
 * @do 一句话描述此模块的功能
 */


@RestController
@RequestMapping("auth")
public class AuthController {


    @Autowired
    private JedisPool jedisPool;

    @Autowired
    private JwtToken jwtToken;


    @GetMapping("role")
    public R getRoleAuth(HttpServletRequest httpServletRequest){
        String token = httpServletRequest.getHeader("token");

        List<String> roleList = jedisPool.getResource().lrange(jwtToken.parseUsernameFormToken(token), 0, -1);

        System.out.println("web层逻辑执行了");

        return R.ok().put("role", roleList);
    }



    @GetMapping("test")
    public R getRoleAuthe(HttpServletRequest httpServletRequest){
        return R.ok().put("ttest",1);
    }

}
