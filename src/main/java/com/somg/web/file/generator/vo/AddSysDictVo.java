package com.somg.web.file.generator.vo;

import lombok.Data;

/**
 * @author somg
 * @date 2023/5/1 21:27
 * @do 添加系统字典的视图对象
 */
@Data
public class AddSysDictVo {

    private String dictCode;
    private String dictValue;
    private String dictDesc;
    private String parentCode;


}
