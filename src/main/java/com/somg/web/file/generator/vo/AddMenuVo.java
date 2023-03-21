package com.somg.web.file.generator.vo;

import lombok.Data;

/**
 * @author somg
 * @date 2023/3/20 17:48
 * @do 添加菜单的Vo
 */

@Data
public class AddMenuVo {

    private String pmenuName;

    private String pmenuPath;

    private String menuName;

    private String menuPath;

    private Long parentIndex;

}
