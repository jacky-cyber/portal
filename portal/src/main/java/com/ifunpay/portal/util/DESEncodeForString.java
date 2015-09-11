package com.ifunpay.portal.util;

import com.ifunpay.util.common.StringUtil;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import java.security.SecureRandom;

/**
 * Created by Conglong Xie on 2015/1/8.
 */
public class DESEncodeForString {
    private static final String EncodeAlgorithm = "DES";
    private static DESEncodeForString instance = null;

    public static DESEncodeForString getInstance() {
        if (instance == null) {
            instance = new DESEncodeForString();
            if (!instance.init()) {
                instance = null;
            }
        }
        return instance;
    }

    private SecretKey key = null;

    private boolean init() {
        try {
            KeyGenerator keygen = KeyGenerator.getInstance(EncodeAlgorithm);
            SecureRandom random = new SecureRandom();
            keygen.init(random);
            key = keygen.generateKey();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return key != null;
    }

    private Cipher getCipher(int mode) {
        try {
            Cipher cipher = Cipher.getInstance(EncodeAlgorithm);
            cipher.init(mode, key);
            return cipher;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public Cipher getEncodeCipher() {
        return this.getCipher(Cipher.ENCRYPT_MODE);
    }

    public Cipher getDecodeCipher() {
        return this.getCipher(Cipher.DECRYPT_MODE);
    }

    /**
     * 解密，若输入为null或加/解密过程出现异常，则输出为null <br/>
     * 参数：<br/>
     *
     * @param str
     * @return
     */
    public String decode(String str) {
        if(str==null)return null;
        Cipher cipher = getDecodeCipher();
        StringBuffer sb = new StringBuffer();
        int blockSize = cipher.getBlockSize();
        int outputSize = cipher.getOutputSize(blockSize);
        byte[] src = stringToBytes(str);
        byte[] outBytes = new byte[outputSize];
        int i = 0;
        try {
            for (; i <= src.length - blockSize; i = i + blockSize) {
                int outLength = cipher.update(src, i, blockSize, outBytes);
                sb.append(new String(outBytes, 0,outLength));
            }
            if (i == src.length)
                outBytes = cipher.doFinal();
            else {
                outBytes = cipher.doFinal(src, i, src.length - i);
            }
            sb.append(new String(outBytes));
            return sb.toString();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 加密，若输入为null或加/解密过程出现异常，则输出为null <br/>
     * 参数：<br/>
     *
     * @param str
     * @return
     */
    public String encode(String str) {
        if(str==null)return null;
        Cipher cipher = getEncodeCipher();
        StringBuffer sb = new StringBuffer();
        int blockSize = cipher.getBlockSize();
        int outputSize = cipher.getOutputSize(blockSize);
        byte[] src = str.getBytes();
        byte[] outBytes = new byte[outputSize];
        int i = 0;
        try {
            for (; i <= src.length - blockSize; i = i + blockSize) {
                int outLength = cipher.update(src, i, blockSize, outBytes);
                sb.append(bytesToString(outBytes, outLength));
            }
            if (i == src.length)
                outBytes = cipher.doFinal();
            else {
                outBytes = cipher.doFinal(src, i, src.length - i);
            }
            sb.append(bytesToString(outBytes));
            return sb.toString();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    private String bytesToString(byte[] bs) {
        if (bs == null || bs.length == 0)
            return "";
        return bytesToString(bs, bs.length);
    }

    private String bytesToString(byte[] bs, int len) {
        if (bs == null || bs.length == 0)
            return "";
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < len; i++) {
            // System.out.println(bs[i]+":"+String.format("%02X", bs[i]));
            sb.append(String.format("%02X", bs[i]));
        }
        return sb.toString();
    }

    private byte[] stringToBytes(String str) {
        if (str == null || str.length() < 2 || str.length() % 2 != 0)
            return new byte[0];
        int len = str.length();
        byte[] bs = new byte[len / 2];
        for (int i = 0; i * 2 < len; i++) {
            bs[i] = (byte) (Integer.parseInt(str.substring(i * 2, i * 2 + 2),
                    16) & 0xFF);
            // System.out.println(str.substring(i * 2, i * 2 + 2)+":"+bs[i]);
        }
        return bs;
    }

    public static String getVoucherCode(String orderId,long amount){
        String resultFinal = "";
        String str = orderId+amount+""+ StringUtil.randomSting(8);
        String tmp = DESEncodeForString.getInstance().encode(str);
        String resultTemp = Math.abs(tmp.hashCode())+"";
        System.out.println("resultTemp is "+resultTemp);
        int rNumber = 12-resultTemp.length();
        System.out.println("number is "+ rNumber);
        if(rNumber > 0){
            resultFinal = resultTemp + StringUtil.randomSting(rNumber);
        }

        return resultFinal;
    }

    public static void main(String[] args) {
        String str = "00000101261"+ StringUtil.generatedRandomNumber(8);
        String tmp = DESEncodeForString.getInstance().encode(str);
        System.out.println("加密结果："+ tmp);
        System.out.println("加密结果hashCode："+ tmp.hashCode());
        String result = Math.abs(tmp.hashCode())+"";
        System.out.println("加密结果HashCode处理之后："+result );
        System.out.println("解密结果："+DESEncodeForString.getInstance().decode(tmp ));
        int rNumber = 12-result.length();
        System.out.println("number is "+rNumber);

        System.out.println("we need is " + result + StringUtil.generatedRandomNumber(rNumber));

        System.out.println("----------------");
        System.out.println(DESEncodeForString.getVoucherCode("0000010126",200));

    }
}
