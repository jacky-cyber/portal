package com.jspgou.cms.entity;

/**
 * Created by zhengjiang on 2015/3/17.
 */
public class ReportEntity {
    private String id;
    private String name;
    private int totalAmount;
    private int scanPayAmount;
    private int qrPayAmount;
    private int unionPayAmount;
    private int quickPayAmount;

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

    public int getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(int totalAmount) {
        this.totalAmount = totalAmount;
    }

    public int getScanPayAmount() {
        return scanPayAmount;
    }

    public void setScanPayAmount(int scanPayAmount) {
        this.scanPayAmount = scanPayAmount;
    }

    public int getQrPayAmount() {
        return qrPayAmount;
    }

    public void setQrPayAmount(int qrPayAmount) {
        this.qrPayAmount = qrPayAmount;
    }

    public int getUnionPayAmount() {
        return unionPayAmount;
    }

    public void setUnionPayAmount(int unionPayAmount) {
        this.unionPayAmount = unionPayAmount;
    }

    public int getQuickPayAmount() {
        return quickPayAmount;
    }

    public void setQuickPayAmount(int quickPayAmount) {
        this.quickPayAmount = quickPayAmount;
    }
}
