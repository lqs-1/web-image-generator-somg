package com.somg.web.file.generator.scheduled;

import com.somg.web.file.generator.action.FileLocationAction;
import com.somg.web.file.generator.action.UserFileService;
import com.somg.web.file.generator.pojo.UserFile;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

/**
 * @author somg
 * @date 2023/5/18 21:50
 * @do 自动删除文件 删除满足时间的文件 彻底删除
 */

@Component
@EnableAsync
@Slf4j
public class AutoTrueDeleteFileScheduled {


    @Autowired
    private UserFileService userFileService;


    @Async
    @Scheduled(cron = "0 0 */2 ? * *") // 每两个小时执行一次
    public void autoCleanLocalImageScheduled(){
        try {
            log.info("自动删除满足时间的文件开始了");
            userFileService.trueDeleteExpireFile();
        }catch (Exception e){
            e.printStackTrace();
        }
    }

}
