package com.somg.image.generator.jwt;

import com.baomidou.mybatisplus.core.toolkit.ObjectUtils;
import com.somg.web.file.generator.WebImageGeneratorApplication;
import com.somg.web.file.generator.action.SysDictService;
import com.somg.web.file.generator.constant.Constant;
import com.somg.web.file.generator.pojo.SysDict;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

/**
 * @author somg
 * @date 2023/6/25 13:42
 * @do 字典测试
 */
@SpringBootTest(classes = WebImageGeneratorApplication.class)
@RunWith(SpringRunner.class)
public class DictTest {



    @Autowired
    private SysDictService sysDictService;
    @Test
    public void dictCodeTest(){
        SysDict dailySendSwitch = sysDictService.findDictByParentAndSelfCode(Constant.TIMED_TASK_PROPERTIES_DICT_PARENT_CODE, Constant.DAILY_SEND_MESSAGE_SWITCH_DICT_CODE);
        if (ObjectUtils.isNotEmpty(dailySendSwitch)){
            System.out.println("hajfoe");
        }
    }


}
