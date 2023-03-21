package com.somg.web.file.generator.vo;

import lombok.Data;

import java.util.List;

/**
 * @author somg
 * @date 2023/3/20 13:14
 * @do 封装用户菜单权限的Vo 用户登录成功之后返回给前端 做页面控制
 */
@Data
public class MenuVo {

    private Long menuIndex;

    private String menuName;

    private List<MenuItem> menuItems;


    @Data
    public static class MenuItem{

        private String menuPath;

        private String menuName;

    }

}
