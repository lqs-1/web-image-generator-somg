package com.somg.web.image.generator.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.somg.web.image.generator.pojo.origin.Permission;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface PermissionMapper extends BaseMapper<Permission> {

    Permission getPermissionByPermissionName(@Param("permissionName") String permissionName);
}
