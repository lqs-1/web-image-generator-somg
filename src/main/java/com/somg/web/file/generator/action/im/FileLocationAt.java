package com.somg.web.file.generator.action.im;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.somg.web.file.generator.action.FileLocationAction;
import com.somg.web.file.generator.mapper.FileLocationMapper;
import com.somg.web.file.generator.pojo.FileLocation;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @author somg
 * @date 2023/3/10 8:51
 * @do 本地存储实现（未用）
 */

@Service
public class FileLocationAt extends ServiceImpl<FileLocationMapper, FileLocation> implements FileLocationAction {

    /**
     * 查询出所有的本地图片地址
     *
     * @return
     */
    @Override
    public List<FileLocation> selectAll() {
        return this.baseMapper.selectList(null);
    }

    /**
     * 删除本地图片 根据地址
     */
    @Override
    @Transactional(readOnly = false)
    public void selectAllAndDelete() {
        List<FileLocation> fileLocations = this.selectAll();

        if (fileLocations.size() > 0){
            fileLocations.stream().forEach(item -> {
                this.baseMapper.deleteById(item.getId());
                try {
                    Files.deleteIfExists(Paths.get(item.getImagePath()));
                } catch (IOException e) {
                    throw new RuntimeException(e);
                }
            });
        }


    }

    /**
     * 保存本地图片地址
     * @param imagePath
     */
    @Override
    @Transactional(readOnly = false)
    public void addFileLocation(String imagePath) {
        FileLocation fileLocation = new FileLocation();
        fileLocation.setImagePath(imagePath);
        this.baseMapper.insert(fileLocation);
    }
}
