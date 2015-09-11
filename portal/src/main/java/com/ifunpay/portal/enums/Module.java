package com.ifunpay.portal.enums;

/**
 * Created by zj on 15-6-16.
 */
public enum Module {

    ORDER("订单"),
    CHANNEL("渠道"),
    COMMERCE("商户"),
    TERMINAL_INFO("终端机管理"),
    POS_INFO("POS信息"),
    INVOICE_INFO("收款方信息"),
    TERMINAL_MODEL("终端机型号"),
    VOUCHER("凭证"),
    MERCHANDISE("商品"),
    SEPARATE("分类"),
    TYPE_MANAGE("类型管理"),
    MALL("商城"),
    STORE("店面"),
    RECEIVING_ACCOUNT("收款帐号"),
    ;
    String displayName;

    public String getDisplayName() {
        return displayName;
    }

    private Module(String display){
        this.displayName = display;
    }

    public void setDisplayName(String displayName) {
        this.displayName = displayName;
    }
}
