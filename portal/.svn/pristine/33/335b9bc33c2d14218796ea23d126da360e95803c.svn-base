package com.ifunpay.portal.service.lottery;

import com.ifunpay.portal.ProjectXml;
import org.springframework.stereotype.Component;

/**
 * Created by Yu on 2014/12/27.
 */
@Component
public class HanYinConfigService {

    private String baseUrl = ProjectXml.getValue("HY_BASE_URL");
    private String key = "p9e2qou8ifxrrxmlaqe3kw4e";
    private boolean wantSendMessage = true;
    private String encoding = ProjectXml.getValue("HY_ENCODING");
    private String providerName = "HAN_YIN";

    private String mobileMerId = ProjectXml.getValue("HY_MOBILE_CHARGE_MER_ID");
    private String mobileRechargeAction = "mobile.do";
    private String mobileRechargeCheckAction = "queryBill.do";
    private String mobileChargeActivityCode = ProjectXml.getValue("HY_MOBILE_CHARGE_ACTIVITY_CODE");
    private String mobileChargeDepartmentId = ProjectXml.getValue("HY_MOBILE_CHARGE_DEPARTMENT_ID");
    private String mobileChargeMdseCode = ProjectXml.getValue("HY_MOBILE_CHARGE_MDSE_CODE");
    private String mobileChargeBisType = "mobile";

    private String lotteryMerId = ProjectXml.getValue("HY_LOTTERY_TICKET_MER_ID");
    private String lotteryTicketAction = "changeInlotteryGame.do";
    private String lotteryTicketCheckAction = "queryChangeInlotteryGameBill.do";
    private String lotteryTicketActivityCode = ProjectXml.getValue("HY_LOTTERY_TICKET_ACTIVITY_CODE");
    private String lotteryTicketDepartmentId = ProjectXml.getValue("HY_LOTTERY_TICKET_DEPARTMENT_ID");
    private String lotteryTicketMdseCode = ProjectXml.getValue("HY_LOTTERY_TICKET_MDSE_CODE");
    private String lotteryTicketBisType = "ics";
    private Integer lotteryTicketPrice = Integer.valueOf(ProjectXml.getValue("HY_LOTTERY_TICKET_PRICE"));


    public String getBaseUrl() {
        return baseUrl;
    }

    public void setBaseUrl(String baseUrl) {
        this.baseUrl = baseUrl;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public boolean isWantSendMessage() {
        return wantSendMessage;
    }

    public void setWantSendMessage(boolean wantSendMessage) {
        this.wantSendMessage = wantSendMessage;
    }

    public String getMobileRechargeAction() {
        return mobileRechargeAction;
    }

    public void setMobileRechargeAction(String mobileRechargeAction) {
        this.mobileRechargeAction = mobileRechargeAction;
    }

    public String getMobileRechargeCheckAction() {
        return mobileRechargeCheckAction;
    }

    public void setMobileRechargeCheckAction(String mobileRechargeCheckAction) {
        this.mobileRechargeCheckAction = mobileRechargeCheckAction;
    }

    public String getMobileChargeActivityCode() {
        return mobileChargeActivityCode;
    }

    public void setMobileChargeActivityCode(String mobileChargeActivityCode) {
        this.mobileChargeActivityCode = mobileChargeActivityCode;
    }

    public String getMobileChargeDepartmentId() {
        return mobileChargeDepartmentId;
    }

    public void setMobileChargeDepartmentId(String mobileChargeDepartmentId) {
        this.mobileChargeDepartmentId = mobileChargeDepartmentId;
    }

    public String getMobileChargeMdseCode() {
        return mobileChargeMdseCode;
    }

    public void setMobileChargeMdseCode(String mobileChargeMdseCode) {
        this.mobileChargeMdseCode = mobileChargeMdseCode;
    }

    public String getLotteryTicketAction() {
        return lotteryTicketAction;
    }

    public void setLotteryTicketAction(String lotteryTicketAction) {
        this.lotteryTicketAction = lotteryTicketAction;
    }

    public String getLotteryTicketCheckAction() {
        return lotteryTicketCheckAction;
    }

    public void setLotteryTicketCheckAction(String lotteryTicketCheckAction) {
        this.lotteryTicketCheckAction = lotteryTicketCheckAction;
    }

    public String getLotteryTicketActivityCode() {
        return lotteryTicketActivityCode;
    }

    public void setLotteryTicketActivityCode(String lotteryTicketActivityCode) {
        this.lotteryTicketActivityCode = lotteryTicketActivityCode;
    }

    public String getLotteryTicketDepartmentId() {
        return lotteryTicketDepartmentId;
    }

    public void setLotteryTicketDepartmentId(String lotteryTicketDepartmentId) {
        this.lotteryTicketDepartmentId = lotteryTicketDepartmentId;
    }

    public String getLotteryTicketMdseCode() {
        return lotteryTicketMdseCode;
    }

    public void setLotteryTicketMdseCode(String lotteryTicketMdseCode) {
        this.lotteryTicketMdseCode = lotteryTicketMdseCode;
    }

    public String getEncoding() {
        return encoding;
    }

    public void setEncoding(String encoding) {
        this.encoding = encoding;
    }

    public String getMobileChargeBisType() {
        return mobileChargeBisType;
    }

    public void setMobileChargeBisType(String mobileChargeBisType) {
        this.mobileChargeBisType = mobileChargeBisType;
    }

    public String getLotteryTicketBisType() {
        return lotteryTicketBisType;
    }

    public void setLotteryTicketBisType(String lotteryTicketBisType) {
        this.lotteryTicketBisType = lotteryTicketBisType;
    }

    public Integer getLotteryTicketPrice() {
        return lotteryTicketPrice;
    }

    public void setLotteryTicketPrice(Integer lotteryTicketPrice) {
        this.lotteryTicketPrice = lotteryTicketPrice;
    }

    public String getProviderName() {
        return providerName;
    }

    public void setProviderName(String providerName) {
        this.providerName = providerName;
    }

    public String getMobileMerId() {
        return mobileMerId;
    }

    public void setMobileMerId(String mobileMerId) {
        this.mobileMerId = mobileMerId;
    }

    public String getLotteryMerId() {
        return lotteryMerId;
    }

    public void setLotteryMerId(String lotteryMerId) {
        this.lotteryMerId = lotteryMerId;
    }
}
