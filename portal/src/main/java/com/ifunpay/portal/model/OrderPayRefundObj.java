package com.ifunpay.portal.model;

import java.util.Date;

/**
 * Created by CongLong Xie on 2015/7/10.
 *
 */
public class OrderPayRefundObj {
    private String id;

    /**
     * 是否付款
     * 1: 付款
     * 0： 退款
     */
    private String isPay;

    /**
     * 订单
     */
    private String code;
    /**
     * 金额
     */
    private long amount ;
    /**
     * 银行流水号
     */
    private String serialNumber;
    /**
     * 支付类型 4-一拍支付
     */
    private String payMethod;
    /**
     * 帐号
     */
    private String accountNumber;
    /**
     * 支付时间
     */
    private Date payTime;
    /**
     * 支付状态 1-未支付 2-付款成功 3-退款成功 4-退款失败
     */
    private String payStatus;


    /**
     * 付款序列号
     * @return
     */
    private String refundSerialNumber;


    /**
     * 付款人
     */
    private String accountName;


    /**
     * 退款操作员
     * @return
     */
    private String operator;

    /**
     * pos机编号
     * @return
     */
    private String posNumber;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIsPay() {
        return isPay;
    }

    public void setIsPay(String isPay) {
        this.isPay = isPay;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public long getAmount() {
        return amount;
    }

    public void setAmount(long amount) {
        this.amount = amount;
    }

    public String getSerialNumber() {
        return serialNumber;
    }

    public void setSerialNumber(String serialNumber) {
        this.serialNumber = serialNumber;
    }

    public String getPayMethod() {
        return payMethod;
    }

    public void setPayMethod(String payMethod) {
        this.payMethod = payMethod;
    }

    public String getAccountNumber() {
        return accountNumber;
    }

    public void setAccountNumber(String accountNumber) {
        this.accountNumber = accountNumber;
    }

    public Date getPayTime() {
        return payTime;
    }

    public void setPayTime(Date payTime) {
        this.payTime = payTime;
    }

    public String getPayStatus() {
        return payStatus;
    }

    public void setPayStatus(String payStatus) {
        this.payStatus = payStatus;
    }

    public String getRefundSerialNumber() {
        return refundSerialNumber;
    }

    public void setRefundSerialNumber(String refundSerialNumber) {
        this.refundSerialNumber = refundSerialNumber;
    }

    public String getAccountName() {
        return accountName;
    }

    public void setAccountName(String accountName) {
        this.accountName = accountName;
    }

    public String getOperator() {
        return operator;
    }

    public void setOperator(String operator) {
        this.operator = operator;
    }

    public String getPosNumber() {
        return posNumber;
    }

    public void setPosNumber(String posNumber) {
        this.posNumber = posNumber;
    }
}
