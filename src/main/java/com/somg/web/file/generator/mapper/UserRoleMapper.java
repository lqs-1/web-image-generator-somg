package com.somg.web.file.generator.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.somg.web.file.generator.pojo.UserRole;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author somg
 * @date 2023/3/20 12:09
 * @do 用户角色权限mapper
 */
@Mapper
public interface UserRoleMapper extends BaseMapper<UserRole> {
    List<Long> selectByUserId(@Param("userId") Long id);
}
