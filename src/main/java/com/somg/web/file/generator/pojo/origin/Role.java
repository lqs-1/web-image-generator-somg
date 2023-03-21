package com.somg.web.file.generator.pojo.origin;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;


/**
 * @author somg
 * @date 2023/3/20 12:02
 * @do 角色权限对象
 */
@Data
@TableName("role")
public class Role {
    private Long id;
    private String roleName;

}
