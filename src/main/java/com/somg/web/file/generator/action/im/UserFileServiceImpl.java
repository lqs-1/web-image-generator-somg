package com.somg.web.file.generator.action.im;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.somg.web.file.generator.action.UserFileService;
import com.somg.web.file.generator.action.UserService;
import com.somg.web.file.generator.cloud.storage.abs.auto.UploadPlusProperties;
import com.somg.web.file.generator.cloud.storage.abs.upload.FileUploadPlus;
import com.somg.web.file.generator.constant.Constant;
import com.somg.web.file.generator.handler.security.filter.TokenAuthFilter;
import com.somg.web.file.generator.mapper.UserFileMapper;
import com.somg.web.file.generator.pojo.origin.User;
import com.somg.web.file.generator.pojo.origin.UserFile;
import com.somg.web.file.generator.utils.Pagination.PageUtils;
import com.somg.web.file.generator.utils.Pagination.QueryPage;
import com.somg.web.file.generator.utils.R;
import com.somg.web.file.generator.vo.StatisticalDataVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

/**
 * @author somg
 * @date 2023/3/19 18:08
 * @do 用户文件实现
 */

@Service
public class UserFileServiceImpl extends ServiceImpl<UserFileMapper, UserFile> implements UserFileService {


    @Autowired
    private FileUploadPlus fileUpload;

    @Autowired
    private UserService userService;

    @Autowired
    private UploadPlusProperties uploadPlusProperties;


    /**
     * 单文件上传
     * @param image
     * @return
     */
    @Override
    @Transactional(readOnly = false)
    public R singleUpload(MultipartFile image) {

        R result = fileUpload.build().singleFileUpload(image);

        if (result.parseCode() >= 10000){
            User user = this.getUser();


            UserFile userFile = new UserFile();
            userFile.setUserId(user.getId());
            userFile.setFile(fileUpload.build().extractFileFullPath((String) result.get("web-file-url"), true));
            userFile.setFileType(image.getContentType());
            userFile.setUploadTime(new Date());

            this.baseMapper.insert(userFile);
        }

        return result;
    }


    /**
     * 同一个线程中获取用户，用户是在用户请求经过TokenAuthFilter过滤器的时候添加的
     * @return
     */
    private User getUser(){
        String username = TokenAuthFilter.userNameThreadLocal.get();

        return userService.selectUserByName(username);
    }


    /**
     * 获取用户的文件分页数据
     * @param params
     * @return
     */
    @Override
    public PageUtils queryAllFileListByPage(Map<String, Object> params) {

        User user = getUser();

        IPage<UserFile> page = this.page(new QueryPage<UserFile>().getPage(params, true),
                new LambdaQueryWrapper<UserFile>().eq(UserFile::getUserId, user.getId()));

        List<UserFile> records = page.getRecords();

        records.stream().map(item -> {
            item.setFile(uploadPlusProperties.getBaseUrl() + item.getFile());
            return item;
        }).collect(Collectors.toList());

        return new PageUtils(page);
    }


    /**
     * 批量文件上传
     * @param images
     * @return
     */
    @Override
    @Transactional(readOnly = false)
    public R multiUpload(List<MultipartFile> images) {

        R result = new R();

        for (MultipartFile image : images) {
            result = fileUpload.build().singleFileUpload(image);

            if (result.parseCode() >= 10000 && result.parseCode() <= 20000){
                User user = this.getUser();


                UserFile userFile = new UserFile();
                userFile.setUserId(user.getId());
                userFile.setFile(fileUpload.build().extractFileFullPath((String) result.get("web-file-url"), true));
                userFile.setFileType(image.getContentType());
                userFile.setUploadTime(new Date());

                this.baseMapper.insert(userFile);
            }
            break;
        }

        return result;

    }


    /**
     * 获取用户所有的图片文件分页数据
     * @param params
     * @return
     */
    @Override
    public PageUtils queryAllImageFileListByPage(Map<String, Object> params) {
        User user = getUser();

        IPage<UserFile> page = this.page(new QueryPage<UserFile>().getPage(params, true),
                new LambdaQueryWrapper<UserFile>().eq(UserFile::getUserId, user.getId()).in(UserFile::getFileType, Constant.IMAGE_CONTENT_TYPES));

        List<UserFile> records = page.getRecords();

        records.stream().map(item -> {
            item.setFile(uploadPlusProperties.getBaseUrl() + item.getFile());
            return item;
        }).collect(Collectors.toList());

        return new PageUtils(page);
    }

    /**
     * 获取用户所有的音频文件分页数据
     * @param params
     * @return
     */
    @Override
    public PageUtils queryAllAudioFileListByPage(Map<String, Object> params) {
        User user = getUser();

        IPage<UserFile> page = this.page(new QueryPage<UserFile>().getPage(params, true),
                new LambdaQueryWrapper<UserFile>().eq(UserFile::getUserId, user.getId()).in(UserFile::getFileType, Constant.AUDIO_CONTENT_TYPES));

        List<UserFile> records = page.getRecords();

        records.stream().map(item -> {
            item.setFile(uploadPlusProperties.getBaseUrl() + item.getFile());
            return item;
        }).collect(Collectors.toList());

        return new PageUtils(page);
    }


    /**
     * 获取用户所有的视频文件分页数据
     * @param params
     * @return
     */
    @Override
    public PageUtils queryAllVideoFileListByPage(Map<String, Object> params) {
        User user = getUser();

        IPage<UserFile> page = this.page(new QueryPage<UserFile>().getPage(params, true),
                new LambdaQueryWrapper<UserFile>().eq(UserFile::getUserId, user.getId()).in(UserFile::getFileType, Constant.VIDEO_CONTENT_TYPES));

        List<UserFile> records = page.getRecords();

        records.stream().map(item -> {
            item.setFile(uploadPlusProperties.getBaseUrl() + item.getFile());
            return item;
        }).collect(Collectors.toList());

        return new PageUtils(page);
    }


    /**
     * 获取当前用户或者所有用户的各种文件的个数 作为前端的统计数据
     * @param currentUser
     * @return
     */
    @Override
    public List<StatisticalDataVo> allStatisticalData(Boolean currentUser) {

        List<StatisticalDataVo> statisticalDataVoList = new ArrayList<>();

        // 获取当前用户
        User user = getUser();

        // 统计图片
        Integer imageFileCount = this.baseMapper.selectCount(new LambdaQueryWrapper<UserFile>()
                        .eq(currentUser, UserFile::getUserId, user.getId()).in(UserFile::getFileType, Constant.IMAGE_CONTENT_TYPES));
        StatisticalDataVo statisticalAllImageData = new StatisticalDataVo();
        statisticalAllImageData.setValue(imageFileCount);
        statisticalAllImageData.setName(Constant.IMAGE_STATISTICAL_NAME);

        // 统计视频
        Integer videoFileCount = this.baseMapper.selectCount(new LambdaQueryWrapper<UserFile>()
                .eq(currentUser, UserFile::getUserId, user.getId()).in(UserFile::getFileType, Constant.VIDEO_CONTENT_TYPES));
        StatisticalDataVo statisticalAllVideoData = new StatisticalDataVo();
        statisticalAllVideoData.setValue(videoFileCount);
        statisticalAllVideoData.setName(Constant.VIDEO_STATISTICAL_NAME);

        // 统计音频
        Integer audioFileCount = this.baseMapper.selectCount(new LambdaQueryWrapper<UserFile>()
                .eq(currentUser, UserFile::getUserId, user.getId()).in(UserFile::getFileType, Constant.AUDIO_CONTENT_TYPES));
        StatisticalDataVo statisticalAllaudioData = new StatisticalDataVo();
        statisticalAllaudioData.setValue(audioFileCount);
        statisticalAllaudioData.setName(Constant.AUDIO_STATISTICAL_NAME);

        // 统计其他项目
        ArrayList typeList=new ArrayList(Arrays.asList(Constant.IMAGE_CONTENT_TYPES));
        typeList.addAll(Arrays.asList(Constant.VIDEO_CONTENT_TYPES));
        typeList.addAll(Arrays.asList(Constant.AUDIO_CONTENT_TYPES));
        Integer otherFileCount = this.baseMapper.selectCount(new LambdaQueryWrapper<UserFile>()
                .eq(currentUser, UserFile::getUserId, user.getId()).notIn(UserFile::getFileType, typeList));
        StatisticalDataVo statisticalAllotherData = new StatisticalDataVo();
        statisticalAllotherData.setName(Constant.OTHER_STATISTICAL_NAME);
        statisticalAllotherData.setValue(otherFileCount);


        statisticalDataVoList.add(statisticalAllImageData);
        statisticalDataVoList.add(statisticalAllotherData);
        statisticalDataVoList.add(statisticalAllaudioData);
        statisticalDataVoList.add(statisticalAllVideoData);

        return statisticalDataVoList;
    }

    /**
     * 超级管理员查看所有用户的文件
     * @param params
     * @return
     */
    @Override
    public PageUtils superAdminAllFilePage(Map<String, Object> params) {

        List<Long> userIds = new ArrayList<>();

        if (params.get("username") != null){
            userIds = userService.selectUserLikeName((String)params.get("username"));
        }

        IPage<UserFile> page = this.page(new QueryPage<UserFile>().getPage(params, true),
                new LambdaQueryWrapper<UserFile>().in(userIds.size() > 0, UserFile::getUserId, userIds));

        List<UserFile> records = page.getRecords();

        records.stream().map(item -> {
            item.setFile(uploadPlusProperties.getBaseUrl() + item.getFile());
            User user = userService.getById(item.getUserId());
            item.setUserName(user.getUsername());
            return item;
        }).collect(Collectors.toList());

        return new PageUtils(page);
    }


    /**
     * 删除文件
     * @param userFile
     * @return
     */
    @Override
    @Transactional(readOnly = false)
    public R deleteFile(UserFile userFile) {
        R deleteResponse = fileUpload.build().singleFileClear(userFile.getFile());

        if (deleteResponse.parseCode() > 10000) {
            this.baseMapper.deleteById(userFile.getId());
        }

        return deleteResponse;
    }


    public static void main(String[] args) {
        List<Long> r = new ArrayList<>();
        System.out.println(r.size());
    }
}
