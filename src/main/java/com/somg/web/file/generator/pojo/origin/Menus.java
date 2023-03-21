package com.somg.web.file.generator.pojo.origin;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

/**
 * @author somg
 * @date 2023/3/20 12:02
 * @do 菜单对象
 */
@Data
@TableName("menus")
public class Menus {

    private Long id;

    private Long menuIndex;

    private Long parentIndex;

    private String menuPath;

    private String menuName;

}
