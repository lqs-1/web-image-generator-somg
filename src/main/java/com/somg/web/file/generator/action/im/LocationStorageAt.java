package com.somg.web.file.generator.action.im;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.somg.web.file.generator.action.LocationStorageAction;
import com.somg.web.file.generator.pojo.FIleLocation;
import com.somg.web.file.generator.mapper.LocationStorageMper;
import org.springframework.stereotype.Service;

/**
 * @author somg
 * @date 2023/3/10 8:51
 * @do 本地存储实现（未用）
 */

@Service
public class LocationStorageAt extends ServiceImpl<LocationStorageMper, FIleLocation> implements LocationStorageAction {
}
