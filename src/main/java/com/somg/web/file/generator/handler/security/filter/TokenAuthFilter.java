package com.somg.web.file.generator.handler.security.filter;

import com.mysql.cj.util.StringUtils;
import com.somg.web.file.generator.handler.security.utils.JwtToken;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.www.BasicAuthenticationFilter;
import org.springframework.util.CollectionUtils;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.*;

/**
 * @author somg
 * @date 2023/3/18 17:04
 * @do 处理权限的过滤器
 */
public class TokenAuthFilter extends BasicAuthenticationFilter {


    private JwtToken jwtToken;

    private JedisPool jedisPool;

    private AuthenticationManager authenticationManager;


    public TokenAuthFilter(AuthenticationManager authenticationManager, JwtToken jwtToken, JedisPool jedisPool) {
        super(authenticationManager);
        this.jwtToken = jwtToken;
        this.jedisPool = jedisPool;
    }


    /**
     * 权限相关操作 将权限从redis中取出来
     * @param request
     * @param response
     * @param chain
     * @throws IOException
     * @throws ServletException
     */
    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain chain) throws IOException, ServletException {

        // 获取token
        String token = request.getHeader("token");

        if (!StringUtils.isNullOrEmpty(token)){
            String username = jwtToken.parseUsernameFormToken(token);

            System.out.println("获取redis中的权限执行了");
            // 从redis中获得该用户的权限
            List<String> permissionValueList = jedisPool.getResource().lrange(username, 0, -1);
            System.out.println(permissionValueList);

            // 将取出的权限存储到权限上下文
            Collection<GrantedAuthority> authorityCollection = new ArrayList<>();
            if (!CollectionUtils.isEmpty(permissionValueList)){
                for (String permissionValue : permissionValueList) {
                    SimpleGrantedAuthority authority = new SimpleGrantedAuthority(permissionValue);
                    authorityCollection.add(authority);
                }
            }
            // 生成权限信息对象
            UsernamePasswordAuthenticationToken authenticationToken = new UsernamePasswordAuthenticationToken(username,token, authorityCollection);
            // 把权限信息对象存入到权限上下文中
            SecurityContextHolder.getContext().setAuthentication(authenticationToken);
        }

        System.out.println("放行");
        // 放行
        chain.doFilter(request, response);

    }
}
