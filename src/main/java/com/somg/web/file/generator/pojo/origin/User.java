package com.somg.web.file.generator.pojo.origin;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;



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
    @TableField(exist = false)
    private String token;
    private String sex;

}
