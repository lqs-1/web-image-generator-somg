package com.somg.web.file.generator.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.somg.web.file.generator.pojo.UserPermission;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
/**
 * @author somg
 * @date 2023/3/20 12:09
 * @do 用户接口权限mapper
 */
public interface UserPermissionMapper extends BaseMapper<UserPermission> {
    List<Long> selectByUserId(@Param("userId") Long id);

}
