package com.jspgou.core.utils;

import org.apache.log4j.Logger;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * 
 *     
 * 项目名称：PORTAL
 * 类名称：MD5test    
 * 类描述：    MD5签名公共类
 * 创建人：xian hong cai (xianhc@ifunpay.com)    
 * 创建时间：2014年10月28日 下午1:37:36    
 * 修改人：  xian hong cai
 * 修改时间：2014年10月28日 下午1:37:36    
 * 修改备注：    
 * @version     
 *
 */
public class CreateMD5 {

    private static final Logger log = Logger.getLogger(CreateMD5.class);
    /**
     * 获取String 字符串的MD5值
     * @param str
     * @return
     * @throws java.io.IOException
     */
	public String getMD5Str(String str)throws IOException {  
        MessageDigest messageDigest = null;
        try {
            messageDigest = MessageDigest.getInstance("MD5");
            messageDigest.reset();
            messageDigest.update(str.getBytes("UTF-8"));
        } catch (NoSuchAlgorithmException e) {
            System.out.println("NoSuchAlgorithmException caught!");
            System.exit(-1);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        byte[] byteArray = messageDigest.digest();

        StringBuffer md5StrBuff = new StringBuffer();

        for (int i = 0; i < byteArray.length; i++) {
            if (Integer.toHexString(0xFF & byteArray[i]).length() == 1)
                md5StrBuff.append("0").append(Integer.toHexString(0xFF & byteArray[i]));
            else
                md5StrBuff.append(Integer.toHexString(0xFF & byteArray[i]));
        }

        return md5StrBuff.toString();
	}
//		 public static void main(String[] args)  {  
//			 MD5test test=new MD5test();
//			 try {
//				test.getMD5Str("12345456676778");
//				System.out.println(test.getMD5Str("ghfghdfhfghfhfhfhfhfhfgh"));
//			} catch (IOException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
//		    }


}
