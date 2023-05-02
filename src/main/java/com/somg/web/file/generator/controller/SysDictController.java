package com.somg.web.file.generator.controller;

import com.somg.web.file.generator.action.SysDictService;
import com.somg.web.file.generator.annotation.SysListenLog;
import com.somg.web.file.generator.constant.REnum;
import com.somg.web.file.generator.pojo.SysDict;
import com.somg.web.file.generator.utils.R;
import com.somg.web.file.generator.vo.AddSysDictVo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @author somg
 * @date 2023/5/1 20:20
 * @do 系统字典控制器 TODO 只是做了一个添加的功能 修改和展示没做
 */
@RestController
@RequestMapping("sysDict")
@Api(tags = "系统字典模块")
public class SysDictController {

    @Autowired
    private SysDictService sysDictService;



    /**
     * 添加字典
     * @param addSysDictVo
     * @return
     */
    @SysListenLog(serverName = "系统字典服务", action = "添加字典")
    @PostMapping("addDict")
    @PreAuthorize("hasAnyRole('admin', 'supermanager') and hasAuthority('add')")
    @ApiOperation(value = "添加字典")
    public R addDict(@RequestBody AddSysDictVo addSysDictVo){
        try {
            sysDictService.addDict(addSysDictVo);

            return R.ok(REnum.ADD_SYS_DICT_SUCCESS.getStatusCode(),REnum.ADD_SYS_DICT_SUCCESS.getStatusMsg());
        }catch (Exception e){
            e.printStackTrace();
            return R.error(REnum.ADD_SYS_DICT_FAIL.getStatusCode(), REnum.ADD_SYS_DICT_FAIL.getStatusMsg());
        }
    }



    /**
     * 获取所有父级字典
     * @return
     */
    @SysListenLog(serverName = "系统字典服务", action = "获取父级字典列表")
    @GetMapping("parentSysDictList")
    @PreAuthorize("hasAnyRole('admin', 'supermanager') and hasAuthority('add')")
    @ApiOperation(value = "获取父级字典列表")
    public R parentSysDictList(){
        try {
            List<SysDict> sysDictList = sysDictService.getAllParentDict();

            return R.ok(REnum.GET_ALL_PARENT_DICT_SUCCESS.getStatusCode(),REnum.GET_ALL_PARENT_DICT_SUCCESS.getStatusMsg()).put("sysDictList", sysDictList);
        }catch (Exception e){
            e.printStackTrace();
            return R.error(REnum.GET_ALL_PARENT_DICT_FAIL.getStatusCode(), REnum.GET_ALL_PARENT_DICT_FAIL.getStatusMsg());
        }
    }






}
