package com.ifunpay.portal.dao.order;

import lombok.Data;
import lombok.extern.log4j.Log4j;

/**
 * Created by CongLong Xie on 2015/7/1.
 */
@Data
@Log4j
public class OrderRecoveryKV {
    private Long activityProductId;//活动商品ID
    private Long recoveryValue;//活动商品要恢复的库存
    private Long originalInventory;//原库存
}