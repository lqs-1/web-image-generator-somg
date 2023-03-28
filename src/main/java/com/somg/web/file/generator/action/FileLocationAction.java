package com.somg.web.file.generator.action;

import com.baomidou.mybatisplus.extension.service.IService;
import com.somg.web.file.generator.pojo.FileLocation;

import java.util.List;

/**
 * @author somg
 * @date 2023/3/10 8:45
 * @do 本地存储接口（未用）
 */
public interface FileLocationAction extends IService<FileLocation> {
    List<FileLocation> selectAll();

    void selectAllAndDelete();

    void addFileLocation(String imagePath);
}
