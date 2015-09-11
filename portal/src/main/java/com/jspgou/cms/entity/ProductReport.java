package com.jspgou.cms.entity;

/**
 * Created by zhengjiang on 2015/3/12.
 */
public class ProductReport {
    private String commerceName;
    private String productName;
    private int totalOrder;
    private int aShotToPay;
    private int flashPay;
    private int insertCard;
    private int qrCode;

    public String getCommerceName() {
        return commerceName;
    }

    public void setCommerceName(String commerceName) {
        this.commerceName = commerceName;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public int getTotalOrder() {
        return totalOrder;
    }

    public void setTotalOrder(int totalOrder) {
        this.totalOrder = totalOrder;
    }

    public int getaShotToPay() {
        return aShotToPay;
    }

    public void setaShotToPay(int aShotToPay) {
        this.aShotToPay = aShotToPay;
    }

    public int getFlashPay() {
        return flashPay;
    }

    public void setFlashPay(int flashPay) {
        this.flashPay = flashPay;
    }

    public int getInsertCard() {
        return insertCard;
    }

    public void setInsertCard(int insertCard) {
        this.insertCard = insertCard;
    }

    public int getQrCode() {
        return qrCode;
    }

    public void setQrCode(int qrCode) {
        this.qrCode = qrCode;
    }
}
