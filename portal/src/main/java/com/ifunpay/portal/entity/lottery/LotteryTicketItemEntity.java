package com.ifunpay.portal.entity.lottery;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import javax.persistence.*;

/**
 * Created by Yu on 2015/3/9.
 */
@Entity
@Table(name = "n_lottery_ticket_item")
@JsonIgnoreProperties("orderEntity")
public class LotteryTicketItemEntity {

    private String id;
    private String order_id;
    private String code;
    private int ticketCount;
    private LotteryTicketOrderEntity orderEntity;

    public LotteryTicketItemEntity() {
    }

    public LotteryTicketItemEntity(String code, int ticketCount){

    }

    public LotteryTicketItemEntity(String id, String order_id, String code, int ticketCount) {
        this.id = id;
        this.order_id = order_id;
        this.code = code;
        this.ticketCount = ticketCount;
    }

    @Id
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Column(name = "order_id", nullable = false)
    public String getOrder_id() {
        return order_id;
    }


    public void setOrder_id(String order_id) {
        this.order_id = order_id;
    }

    @Column(name = "ticket_code")
    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    @Column(name = "ticket_count")
    public int getTicketCount() {
        return ticketCount;
    }

    public void setTicketCount(int ticketCount) {
        this.ticketCount = ticketCount;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(insertable = false, updatable = false, name = "order_id")
    public LotteryTicketOrderEntity getOrderEntity() {
        return orderEntity;
    }

    public void setOrderEntity(LotteryTicketOrderEntity orderEntity) {
        this.orderEntity = orderEntity;
    }
}
