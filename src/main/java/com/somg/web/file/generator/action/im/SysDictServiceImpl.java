package com.somg.web.file.generator.action.im;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.mysql.cj.util.StringUtils;
import com.somg.web.file.generator.action.SysDictService;
import com.somg.web.file.generator.mapper.SysDictMapper;
import com.somg.web.file.generator.pojo.Menus;
import com.somg.web.file.generator.pojo.SysDict;
import com.somg.web.file.generator.vo.AddSysDictVo;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @author somg
 * @date 2023/3/20 12:12
 * @do 系统字典服务实现
 */

@Service
public class SysDictServiceImpl extends ServiceImpl<SysDictMapper, SysDict> implements SysDictService {


    /**
     * 添加系统字典
     *
     * @param addSysDictVo
     */
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    @Override
    public void addDict(AddSysDictVo addSysDictVo) {

        if (!StringUtils.isNullOrEmpty(addSysDictVo.getDictCode()) &&
                !StringUtils.isNullOrEmpty(addSysDictVo.getDictDesc()) &&
                !StringUtils.isNullOrEmpty(addSysDictVo.getDictValue()) &&
                !StringUtils.isNullOrEmpty(addSysDictVo.getParentCode())) {

            if (this.baseMapper.selectList(new LambdaQueryWrapper<SysDict>().eq(SysDict::getDictCode, addSysDictVo.getDictCode())).size() > 0) {
                return;
            }

            SysDict sysDict = new SysDict();
            sysDict.setDictValue(addSysDictVo.getDictValue());
            sysDict.setDictCode(addSysDictVo.getDictCode());
            sysDict.setDictDesc(addSysDictVo.getDictDesc());

            SysDict parentSysDict = this.baseMapper.selectOne(new LambdaQueryWrapper<SysDict>().eq(SysDict::getDictCode, addSysDictVo.getParentCode()));

            sysDict.setParentId(parentSysDict.getId());

            this.baseMapper.insert(sysDict);

        } else if (!StringUtils.isNullOrEmpty(addSysDictVo.getDictCode()) && !StringUtils.isNullOrEmpty(addSysDictVo.getDictCode())) {

            SysDict sysDict = new SysDict();
            sysDict.setDictCode(addSysDictVo.getDictCode());
            sysDict.setDictDesc(addSysDictVo.getDictDesc());

            this.baseMapper.insert(sysDict);
        }

    }

    /**
     * 获取所有的父级字典
     * @return
     */
    @Override
    public List<SysDict> getAllParentDict() {
        return  this.baseMapper.selectList(new LambdaQueryWrapper<SysDict>().isNull(SysDict::getDictValue));
    }
}
