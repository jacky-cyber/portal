package com.ifunpay.portal.entity.lottery;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

/**
 * Created by Yu on 2015/3/9.
 */
@Entity
@Table(name = "n_lottery_ticket_order")
public class LotteryTicketOrderEntity {

    private String id;
    private List<LotteryTicketItemEntity> itemEntityList;
    private int ticketCount;
    private Date orderDate;
    private String mobile;
    private String message;
    //状态： 0：成功， 1：失败， 2：充值中
    private int state;
    private String provider;


    private String errorMessage;

    public LotteryTicketOrderEntity(){
    }

    public LotteryTicketOrderEntity(String id, int count, Date orderDate, String mobile, String message, String provider){
        this.id = id;
        this.ticketCount = count;
        this.orderDate = orderDate;
        this.mobile = mobile;
        this.message = message;
        this.provider = provider;
        this.state = 1;
    }

    @Id
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @OneToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "order_id")
    public List<LotteryTicketItemEntity> getItemEntityList() {
        return itemEntityList;
    }

    public void setItemEntityList(List<LotteryTicketItemEntity> itemEntityList) {
        this.itemEntityList = itemEntityList;
    }

    @Column(name = "ticket_count")
    public int getTicketCount() {
        return ticketCount;
    }

    public void setTicketCount(int ticketCount) {
        this.ticketCount = ticketCount;
    }

    @Column(name = "order_date", columnDefinition="DATETIME")
    @Temporal(TemporalType.TIMESTAMP)
    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    @Column
    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    @Column
    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    @Column
    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

    @Column
    public String getProvider() {
        return provider;
    }

    public void setProvider(String provider) {
        this.provider = provider;
    }

    @Column(name = "error_message")
    public String getErrorMessage() {
        return errorMessage;
    }

    public void setErrorMessage(String errorMessage) {
        this.errorMessage = errorMessage;
    }
}
