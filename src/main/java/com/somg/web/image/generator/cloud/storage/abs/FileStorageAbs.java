package com.somg.web.image.generator.cloud.storage.abs;

import com.aliyun.oss.OSS;
import com.somg.web.image.generator.cloud.storage.abs.exception.FIleLocalDealErrorException;
import com.somg.web.image.generator.cloud.storage.abs.exception.FileUploadErrorException;
import com.somg.web.image.generator.cloud.storage.abs.itfce.FileStorage;
import com.somg.web.image.generator.utils.R;
import com.sun.istack.NotNull;
import net.coobird.thumbnailator.Thumbnails;
import org.apache.commons.io.FileUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.text.SimpleDateFormat;
import java.util.*;


/**
 * @author somg
 * @date 2023/3/1 13:04
 * @do 文件存储抽象类
 */
public abstract class FileStorageAbs implements FileStorage {

    /**
     * 帮助信息存放map
     */
    protected Map<String, Object> helpMap = new HashMap<String, Object>();

    protected String baseUrl;

    protected String fullUrl;

    protected String type;


    protected String bucketName;

    protected List<String> fullUrlList = new ArrayList<String>();

    protected String localFilePath;



    /**
     * 根据文件本地名称来生成加密后的文件名
     * @param fileOriginName 文件本地名字
     * @return
     */
    protected String generatorFileUploadPath(@NotNull String fileOriginName){
        // 根据种类定义文件夹 类别/今天 如果存在就直接存储 不存在就创建 方便按天统计
        String fileUploadDir = type + "/" + new SimpleDateFormat("yyyy-MM-dd").format(new Date()) + "/";
        // 获取原文件的拓展名 lastIndexOf(".")查找”.“在最右边出现的位置 substring从在最右边出现的位置截取到结束（包含）
        String uploadFileExName = fileOriginName.substring(fileOriginName.lastIndexOf("."));
        // 生成uuid唯一文件主体名字
        String uploadFileMainName = UUID.randomUUID().toString().replace("-", "");
        // 真实的上传文件的路径+文件名，不加域名
        String uploadFileRealPath = fileUploadDir + uploadFileMainName + uploadFileExName;

        return uploadFileRealPath;
    }


    /**
     * 对图片进行处理 TODO 并没有做 后面再加上下载功能
     * @param imageInputStream 图片的inputStream
     * @param uploadFileRealPath 图片要上传的路径
     * @return
     * @throws Exception
     */
    protected InputStream imageCompression(InputStream imageInputStream, String uploadFileRealPath) {

        String contentPath = localFilePath + uploadFileRealPath;

        //存的项目的中模版图片
        File localOriginImage = null;
        //上传时从项目中拿到的图片
        File localDelImage = null;

        //图片在项目中的地址(项目位置+图片名,带后缀名)
        localOriginImage = new File(contentPath);

        if (!localOriginImage.exists()) {

            //生成图片文件
            try {
                FileUtils.copyInputStreamToFile(imageInputStream, localOriginImage);
                Thumbnails.of(contentPath)
                        .outputQuality(1f)
                        .scale(3f)
                        .outputFormat(contentPath.substring(contentPath.lastIndexOf("."))
                                .replace(".", ""))
                        .toFile(contentPath);
            } catch (IOException e) {
                throw new FIleLocalDealErrorException();
            }
        }


        localDelImage = new File(contentPath);
        try {
            return new FileInputStream(localDelImage);
        } catch (FileNotFoundException e) {
            throw new FIleLocalDealErrorException();
        }

    }





    /**
     * 单个文件上传
     * @param file 要上传的文件对象
     * @return
     */
    public abstract R singleFileUpload(@NotNull MultipartFile file);


    /**
     * 批量文件上传
     * @param fileList 要上传的所有文件列表
     * @return
     */
    public abstract R multiFileUpload(@NotNull List<MultipartFile> fileList);


    /** oss删除文件是根据文件完成路径删除的，但文件完整路径中不能包含Bucket名称。
     * 比如文件路径为：http://edu-czf.oss-cn-guangzhou.aliyuncs.com/2022/08/abc.jpg",
     * 则完整路径就是：2022/08/abc.jpg
     */

    /**
     * 根据文件在网络上的url地址，提取出他的完整路径
     * @param fileUrl 要删除文件的url
     * @return
     */
    protected String extractFileFullPath(@NotNull String fileUrl){
        //找到文件路径的开始下标
        int begin = baseUrl.length();
        // 截取文件
        return fileUrl.substring(begin);
    }

    /**
     * 单个文件删除
     * @param fileUrl 要被删除文件的url
     * @return
     */
    public abstract R singleFileClear(@NotNull String fileUrl);


    /**
     * 批量删除文件
     * @param fileUrlList 要被删除的文件url列表
     * @return
     */
    public abstract R batchFileClear(@NotNull List<String> fileUrlList);


    /**
     * 重写父类的帮助方法
     * @return
     */
    @Override
    public HashMap<String, Object> help() {

        List<String> methods = new ArrayList<>();
        List<String> fields = new ArrayList<>();

        // 类说明
        helpMap.put("Class", this.getClass().toString());

        // 方法
        Arrays.stream(this.getClass().getMethods()).forEach(method -> {
            methods.add(method.getName());
        });
        helpMap.put("Methods", methods);

        // 参数
        Arrays.stream(this.getClass().getFields()).forEach(field -> {
            fields.add(field.getName());
        });
        helpMap.put("Fields", fields);


        return (HashMap<String, Object>) helpMap;
    }

}
