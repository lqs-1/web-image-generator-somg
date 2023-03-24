package com.somg.web.file.generator.controller;

import com.somg.web.file.generator.handler.security.utils.JwtToken;
import com.somg.web.file.generator.utils.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.Collections;
import java.util.List;

/**
 * @author somg
 * @date 2023/3/10 12:45
 * @do 认证控制器 未作
 */


@RestController
@RequestMapping("auth")
public class AuthController {


    @Autowired
    private RedisTemplate redisTemplate;

    @Autowired
    private JwtToken jwtToken;


    /**
     * 无用测试
     * @param httpServletRequest
     * @return
     */
    @GetMapping("role")
    public R getRoleAuth(HttpServletRequest httpServletRequest){
        String token = httpServletRequest.getHeader("token");

        List<String> roleList = (List<String>) redisTemplate.opsForValue().get(jwtToken.parseUsernameFormToken(token));

        // System.out.println("web层逻辑执行了");

        return R.ok().put("role", roleList);
    }


    /**
     * 无用测试
     * @param httpServletRequest
     * @return
     */
    @GetMapping("test")
    public R getRoleAuthe(HttpServletRequest httpServletRequest){
        return R.ok().put("ttest",1);
    }

}
