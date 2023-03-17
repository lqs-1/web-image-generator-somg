package com.somg.web.image.generator.handler;

import com.alibaba.fastjson.JSON;
import com.somg.web.image.generator.constant.REnum;
import com.somg.web.image.generator.utils.R;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;


public class LoginFailHandler implements AuthenticationFailureHandler {

    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception) throws IOException, ServletException {

        response.setContentType("application/json;charset=utf-8");

        response.setStatus(HttpServletResponse.SC_OK);

        PrintWriter writer = response.getWriter();

        String code = (String) request.getSession().getAttribute("code");

        writer.write(JSON.toJSONString(R.ok(REnum.LOGIN_FAIL.getStatusCode(),
                REnum.LOGIN_FAIL.getStatusMsg())));

        writer.flush();

    }
}
