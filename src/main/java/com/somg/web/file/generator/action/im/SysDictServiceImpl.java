package com.somg.web.file.generator.action.im;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.mysql.cj.util.StringUtils;
import com.somg.web.file.generator.action.SysDictService;
import com.somg.web.file.generator.constant.Constant;
import com.somg.web.file.generator.constant.REnum;
import com.somg.web.file.generator.mapper.SysDictMapper;
import com.somg.web.file.generator.pojo.SysDict;
import com.somg.web.file.generator.utils.Pagination.PageUtils;
import com.somg.web.file.generator.utils.Pagination.QueryPage;
import com.somg.web.file.generator.utils.R;
import com.somg.web.file.generator.vo.AddSysDictVo;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

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


    /**
     * 根据条件查询字典列表
     * @param param
     * @return
     */
    @Override
    public PageUtils selectDictByPage(Map<String, Object> param) {
        // 根字典
        if (param.get("type").equals(Constant.DICT_TYPE_PARENT)){

            IPage<SysDict> page = this.page(new QueryPage<SysDict>().getPage(param, true),

                    new LambdaQueryWrapper<SysDict>().isNull(SysDict::getDictValue));

            return new PageUtils(page);

        } else if (param.get("type").equals(Constant.DICT_TYPE_SON)) { // 子字典

            IPage<SysDict> page = this.page(new QueryPage<SysDict>().getPage(param, true),

                    new LambdaQueryWrapper<SysDict>().eq(SysDict::getParentId, param.get("parentId")));

            return new PageUtils(page);
        }

        return null;
    }

    /**
     * 删除字典，父类如果存在子字典引用就不能删除
     * @param dictId
     * @return
     */
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    @Override
    public R deleteDict(Long dictId) {
        // 如果是父字典
        if (StringUtils.isNullOrEmpty(this.getById(dictId).getDictValue())) {
            // 是否有引用
            List<SysDict> sonDictList = this.baseMapper.selectList(new LambdaQueryWrapper<SysDict>().eq(SysDict::getParentId, dictId));
            if (sonDictList != null && sonDictList.size() > 0){
                return R.error(REnum.PARENT_DICT_USED.getStatusCode(), REnum.PARENT_DICT_USED.getStatusMsg());
            }
            this.baseMapper.deleteById(dictId);
        }else {
            this.baseMapper.deleteById(dictId);
        }

        return R.ok(REnum.DICT_DELETE_SUCCESS.getStatusCode(), REnum.DICT_DELETE_SUCCESS.getStatusMsg());
    }
}
