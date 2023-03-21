package com.somg.web.file.generator.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.somg.web.file.generator.pojo.origin.User;
import com.somg.web.file.generator.pojo.origin.UserFile;
import org.apache.ibatis.annotations.Mapper;

/**
 * @author somg
 * @date 2023/3/19 18:06
 * @do 用户文件mapper
 */
@Mapper
public interface UserFileMapper extends BaseMapper<UserFile> {
}
