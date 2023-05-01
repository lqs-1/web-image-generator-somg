package com.somg.web.file.generator.pojo;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

/**
 * @author somg
 * @date 2023/5/1 20:13
 * @do 系统字典
 */

@Data
@TableName("sys_dict")
public class SysDict {
    private Long id;

    private Long dictCode;

    private Long dictValue;

    private String parentId;

    private String desc;



}
