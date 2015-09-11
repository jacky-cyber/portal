package com.jspgou.cms.model;

import lombok.Data;

import java.math.BigDecimal;

/**
 * Created by jiang on 2015/9/7.
 */
@Data
public class ChannelReport {
    private Integer channelId;
    private String channelName;
    private int totalOrder;
    private BigDecimal totalAmount;
    private BigDecimal returnAmount;
    private BigDecimal paiedAmount;
}
