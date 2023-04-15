package com.somg.web.file.generator.utils;

import java.util.Random;

/**
 * @author : 李奇凇
 * @date : 2022/5/5 8:46
 * @do : 生成邮件验证码工具类
 */

public class GenerateValidateCodeUtils {

    public static String generateEmailCodeNumber(Integer validateCodeLength){
        //定义取值范围
        String str = "somga0123456789";
        //容量为4
        StringBuilder smsCode = new StringBuilder(validateCodeLength);
        for (int i = 0; i < validateCodeLength; i++) {
            //遍历smsCodeLen次，拿到某个字符并且拼接,nextInt(10)表示每个数的取值范围为[0-10)
            char ch = str.charAt(new Random().nextInt(10));
            smsCode.append(ch);
        }
        return smsCode.toString();

    }


    public static void main(String[] args) {
        String s = GenerateValidateCodeUtils.generateEmailCodeNumber(7);
        System.out.println(s);
    }


}