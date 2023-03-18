package com.somg.web.file.generator.handler.security.utils;

import com.alibaba.fastjson.JSON;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.somg.web.file.generator.utils.R;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * @author somg
 * @date 2023/3/18 15:11
 * @do response写入对象
 */
public class ResponseUtils {

    public static void out(HttpServletResponse response, R result){
        // 封装response的状态码和内容格式
        response.setStatus(HttpStatus.OK.value());
        response.setContentType(MediaType.APPLICATION_JSON_VALUE + ";charset=UTF-8");
        // 内容 把数据装化成json类型并返回
        PrintWriter writer = null;
        try {
            writer = response.getWriter();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

        writer.write(JSON.toJSONString(result));

        writer.flush();
    }


}
