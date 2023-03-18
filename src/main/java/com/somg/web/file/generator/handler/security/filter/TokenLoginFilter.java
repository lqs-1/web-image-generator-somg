package com.somg.web.file.generator.handler.security.filter;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.somg.web.file.generator.constant.REnum;
import com.somg.web.file.generator.handler.security.utils.JwtToken;
import com.somg.web.file.generator.pojo.SecurityUser;
import com.somg.web.file.generator.pojo.origin.User;
import com.somg.web.file.generator.utils.R;
import com.somg.web.file.generator.handler.security.utils.ResponseUtils;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.util.matcher.AndRequestMatcher;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import redis.clients.jedis.JedisPool;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * @author somg
 * @date 2023/3/18 16:24
 * @do 登录拦截器
 */
public class TokenLoginFilter extends UsernamePasswordAuthenticationFilter {

    private JwtToken jwtToken;

    private JedisPool jedisPool;

    private AuthenticationManager authenticationManager;


    public TokenLoginFilter(AuthenticationManager authenticationManager, JwtToken jwtToken, JedisPool jedisPool) {
        this.authenticationManager = authenticationManager;
        this.jwtToken = jwtToken;
        this.jedisPool = jedisPool;
        // 不是只允许post请求,才能经过这个filter
        this.setPostOnly(false);
        // 设置登录的路径和请求方式
        this.setRequiresAuthenticationRequestMatcher(new AntPathRequestMatcher("/user/login", "POST"));
    }

    /**
     * 执行认证的方法 给认证做准备工作，获取前端传递的数据
     * @param request
     * @param response
     * @return
     * @throws AuthenticationException
     */
    @Override
    public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response) throws AuthenticationException {

        // 获取表单提交的数据
        ObjectMapper objectMapper = new ObjectMapper();
        System.out.println("登录认证之前的准备工作执行了");

        try {
            User user = objectMapper.readValue(request.getInputStream(), User.class);

            // 校验 认证的过程
            return authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(user.getUsername(), user.getPassword(), new ArrayList<>()));
        } catch (IOException e) {
            throw new RuntimeException();
        }
    }

    /**
     * 认证成功以后
     * @param request
     * @param response
     * @param chain
     * @param authResult
     * @throws IOException
     * @throws ServletException
     */
    @Override
    protected void successfulAuthentication(HttpServletRequest request, HttpServletResponse response, FilterChain chain, Authentication authResult) throws IOException, ServletException {
        // 获取当前用户 UserDetails
        SecurityUser securityUser = (SecurityUser) authResult.getPrincipal();

        System.out.println("登录成功执行了");
        String username = securityUser.getUsername();

        // 生成token
        String token = jwtToken.createToken(username);


        // 权限存入redis
        List<String> permissionValueList = securityUser.getPermissionValueList();
        for (String permissionValue : permissionValueList) {
            jedisPool.getResource().rpush(username, permissionValue);
        }

        ResponseUtils.out(response, R.ok(REnum.LOGIN_SUCCESS.getStatusCode(), REnum.LOGIN_SUCCESS.getStatusMsg()).put("token", token));

    }


    /**
     * 认证失败
     * @param request
     * @param response
     * @param failed
     * @throws IOException
     * @throws ServletException
     */
    @Override
    protected void unsuccessfulAuthentication(HttpServletRequest request, HttpServletResponse response, AuthenticationException failed) throws IOException, ServletException {
        System.out.println("登录失败执行了");
        ResponseUtils.out(response, R.error(REnum.LOGIN_FAIL.getStatusCode(),REnum.LOGIN_FAIL.getStatusMsg()));
    }
}
