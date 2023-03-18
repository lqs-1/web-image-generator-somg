package com.somg.web.file.generator.vo;

import com.somg.web.file.generator.pojo.origin.User;
import lombok.Data;

@Data
public class UserLoginVo extends User {

    private String code;
}
