package com.somg.web.file.generator.controller;

import com.somg.web.file.generator.action.UserFileService;
import com.somg.web.file.generator.constant.REnum;
import com.somg.web.file.generator.utils.R;
import com.somg.web.file.generator.vo.StatisticalDataVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * @author somg
 * @date 2023/3/21 14:21
 * @do 统计控制器
 */
@RestController
@RequestMapping("allStatistical")
public class StatisticalController {

    @Autowired
    private UserFileService userFileService;


    /**
     * 统计所有用户或者当前用户的数据
     * @param currentUser
     * @return
     */
    @GetMapping("allStatisticalData")
    public R requestAllStatisticalData(@RequestParam Boolean currentUser){
        try {

            List<StatisticalDataVo> statisticalAllDataList = userFileService.allStatisticalData(currentUser);
            // System.out.println(statisticalAllDataList);

            return R.ok(REnum.GET_ALL_STATISTICAL_SUCCESS.getStatusCode(),
                    REnum.GET_ALL_STATISTICAL_SUCCESS.getStatusMsg())
                    .put("statisticalAllDataList", statisticalAllDataList);
        }catch (Exception e){
            e.printStackTrace();

            return R.error(REnum.GET_ALL_STATISTICAL_FAIL.getStatusCode(),REnum.GET_ALL_STATISTICAL_FAIL.getStatusMsg());
        }

    }




}
