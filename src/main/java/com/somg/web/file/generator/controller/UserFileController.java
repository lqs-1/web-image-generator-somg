package com.somg.web.file.generator.controller;

import com.somg.web.file.generator.action.UserFileService;
import com.somg.web.file.generator.annotation.SysListenLog;
import com.somg.web.file.generator.constant.REnum;
import com.somg.web.file.generator.pojo.origin.UserFile;
import com.somg.web.file.generator.utils.Pagination.PageUtils;
import com.somg.web.file.generator.utils.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

/**
 * @author somg
 * @date 2023/3/19 18:28
 * @do 用户文件控制器
 */


@RestController
@RequestMapping("storage")
public class UserFileController {


    @Autowired
    private UserFileService userFileService;

    /**
     * 获取当前用户的文件分页数据
     * @param params
     * @return
     */
    @SysListenLog(serverName = "文件服务", action = "所有文件列表[用户]")
    @GetMapping("allFilePage")
    public R requestFilePage(@RequestParam Map<String, Object> params){
        try {
            PageUtils userAllFileList = userFileService.queryAllFileListByPage(params);

            return R.ok(REnum.GET_USER_ALL_FILE_LIST_SUCCESS.getStatusCode(),
                            REnum.GET_USER_ALL_FILE_LIST_SUCCESS.getStatusMsg())
                    .put("fileList", userAllFileList);
        } catch (Exception e){
            e.printStackTrace();
            return R.ok(REnum.GET_USER_ALL_FILE_LIST_FAIL.getStatusCode(),
                    REnum.GET_USER_ALL_FILE_LIST_FAIL.getStatusMsg());
        }
    }


    /**
     * 超级管理员可以查看所有用户的文件
     * @param params
     * @return
     */
    @SysListenLog(serverName = "文件服务", action = "所有文件列表[所有]")
    @GetMapping("superAdminAllFilePage")
    @PreAuthorize("hasAnyRole('supermanager')")
    public R superAdminAllFilePage(@RequestParam Map<String, Object> params){
        try {
            PageUtils allFileList = userFileService.superAdminAllFilePage(params);

            return R.ok(REnum.GET_ALL_FILE_LIST_SUCCESS.getStatusCode(),
                            REnum.GET_ALL_FILE_LIST_SUCCESS.getStatusMsg())
                    .put("allFileList", allFileList);
        } catch (Exception e){
            e.printStackTrace();
            return R.ok(REnum.GET_ALL_FILE_LIST_FAIL.getStatusCode(),
                    REnum.GET_ALL_FILE_LIST_FAIL.getStatusMsg());
        }

    }


    /**
     * 删除文件 单个
     * @param userFile
     * @return
     */
    @SysListenLog(serverName = "上传服务", action = "删除文件")
    @PostMapping("deleteFile")
    public R deleteFile(@RequestBody UserFile userFile){

        return userFileService.deleteFile(userFile);
    }

    /**
     * 获取当前用户所有的图片分页数据
     * @param params
     * @return
     */
    @SysListenLog(serverName = "文件服务", action = "所有图片列表[用户]")
    @GetMapping("allImagePage")
    public R requestAllImageFiles(@RequestParam Map<String, Object> params){

        try{
            PageUtils imageList = userFileService.queryAllImageFileListByPage(params);

            return R.ok(REnum.GET_USER_ALL_IMAGE_LIST_SUCCESS.getStatusCode(),
                    REnum.GET_USER_ALL_IMAGE_LIST_SUCCESS.getStatusMsg())
                    .put("imageList", imageList);
        }catch (Exception e){

            e.printStackTrace();

            return R.error(REnum.GET_USER_ALL_IMAGE_LIST_FAIL.getStatusCode(), REnum.GET_USER_ALL_IMAGE_LIST_FAIL.getStatusMsg());
        }
    }


    /**
     * 获取当前用户所有的视频分页数据
     * @param params
     * @return
     */
    @SysListenLog(serverName = "文件服务", action = "所有视频列表[用户]")
    @GetMapping("allVideoPage")
    public R requestAllVideoFiles(@RequestParam Map<String, Object> params){

        try{
            PageUtils videoList = userFileService.queryAllVideoFileListByPage(params);

            return R.ok(REnum.GET_USER_ALL_VIDEO_LIST_SUCCESS.getStatusCode(),
                            REnum.GET_USER_ALL_VIDEO_LIST_SUCCESS.getStatusMsg())
                    .put("videoList", videoList);
        }catch (Exception e){

            e.printStackTrace();

            return R.error(REnum.GET_USER_ALL_VIDEO_LIST_FAIL.getStatusCode(), REnum.GET_USER_ALL_VIDEO_LIST_FAIL.getStatusMsg());
        }
    }


    /**
     * 获取当前用户所有的音频分页数据
     * @param params
     * @return
     */
    @SysListenLog(serverName = "文件服务", action = "所有音频列表[用户]")
    @GetMapping("allAudioPage")
    public R requestAllAudioFiles(@RequestParam Map<String, Object> params){

        try{
            PageUtils audioList = userFileService.queryAllAudioFileListByPage(params);

            return R.ok(REnum.GET_USER_ALL_AUDIO_LIST_SUCCESS.getStatusCode(),
                            REnum.GET_USER_ALL_AUDIO_LIST_SUCCESS.getStatusMsg())
                    .put("audioList", audioList);
        }catch (Exception e){

            e.printStackTrace();

            return R.error(REnum.GET_USER_ALL_AUDIO_LIST_FAIL.getStatusCode(), REnum.GET_USER_ALL_AUDIO_LIST_FAIL.getStatusMsg());
        }
    }

}
