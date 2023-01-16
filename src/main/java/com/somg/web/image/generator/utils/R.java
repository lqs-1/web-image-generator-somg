package com.somg.web.image.generator.utils;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.somg.web.image.generator.constant.Constant;
import com.somg.web.image.generator.constant.REnum;

import java.util.HashMap;
import java.util.Map;


/**
 * @author somg
 * @date 2023/1/16 12:13
 * @do 网页响应对象
 */
public class R extends HashMap<String,Object>{

    private static final long serialVersionUID = 1L;

    // 获取指定类型的数据
    public <T> T parseType(TypeReference<T> type, String paramName){
        // 从map中获取对应key的值，直接获取是一个Object
        Object originObject = this.get(paramName);
        // 将这个对象转换为字符串
        String objetString = JSON.toJSONString(originObject);
        // 在将字符串转换为指定对象
        T resultObject = JSON.parseObject(objetString, type);
        // 返回结果对象
        return resultObject;

    }


    public Integer parseCode(){
        return this.parseType(new TypeReference<Integer>(){}, Constant.RESPONSE_CODE_KEY);
    }

    public String parseMsg(){
        return this.parseType(new TypeReference<String>(){}, Constant.RESPONSE_MSG_KEY);
    }






    public R() {
        put(Constant.RESPONSE_CODE_KEY, REnum.SUCCESS.getStatusCode());
        put(Constant.RESPONSE_MSG_KEY, REnum.SUCCESS.getStatusMsg());
    }


    public static R error(int code, String msg) {
        R r = new R();
        r.put(Constant.RESPONSE_CODE_KEY, code);
        r.put(Constant.RESPONSE_MSG_KEY, msg);
        return r;
    }

    public static R error() {
        R r = new R();
        r.put(Constant.RESPONSE_CODE_KEY, REnum.FAIL.getStatusCode());
        r.put(Constant.RESPONSE_MSG_KEY, REnum.FAIL.getStatusMsg());
        return r;
    }

    public static R error(String msg) {
        R r = new R();
        r.put(Constant.RESPONSE_CODE_KEY, REnum.FAIL.getStatusCode());
        r.put(Constant.RESPONSE_MSG_KEY, msg);
        return r;
    }

    public static R ok(String msg) {
        R r = new R();
        r.put(Constant.RESPONSE_MSG_KEY, msg);
        return r;
    }

    public static R ok(Integer code, String msg) {
        R r = new R();
        r.put(Constant.RESPONSE_CODE_KEY, code);
        r.put(Constant.RESPONSE_MSG_KEY, msg);
        return r;
    }

    public static R ok(Map<String, Object> map) {
        R r = new R();
        r.putAll(map);
        return r;
    }


    public static R ok() {
        return new R();
    }

    public R put(String key, Object value) {
        super.put(key, value);
        return this;
    }

    public R put(Object value){
        super.put("data", value);
        return this;
    }


}
