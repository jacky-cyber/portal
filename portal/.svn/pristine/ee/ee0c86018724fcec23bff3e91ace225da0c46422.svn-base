package com.ifunpay.portal.entity;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import java.util.Date;

/**
 * Created by David on 2015/5/8.
 */
@Entity
@Table(name = "n_member_addr")
public class MemberAddr extends AutoIdEntity {

    /**
     * 用户id
     */
    @Basic
    @Column(name ="memberId" ,unique = true, nullable = false)
    private String memberId;
    /**
     * 收货联系电话
     */
    @Basic
    @Column(name = "phone")
    private String phone;
    /**
     * 收货联系人
     */
    @Basic
    @Column(name = "name")
    private String name;

    /**
     * 省份
     */
    @Basic
    @Column(name = "province")
    private String province;
    /**
     * 城市
     */
    @Basic
    @Column(name = "city")
    private String city;
    /**
     * 具体地址
     */
    @Basic
    @Column(name = "detail")
    private String detail;
    /**
     * 添加时间
     */
    @Basic
    @Column(name = "createTime")
    private Date createTime;



    public String getMemberId() {
        return memberId;
    }

    public void setMemberId(String memberId) {
        this.memberId = memberId;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    @Override
    public String toString() {
        return "memberAddr{" +
                ", memberId='" + memberId + '\'' +
                ", phone='" + phone + '\'' +
                ", name='" + name + '\'' +
                ", province='" + province + '\'' +
                ", city='" + city + '\'' +
                ", detail='" + detail + '\'' +
                ", createTime='" + createTime + '\'' +
                '}';
    }
}
