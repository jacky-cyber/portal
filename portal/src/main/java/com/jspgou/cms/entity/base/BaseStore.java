package com.jspgou.cms.entity.base;

import java.io.Serializable;
import java.util.Date;

/**
 * Created by zhengjiang on 2015-07-09.
 */
public abstract class BaseStore implements Serializable{
    public BaseStore(){
        initialize();
    }

    public BaseStore(Long id, String storeName, Long commerceId, String commerceName, Integer storeStatus, String mobile) {
        this.setId(id);
        this.setStoreName(storeName);
        this.setCommerceId(commerceId);
        this.setCommerceName(commerceName);
        this.setStoreStatus(storeStatus);
        this.setMobile(mobile);
    }

    private void initialize(){}

    public BaseStore(Long id){
        this.setId(id);
        initialize();
    }

    private Long id;
    private String storeName;
    private Long commerceId;
    private String commerceName;

    // 店面状态:1.启用 2.禁用 3.删除
    private Integer storeStatus;
    private String mobile;
    private String email;
    private String province;
    private String city;
    private String detail;
    private Date createDate;
    private String creatorId;
    private Date modifyDate;
    private String modifierId;
    private String description;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getStoreName() {
        return storeName;
    }

    public void setStoreName(String storeName) {
        this.storeName = storeName;
    }

    public Long getCommerceId() {
        return commerceId;
    }

    public void setCommerceId(Long commerceId) {
        this.commerceId = commerceId;
    }

    public String getCommerceName() {
        return commerceName;
    }

    public void setCommerceName(String commerceName) {
        this.commerceName = commerceName;
    }

    public Integer getStoreStatus() {
        return storeStatus;
    }

    public void setStoreStatus(Integer storeStatus) {
        this.storeStatus = storeStatus;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getCreatorId() {
        return creatorId;
    }

    public void setCreatorId(String creatorId) {
        this.creatorId = creatorId;
    }

    public Date getModifyDate() {
        return modifyDate;
    }

    public void setModifyDate(Date modifyDate) {
        this.modifyDate = modifyDate;
    }

    public String getModifierId() {
        return modifierId;
    }

    public void setModifierId(String modifierId) {
        this.modifierId = modifierId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
