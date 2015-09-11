package com.ifunpay.portal.service.lottery;

import com.ifunpay.portal.model.lottery.LotteryAcceptInfo;
import com.ifunpay.util.common.StringUtil;
import com.ifunpay.util.network.HttpStatusClient;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by Yu on 2014/11/25.
 */
@Service
public class HyMobileRechargeService {

    static Logger logger = Logger.getLogger(HyMobileRechargeService.class);

    @Resource
    private HanYinConfigService hanYinConfigService;

    public static void main(String... args) throws IOException, InterruptedException {

    }


    /**
     * 手机充值
     *
     * @return 0: 成功
     * 1: 失败
     * 2：进行中
     * -1：没有该订单
     */
    public int accept(String orderId, Date orderDate, String phone, int cardValue) throws IOException {
        LotteryAcceptInfo lotteryAcceptInfo = new LotteryAcceptInfo();
        lotteryAcceptInfo.setOrderNumber(orderId);
        lotteryAcceptInfo.setOrderDate(orderDate);
        lotteryAcceptInfo.setMobileNumber(new Long(phone));
        lotteryAcceptInfo.setCarValue(cardValue);
        return accept(lotteryAcceptInfo);
    }


    /**
     * @param orderId
     * @param orderDate
     * @return
     * @throws IOException
     */
    public int check(String orderId, Date orderDate) throws IOException {
        HttpStatusClient client1 = new HttpStatusClient();
        String settleDate = new SimpleDateFormat("yyyyMMddHHmmss").format(orderDate);
        String merId = hanYinConfigService.getMobileMerId();
        String sign = StringUtil.getMd5Hex((merId + orderId + settleDate + hanYinConfigService.getKey()).getBytes()).toUpperCase();
        client1.addParam("merId", merId);
        client1.addParam("activityCode", hanYinConfigService.getMobileChargeActivityCode() + "");
        client1.addParam("orderId", orderId);
        client1.addParam("settleDate", settleDate);
        client1.addParam("bisType", hanYinConfigService.getMobileChargeBisType());
        client1.addParam("sign", sign);
        String url = hanYinConfigService.getBaseUrl() + hanYinConfigService.getMobileRechargeCheckAction();
        String rs = client1.doPost(url);
        String statusStr = rs.replaceAll(".*status\\>(.*)\\</status.*", "$1");
        logger.debug("response String: " + rs);
        logger.debug("status: " + statusStr);
        int status = Integer.parseInt(statusStr);

        switch (status) {
            case 0:
                logger.debug("server charged.");
                return 0;
            case 1:
                logger.info("server charge failed.");
                return 1;
            case 2:
                logger.info("server charging, check again later.");
                return 2;
            case -1:
                logger.info("no such order: " + orderId);
                return -1;
            default:
                return -1;
        }
    }


    /**
     * @return 0: 成功
     * 1: 失败
     * 2：进行中
     * -1：没有该订单
     */
    public int accept(LotteryAcceptInfo lotteryAcceptInfo) {

        HttpStatusClient client1 = new HttpStatusClient();
        String settleDate = new SimpleDateFormat("yyyyMMddHHmmss").format(lotteryAcceptInfo.getOrderDate());
        int isSendSms = hanYinConfigService.isWantSendMessage() ? 1 : 0;
        int parValue = lotteryAcceptInfo.getCarValue();
        String orderId = lotteryAcceptInfo.getOrderNumber();
        long phone = lotteryAcceptInfo.getMobileNumber();
        String reserveInfo = "";
        String sign;
        String merId = hanYinConfigService.getMobileMerId();
        String activityCode = hanYinConfigService.getMobileChargeActivityCode();
        String departmentId = hanYinConfigService.getMobileChargeDepartmentId();
        String mdseCode = hanYinConfigService.getMobileChargeMdseCode();
        String key = hanYinConfigService.getKey();
        try {
            sign = StringUtil.getMd5Hex((merId + activityCode + orderId + settleDate + phone + parValue + reserveInfo + departmentId + mdseCode + key).getBytes("GB2312")).toUpperCase();
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException("I think i will not be here.", e);
        }
        client1.addParam("merId", merId);
        client1.addParam("activityCode", activityCode + "");
        client1.addParam("orderId", orderId);
        client1.addParam("settleDate", settleDate);
        client1.addParam("phone", phone + "");
        client1.addParam("isSendSms", isSendSms + "");
        client1.addParam("parValue", parValue + "");
        client1.addParam("departmentId", departmentId);
        client1.addParam("mdseCode", mdseCode);
        client1.addParam("sign", sign);
        String url = hanYinConfigService.getBaseUrl() + hanYinConfigService.getMobileRechargeAction();
        String rs = null;
        try {
            rs = client1.doPost(url);
        } catch (IOException e) {
            logger.warn("", e);
            return 1;
        }
        logger.debug("response content: " + rs);
        if (!checkResponseSign(rs)) {
            return 1;
        }
        String retCode = rs.replaceAll(".*retCode\\>(.*)\\</retCode.*", "$1");
        logger.debug(retCode);
        try {
            int ret = Integer.parseInt(retCode);
            if (ret == 1)
                return 0;
            else
                return 1;
        } catch (Throwable e) {
            logger.error("HY recharge ERROR: ", e);
            return 1;
        }
    }

    private boolean checkResponseSign(String responseXml) {
        String merId = StringUtil.getFirstMatchByXmlTagName(responseXml, "merchId");
        String activityCode = StringUtil.getFirstMatchByXmlTagName(responseXml, "activityCode");
        String orderId = StringUtil.getFirstMatchByXmlTagName(responseXml, "orderId");
        String settleDate = StringUtil.getFirstMatchByXmlTagName(responseXml, "settleDate");
        String phone = StringUtil.getFirstMatchByXmlTagName(responseXml, "phone");
        String parValue = StringUtil.getFirstMatchByXmlTagName(responseXml, "parValue");
        String hyOrderId = StringUtil.getFirstMatchByXmlTagName(responseXml, "hyOrderId");
        String status = StringUtil.getFirstMatchByXmlTagName(responseXml, "status");
        String key = hanYinConfigService.getKey();
        String encoding = hanYinConfigService.getEncoding();
        String forMd5 = merId + activityCode + orderId + settleDate + phone + parValue + hyOrderId + status + key;
        try {
            String md5 = StringUtil.getMd5Hex(forMd5.getBytes(encoding));
            String sign = StringUtil.getFirstMatchByXmlTagName(responseXml, "sign");
            return md5.equalsIgnoreCase(sign);
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException(e.getMessage(), e);
        }
    }
}
