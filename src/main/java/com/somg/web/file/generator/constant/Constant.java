package com.somg.web.file.generator.constant;

import java.util.Arrays;

/**
 * @author somg
 * @date 2023/1/16 12:35
 * @do 系统常量
 */
public class Constant {

    // 单张网络图片生成目录
    public static final String WEB_FILE_SINGLE_GENERATE_DIR = "somgWebFileSingleGenerate";
    // 批量网络图片生成目录
    public static final String WEB_FILE_MULTI_GENERATE_DIR = "somgWebFileMultiGenerate";
    // 响应对象中的图片地址key
    public static final String WEB_FILE_GENERATE_SINGLE_SUCCESS_RESPONSE_NAME = "web-file-url";
    public static final String WEB_FILE_GENERATE_MULTI_SUCCESS_RESPONSE_NAME = "web-file-url-list";


    // 分页参数常量
    public static final String PAGE = "page";
    public static final String LIMIT = "limit";
    public static final String ORDERFILED = "orderFiled";
    public static final String ORDERTYPE = "orderType";





    // 默认添加的角色
    // public static final String COMMON_ROLE = "common";

    // 默认添加的权限
    // public static final String COMMON_PERMISSION = "select";

    // 添加默认菜单权限
    // public static final String COMMON_MENU_AUTH_ONE = "storage";
    // public static final String COMMON_MENU_AUTH_TWO = "chatGPT";
    // public static final String COMMON_MENU_AUTH_THREE = "image";
    // public static final String COMMON_MENU_AUTH_FOUR = "news";
    // public static final String COMMON_MENU_AUTH_FIVE = "tv";



    // 图片的contentType
    public static final String[] IMAGE_CONTENT_TYPES
            = {
            "image/jpeg",
            "image/tiff",
            "image/gif",
            "image/jpeg",
            "image/tiff",
            "image/png",
            "image/x-icon",
            "image/jpeg",
            "image/vnd.wap.wbmp",
            "image/fax",
            "image/pnetvue",
            "image/jpeg",
            "image/vnd.rn-realpix"
    };
    // 统计的时候使用的统计名字
    public static final String IMAGE_STATISTICAL_NAME = "图片";

    // 视频的contentType
    public static final String[] VIDEO_CONTENT_TYPES
            = {
            "video/x-ms-wmv",
            "video/mpeg4",
            "video/avi",
            "video/wma",
            "video/mp4",
            "video/quicktime",
            "video/3gpp",
            "video/webm",
            "video/x-flv",
            "video/mpg",
            "video/vnd.dlna.mpeg-tts",
            "video/vob",
            "video/x-matroska",
            "video/ogg",
    };
    // 统计的时候使用的统计名字
    public static final String VIDEO_STATISTICAL_NAME = "视频";

    // 音频的contentType
    public static final String[] AUDIO_CONTENT_TYPES
            ={
            "audio/mp3",
            "audio/midi",
            "audio/mpeg",
            "audio/webm",
            "audio/ogg",
            "audio/wav",
            "audio/x-wav",
            "audio/x-mpegurl",
            "audio/x-m4a",
            "audio/ogg",
            "audio/x-realaudio",
            "audio/basic",
            "audio/mid",
            "audio/x-aiff",
            "audio/x-pn-realaudio",
    };
    // 统计的时候使用的统计名字
    public static final String AUDIO_STATISTICAL_NAME = "音频";
    // 统计的时候使用的统计名字
    public static final String OTHER_STATISTICAL_NAME = "其他";


    // R对象中使用的常量
    public static final String RESPONSE_CODE_KEY = "code";
    // R对象中使用的常量
    public static final String RESPONSE_MSG_KEY = "msg";
    // 根字典
    public static final String  DICT_TYPE_PARENT = "0";
    // 子字典
    public static final String  DICT_TYPE_SON = "1";

    // 根菜单
    public static final String MENU_TYPE_PARENT = "0";
    // 子菜单
    public static final String MENU_TYPE_SON = "1";
    // 系统默认配置项根字典编码
    public static final String SYSTEM_DEFAULT_SETTING_DICT_PARENT_CODE = "SYSTEM_DEFAULT_SETTING";
    // 系统默认配置项中用户重置默认密码字典编码
    public static final String SYSTEM_DEFAULT_SETTING_DICT_USER_DEFAULT_RESET_PASSWORD = "USER_DEFAULT_PASSWORD";
    public static final String SYSTEM_DEFAULT_SETTING_DICT_USER_DEFAULT_ROLE = "USER_DEFAULT_ROLE";
    public static final String SYSTEM_DEFAULT_SETTING_DICT_USER_DEFAULT_PERMISSION = "USER_DEFAULT_PERMISSION";
    public static final String SYSTEM_DEFAULT_SETTING_DICT_USER_DEFAULT_MENU = "USER_DEFAULT_MENU";
    public static final String SYSTEM_DEFAULT_SETTING_DICT_FILE_DELETE_EXPIRE_TIME = "FILE_DELETE_DEFAULT_EXPIRE_TIME";
    public static final String TIMED_TASK_PROPERTIES_DICT_PARENT_CODE = "TIMED_TASK_PROPERTIES";
    public static final String DAILY_SEND_MESSAGE_SWITCH_DICT_CODE = "DAILY_SEND_MESSAGE_SWITCH";
    public static final String DAILY_SEND_MESSAGE_DICT_CODE = "DAILY_SEND_MESSAGE";
    public static final String DAILY_SEND_SUBJECT_DICT_CODE = "DAILY_SEND_SUBJECT";
    public static final String WEEK_SEND_MESSAGE_SWITCH_DICT_CODE = "WEEK_SEND_MESSAGE_SWITCH";
    public static final String WEEK_SEND_MESSAGE_DICT_CODE = "WEEK_SEND_MESSAGE";
    public static final String WEEK_SEND_SUBJECT_DICT_CODE = "WEEK_SEND_SUBJECT";



    // headers允许前端访问的header字段名
    public static final String ACCESS_CONTROL_EXPOSE_HEADERS = "Access-Control-Expose-Headers";


    public static void main(String[] args) {
        System.out.println(Arrays.asList(IMAGE_CONTENT_TYPES).contains("image/jpeg"));
    }


}
