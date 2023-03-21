package com.somg.web.file.generator.vo;

import com.somg.web.file.generator.pojo.origin.User;
import lombok.Data;


/**
 * @author somg
 * @date 2023/3/20 12:02
 * @do 用户登录的Vo 弃用
 */
@Data
public class UserLoginVo extends User {

    private String code;
}
