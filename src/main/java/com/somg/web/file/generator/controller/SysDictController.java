package com.somg.web.file.generator.controller;

import com.somg.web.file.generator.action.SysDictService;
import com.somg.web.file.generator.annotation.SysListenLog;
import com.somg.web.file.generator.constant.REnum;
import com.somg.web.file.generator.pojo.SysDict;
import com.somg.web.file.generator.utils.Pagination.PageUtils;
import com.somg.web.file.generator.utils.R;
import com.somg.web.file.generator.vo.AddSysDictVo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

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
     * 展示字典，可以根据关键字
     * @param param
     * @return
     */
    @SysListenLog(serverName = "系统字典服务", action = "展示字典")
    @GetMapping("selectDict")
    @PreAuthorize("hasAnyRole('admin', 'supermanager') and hasAuthority('select')")
    @ApiOperation(value = "展示字典")
    public R selectDictByPage(@RequestParam Map<String, Object> param){
        try {
            PageUtils dictList = sysDictService.selectDictByPage(param);

            return R.ok(REnum.SELECT_DICT_LIST_SUCCESS.getStatusCode(),
                    REnum.SELECT_DICT_LIST_SUCCESS.getStatusMsg()).put("dictList", dictList);
        }catch (Exception e){
            e.printStackTrace();
            return R.error(REnum.SELECT_DICT_LIST_FAIL.getStatusCode(), REnum.SELECT_DICT_LIST_FAIL.getStatusMsg());
        }
    }




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
     * 修改字典
     * @param sysDict
     * @return
     */
    @SysListenLog(serverName = "系统字典服务", action = "修改字典")
    @PostMapping("editDict")
    @PreAuthorize("hasAnyRole('admin', 'supermanager') and hasAuthority('update')")
    @ApiOperation(value = "修改字典")
    public R editDict(@RequestBody SysDict sysDict){
        try {
            sysDictService.updateById(sysDict);

            return R.ok(REnum.ALTER_DICT_SUCCESS.getStatusCode(),REnum.ALTER_DICT_SUCCESS.getStatusMsg());
        }catch (Exception e){
            e.printStackTrace();
            return R.error(REnum.ALTER_DICT_FAIL.getStatusCode(), REnum.ALTER_DICT_FAIL.getStatusMsg());
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


    /**
     * 删除字典
     * @return
     */
    @SysListenLog(serverName = "系统字典服务", action = "删除字典")
    @PostMapping("deleteDict/{dictId}")
    @PreAuthorize("hasAnyRole('admin', 'supermanager') and hasAuthority('delete')")
    @ApiOperation(value = "删除字典")
    public R deleteDict(@PathVariable Long dictId){
        try {
            return sysDictService.deleteDict(dictId);

        }catch (Exception e){
            e.printStackTrace();
            return R.error(REnum.DICT_DELETE_FAIL.getStatusCode(), REnum.DICT_DELETE_FAIL.getStatusMsg());
        }
    }







}
