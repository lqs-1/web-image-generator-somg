package com.somg.web.file.generator.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.somg.web.file.generator.pojo.origin.UserMenu;
import org.apache.ibatis.annotations.Mapper;

/**
 * @author somg
 * @date 2023/3/20 12:10
 * @do 用户菜单权限mapper
 */
@Mapper
public interface UserMenuMapper extends BaseMapper<UserMenu> {
}
