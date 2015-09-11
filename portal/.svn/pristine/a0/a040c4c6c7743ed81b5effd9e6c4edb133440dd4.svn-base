package com.ifunpay.portal.entity.order;

import com.ifunpay.portal.entity.LogDescCN;
import org.hibernate.search.annotations.Indexed;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by CongLong Xie on 2015/7/24.
 */
@Entity
@Table(name="n_order_post_info")
@Indexed
public class OrderPostInfo {
    @Id
    @GeneratedValue
    @Column(name = "id")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "order_id")
    @LogDescCN(chineseName = "订单Id")
    private OrderEntity orderEntity;

    @Column(name = "order_number")
    @LogDescCN(chineseName = "订单号")
    private String orderNumber;

    @Column(name = "receive_name")
    @LogDescCN(chineseName = "收货人姓名")
    private String receiveName;

    @Column(name = "receive_address")
    @LogDescCN(chineseName = "收货人地址")
    private String receiveAddress;

    @Column(name = "receive_zip")
    @LogDescCN(chineseName = "收货人邮编")
    private String receiveZip;

    @Column(name = "receive_phone")
    @LogDescCN(chineseName = "收货人电话")
    private String receivePhone;

    @Column(name = "shipping_time")
    @LogDescCN(chineseName = "发货时间")
    private Date shippingTime;

    @Column(name = "create_time")
    @LogDescCN(chineseName = "创建时间")
    private Date createTime;


    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public OrderEntity getOrderEntity() {
        return orderEntity;
    }

    public void setOrderEntity(OrderEntity orderEntity) {
        this.orderEntity = orderEntity;
    }

    public String getReceiveName() {
        return receiveName;
    }

    public void setReceiveName(String receiveName) {
        this.receiveName = receiveName;
    }

    public String getReceiveAddress() {
        return receiveAddress;
    }

    public void setReceiveAddress(String receiveAddress) {
        this.receiveAddress = receiveAddress;
    }

    public String getReceiveZip() {
        return receiveZip;
    }

    public void setReceiveZip(String receiveZip) {
        this.receiveZip = receiveZip;
    }

    public String getReceivePhone() {
        return receivePhone;
    }

    public void setReceivePhone(String receivePhone) {
        this.receivePhone = receivePhone;
    }

    public Date getShippingTime() {
        return shippingTime;
    }

    public void setShippingTime(Date shippingTime) {
        this.shippingTime = shippingTime;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getOrderNumber() {
        return orderNumber;
    }

    public void setOrderNumber(String orderNumber) {
        this.orderNumber = orderNumber;
    }
}
