package com.ifunpay.portal.entity;

import org.hibernate.annotations.CacheConcurrencyStrategy;

import javax.persistence.*;
import java.util.Date;

/**
 * 会员，区别于系统用户
 * Created by Yu on 2014/12/4.
 */
@Entity
@Table(name = "n_member_user")
@org.hibernate.annotations.Cache(usage = CacheConcurrencyStrategy.READ_WRITE, region="longTimeCache")
public class MemberUserEntity {

//    @Id
//    @Column(name = "id")
//    private String id;

    /**
     * 可以是手机号码
     */

    @Id
    @GeneratedValue
    @Column(name = "id")
    private Long id;

    @Column(name = "uuid")
    private String uuid;

    @Basic
    @Column(name ="name" ,unique = true, nullable = false)
    private String name;

    /**
     * 未绑定的手机号码，如果有已绑定的手机号码，该字段无效
     */
    @Basic
    @Column(name = "phone" , unique = true)
    private String phone;

    /**
     * 用户密码
     */
    @Basic
    @Column(name = "password")
    private String password;

    /**
     * 用户邮箱
     */
    @Basic
    @Column(name = "email")
    private String email;

    /**
     * 注册时间
     */
    @Basic
    @Column(name = "register_date")
    private Date registerDate;

    /**
     * 性别，0表示男,1表示女
     */
    @Basic
    @Column(name = "sex")
    private Integer sex;

    /**
     * 注册IP
     */
    @Basic
    @Column(name = "register_ip")
    private String registerIp;

    /**
     * 状态,0表示删除,1表示已注册,2表示未注册
     */
    @Basic
    @Column(name = "user_status")
    private Integer userStatus = 1;

    /**
     * 来源:0表示建行，1表示其他,2表示民生银行
     */
    @Basic
    @Column(name = "origin")
    private Integer origin;

    /**
     * 最后一次登录的时间
     */
    @Basic
    @Column(name = "last_login")
    private Date lastLogin;

    /**
     * 最后一次登录的IP
     */
    @Basic
    @Column(name = "last_login_ip")
    private String lastLoginIp;

    /**
     * 用户编号
     */
    @Basic
    @Column(name = "user_id")
    private String userId;

    /**
     * 民生银行md5用户唯一标识
     */
    @Basic
    @Column(name = "cmbc_user_id")
    private String cmbcUserId = null;

//    public String getId() {
//        return id;
//    }
//
//    public void setId(String id) {
//        this.id = id;
//    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Date getRegisterDate() {
        return registerDate;
    }

    public void setRegisterDate(Date registerDate) {
        this.registerDate = registerDate;
    }

    public Integer getSex() {
        return sex;
    }

    public void setSex(Integer sex) {
        this.sex = sex;
    }

    public String getRegisterIp() {
        return registerIp;
    }

    public void setRegisterIp(String registerIp) {
        this.registerIp = registerIp;
    }

    public Integer getUserStatus() {
        return userStatus;
    }

    public void setUserStatus(Integer userStatus) {
        this.userStatus = userStatus;
    }

    public Integer getOrigin() {
        return origin;
    }

    public void setOrigin(Integer origin) {
        this.origin = origin;
    }

    public Date getLastLogin() {
        return lastLogin;
    }

    public void setLastLogin(Date lastLogin) {
        this.lastLogin = lastLogin;
    }

    public String getLastLoginIp() {
        return lastLoginIp;
    }

    public void setLastLoginIp(String lastLoginIp) {
        this.lastLoginIp = lastLoginIp;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getCmbcUserId() {
        return cmbcUserId;
    }

    public void setCmbcUserId(String cmbcUserId) {
        this.cmbcUserId = cmbcUserId;
    }


    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }
}
