package com.ifunpay.portal.entity;

import com.ifunpay.portal.entity.order.OrderProduct;
import com.ifunpay.portal.enums.VoucherStatus;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by Cong Long Xie on 2015/1/8.
 *
 * Entity for New Voucher
 */
@Entity
@Table(name = "t_n_voucher")
@org.hibernate.annotations.Cache(usage = CacheConcurrencyStrategy.READ_WRITE, region="longTimeCache")
public class OrderVoucher {
    @Id
    @Column(name = "id")
    @GeneratedValue
    private Long id;

    /**
     * 凭证号
     */
    @Column(name = "VOUCHER_CODE",nullable = true)
    private String voucherCode;

    /**
     * 接收手机号
     */
    @Column(name = "recep_phone")
    private String recepPhone;

    /**
     * 订单号
     */
    @Column(name = "order_number")
    private String code;


    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ORDER_PRODUCT_ID")
    private OrderProduct orderProduct;


    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "commerce_id")
    @Setter
    @Getter
    private Commerce commerce;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "channel_id")
    @Setter
    @Getter
    private Channel channel;
    /**
     * 订单金额
     */
    @Column(name = "COST")
    private long cost;

    /**
     * 商品名称
     */
    @Column(name = "PRODUCT_NAME")
    private String productName;


    /**
     * 操作员名称
     */
    @Column(name = "operator")
    private String operator;
    /**
     * 商户名称
     */
    @Column(name = "commerce_name")
    private String commerceName;
    /**
     * 店面名称
     */
    @Column(name = "store_name")
    private String storeName;

    /**
     * 用户ID
     */
    @Column(name = "USER_ID")
    private String userId;

    /**
     * 发送手机
     */
    @Column(name = "SEND_MOBILE")
    private String sendMobile;

    /**
     * 短信标题
     */
    @Column(name = "SMS_SUB")
    private String smsSub;

    /**
     * 短信内容
     */
    @Column(name = "SMS_TEXT")
    private String smsText;

    /**
     * 凭证最大使用次数
     */
    @Column(name = "MAX_USE_TIMES")
    private int maxUseTimes;

    /**
     * 已验证次数
     */
    @Column(name = "VALI_DATE_TIMES")
    private int valiDateTimes;

    /**
     * 短信发送次数
     */
    @Column(name = "SMS_COUNT")
    private int smsCount;

    /**
     *凭证状态 0：未使用 1：已使用 2：过期结算 3：已作废
     */
    @Enumerated(EnumType.STRING)
    @Column(name = "STATUS")
    private VoucherStatus status;

    /**
     *凭证使用时间
     */
    @Column(name = "USE_TIME")
    private Date useTime;

    /**
     *凭证发送时间
     */
    @Column(name = "SEND_TIME")
    private Date sendTime;

    /**
     *凭证有效期开始时间
     */
    @Column(name = "START_DATE")
    private Date startTime;

    /**
     *凭证有效期结束时间
     */
    @Column(name = "END_DATE")
    private Date endTime;

    /**
     *作废原因
     */
    @Column(name = "INVALID_DESC")
    private String invalidateDesc;

    /**
     *用户手机号
     */
    @Column(name = "MOBILE")
    private String mobile;

    /**
     * 兑换点ID的集合
     */
    @Column(name = "PIONT_IDS")
    private String pointIds;


    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getVoucherCode() {
        return voucherCode;
    }

    public void setVoucherCode(String voucherCode) {
        this.voucherCode = voucherCode;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public long getCost() {
        return cost;
    }

    public void setCost(long cost) {
        this.cost = cost;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getSendMobile() {
        return sendMobile;
    }

    public void setSendMobile(String sendMobile) {
        this.sendMobile = sendMobile;
    }

    public String getSmsSub() {
        return smsSub;
    }

    public void setSmsSub(String smsSub) {
        this.smsSub = smsSub;
    }

    public String getSmsText() {
        return smsText;
    }

    public void setSmsText(String smsText) {
        this.smsText = smsText;
    }

    public int getMaxUseTimes() {
        return maxUseTimes;
    }

    public void setMaxUseTimes(int maxUseTimes) {
        this.maxUseTimes = maxUseTimes;
    }

    public int getValiDateTimes() {
        return valiDateTimes;
    }

    public void setValiDateTimes(int valiDateTimes) {
        this.valiDateTimes = valiDateTimes;
    }

    public int getSmsCount() {
        return smsCount;
    }

    public void setSmsCount(int smsCount) {
        this.smsCount = smsCount;
    }

    public VoucherStatus getStatus() {
        return status;
    }

    public void setStatus(VoucherStatus status) {
        this.status = status;
    }

    public Date getUseTime() {
        return useTime;
    }

    public void setUseTime(Date useTime) {
        this.useTime = useTime;
    }

    public Date getSendTime() {
        return sendTime;
    }

    public void setSendTime(Date sendTime) {
        this.sendTime = sendTime;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public String getInvalidateDesc() {
        return invalidateDesc;
    }

    public void setInvalidateDesc(String invalidateDesc) {
        this.invalidateDesc = invalidateDesc;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getPointIds() {
        return pointIds;
    }

    public void setPointIds(String pointIds) {
        this.pointIds = pointIds;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public OrderProduct getOrderProduct() {
        return orderProduct;
    }

    public void setOrderProduct(OrderProduct orderProduct) {
        this.orderProduct = orderProduct;
    }

    public String getOperator() {
        return operator;
    }

    public void setOperator(String operator) {
        this.operator = operator;
    }

    public String getCommerceName() {
        return commerceName;
    }

    public void setCommerceName(String commerceName) {
        this.commerceName = commerceName;
    }

    public String getStoreName() {
        return storeName;
    }

    public void setStoreName(String storeName) {
        this.storeName = storeName;
    }

    public String getRecepPhone() {
        return recepPhone;
    }

    public void setRecepPhone(String recepPhone) {
        this.recepPhone = recepPhone;
    }
}
