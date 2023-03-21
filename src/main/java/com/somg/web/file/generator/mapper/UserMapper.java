package com.somg.web.file.generator.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.somg.web.file.generator.pojo.origin.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
/**
 * @author somg
 * @date 2023/3/20 12:09
 * @do 用户mapper
 */
@Mapper
public interface UserMapper extends BaseMapper<User> {

    User selectByUserName(@Param("username") String username);

    User getUserByUserName(@Param("username") String username);

    int alterPwdByUserName(User user);
}
