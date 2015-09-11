package com.jspgou.cms.entity.base;

import java.io.Serializable;

/**
 * Created by David on 2015/3/18.
 */
public class BaseProductFavorable implements Serializable {

    public static String REF = "ProductFavorable";

    public static String PROP_ID = "id";
    public static String PROP_PRODUCT_ID = "productId";
    public static String PROP_PRODUCT_STAMP = "productStamp";
    public static String PROP_FAVORABLE_ID = "favorableId";
    public static String PROP_PRODUCT_NAME = "productName";


    // constructors
    public BaseProductFavorable () {
        initialize();
    }

    /**
     * Constructor for primary key
     */
    public BaseProductFavorable (Long id) {
        this.setId(id);
        initialize();
    }

    protected void initialize () {}





    // primary key
    private Long id;

    // fields
    private Long productId;
    private Integer productStamp;
    private Long favorableId;
    private String productName;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getProductId() {
        return productId;
    }

    public void setProductId(Long productId) {
        this.productId = productId;
    }

    public Integer getProductStamp() {
        return productStamp;
    }

    public void setProductStamp(Integer productStamp) {
        this.productStamp = productStamp;
    }

    public Long getFavorableId() {
        return favorableId;
    }

    public void setFavorableId(Long favorableId) {
        this.favorableId = favorableId;
    }

    public String toString () {
        return super.toString();
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }
}
