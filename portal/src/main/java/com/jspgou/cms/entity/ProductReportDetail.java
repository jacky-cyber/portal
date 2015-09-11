package com.jspgou.cms.entity;

import java.math.BigDecimal;

/**
 * Created by zj on 15-7-29.
 */
public class ProductReportDetail extends BaseProductReport{
    private Integer productId;
    private Integer commerceId;
    private String commerceName;

    public ProductReportDetail(String productName, BigDecimal price, Integer sell, Integer refund, Integer order, Integer used, BigDecimal usedAmount, BigDecimal receivedAmount, BigDecimal refundAmount, BigDecimal realReceivedAmount) {
        super(productName, price, sell, refund, order, used, usedAmount, receivedAmount, refundAmount, realReceivedAmount);
    }

    public ProductReportDetail() {
        super();
    }

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public Integer getCommerceId() {
        return commerceId;
    }

    public void setCommerceId(Integer commerceId) {
        this.commerceId = commerceId;
    }

    public String getCommerceName() {
        return commerceName;
    }

    public void setCommerceName(String commerceName) {
        this.commerceName = commerceName;
    }


}
