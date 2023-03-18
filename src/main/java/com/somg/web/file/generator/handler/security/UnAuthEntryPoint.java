package com.somg.web.file.generator.handler.security;

import com.somg.web.file.generator.handler.security.utils.ResponseUtils;
import com.somg.web.file.generator.constant.REnum;
import com.somg.web.file.generator.utils.R;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author somg
 * @date 2023/3/18 15:08
 * @do 没有权限时候的处理方案(匿名用户，没有登录)
 */
public class UnAuthEntryPoint implements AuthenticationEntryPoint {
    @Override
    public void commence(HttpServletRequest request, HttpServletResponse response, AuthenticationException authException) throws IOException, ServletException {
        System.out.println("匿名用户访问执行了");
        ResponseUtils.out(response, R.error(REnum.NO_AUTH.getStatusCode(),REnum.NO_AUTH.getStatusMsg()));
    }
}
