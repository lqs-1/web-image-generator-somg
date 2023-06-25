package com.somg.web.file.generator.scheduled;

import com.baomidou.mybatisplus.core.toolkit.ObjectUtils;
import com.somg.web.file.generator.action.SysDictService;
import com.somg.web.file.generator.action.UserFileService;
import com.somg.web.file.generator.config.EmailCodeClient;
import com.somg.web.file.generator.constant.Constant;
import com.somg.web.file.generator.constant.REnum;
import com.somg.web.file.generator.pojo.SysDict;
import com.somg.web.file.generator.utils.R;
import com.somg.web.file.generator.vo.MessageSendVo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * @author somg
 * @date 2023/6/25 13:27
 * @do 自动推送消息
 */

@Component
@Slf4j
public class AutoSendMessageScheduled {

    @Autowired
    private SysDictService sysDictService;

    @Autowired
    private UserFileService userFileService;

    @Autowired
    private EmailCodeClient emailCodeClient;


    /**
     * 这个方法是用来玩的
     */

    @Scheduled(cron = "*/50 * * * * *")
    public void dailySendMessage(){
        SysDict dailySendSwitch = sysDictService.findDictByParentAndSelfCode(Constant.TIMED_TASK_PROPERTIES_DICT_PARENT_CODE, Constant.DAILY_SEND_MESSAGE_SWITCH_DICT_CODE);
        if (ObjectUtils.isNotEmpty(dailySendSwitch) && dailySendSwitch.getDictValue().equals("0")){
            SysDict dailySendMessage = sysDictService.findDictByParentAndSelfCode(Constant.TIMED_TASK_PROPERTIES_DICT_PARENT_CODE, Constant.DAILY_SEND_MESSAGE_DICT_CODE);
            SysDict dailySendSubJect = sysDictService.findDictByParentAndSelfCode(Constant.TIMED_TASK_PROPERTIES_DICT_PARENT_CODE, Constant.DAILY_SEND_SUBJECT_DICT_CODE);
            emailCodeClient.sendSimpleEmail("3228949325@qq.com", dailySendMessage.getDictValue() , dailySendSubJect.getDictValue());
            log.info("dailySendMessage方法发给向金花 ===> 3228949325@qq.com");
        }
    }


    /**
     * 统计每个用户每周的文件上传的数据(这周统计上周)
     * 每周一上午8点推送一次
     */
    @Scheduled(cron = "0 0 8 ? * 1")
    public void weekSendMessage(){

        SysDict weekSendSwitch = sysDictService.findDictByParentAndSelfCode(Constant.TIMED_TASK_PROPERTIES_DICT_PARENT_CODE, Constant.WEEK_SEND_MESSAGE_SWITCH_DICT_CODE);
        if (ObjectUtils.isNotEmpty(weekSendSwitch) && weekSendSwitch.getDictValue().equals("0")){
            SysDict weekSendMessage = sysDictService.findDictByParentAndSelfCode(Constant.TIMED_TASK_PROPERTIES_DICT_PARENT_CODE, Constant.WEEK_SEND_MESSAGE_DICT_CODE);
            SysDict weekSendSubJect = sysDictService.findDictByParentAndSelfCode(Constant.TIMED_TASK_PROPERTIES_DICT_PARENT_CODE, Constant.WEEK_SEND_SUBJECT_DICT_CODE);


            List<MessageSendVo> sendVoList = userFileService.statisticalLastWeekData();

            sendVoList.stream().forEach(messageSend -> {
                emailCodeClient.sendSimpleEmail(messageSend.getEmail(),
                        "<h3>尊敬的用户：" + messageSend.getUserName() + "</h3>" + weekSendMessage.getDictValue()
                                + "<br>您上周上传文件" + messageSend.getTotalCount() +
                                "个,其中图片"+ messageSend.getImageCount() +
                                "个,视频" + messageSend.getVideoCount() +
                                "个,音频" + messageSend.getAudioCount() +
                                "个,其他" + messageSend.getOtherCount() + "个"
                        , weekSendSubJect.getDictValue());
                log.info("每周发送 ====> " + messageSend.getEmail() + " ===> 用户 ===> " + messageSend.getUserName());
                try {
                    Thread.sleep(60000);
                } catch (InterruptedException e) {
                    throw new RuntimeException(e);
                }
            });


        }

    }



}
