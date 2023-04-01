package com.somg.web.file.generator.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.somg.web.file.generator.pojo.origin.SysLog;
import org.apache.ibatis.annotations.Mapper;

/**
 * @author somg
 * @date 2023/3/10 12:41
 * @do 系统日志Mapper
 */
@Mapper
public interface SysLogMapper extends BaseMapper<SysLog> {
}
