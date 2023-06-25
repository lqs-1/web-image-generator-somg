package com.somg.web.file.generator.vo;

import lombok.Data;

/**
 * @author somg
 * @date 2023/6/25 14:16
 * @do 消息推送vo
 */

@Data
public class MessageSendVo {
    private String userName;

    private String email;

    private Integer totalCount; // 文件总数量

    private Integer audioCount; // 音频文件数量

    private Integer videoCount; // 视频文件数量

    private Integer imageCount; // 图片文件数量

    private Integer otherCount; // 其余文件数量
}
