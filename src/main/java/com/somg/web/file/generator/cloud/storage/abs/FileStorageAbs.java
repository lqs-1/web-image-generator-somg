package com.somg.web.file.generator.cloud.storage.abs;

import com.somg.web.file.generator.cloud.storage.abs.exception.FIleLocalDealErrorException;
import com.somg.web.file.generator.cloud.storage.abs.exception.FIleLocalUpErrorException;
import com.somg.web.file.generator.cloud.storage.abs.itfce.FileStorage;
import com.somg.web.file.generator.cloud.storage.abs.utils.result.LocalFileResult;
import com.somg.web.file.generator.cloud.storage.abs.utils.result.ScaleResult;
import com.somg.web.file.generator.utils.R;
import com.sun.istack.NotNull;
import net.coobird.thumbnailator.Thumbnails;
import org.apache.commons.io.FileUtils;
import org.springframework.util.StringUtils;
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


    // 帮助信息存放map
    protected Map<String, Object> helpMap = new HashMap<String, Object>();

    // url前缀和上传地址
    protected String baseUrl;

    // 上传之后的完整路径
    protected String fullUrl;

    // 上传到哪个文件夹
    protected String type;

    // 上传到哪个桶
    protected String bucketName;

    // 上传完成之后url列表
    protected List<String> fullUrlList = new ArrayList<String>();

    // 缩放的时候缩放后的图片存放的本地目录
    protected String localImageScalePath = "/home/somg/img/scale/";

    // 图片上传本地存储的目录
    protected String localImagePath = "/home/somg/img/local/";


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
     * 对图片进行处理 缩放
     * @param imageInputStream 图片的inputStream
     * @param uploadFileRealPath 图片要上传的路径 [originFileName]
     * @param scale 放大或者缩小 <1表示缩小 >1表示放大
     * @return
     * @throws Exception
     */
    public ScaleResult imageScale(InputStream imageInputStream, String uploadFileRealPath, Float scale) {

        // 生成存储全路径 文件名UUID + 扩展名
        String contentPath = localImageScalePath + UUID.randomUUID().toString().replace("-", "") + "." + StringUtils.getFilenameExtension(uploadFileRealPath);

        //将上传的图片写入本地
        File localOriginImage = null;
        //将写入本地的图片再次读出
        File localDealImage = null;

        //图片在项目中的地址(项目位置) 这里如果文件不存在是不会创建的 要使用localDealImage.createNewFile();才会创建
        localOriginImage = new File(contentPath);

        // 如果这个文件不存在
        if (!localOriginImage.exists()) {
            //Thumbnails处理之后 生成图片文件
            try {
                FileUtils.copyInputStreamToFile(imageInputStream, localOriginImage);
                Thumbnails.of(contentPath)
                        .outputQuality(1.0f)
                        .scale(scale)
                        .outputFormat(contentPath.substring(contentPath.lastIndexOf("."))
                                .replace(".", "")) // 图片格式如 png jpg
                        .toFile(contentPath); // 这个toFile会自动创建目录和文件
            } catch (IOException e) {
                e.printStackTrace();
                throw new FIleLocalDealErrorException();
            }
        }

        // 将这个创建好的图片读出
        localDealImage = new File(contentPath);

        // 填充返回对象
        ScaleResult scaleResult = new ScaleResult();
        try{
            FileInputStream inputStream = new FileInputStream(localDealImage);
            byte[] data = new byte[inputStream.available()];
            inputStream.read(data);
            scaleResult.setData(data);
            scaleResult.setInputStream(inputStream);
            scaleResult.setImagePath(contentPath);
            // 关闭之后才能让异步定时任务删除
            inputStream.close();
        }catch (Exception e){
            e.printStackTrace();
            throw new FIleLocalDealErrorException();
        }

        return scaleResult;

    }


    /**
     * 图片上传存储到本地
     * @param imageInputStream 图片的inputStream
     * @param uploadFileRealPath 图片要上传的路径 [originFileName]
     * @return
     */
    public LocalFileResult imageLocalUp(InputStream imageInputStream, String uploadFileRealPath){

        // 生成存储全路径 文件名UUID + 扩展名
        String contentPath = localImagePath + UUID.randomUUID().toString().replace("-", "") + "." + StringUtils.getFilenameExtension(uploadFileRealPath);

        //将上传的图片写入本地
        File localImageFile = null;

        //图片在项目中的地址(项目位置+图片名,带后缀名) 这里如果文件不存在是不会创建的 要使用localDealImage.createNewFile();才会创建
        localImageFile = new File(contentPath);

        // 创建文件夹
        new File(localImagePath).mkdirs();


        LocalFileResult localFileResult = new LocalFileResult();

        // 将文件创建
        try {
            // 将图片拷贝到本地文件中
            FileUtils.copyInputStreamToFile(imageInputStream, localImageFile);
            localImageFile.createNewFile();

            FileInputStream inputStream = new FileInputStream(localImageFile);
            byte[] data = new byte[inputStream.available()];
            inputStream.read(data);
            localFileResult.setData(data);
            localFileResult.setInputStream(inputStream);
            localFileResult.setImagePath(contentPath);

            // 关闭之后才能让异步定时任务删除
            inputStream.close();
        } catch (IOException e) {
            e.printStackTrace();
            throw new FIleLocalUpErrorException();
        }

        return localFileResult;
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


    public String extractFileFullPath(String fileUrl, Boolean hasBucket){
        return hasBucket ? this.extractFileFullPath(fileUrl) : this.extractFileFullPath(fileUrl).replace(this.bucketName + "/", "");
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
