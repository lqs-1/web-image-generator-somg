package com.somg.web.file.generator.action;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.mysql.cj.util.StringUtils;
import com.somg.web.file.generator.mapper.SysLogMapper;
import com.somg.web.file.generator.pojo.origin.SysLog;
import com.somg.web.file.generator.pojo.origin.User;
import com.somg.web.file.generator.utils.Pagination.PageUtils;
import com.somg.web.file.generator.utils.Pagination.QueryPage;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * @author somg
 * @date 2023/4/1 14:17
 * @do 系统日志服务实现
 */
@Service
public class SysLogServiceImpl extends ServiceImpl<SysLogMapper, SysLog> implements SysLogService {
    @Override
    public PageUtils getLogPage(Map<String, Object> params) {

        LambdaQueryWrapper<SysLog> sysLogLambdaQueryWrapper = new LambdaQueryWrapper<>();
        if (!StringUtils.isNullOrEmpty((String) params.get("keyword")) && params.get("keyword") != null){
            sysLogLambdaQueryWrapper.like(SysLog::getUserName, params.get("keyword"))
                    .or().like(SysLog::getServerName, params.get("keyword"))
                    .or().like(SysLog::getAction, params.get("keyword"));
        }

        IPage<SysLog> page = this.page(new QueryPage<SysLog>().getPage(params, true), sysLogLambdaQueryWrapper);

        return new  PageUtils(page);
    }
}
