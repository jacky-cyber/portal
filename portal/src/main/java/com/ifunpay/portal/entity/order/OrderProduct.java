package com.ifunpay.portal.entity.order;

import com.ifunpay.portal.entity.Commerce;
import com.ifunpay.portal.entity.LogDescCN;
import com.jspgou.cms.entity.Product;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.search.annotations.Indexed;

import javax.persistence.*;

/**
 * Created by CongLong Xie on 2015/7/24.
 */
@Entity
@Table(name="n_order_product")
@org.hibernate.annotations.Cache(usage = CacheConcurrencyStrategy.READ_WRITE, region="longTimeCache")
public class OrderProduct {
    @Id
    @GeneratedValue
    @Column(name = "id")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "order_id")
    @LogDescCN(chineseName = "订单Id")
    private OrderEntity entity;

    @Column(name = "order_number")
    @LogDescCN(chineseName = "订单号")
    private String orderNumber;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id")
    @LogDescCN(chineseName = "商品")
    private Product product;

    @Column(name = "product_name")
    @LogDescCN(chineseName = "商品名称")
    private String productName;

    @Column(name = "product_qty")
    @LogDescCN(chineseName = "商品数量")
    private Integer productQty;

    @Column(name = "product_price")
    @LogDescCN(chineseName = "商品价格")
    private Long productPrice;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "commerce_id")
    @LogDescCN(chineseName = "商户ID")
    private Commerce commerce;

    @Column(name = "commerce_name")
    @LogDescCN(chineseName = "商户名称")
    private String commerceName;

    public Commerce getCommerce() {
        return commerce;
    }

    public void setCommerce(Commerce commerce) {
        this.commerce = commerce;
    }

    public String getCommerceName() {
        return commerceName;
    }

    public void setCommerceName(String commerceName) {
        this.commerceName = commerceName;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public OrderEntity getEntity() {
        return entity;
    }

    public void setEntity(OrderEntity entity) {
        this.entity = entity;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public Integer getProductQty() {
        return productQty;
    }

    public void setProductQty(Integer productQty) {
        this.productQty = productQty;
    }

    public Long getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(Long productPrice) {
        this.productPrice = productPrice;
    }

    public String getOrderNumber() {
        return orderNumber;
    }

    public void setOrderNumber(String orderNumber) {
        this.orderNumber = orderNumber;
    }
}
