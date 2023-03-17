package com.somg.web.image.generator.vo;

import com.somg.web.image.generator.pojo.origin.User;
import lombok.Data;

@Data
public class UserLoginVo extends User {

    private String code;
}
