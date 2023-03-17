package com.somg.web.image.generator.handler;

import com.alibaba.fastjson.JSON;
import com.somg.web.image.generator.constant.REnum;
import com.somg.web.image.generator.utils.R;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class MyAccessDeniedHandler implements AccessDeniedHandler {


    @Override
    public void handle(HttpServletRequest request, HttpServletResponse response, AccessDeniedException accessDeniedException) throws IOException, ServletException {

        response.setContentType("application/json;charset=utf-8");

        response.setStatus(HttpServletResponse.SC_OK);

        PrintWriter writer = response.getWriter();

        writer.write(JSON.toJSONString(R.error(REnum.USER_PERMISSIONS_ERROR.getStatusCode(),
                REnum.USER_PERMISSIONS_ERROR.getStatusMsg())));

        writer.flush();
    }
}
