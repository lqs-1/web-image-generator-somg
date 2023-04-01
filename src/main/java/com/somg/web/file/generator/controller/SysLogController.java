package com.somg.web.file.generator.controller;

import com.somg.web.file.generator.action.SysLogService;
import com.somg.web.file.generator.annotation.SysListenLog;
import com.somg.web.file.generator.constant.REnum;
import com.somg.web.file.generator.utils.Pagination.PageUtils;
import com.somg.web.file.generator.utils.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

/**
 * @author somg
 * @date 2023/4/1 14:43
 * @do 系统日志控制器
 */

@RestController
@RequestMapping("sysLog")
public class SysLogController {

    @Autowired
    private SysLogService sysLogService;

    /**
     * 获取系统日志分页数据
     * @param params
     * @return
     */
    @SysListenLog(serverName = "日志服务", action = "日志列表")
    @PreAuthorize("hasAnyRole('common','admin', 'supermanager') and hasAuthority('select')")
    @GetMapping("logPage")
    public R getLogPage(@RequestParam Map<String, Object> params){

        try{

            PageUtils logList = sysLogService.getLogPage(params);

            return R.ok(REnum.GET_LOG_LIST_SUCCESS.getStatusCode(),
                            REnum.GET_LOG_LIST_SUCCESS.getStatusMsg())
                    .put("logList", logList);

        }catch (Exception e){

            e.printStackTrace();

            return R.error(REnum.GET_LOG_LIST_FAIL.getStatusCode(),
                    REnum.GET_LOG_LIST_FAIL.getStatusMsg());
        }
    }



}
