package com.somg.web.file.generator.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.somg.web.file.generator.pojo.origin.Permission;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * @author somg
 * @date 2023/3/20 12:09
 * @do 权限mapper
 */
@Mapper
public interface PermissionMapper extends BaseMapper<Permission> {

    Permission getPermissionByPermissionName(@Param("permissionName") String permissionName);
}
