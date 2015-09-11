package com.jspgou.cms.model;

import lombok.Data;

/**
 * Created by jiang on 2015/9/10.
 */
@Data
public class ProductReport {
    private Integer productId;
    private String productName;
    private Integer merchantId;
    private String merchantName;
    private Integer channelId;
    private String channelName;
    private Integer totalOrder;
    private Integer oneShotToPay;
    private Integer flashPay;
    private Integer insertCard;
    private Integer qrCode;
}
