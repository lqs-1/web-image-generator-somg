package com.somg.web.file.generator.utils.Pagination;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.metadata.OrderItem;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.somg.web.file.generator.constant.Constant;

import java.util.Map;



/**
 * @author somg
 * @date 2023/3/20 12:02
 * @do 封装前端的分页参数的对象
 */
public class QueryPage<T> {
    public IPage<T> getPage(Map<String, Object> param){
        return getPage(param, false);
    }

    /**
     * 根据前端传递的参数来封装IPage分页对象
     * @param params
     * @param isDesc
     * @return
     */
    public IPage<T> getPage(Map<String, Object> params, Boolean isDesc) {
        //分页参数
        long curPage = 1;
        long limit = 10;

        if(params.get(Constant.PAGE) != null){
            curPage = Long.parseLong((String)params.get(Constant.PAGE));
        }

        if(params.get(Constant.LIMIT) != null){
            limit = Long.parseLong((String)params.get(Constant.LIMIT));
        }
        //分页对象
        Page<T> page = new Page<>(curPage, limit);

        /**
         * 排序操作
         */
        if(isDesc){
            if(params.get(Constant.ORDERFILED) != null){
                // 0是升序1是降序
                if(params.get(Constant.ORDERTYPE) != null){
                    if(Long.parseLong((String)params.get(Constant.ORDERTYPE)) == 0){
                        page.addOrder(OrderItem.asc((String) params.get(Constant.ORDERFILED)));
                    }else if (Long.parseLong((String)params.get(Constant.ORDERTYPE)) == 1){
                        page.addOrder(OrderItem.desc((String) params.get(Constant.ORDERFILED)));
                    }
                }
                return page;
            }
        }
        return page;
    }
}
