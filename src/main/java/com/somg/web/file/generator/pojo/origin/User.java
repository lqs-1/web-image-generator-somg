package com.somg.web.file.generator.pojo.origin;

import lombok.Data;

@Data
public class User {
    private Long id;
    private String username;
    private String password;
    private String token;
    private String sex;

}
