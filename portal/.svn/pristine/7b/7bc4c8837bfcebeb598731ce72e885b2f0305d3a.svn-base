package com.ifunpay.portal.entity.order;

import lombok.Data;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by CongLong Xie on 2014/12/12.
 * saving the bank account information
 */
@Entity
@Table(name = "n_bank_account_info")
@Data
public class BankAccountInfo{

    @Id
    @GeneratedValue
    private Long id;

    /**
     * 订单号
     */
    @Column(name = "order_id")
    private String orderId;

    /**
     * 参数名
     */
    @Column(name = "param_name")
    private String paramName;

    /**
     * 参数值
     */
    @Column(name = "param_value")
    private String paramValue;

    /**
     * 创建时间
     */
    @Basic
    @Column(name = "create_time")
    private Date createTime;


}
