package com.jspgou.cms.entity;

import java.math.BigDecimal;

/**
 * Created by zhengjiang on 2015/3/9.
 */
public class Settlement {
    private Integer id;
    private String commerceName;
    private String channelName;
    private int totalOrder;
    private BigDecimal totalSellAmount;
    private BigDecimal totalRefundAmount;
    private BigDecimal totalPaiedAmount;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCommerceName() {
        return commerceName;
    }

    public void setCommerceName(String commerceName) {
        this.commerceName = commerceName;
    }

    public String getChannelName() {
        return channelName;
    }

    public void setChannelName(String channelName) {
        this.channelName = channelName;
    }

    public int getTotalOrder() {
        return totalOrder;
    }

    public void setTotalOrder(int totalOrder) {
        this.totalOrder = totalOrder;
    }

    public BigDecimal getTotalSellAmount() {
        return totalSellAmount;
    }

    public void setTotalSellAmount(BigDecimal totalSellAmount) {
        this.totalSellAmount = totalSellAmount;
    }

    public BigDecimal getTotalRefundAmount() {
        return totalRefundAmount;
    }

    public void setTotalRefundAmount(BigDecimal totalRefundAmount) {
        this.totalRefundAmount = totalRefundAmount;
    }

    public BigDecimal getTotalPaiedAmount() {
        return totalPaiedAmount;
    }

    public void setTotalPaiedAmount(BigDecimal totalPaiedAmount) {
        this.totalPaiedAmount = totalPaiedAmount;
    }
}
