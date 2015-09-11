package com.ifunpay.portal.entity.order;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.ifunpay.portal.entity.Channel;
import com.ifunpay.portal.entity.LogDescCN;
import com.ifunpay.portal.entity.MemberUserEntity;
import com.ifunpay.util.enums.OrderStatusEnum;
import com.ifunpay.util.enums.PayMethodEnum;
import com.ifunpay.util.enums.PaymentStatusEnum;
import com.ifunpay.util.enums.ShipmentStatusEnum;
import lombok.Data;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by CongLong Xie on 2015/7/24.
 */
@Entity
@Table(name="n_order")
@JsonIgnoreProperties(value={"hibernateLazyInitializer", "channel", "memberUserEntity"})
@org.hibernate.annotations.Cache(usage = CacheConcurrencyStrategy.READ_WRITE, region="longTimeCache")
@Data
public class OrderEntity {
    @Id
    @GeneratedValue
    @Column(name = "id")
    private Long id;

    @Column(name = "order_id")
    @LogDescCN(chineseName = "订单号")
    private String code;

    @Column(name = "phone")
    @LogDescCN(chineseName = "手机号码")
    private String phone;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "channel_id")
    @LogDescCN(chineseName = "渠道Id")
    private Channel channel;

    @Column(name = "channel_name")
    @LogDescCN(chineseName = "渠道名称")
    private String channelName;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_user_id")
    @LogDescCN(chineseName = "用户Id")
    private MemberUserEntity memberUserEntity;

    @Enumerated(EnumType.STRING)
    @Column(name = "pay_method")
    @LogDescCN(chineseName = "支付方式")
    private PayMethodEnum payMethod ;

    @Enumerated(EnumType.STRING)
    @Column(name = "pay_status")
    @LogDescCN(chineseName = "支付状态")
    private PaymentStatusEnum paymentStatus;

    @Enumerated(EnumType.STRING)
    @Column(name = "ship_status")
    @LogDescCN(chineseName = "发货状态")
    private ShipmentStatusEnum shipmentStatus;

    @Enumerated(EnumType.STRING)
    @Column(name = "order_status")
    @LogDescCN(chineseName = "订单状态")
    private OrderStatusEnum status;

    @Column(name = "total_amount")
    @LogDescCN(chineseName = "订单总金额")
    private Long totalAmount;

    @Column(name = "create_time")
    @LogDescCN(chineseName = "创建时间")
    private Date createTime;

    @Column(name = "last_modified_time")
    @LogDescCN(chineseName = "最后修改时间")
    private Date lastModifiedTime;

    @Column(name = "del")
    @LogDescCN(chineseName = "是否删除，0-未删除；1-删除")
    private int del;

    @Column(name = "comments")
    @LogDescCN(chineseName = "订单附言")
    private String comments;

    @Column(name = "terminal_id")
    @LogDescCN(chineseName = "终端机编号")
    private String terminalId;

    @Column(name = "terminal_order_id")
    @LogDescCN(chineseName = "终端机订单号")
    private String terminalOrderId;

    @Column(name = "serial_no")
    @LogDescCN(chineseName = "序列号")
    private String serialNo;

    @Column(name = "trade_no")
    @LogDescCN(chineseName = "交易号")
    private String tradeNo;

    @Column(name = "original_price")
    @LogDescCN(chineseName = "成本价")
    private Long originalPrice;

    @Column(name = "diff_price")
    @LogDescCN(chineseName = "差价")
    private Long diffPrice;

    @Column(name = "pay_account_name")
    @LogDescCN(chineseName = "支付账号")
    private String payAccountName;

    @Column(name = "device_name")
    @LogDescCN(chineseName = "设备标识")
    private String deviceName;

    @Column(name = "feed_back")
    @LogDescCN(chineseName = "出货信息反馈")
    private String feedBack;

}
