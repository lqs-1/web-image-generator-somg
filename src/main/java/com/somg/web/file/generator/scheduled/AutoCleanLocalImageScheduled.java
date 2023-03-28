package com.somg.web.file.generator.scheduled;

import com.somg.web.file.generator.action.FileLocationAction;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

/**
 * @author somg
 * @date 2023/3/28 16:19
 * @do 自动删除本地的图片，放大缩小的
 */

@Component
@EnableScheduling
@EnableAsync
@Slf4j
public class AutoCleanLocalImageScheduled {


    @Autowired
    private FileLocationAction fileLocationAction;


    @Async
    @Scheduled(cron = "*/30 * * * * ?")
    public void autoCleanLocalImageScheduled(){
        try {
            log.info("清除被处理的图片开始了");
            fileLocationAction.selectAllAndDelete();
        }catch (Exception e){
            e.printStackTrace();
        }
    }



}
