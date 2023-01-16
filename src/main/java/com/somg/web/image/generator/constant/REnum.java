package com.somg.web.image.generator.constant;

/**
 * @author somg
 * @date 2023/1/16 12:15
 * @do 响应状态码枚举
 */
public enum REnum {


    // 通用成功失败状态码
    SUCCESS(0, "成功"),
    FAIL(1, "失败"),

    // 业务需求状态码
    WEB_IMAGE_GENERATE_SUCCESS(10000, "网页图片生成成功"),
    WEB_IMAGE_GENERATE_FAIL(20000, "网页图片生成失败"),
    NETWORK_CONNECT_FAIL(20001, "网络连接失败");

    private Integer statusCode;

    private String statusMsg;

    REnum(Integer statusCode, String statusMsg){
        this.statusCode = statusCode;
        this.statusMsg = statusMsg;
    }

    public Integer getStatusCode() {
        return statusCode;
    }

    public String getStatusMsg() {
        return statusMsg;
    }
}
