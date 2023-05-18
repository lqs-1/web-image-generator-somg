package com.somg.web.file.generator.controller;

import com.somg.web.file.generator.action.SysLogService;
import com.somg.web.file.generator.annotation.SysListenLog;
import com.somg.web.file.generator.constant.REnum;
import com.somg.web.file.generator.pojo.SysLog;
import com.somg.web.file.generator.utils.Pagination.PageUtils;
import com.somg.web.file.generator.utils.R;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.Map;

/**
 * @author somg
 * @date 2023/4/1 14:43
 * @do 系统日志控制器
 */

@RestController
@RequestMapping("sysLog")
@Api(tags = "日志模块")
public class SysLogController {

    @Autowired
    private SysLogService sysLogService;

    /**
     * 获取系统日志分页数据
     * @param params
     * @return
     */
    @PreAuthorize("hasAnyRole('supermanager') and hasAuthority('select')")
    @GetMapping("logPage")
    @ApiOperation(value = "获取系统日志")
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


    /**
     * 第三方日志保存
     * @param sysLog
     * @return
     */
    @PostMapping("thirdSysLog")
    @ApiOperation(value = "第三方日志保存")
    public R thirdSysLog(@RequestBody SysLog sysLog){

        try{
            sysLog.setTime(new Date());
            sysLogService.save(sysLog);

            return R.ok(REnum.THIRD_SYS_LOG_SAVE_SUCCESS.getStatusCode(),
                            REnum.THIRD_SYS_LOG_SAVE_SUCCESS.getStatusMsg());

        }catch (Exception e){

            e.printStackTrace();

            return R.error(REnum.THIRD_SYS_LOG_SAVE_FAIL.getStatusCode(),
                    REnum.THIRD_SYS_LOG_SAVE_FAIL.getStatusMsg());
        }
    }



}
