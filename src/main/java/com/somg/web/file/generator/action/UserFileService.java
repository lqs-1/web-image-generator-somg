package com.somg.web.file.generator.action;

import com.baomidou.mybatisplus.extension.service.IService;
import com.somg.web.file.generator.pojo.UserFile;
import com.somg.web.file.generator.utils.Pagination.PageUtils;
import com.somg.web.file.generator.utils.R;
import com.somg.web.file.generator.vo.StatisticalDataVo;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

/**
 * @author somg
 * @date 2023/3/19 18:07
 * @do 用户文件接口
 */
public interface UserFileService extends IService<UserFile> {
    R singleUpload(MultipartFile file);

    PageUtils queryAllFileListByPage(Map<String, Object> params);

    R deleteFile(UserFile userFile);

    R multiUpload(List<MultipartFile> files);

    PageUtils queryAllImageFileListByPage(Map<String, Object> params);

    PageUtils queryAllAudioFileListByPage(Map<String, Object> params);

    PageUtils queryAllVideoFileListByPage(Map<String, Object> params);

    List<StatisticalDataVo> allStatisticalData(Boolean currentUser);

    PageUtils superAdminAllFilePage(Map<String, Object> params);

    List<String> queryCurrentUserAllFilePath();
}
