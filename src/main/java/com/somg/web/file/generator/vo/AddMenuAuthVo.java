package com.somg.web.file.generator.vo;

import lombok.Data;

import java.util.List;

/**
 * @author somg
 * @date 2023/3/20 20:59
 * @do 给用户添加菜单权限的Vo
 */

@Data
public class AddMenuAuthVo {

    private Long userId;

    private List<Long> menuIds;

}
