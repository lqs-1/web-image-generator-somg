package com.somg.web.file.generator.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.somg.web.file.generator.pojo.origin.Menus;
import org.apache.ibatis.annotations.Mapper;

/**
 * @author somg
 * @date 2023/3/20 12:09
 * @do 菜单mapper
 */
@Mapper
public interface MenuMapper extends BaseMapper<Menus> {
}
