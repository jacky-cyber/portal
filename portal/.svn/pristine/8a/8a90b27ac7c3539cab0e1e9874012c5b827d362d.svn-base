package com.ifunpay.portal.service;

import com.ifunpay.portal.ProjectXml;
import com.ifunpay.portal.model.cmbc.MBECShopSecurity;
import com.ifunpay.util.network.HttpStatusClient;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;

/**
 * Created by David on 2015/1/19.
 */
@Service
public class CmbcRefundService {
    private Logger logger = LoggerFactory.getLogger(CmbcRefundService.class);
    /**
     * @param orderId  订单Id
     * @param amount   金额 分
     * @param refundId 退款单号  同一个订单退多次  refundId 不能重复 15位以内
     * @return
     */
    public HashMap Refund(String orderId, String amount, String refundId) {
        HashMap<String, String> map = new HashMap<>();
        if (!"".equals(orderId)) {
            String dealNo = ProjectXml.getValue("cmbc_dealNo");//请求交易码
            String corpId = ProjectXml.getValue("cmbc_corpId");//商户编号
            SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
            String time = formatter.format(new Date());//退款时间
            String billNo = corpId + orderId;//订单编号
            String refundNo = corpId + refundId;//退款编号
            double d = new Double(amount);
            double yuan = d / 100.0;
            String amounts = new DecimalFormat("#0.00").format(yuan);
            String amountStr = amounts;//退款金额
            String rmark = "test";//备注
            String url = "";//退款情况通知
            StringBuffer sbf = new StringBuffer();
            sbf.append(dealNo).append("|").append(corpId).append("|").append(time).append("|").append(billNo).append("|").append(refundNo).append("|").append(amountStr)
                    .append("|").append(rmark).append("|").append(url);
            logger.info("orderInfo:" + sbf.toString());
            MBECShopSecurity mBECShopSecurity = new MBECShopSecurity();
            String orderInfo = mBECShopSecurity.encryptOrder(sbf.toString());

            HttpStatusClient httpStatusClient = new HttpStatusClient();
            httpStatusClient.addParam("cryptograph", orderInfo);
            String re = null;
            try {
                re = httpStatusClient.doPost(ProjectXml.getValue("cmbc_refund_url"));
            } catch (IOException e) {
                logger.error("", e);
                throw new RuntimeException(e);
            }
            logger.info("响应参数" + re.substring(12));
            String resultParam = "";
            try {
                resultParam = mBECShopSecurity.decryptTradeResult(re.substring(12));
            } catch (Exception e) {
                logger.info("解密异常" + e);
            }
            String[] res = resultParam.split("\\|");
            String refundStatus = res[5]; // refundStatus 为 00：表示退款成功 01：失败； 05：退款中。
            map.put("orderId", orderId); //原订单号
            map.put("refundId", refundId);//退款单号
            map.put("refundStatus", refundStatus);//退款状态
        }
        return map;
    }

}
