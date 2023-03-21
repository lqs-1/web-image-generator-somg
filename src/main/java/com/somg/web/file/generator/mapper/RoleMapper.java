package com.somg.web.file.generator.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.somg.web.file.generator.pojo.origin.Role;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * @author somg
 * @date 2023/3/20 12:09
 * @do 角色mapper
 */
@Mapper
public interface RoleMapper extends BaseMapper<Role> {
    Role getRoleByRoleName(@Param("roleName") String roleName);

}
