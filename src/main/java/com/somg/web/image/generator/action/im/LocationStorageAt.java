package com.somg.web.image.generator.action.im;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.somg.web.image.generator.action.LocationStorageAction;
import com.somg.web.image.generator.mapper.LocationStorageMper;
import com.somg.web.image.generator.pojo.FIleLocation;
import org.springframework.stereotype.Service;

/**
 * @author somg
 * @date 2023/3/10 8:51
 * @do 一句话描述此模块的功能
 */

@Service
public class LocationStorageAt extends ServiceImpl<LocationStorageMper, FIleLocation> implements LocationStorageAction {
}
