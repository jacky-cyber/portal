package com.ifunpay.portal.model;

import com.ifunpay.util.enums.PaymentStatusEnum;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Yu on 2014/12/22.
 */
public class PaidInfo {

    //订单号
    private String orderId;
    //银行流水号
    private String serialNumber;
    /**
     * 付款金额，单位为"分"
     */
    private long amount;
    //状态
    private PaymentStatusEnum status;

    //支付账户名
    private String userName;
    //支付帐号
    private String account;
    //手机号码
    private String mobile;

    //收款银行
    private BankAppEnum bank;
    //银行分行id
    private String branchId;
    //柜台号Id
    private String posId;

    private List<String> remarks = new ArrayList<>();

    private ModelAndView modelAndView;

    /**
     * 是否来自用户的请求
     *  true：来自用于
     *  false：来自银行后台
     */
    private boolean fromUser;

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getSerialNumber() {
        return serialNumber;
    }

    public void setSerialNumber(String serialNumber) {
        this.serialNumber = serialNumber;
    }

    public long getAmount() {
        return amount;
    }

    public void setAmount(long amount) {
        this.amount = amount;
    }

    public PaymentStatusEnum getStatus() {
        return status;
    }

    public void setStatus(PaymentStatusEnum status) {
        this.status = status;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public BankAppEnum getBank() {
        return bank;
    }

    public void setBank(BankAppEnum bank) {
        this.bank = bank;
    }

    public String getBranchId() {
        return branchId;
    }

    public void setBranchId(String branchId) {
        this.branchId = branchId;
    }

    public String getPosId() {
        return posId;
    }

    public void setPosId(String posId) {
        this.posId = posId;
    }

    public List<String> getRemarks() {
        return remarks;
    }

    public void setRemarks(List<String> remarks) {
        this.remarks = remarks;
    }

    public ModelAndView getModelAndView() {
        return modelAndView;
    }

    public void setModelAndView(ModelAndView modelAndView) {
        this.modelAndView = modelAndView;
    }

    public boolean isFromUser() {
        return fromUser;
    }

    public void setFromUser(boolean fromUser) {
        this.fromUser = fromUser;
    }


    @Override
    public String toString() {
        return "PaidInfo{" +
                "orderId='" + orderId + '\'' +
                ", serialNumber='" + serialNumber + '\'' +
                ", amount=" + amount +
                ", status=" + status +
                ", userName='" + userName + '\'' +
                ", account='" + account + '\'' +
                ", mobile='" + mobile + '\'' +
                ", bank=" + bank +
                ", branchId='" + branchId + '\'' +
                ", posId='" + posId + '\'' +
                ", remarks=" + remarks +
                ", modelAndView=" + modelAndView +
                ", fromUser=" + fromUser +
                '}';
    }
}
