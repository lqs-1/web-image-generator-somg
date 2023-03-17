package com.somg.web.image.generator.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.somg.web.image.generator.pojo.origin.UserPermission;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface UserPermissionMapper extends BaseMapper<UserPermission> {
    List<Long> selectByUserId(@Param("userId") Long id);

}
