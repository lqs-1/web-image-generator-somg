package com.somg.web.file.generator.pojo.origin;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.util.Date;


/**
 * @author somg
 * @date 2023/3/20 12:02
 * @do 用户对象
 */
@Data
@TableName("user")
public class User {
    private Long id;
    private String username;
    private String password;
    private Date createTime;
    private Date loginTime;
    private String sex;
    private String email;

    @TableField(exist = false)
    private String token;

    @TableField(exist = false)
    private String emailCode;

}
