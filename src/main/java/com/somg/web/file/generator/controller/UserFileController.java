package com.somg.web.file.generator.controller;

import com.somg.web.file.generator.action.UserFileService;
import com.somg.web.file.generator.constant.REnum;
import com.somg.web.file.generator.pojo.origin.UserFile;
import com.somg.web.file.generator.utils.Pagination.PageUtils;
import com.somg.web.file.generator.utils.R;
import org.springframework.beans.factory.annotation.Autowired;
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
     * 获取用户的文件分页数据
     * @param params
     * @return
     */
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
     * 删除文件 单个
     * @param userFile
     * @return
     */
    @PostMapping("deleteFile")
    public R deleteFile(@RequestBody UserFile userFile){

        return userFileService.deleteFile(userFile);
    }

    /**
     * 获取所有的图片分页数据
     * @param params
     * @return
     */

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
     * 获取所有的视频分页数据
     * @param params
     * @return
     */
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
     * 获取所有的音频分页数据
     * @param params
     * @return
     */
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
