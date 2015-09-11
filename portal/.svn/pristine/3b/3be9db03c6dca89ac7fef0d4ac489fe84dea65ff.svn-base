/**
 * 银行公钥：测试环境上请到这里下载：http://www.cmbc.com.cn/cmbc/ca/testcmbc.cer
 */
package com.ifunpay.portal.model.cmbc;

import Union.DecryptAndCheck;
import Union.JnkyServer;
import Union.UnionException;
import org.apache.log4j.Logger;



public class MBECShopSecurity {
    private static Logger logger = Logger.getLogger(MBECShopSecurity.class);
    String ecShopPrivateKeyPwd = "1111";
    String ecShopPrivateKey = this.getClass().getResource("/security/cmbc/06005.pfx").getPath();
    String bankPublicKey = this.getClass().getResource("/security/cmbc/cmbc2015der.cer").getPath();

    /**
     * 商户加密订单
     */
    public String encryptOrder(String orderPlain) {
        logger.debug("orderPlain:" + orderPlain);
        JnkyServer my = null;
        try {
            my = new JnkyServer(bankPublicKey, ecShopPrivateKey, ecShopPrivateKeyPwd);
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (my == null)
            return "JnkyServer is null";
        String data = "";
        try {
            data = my.EnvelopData(orderPlain);
            logger.info("加密中。。。。。。。。。。。。。" + orderPlain);
        } catch (Exception e) {
            e.printStackTrace();
        }
        logger.debug("商户加密订单:" + data);
        return data;
    }

    /**
     * 商户解密交易结果
     *
     * @param tradeResultEncrypt 交易结果明文
     * @return 解密后的交易结果
     */
    public String decryptTradeResult(String tradeResultEncrypt)
            throws UnionException, Exception {
        JnkyServer my1 = new JnkyServer(bankPublicKey, ecShopPrivateKey, ecShopPrivateKeyPwd);
        String plainText = my1.DecryptData(tradeResultEncrypt);
        logger.debug("商户解密交易结果:" + plainText);

        return plainText;
    }


    //商户解密用户登录信息
    public String readusr(String usrInfo) throws UnionException {

        logger.info("解密登录信息中。。。。。。。。。。。。。。。。。。。。。。");
        String password = "14B1B7EB4DF4928A9D0FECA796EA5E9C14B1B7EB4DF4928A9D0FECA796EA5E9C14B1B7EB4DF4928A9D0FECA796EA5E9C14B1B7EB4DF4928A9D0FECA796EA5E9C14B1B7EB4DF4928A9D0FECA796EA5E9C14B1B7EB4DF4928A9D0FECA796EA5E9C14B1B7EB4DF4928A9D0FECA796EA5E9C14B1B7EB4DF4928A9D0FECA796EA5E9C14B1B7EB4DF4928A9D0FECA796EA5E9C";
        DecryptAndCheck decryptAndCheck = new DecryptAndCheck();
        String decryptContentStr = decryptAndCheck.decryptAndCheck(usrInfo, password);
        return decryptContentStr;

    }

    public static void main(String[] args) {
        String plaintext = "GNtZIo1zbDbjGHr8GwZz0imTgJI881NQqRd8n0bjOB8FeCWY206drlo/SuApBF6xwKCA4Uid1RkB\n" +
                "Z0sWeD8K9vSMtIGCPGwk2EBHVFoCr28=";
        MBECShopSecurity mbecShopSecurity = new MBECShopSecurity();
        try {
            String param = mbecShopSecurity.readusr(plaintext);
            logger.debug(">>>>" + param);
        } catch (UnionException e) {
            e.printStackTrace();
        }
    }

}

