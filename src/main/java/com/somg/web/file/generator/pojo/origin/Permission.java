package com.somg.web.file.generator.pojo.origin;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;



/**
 * @author somg
 * @date 2023/3/20 12:02
 * @do 接口权限对象
 */
@Data
@TableName("permission")
public class Permission {

    private Long id;

    private String permissionName;

}
