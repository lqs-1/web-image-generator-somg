package com.somg.web.file.generator.action.im;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.somg.web.file.generator.action.LocationStorageAction;
import com.somg.web.file.generator.pojo.FIleLocation;
import com.somg.web.file.generator.mapper.LocationStorageMper;
import org.springframework.stereotype.Service;

/**
 * @author somg
 * @date 2023/3/10 8:51
 * @do 一句话描述此模块的功能
 */

@Service
public class LocationStorageAt extends ServiceImpl<LocationStorageMper, FIleLocation> implements LocationStorageAction {
}
