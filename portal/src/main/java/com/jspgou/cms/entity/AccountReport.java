package com.jspgou.cms.entity;

import lombok.Data;

import java.math.BigDecimal;

/**
 * Created by zj on 15-8-5.
 */
@Data
public class AccountReport {
    private String account;
    private String day;
    private BigDecimal amount;
}
