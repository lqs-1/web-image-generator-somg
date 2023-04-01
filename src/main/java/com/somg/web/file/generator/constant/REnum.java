package com.somg.web.file.generator.constant;

/**
 * @author somg
 * @date 2023/1/16 12:15
 * @do 响应状态码枚举
 */
public enum REnum {


    // 通用成功失败状态码
    SUCCESS(0, "成功"),
    FAIL(1, "失败"),


    // 没有权限
    NO_AUTH(401, "没有权限"),
    NO_LOGIN(402, "没有登录"),
    LOGOUT_SUCCESS_E(1000, "注销成功"),

    // 业务需求状态码
    WEB_FILE_GENERATE_SUCCESS(10000, "网页文件生成成功"),
    WEB_FILE_GENERATE_FAIL(20000, "网页文件生成失败"),


    NETWORK_CONNECT_FAIL(20001, "网络连接失败"),

    WEB_FILE_SINGLE_DELETE_SUCCESS(10003,"网页文件单个文件删除成功"),
    WEB_FILE_SINGLE_DELETE_FAIL(20003,"网页文件单个文件删除失败"),
    WEB_FILE_MULTI_DELETE_SUCCESS(10004,"网页文件批量文件删除成功"),
    WEB_FILE_MULTI_DELETE_FAIL(20004,"网页文件批量文件删除失败"),





    WELCOME_MAIN(11000, "欢迎来到主页"),
    PLEASE_LOGIN(21000, "请先登录"),
    DATABASE_ERROR(21001, "数据库链接错误"),
    VALIDATE_CODE_ERROR(21002, "验证码错误"),
    USER_DOES_NOT_EXIST(21003, "用户不存在"),
    USER_PASSWORD_ERROR(21004, "用户密码错误"),
    LOGIN_SUCCESS(11001, "登录成功"),
    LOGOUT_SUCCESS(11002, "注销成功"),
    ADD_USER_SUCCESS(11003, "用户添加成功"),
    ADD_USER_FAIL(21005, "用户添加失败"),
    EDIT_USER_SUCCESS(11004, "用户修改成功"),
    EDIT_USER_FAIL(21006, "用户修改失败"),
    DELETE_USER_SUCCESS(11005, "删除用户成功"),
    DELETE_USER_FAIL(21007, "删除用户失败"),
    GET_USER_LIST_SUCCESS(11006, "获取用户列表成功"),
    GET_USER_LIST_FAIL(21008, "获取用户列表失败"),
    USER_PERMISSIONS_ERROR(21009, "权限不足"),
    LOGIN_FAIL(21010, "登录失败"),
    REGISTER_SUCCESS(11007, "用户注册成功"),
    REGISTER_FAIL(21011, "用户注册失败"),
    ALTER_PASSWORD_SUCCESS(11008, "用户密码修改成功"),
    ALTER_PASSWORD_FAIL(21012, "用户密码修改失败"),
    USER_DOES_EXIST(21013, "用户已经存在，请登录"),
    GET_ROLE_SUCCESS(11009, "获取角色列表成功"),
    GET_ROLE_FAIL(21014, "获取角色列表失败"),
    ROLE_DOES_EXIST(21015, "角色已经存在"),
    ROLE_ADD_SUCCESS(11010, "角色添加成功"),
    ROLE_ADD_FAIL(21016, "角色添加失败"),
    ROLE_EDIT_SUCCESS(11011, "角色修改成功"),
    ROLE_EDIT_FAIL(21017, "角色修改失败"),
    ROLE_DELETE_SUCCESS(11012, "角色删除成功"),
    ROLE_DELETE_FAIL(21018, "角色删除失败"),
    GET_PERMISSION_SUCCESS(11013, "获取权限列表成功"),
    GET_PERMISSION_FAIL(21019, "获取权限列表失败"),
    PERMISSION_ADD_SUCCESS(11014, "添加权限成功"),
    PERMISSION_ADD_FAIL(21020, "添加权限失败"),
    PERMISSION_DOES_EXIST(21021, "权限已经存在"),
    PERMISSION_EDIT_SUCCESS(11015, "权限修改成功"),
    PERMISSION_EDIT_FAIL(21022, "权限修改失败"),
    PERMISSION_DELETE_SUCCESS(11016, "删除权限成功"),
    PERMISSION_DELETE_FAIL(21023, "删除权限失败"),
    GET_EXIST_ROLE_SUCCESS(11017, "获取已拥有角色列表成功"),
    GET_EXIST_ROLE_FAIL(21024, "获取已拥有角色列表失败"),
    GET_EXIST_PERMISSION_SUCCESS(11018, "获取已拥有权限列表成功"),
    GET_EXIST_PERMISSION_FAIL(21025, "获取已拥有权限列表失败"),


    GET_USER_ALL_FILE_LIST_SUCCESS(11019, "获取用户所有文件成功"),
    GET_USER_ALL_FILE_LIST_FAIL(21026, "获取用户所有文件失败"),

    GET_ALL_PARENT_MENUS_SUCCESS(11020, "获取所有父级菜单成功"),
    GET_ALL_PARENT_MENUS_FAIL(21027, "获取所有父级菜单失败"),

    ADD_MENUS_SUCCESS(11021, "添加菜单成功"),
    ADD_MENUS_FAIL(21028, "添加菜单失败"),

    GET_MENUS_LIST_SUCCESS(11022, "获取菜单列表成功"),
    GET_MENUS_LIST_FAIL(21029, "获取菜单列表失败"),

    DELETE_MENUS_SUCCESS(11023, "删除菜单成功"),
    DELETE_MENUS_FAIL(21030, "删除菜单失败"),

    GET_CHECKED_MENUS_SUCCESS(11024, "获取已有菜单权限成功"),
    GET_CHECKED_MENUS_FAIL(21031, "获取已有菜单权限失败"),

    ALTER_MENUS_AUTH_SUCCESS(11025, "修改菜单权限成功"),
    ALTER_MENUS_AUTH_FAIL(21032, "修改菜单权限失败"),


    GET_USER_ALL_IMAGE_LIST_SUCCESS(11026, "获取用户所有图片文件成功"),
    GET_USER_ALL_IMAGE_LIST_FAIL(21033, "获取用户所有图片文件失败"),

    GET_USER_ALL_VIDEO_LIST_SUCCESS(11027, "获取用户所有视频文件成功"),
    GET_USER_ALL_VIDEO_LIST_FAIL(21034, "获取用户所有视频文件失败"),

    GET_USER_ALL_AUDIO_LIST_SUCCESS(11028, "获取用户所有音频文件成功"),
    GET_USER_ALL_AUDIO_LIST_FAIL(21035, "获取用户所有音频文件失败"),

    GET_ALL_STATISTICAL_SUCCESS(11029, "获取所有统计数据成功"),
    GET_ALL_STATISTICAL_FAIL(21036, "获取所有统计数据失败"),

    GET_ALL_FILE_LIST_SUCCESS(11030, "获取所有文件成功"),
    GET_ALL_FILE_LIST_FAIL(21037, "获取所有文件失败"),

    GET_LOG_LIST_SUCCESS(11031, "获取日志列表成功"),
    GET_LOG_LIST_FAIL(21038, "获取日志列表失败"),

    ;

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
