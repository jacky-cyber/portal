package com.jspgou.cms.model;

import lombok.Data;

import java.math.BigDecimal;

/**
 * Created by jiang on 2015/9/11.
 */
@Data
public class ProductReportRMB {
    private Integer productId;
    private String productName;
    private Integer merchantId;
    private String merchantName;
    private Integer channelId;
    private String channelName;
    private BigDecimal totalAmount;
    private BigDecimal oneShotToPay;
    private BigDecimal flashPay;
    private BigDecimal insertCard;
    private BigDecimal qrCode;
}
