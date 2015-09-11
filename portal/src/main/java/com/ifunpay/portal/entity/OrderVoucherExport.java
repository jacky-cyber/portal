package com.ifunpay.portal.entity;

import com.ifunpay.portal.entity.order.OrderProduct;
import com.ifunpay.portal.enums.VoucherStatus;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by Cong Long Xie on 2015/8/1.
 *
 * Entity for New Voucher Export
 */
public class OrderVoucherExport {
    private String voucherCode;
    private String recepPhone;

    private String code;

    private long cost;

    private String productName;

    private String operator;

    private String commerceName;

    private String storeName;

    private String status;

    public OrderVoucherExport(String voucherCode, String recepPhone, String code, long cost, String productName, String operator, String commerceName, String storeName, String status) {
        this.voucherCode = voucherCode;
        this.recepPhone = recepPhone;
        this.code = code;
        this.cost = cost;
        this.productName = productName;
        this.operator = operator;
        this.commerceName = commerceName;
        this.storeName = storeName;
        this.status = status;
    }

    public String getVoucherCode() {
        return voucherCode;
    }

    public void setVoucherCode(String voucherCode) {
        this.voucherCode = voucherCode;
    }

    public String getRecepPhone() {
        return recepPhone;
    }

    public void setRecepPhone(String recepPhone) {
        this.recepPhone = recepPhone;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public long getCost() {
        return cost;
    }

    public void setCost(long cost) {
        this.cost = cost;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getOperator() {
        return operator;
    }

    public void setOperator(String operator) {
        this.operator = operator;
    }

    public String getCommerceName() {
        return commerceName;
    }

    public void setCommerceName(String commerceName) {
        this.commerceName = commerceName;
    }

    public String getStoreName() {
        return storeName;
    }

    public void setStoreName(String storeName) {
        this.storeName = storeName;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
