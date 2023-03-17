package com.somg.web.image.generator.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.somg.web.image.generator.pojo.FIleLocation;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

/**
 * @author somg
 * @date 2023/3/10 8:53
 * @do 一句话描述此模块的功能
 */

@Mapper
public interface LocationStorageMper extends BaseMapper<FIleLocation> {



}
