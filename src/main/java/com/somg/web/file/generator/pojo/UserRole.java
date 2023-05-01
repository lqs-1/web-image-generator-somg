package com.somg.web.file.generator.pojo;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;


/**
 * @author somg
 * @date 2023/3/20 12:02
 * @do 用户角色权限对象
 */
@Data
@TableName("user_role")
public class UserRole {
    private Long id;
    private Long userId;
    private Long roleId;

}
