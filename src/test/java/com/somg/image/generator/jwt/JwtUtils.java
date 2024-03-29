package com.somg.image.generator.jwt;

import com.baomidou.mybatisplus.core.toolkit.ObjectUtils;
import com.somg.web.file.generator.action.SysDictService;
import com.somg.web.file.generator.constant.Constant;
import com.somg.web.file.generator.pojo.SysDict;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.Date;

/**
 * @author somg
 * @date 2023/3/18 12:06
 * @do JWT测试
 */

@RunWith(SpringRunner.class)
@SpringBootTest
public class JwtUtils {



    @Test
    public void generatorJwt(){
        long l = System.currentTimeMillis();
        long exp = l + 100*1000;
        String compact = Jwts.builder().setId("1").setSubject("lqs").setIssuedAt(new Date()).setExpiration(new Date(exp)).signWith(SignatureAlgorithm.HS256, "javalqs").compact();
        System.out.println(compact);

        // eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiIxIiwic3ViIjoibHFzIiwiaWF0IjoxNjc5MTEyODA4LCJleHAiOjE2NzkxMTI5MDd9.NjGZ0CQ3lN80iLmyTNbHx8vKpmC6XKCRaZsus2CoP54
    }



}
