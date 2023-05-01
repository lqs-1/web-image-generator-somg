package com.somg.web.file.generator.action;

import com.baomidou.mybatisplus.extension.service.IService;
import com.somg.web.file.generator.pojo.SysLog;
import com.somg.web.file.generator.utils.Pagination.PageUtils;

import java.util.Map;

/**
 * @author somg
 * @date 2023/4/1 14:16
 * @do 系统日志服务接口
 */
public interface SysLogService extends IService<SysLog> {
    PageUtils getLogPage(Map<String, Object> params);
}
