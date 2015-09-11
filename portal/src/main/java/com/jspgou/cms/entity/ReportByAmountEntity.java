package com.jspgou.cms.entity;

/**
 * Created by zhengjiang on 2015/3/17.
 */
public class ReportByAmountEntity {
    private String id;
    private String name;
    private Double totalAmount;
    private Double scanPayAmount;
    private Double qrPayAmount;
    private Double unionPayAmount;
    private Double quickPayAmount;

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

    public Double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(Double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public Double getScanPayAmount() {
        return scanPayAmount;
    }

    public void setScanPayAmount(Double scanPayAmount) {
        this.scanPayAmount = scanPayAmount;
    }

    public Double getQrPayAmount() {
        return qrPayAmount;
    }

    public void setQrPayAmount(Double qrPayAmount) {
        this.qrPayAmount = qrPayAmount;
    }

    public Double getUnionPayAmount() {
        return unionPayAmount;
    }

    public void setUnionPayAmount(Double unionPayAmount) {
        this.unionPayAmount = unionPayAmount;
    }

    public Double getQuickPayAmount() {
        return quickPayAmount;
    }

    public void setQuickPayAmount(Double quickPayAmount) {
        this.quickPayAmount = quickPayAmount;
    }
}
