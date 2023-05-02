package com.somg.web.file.generator.action;

import com.baomidou.mybatisplus.extension.service.IService;
import com.somg.web.file.generator.pojo.SysDict;
import com.somg.web.file.generator.vo.AddSysDictVo;

import java.util.List;

/**
 * @author somg
 * @date 2023/3/10 12:43
 * @do 系统字典服务接口
 */
public interface SysDictService extends IService<SysDict> {
    void addDict(AddSysDictVo addSysDictVo);

    List<SysDict> getAllParentDict();
}
