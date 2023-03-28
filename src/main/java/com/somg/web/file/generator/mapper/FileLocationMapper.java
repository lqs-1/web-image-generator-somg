package com.somg.web.file.generator.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.somg.web.file.generator.pojo.FileLocation;
import org.apache.ibatis.annotations.Mapper;

/**
 * @author somg
 * @date 2023/3/28 16:23
 * @do 本地文件mapper
 */
@Mapper
public interface FileLocationMapper extends BaseMapper<FileLocation> {
}
