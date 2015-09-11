package com.ifunpay.portal.entity;


import com.ifunpay.portal.model.BankAppEnum;

import javax.persistence.*;

/**
 * 银行支付方式信息
 * Created by Yu on 2014/12/15.
 */
@Entity
@Table(name = "n_bank_pay_info")
public class BankPayInfo {

    @Id
    
    
    private String id;

    /** 名称 **/
    @Column(name = "name", nullable = false, unique = true)
    
    
    private String name;

    /** 商户ID **/
    @Column(name = "merchant_id")
    
    
    private String merchantId;

    /** 网上支付柜台 **/
    @Column(name = "web_counter")
    
    
    private String webCounter;

    /** 手机支付柜台 **/
    @Column(name = "mobile_counter")
    
    
    private String mobileCounter;

    /** 分行 **/
    @Column(name = "branch")
    
    
    private String branch;

    /** 银行APP **/
    @Enumerated(EnumType.STRING)
    @Column(name = "app")
    
    
    private BankAppEnum app;


    @Column(name = "public_key")
    private String publicKey;

    @Basic
    @Column(name = "remark")
    private String remark;

    // The type of bank pay information: 0 channel's pay account, 1 merchant's pay account
    @Basic
    @Column(name = "type")
    private Integer type;


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getMerchantId() {
        return merchantId;
    }

    public void setMerchantId(String merchantId) {
        this.merchantId = merchantId;
    }

    public String getWebCounter() {
        return webCounter;
    }

    public void setWebCounter(String webCounter) {
        this.webCounter = webCounter;
    }

    public String getMobileCounter() {
        return mobileCounter;
    }

    public void setMobileCounter(String mobileCounter) {
        this.mobileCounter = mobileCounter;
    }

    public String getBranch() {
        return branch;
    }

    public void setBranch(String branch) {
        this.branch = branch;
    }

    public BankAppEnum getApp() {
        return app;
    }

    public void setApp(BankAppEnum app) {
        this.app = app;
    }

    public String getPublicKey() {
        return publicKey;
    }

    public void setPublicKey(String publicKey) {
        this.publicKey = publicKey;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }
}
