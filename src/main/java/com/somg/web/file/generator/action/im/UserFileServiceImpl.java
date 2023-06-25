package com.somg.web.file.generator.action.im;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.mysql.cj.util.StringUtils;
import com.somg.web.file.generator.action.SysDictService;
import com.somg.web.file.generator.action.UserFileService;
import com.somg.web.file.generator.action.UserService;
import com.somg.web.file.generator.cloud.storage.abs.auto.UploadPlusProperties;
import com.somg.web.file.generator.cloud.storage.abs.upload.FileUploadPlus;
import com.somg.web.file.generator.constant.Constant;
import com.somg.web.file.generator.constant.REnum;
import com.somg.web.file.generator.handler.security.filter.TokenAuthFilter;
import com.somg.web.file.generator.mapper.UserFileMapper;
import com.somg.web.file.generator.pojo.SysDict;
import com.somg.web.file.generator.pojo.User;
import com.somg.web.file.generator.pojo.UserFile;
import com.somg.web.file.generator.utils.Pagination.PageUtils;
import com.somg.web.file.generator.utils.Pagination.QueryPage;
import com.somg.web.file.generator.utils.R;
import com.somg.web.file.generator.vo.MessageSendVo;
import com.somg.web.file.generator.vo.StatisticalDataVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.time.*;
import java.util.*;
import java.util.concurrent.TimeUnit;
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

    @Autowired
    private SysDictService sysDictService;

    /**
     * 单文件上传
     *
     * @param file
     * @return
     */
    @Override
    @Transactional(readOnly = false)
    public R singleUpload(MultipartFile file) {

        R result = fileUpload.build().singleFileUpload(file);

        if (result.parseCode() >= 10000 && result.parseCode() < 20000) {

            User user = this.getUser();

            String originalFilename = file.getOriginalFilename();
            String fileName = originalFilename.substring(0, originalFilename.lastIndexOf("."));


            UserFile userFile = new UserFile();
            userFile.setUserId(user.getId());
            userFile.setFileName(fileName);
            userFile.setFile(fileUpload.build().extractFileFullPath((String) result.get("web-file-url"), true));
            userFile.setFileType(file.getContentType());
            userFile.setUploadTime(new Date());

            this.baseMapper.insert(userFile);
        }

        return result;
    }


    /**
     * 同一个线程中获取用户，用户是在用户请求经过TokenAuthFilter过滤器的时候添加的
     *
     * @return
     */
    private User getUser() {
        String username = TokenAuthFilter.userNameThreadLocal.get();

        // System.out.println("username" + username);
        return userService.selectUserByName(username);
    }


    /**
     * 获取用户的文件分页数据
     *
     * @param params
     * @return
     */
    @Override
    public PageUtils queryAllFileListByPage(Map<String, Object> params) {

        User user = getUser();


        // 条件查询
        LambdaQueryWrapper<UserFile> userFileLambdaQueryWrapper = new LambdaQueryWrapper<>();
        userFileLambdaQueryWrapper.eq(UserFile::getUserId, user.getId());
        userFileLambdaQueryWrapper.eq(UserFile::getIsDelete, 0);
        if (!StringUtils.isNullOrEmpty((String) params.get("key")) && params.get("key") != null) {
            userFileLambdaQueryWrapper.and(query -> {
                query.like(UserFile::getFileName, params.get("key"))
                        .or().like(UserFile::getFileType, params.get("key"));

            });
        }

        IPage<UserFile> page = this.page(new QueryPage<UserFile>().getPage(params, true), userFileLambdaQueryWrapper);

        List<UserFile> records = page.getRecords();

        records.stream().map(item -> {
            item.setFile(uploadPlusProperties.getBaseUrl() + item.getFile());
            return item;
        }).collect(Collectors.toList());

        return new PageUtils(page);
    }


    /**
     * 批量文件上传
     *
     * @param files
     * @return
     */
    @Override
    @Transactional(readOnly = false)
    public R multiUpload(List<MultipartFile> files) {

        R result = new R();

        for (MultipartFile file : files) {
            result = fileUpload.build().singleFileUpload(file);

            if (result.parseCode() >= 10000 && result.parseCode() <= 20000) {
                String originalFilename = file.getOriginalFilename();
                String fileName = originalFilename.substring(0, originalFilename.lastIndexOf("."));

                User user = this.getUser();

                UserFile userFile = new UserFile();
                userFile.setUserId(user.getId());
                userFile.setFileName(fileName);
                userFile.setFile(fileUpload.build().extractFileFullPath((String) result.get("web-file-url"), true));
                userFile.setFileType(file.getContentType());
                userFile.setUploadTime(new Date());

                this.baseMapper.insert(userFile);
            }
            break;
        }

        return result;

    }


    /**
     * 获取用户所有的图片文件分页数据
     *
     * @param params
     * @return
     */
    @Override
    public PageUtils queryAllImageFileListByPage(Map<String, Object> params) {
        User user = getUser();

        IPage<UserFile> page = this.page(new QueryPage<UserFile>().getPage(params, true),
                new LambdaQueryWrapper<UserFile>().eq(UserFile::getUserId, user.getId()).eq(UserFile::getIsDelete, 0).in(UserFile::getFileType, Constant.IMAGE_CONTENT_TYPES));

        List<UserFile> records = page.getRecords();

        records.stream().map(item -> {
            item.setFile(uploadPlusProperties.getBaseUrl() + item.getFile());
            return item;
        }).collect(Collectors.toList());

        return new PageUtils(page);
    }

    /**
     * 获取用户所有的音频文件分页数据
     *
     * @param params
     * @return
     */
    @Override
    public PageUtils queryAllAudioFileListByPage(Map<String, Object> params) {
        User user = getUser();

        IPage<UserFile> page = this.page(new QueryPage<UserFile>().getPage(params, true),
                new LambdaQueryWrapper<UserFile>().eq(UserFile::getUserId, user.getId()).eq(UserFile::getIsDelete, 0).in(UserFile::getFileType, Constant.AUDIO_CONTENT_TYPES));

        List<UserFile> records = page.getRecords();

        records.stream().map(item -> {
            item.setFile(uploadPlusProperties.getBaseUrl() + item.getFile());
            return item;
        }).collect(Collectors.toList());

        return new PageUtils(page);
    }


    /**
     * 获取用户所有的视频文件分页数据
     *
     * @param params
     * @return
     */
    @Override
    public PageUtils queryAllVideoFileListByPage(Map<String, Object> params) {
        User user = getUser();

        IPage<UserFile> page = this.page(new QueryPage<UserFile>().getPage(params, true),
                new LambdaQueryWrapper<UserFile>().eq(UserFile::getUserId, user.getId()).eq(UserFile::getIsDelete, 0).in(UserFile::getFileType, Constant.VIDEO_CONTENT_TYPES));

        List<UserFile> records = page.getRecords();

        records.stream().map(item -> {
            item.setFile(uploadPlusProperties.getBaseUrl() + item.getFile());
            return item;
        }).collect(Collectors.toList());

        return new PageUtils(page);
    }


    /**
     * 获取当前用户或者所有用户的各种文件的个数 作为前端的统计数据
     *
     * @param currentUser
     * @return
     */
    @Override
    public List<StatisticalDataVo> allStatisticalData(Boolean currentUser) {


        List<StatisticalDataVo> statisticalDataVoList = new ArrayList<>();

        // 获取当前用户
        User user = getUser();

        // 统计图片
        LambdaQueryWrapper<UserFile> imageWrapper = new LambdaQueryWrapper<>();
        if (currentUser) {
            imageWrapper.eq(currentUser, UserFile::getUserId, user.getId()).eq(UserFile::getIsDelete, 0);
        }
        imageWrapper.in(UserFile::getFileType, Constant.IMAGE_CONTENT_TYPES);

        Integer imageFileCount = this.baseMapper.selectCount(imageWrapper);
        StatisticalDataVo statisticalAllImageData = new StatisticalDataVo();
        statisticalAllImageData.setValue(imageFileCount);
        statisticalAllImageData.setName(Constant.IMAGE_STATISTICAL_NAME);

        // 统计视频
        LambdaQueryWrapper<UserFile> videoWrapper = new LambdaQueryWrapper<>();
        if (currentUser) {
            videoWrapper.eq(currentUser, UserFile::getUserId, user.getId()).eq(UserFile::getIsDelete, 0);
        }
        videoWrapper.in(UserFile::getFileType, Constant.VIDEO_CONTENT_TYPES);

        Integer videoFileCount = this.baseMapper.selectCount(videoWrapper);
        StatisticalDataVo statisticalAllVideoData = new StatisticalDataVo();
        statisticalAllVideoData.setValue(videoFileCount);
        statisticalAllVideoData.setName(Constant.VIDEO_STATISTICAL_NAME);

        // 统计音频
        LambdaQueryWrapper<UserFile> audioWrapper = new LambdaQueryWrapper<>();
        if (currentUser) {
            audioWrapper.eq(currentUser, UserFile::getUserId, user.getId()).eq(UserFile::getIsDelete, 0);
        }
        audioWrapper.in(UserFile::getFileType, Constant.AUDIO_CONTENT_TYPES);

        Integer audioFileCount = this.baseMapper.selectCount(audioWrapper);
        StatisticalDataVo statisticalAllaudioData = new StatisticalDataVo();
        statisticalAllaudioData.setValue(audioFileCount);
        statisticalAllaudioData.setName(Constant.AUDIO_STATISTICAL_NAME);

        // 统计其他项目
        ArrayList typeList = new ArrayList(Arrays.asList(Constant.IMAGE_CONTENT_TYPES));
        typeList.addAll(Arrays.asList(Constant.VIDEO_CONTENT_TYPES));
        typeList.addAll(Arrays.asList(Constant.AUDIO_CONTENT_TYPES));

        LambdaQueryWrapper<UserFile> otherWrapper = new LambdaQueryWrapper<>();
        if (currentUser) {
            otherWrapper.eq(currentUser, UserFile::getUserId, user.getId()).eq(UserFile::getIsDelete, 0);
        }
        otherWrapper.notIn(UserFile::getFileType, typeList);


        Integer otherFileCount = this.baseMapper.selectCount(otherWrapper);
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
     *
     * @param params
     * @return
     */
    @Override
    public PageUtils superAdminAllFilePage(Map<String, Object> params) {

        List<Long> userIds = new ArrayList<>();

        // 查询条件
        LambdaQueryWrapper<UserFile> userFileLambdaQueryWrapper = new LambdaQueryWrapper<>();

        if (!StringUtils.isNullOrEmpty((String) params.get("key")) && params.get("key") != null) {
            userIds = userService.selectUserLikeName((String) params.get("key"));
            userFileLambdaQueryWrapper.in(userIds.size() > 0, UserFile::getUserId, userIds).or().like(UserFile::getFileType, params.get("key")).or().like(UserFile::getFileName, params.get("key"));
        }


        userFileLambdaQueryWrapper.eq(UserFile::getIsDelete, 0);
        IPage<UserFile> page = this.page(new QueryPage<UserFile>().getPage(params, true), userFileLambdaQueryWrapper);

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
     * 获取当前用户所有的文件路径
     *
     * @return
     */
    @Override
    public List<String> queryCurrentUserAllFilePath() {
        User user = getUser();
        List<UserFile> userFileList = this.baseMapper.selectList(new LambdaQueryWrapper<UserFile>().eq(UserFile::getUserId, user.getId()));

        return userFileList.stream().map(item -> item.getFile()).collect(Collectors.toList());

    }

    /**
     * 获取已经删除可以恢复的文件
     *
     * @param params
     * @return
     */
    @Override
    public PageUtils queryAllDeleteFile(Map<String, Object> params) {

        User user = getUser();

        // 查询字典值
        SysDict dictByParentAndSelfCode = sysDictService.findDictByParentAndSelfCode(Constant.SYSTEM_DEFAULT_SETTING_DICT_PARENT_CODE, Constant.SYSTEM_DEFAULT_SETTING_DICT_FILE_DELETE_EXPIRE_TIME);

        Long expireHour = Long.valueOf(dictByParentAndSelfCode.getDictValue());
        // 条件查询
        LambdaQueryWrapper<UserFile> userFileLambdaQueryWrapper = new LambdaQueryWrapper<>();
        userFileLambdaQueryWrapper.eq(UserFile::getUserId, user.getId());
        userFileLambdaQueryWrapper.eq(UserFile::getIsDelete, 1);
        if (!StringUtils.isNullOrEmpty((String) params.get("key")) && params.get("key") != null) {
            userFileLambdaQueryWrapper.and(query -> {
                query.like(UserFile::getFileName, params.get("key"))
                        .or().like(UserFile::getFileType, params.get("key"));

            });
        }

        IPage<UserFile> page = this.page(new QueryPage<UserFile>().getPage(params, true), userFileLambdaQueryWrapper);

        List<UserFile> records = page.getRecords();

        records.stream().map(item -> {
            item.setExpire(TimeUnit.MILLISECONDS.toHours((TimeUnit.HOURS.toMillis(expireHour) + item.getDeleteTime().getTime()) - System.currentTimeMillis()));
            return item;
        }).collect(Collectors.toList());

        return new PageUtils(page);

    }

    /**
     * 删除满足时间的文件 彻底删除 定时任务 清除
     */
    @Override
    @Transactional(readOnly = false)
    public void trueDeleteExpireFile() {
        // 获取字典值
        SysDict dictByParentAndSelfCode = sysDictService.findDictByParentAndSelfCode(Constant.SYSTEM_DEFAULT_SETTING_DICT_PARENT_CODE, Constant.SYSTEM_DEFAULT_SETTING_DICT_FILE_DELETE_EXPIRE_TIME);
        Long expireHour = Long.valueOf(dictByParentAndSelfCode.getDictValue());

        List<UserFile> userFileList = this.baseMapper.selectList(new LambdaQueryWrapper<UserFile>().eq(UserFile::getIsDelete, 1));

        if (userFileList != null && userFileList.size() > 0) {
            List<UserFile> timeOutFileList = userFileList.stream().filter(item -> TimeUnit.MILLISECONDS.toHours((TimeUnit.HOURS.toMillis(expireHour) + item.getDeleteTime().getTime()) - System.currentTimeMillis()) <= 0).collect(Collectors.toList());

            if (timeOutFileList != null && timeOutFileList.size() > 0) {
                List<String> timeOutFilePath = timeOutFileList.stream().map(item -> item.getFile()).collect(Collectors.toList());

                List<Long> timeOutFileIds = timeOutFileList.stream().map(item -> item.getId()).collect(Collectors.toList());

                R deleteResponse = fileUpload.build().batchFileClear(timeOutFilePath);

                if (deleteResponse.parseCode() > 10000) {
                    this.baseMapper.deleteBatchIds(timeOutFileIds);
                }
            }
        }
    }

    /**
     * 根据文件id恢复文件
     *
     * @param fileId
     */
    @Override
    @Transactional(readOnly = false)
    public void fileRecovery(String fileId) {
        // 恢复文件 修改删除状态
        UserFile file = this.getById(fileId);
        file.setIsDelete(0);

        this.updateById(file);
    }


    /**
     * 手动彻底删除文件
     *
     * @param fileId
     */
    @Transactional(readOnly = false)
    @Override
    public void trueDeleteFile(String fileId) {

        UserFile file = this.getById(fileId);

        R deleteResponse = fileUpload.build().singleFileClear(file.getFile());

        if (deleteResponse.parseCode() > 10000) {
            this.baseMapper.deleteById(fileId);
        }
    }

    /**
     * 统计所有用户上周的数据
     *
     * @return
     */
    @Override
    public List<MessageSendVo> statisticalLastWeekData() {

        LocalDateTime now = LocalDateTime.now();
        LocalDateTime lastMondayStart = now.minusWeeks(1).with(DayOfWeek.MONDAY).with(LocalTime.MIN);
        LocalDateTime lastSundayEnd = now.minusWeeks(1).with(DayOfWeek.SUNDAY).with(LocalTime.MAX);

        List<MessageSendVo> messageSendVoList = null;

        // 获取所有的用户
        List<User> userList = userService.getUserList();

        messageSendVoList = userList.stream().map(user -> {

            MessageSendVo messageSendVo = new MessageSendVo();
            messageSendVo.setUserName(user.getUsername());
            messageSendVo.setEmail(user.getEmail());

            // 统计图片文件个数
            LambdaQueryWrapper<UserFile> imageWrapper = new LambdaQueryWrapper<>();
            imageWrapper.eq(UserFile::getUserId, user.getId()).eq(UserFile::getIsDelete, 0);
            imageWrapper.in(UserFile::getFileType, Constant.IMAGE_CONTENT_TYPES);
            imageWrapper.between(UserFile::getUploadTime, lastMondayStart, lastSundayEnd);
            Integer imageFileCount = this.baseMapper.selectCount(imageWrapper);

            // 统计音频文件个数
            LambdaQueryWrapper<UserFile> audioWrapper = new LambdaQueryWrapper<>();
            audioWrapper.eq(UserFile::getUserId, user.getId()).eq(UserFile::getIsDelete, 0);
            audioWrapper.in(UserFile::getFileType, Constant.AUDIO_CONTENT_TYPES);
            audioWrapper.between(UserFile::getUploadTime, lastMondayStart, lastSundayEnd);
            Integer audioFileCount = this.baseMapper.selectCount(audioWrapper);

            // 统计视频文件个数
            LambdaQueryWrapper<UserFile> videoWrapper = new LambdaQueryWrapper<>();
            videoWrapper.eq(UserFile::getUserId, user.getId()).eq(UserFile::getIsDelete, 0);
            videoWrapper.in(UserFile::getFileType, Constant.VIDEO_CONTENT_TYPES);
            videoWrapper.between(UserFile::getUploadTime, lastMondayStart, lastSundayEnd);
            Integer videoFileCount = this.baseMapper.selectCount(videoWrapper);

            // 统计其他文件个数
            ArrayList typeList = new ArrayList(Arrays.asList(Constant.IMAGE_CONTENT_TYPES));
            typeList.addAll(Arrays.asList(Constant.VIDEO_CONTENT_TYPES));
            typeList.addAll(Arrays.asList(Constant.AUDIO_CONTENT_TYPES));

            LambdaQueryWrapper<UserFile> otherWrapper = new LambdaQueryWrapper<>();
            otherWrapper.eq(UserFile::getUserId, user.getId()).eq(UserFile::getIsDelete, 0);
            otherWrapper.notIn(UserFile::getFileType, typeList);
            otherWrapper.between(UserFile::getUploadTime, lastMondayStart, lastSundayEnd);
            Integer otherFileCount = this.baseMapper.selectCount(otherWrapper);

            // 统计总文件个数
            LambdaQueryWrapper<UserFile> totalWarapper = new LambdaQueryWrapper<>();
            totalWarapper.eq(UserFile::getUserId, user.getId()).eq(UserFile::getIsDelete, 0);
            totalWarapper.between(UserFile::getUploadTime, lastMondayStart, lastSundayEnd);
            Integer totalFileCount = this.baseMapper.selectCount(totalWarapper);


            messageSendVo.setTotalCount(totalFileCount);
            messageSendVo.setAudioCount(audioFileCount);
            messageSendVo.setVideoCount(videoFileCount);
            messageSendVo.setImageCount(imageFileCount);
            messageSendVo.setOtherCount(otherFileCount);

            return messageSendVo;

        }).collect(Collectors.toList());

        return messageSendVoList;


    }


    /**
     * 删除文件
     *
     * @param userFile
     * @return
     */
    @Override
    @Transactional(readOnly = false)
    public R deleteFile(UserFile userFile) {
        // 原始删除
        //  R deleteResponse = fileUpload.build().singleFileClear(userFile.getFile());

        // if (deleteResponse.parseCode() > 10000) {
        //     this.baseMapper.deleteById(userFile.getId());
        // }

        // 逻辑删除
        try {
            userFile.setFile(null);
            userFile.setIsDelete(1);
            userFile.setDeleteTime(new Date());
            this.updateById(userFile);

            return R.ok(REnum.WEB_FILE_SINGLE_DELETE_SUCCESS.getStatusCode(),
                    REnum.WEB_FILE_SINGLE_DELETE_SUCCESS.getStatusMsg());
        } catch (Exception e) {
            e.printStackTrace();
        }

        return R.error(REnum.WEB_FILE_SINGLE_DELETE_FAIL.getStatusCode(),
                REnum.WEB_FILE_SINGLE_DELETE_FAIL.getStatusMsg());
    }


    public static void main(String[] args) {
        List<Long> r = new ArrayList<>();
        System.out.println(r.size());
    }
}
