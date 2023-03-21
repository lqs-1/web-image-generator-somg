package com.somg.web.file.generator.pojo.origin;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

/**
 * @author somg
 * @date 2023/3/20 12:05
 * @do 用户菜单权限对象
 */


@Data
@TableName("user_menu")
public class UserMenu {

    private Long id;

    private Long userId;

    private Long menuId;
}
