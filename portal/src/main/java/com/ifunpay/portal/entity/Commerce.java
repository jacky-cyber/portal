package com.ifunpay.portal.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jdk.nashorn.internal.ir.annotations.Ignore;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.search.annotations.Indexed;

import javax.persistence.*;
import java.util.Date;

/**
 * 商户表。
 */
@Entity
@Table(name = "T_COMMERCE")
@Indexed
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE, region="longTimeCache")
public class Commerce {

   /* @Column(name = "comm_id")
    private long commId;*/

    @Id
    @GeneratedValue
    @Column(name = "id")
    private Long id;

    @Column(name = "uuid")
    private String uuid;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "chan_id_rela")
    private Channel chanIdRela;
	
	@Column(name = "COMMERCE_ID")
	private String commerceId; //业务平台生成ID
	
    @Column(name = "STATUS")
	@LogDescCN(chineseName = "商户状态")
	private String status;// 商户状态

	@LogDescCN(chineseName = "商户名称")
	private String name;// 商户名称

	@Column(name = "MOBILE_PHONE")
	@LogDescCN(chineseName = "手机")
	private String mobilePhone;// 手机
	private String email;// 邮箱
	// @NotNull
	// @Field(analyze = Analyze.NO)
	// private String area;// 总部所属区域
	/** 关联地区 */
	/*@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "AREA")
	private Area area;*/

    @Column(name = "province")
    private String pro;

    @Column(name = "city")
    private String city;

    @Column(name = "detailed")
    private String detailed;

	@Column(name = "CREATE_DATE")
	private Date createDate;//
	/** 关联用户 */
    /*@ManyToOne(fetch=FetchType.LAZY,optional=true)
	@JoinColumn(name = "CREATOR_ID")*/
    @Column(name = "CREATOR_ID")
	private String creator;

	@Column(name = "MODIFY_DATE")
	private Date modifyDate;

	/** 关联用户 */
    //@ManyToOne(fetch=FetchType.LAZY,optional=true)
	@Column(name = "MODIFIER_ID")
	private String modifier;
	// private String channelId;
	/** 关联渠道 */
	//@ManyToOne(fetch = FetchType.LAZY)
	@Column(name = "CHANNEL_ID")
	private String channel;

	@LogDescCN(chineseName = "商户代码")
	private String code;// 商户代码
	
	
	/*@Column(name = "ADDRESS")
	private String address;*/
	
	private String description;// 商户说明

	/*@Column(name = "SYN_STATUS")
	@LogDescCN(chineseName = "同步状态")
	private String synStatus;*/// 同步状态

	private String delStatus = "0";//0.正常 1.删除
	
	@Column(name = "collaborate_start_time")
	private Date collaborateStartTime;// 合作开始时间
	@Column(name = "collaborate_end_time")
	private Date collaborateEndTime;// 合作结束时间
	private String checked = "1";//审核 1.未审核  2.审核
	
//	private String special; //是否特约商户
	
//	private String sort;//排序

	/*@Column(name = "EXPRESS")
	private String express;*/// 物流公司
	
	@Column(name = "LINKMAN")
	private String linkMan;// 联系人
	
	@Column(name = "ACCOUNT")
	private String account;// 清算账号
	
	@Column(name = "ROUND_DAY")
	private Integer roundDay;// 清算周期
	
	@Column(name = "RATE")
	private Double  rate;// 费率
	
	/*public String getExpress() {
		return express;
	}

	public void setExpress(String express) {
		this.express = express;
	}*/

	// 支付帐号ID
	@Basic
	@Column(name = "pay_account_id")
	private String payAccountId;

	// 支付帐号启用状态:0禁用, 1启用
	@Basic
	@Column(name = "pay_account_status")
	private Integer payAccountStatus;

	@Ignore
	@Column(name = "chan_id_rela", insertable = false, updatable = false)
	private Long chanId;
	
	public Double getRate() {
		return rate;
	}

	public void setRate(Double rate) {
		this.rate = rate;
	}

	public String getChecked() {
		return checked;
	}
	
	public String getLinkMan() {
		return linkMan;
	}

	public void setLinkMan(String linkMan) {
		this.linkMan = linkMan;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	

	public Integer getRoundDay() {
		return roundDay;
	}

	public void setRoundDay(Integer roundDay) {
		this.roundDay = roundDay;
	}


	/*public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}*/

	public void setChecked(String checked) {
		this.checked = checked;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getMobilePhone() {
		return mobilePhone;
	}

	public void setMobilePhone(String mobilePhone) {
		this.mobilePhone = mobilePhone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

    /*@JsonIgnore
	public Area getArea() {
		return area;
	}

	public void setArea(Area area) {
		this.area = area;
	}*/

    public String getPro() {
        return pro;
    }

    public void setPro(String pro) {
        this.pro = pro;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getDetailed() {
        return detailed;
    }

    public void setDetailed(String detailed) {
        this.detailed = detailed;
    }

    public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

    public String getCreator() {
        return creator;
    }

    public void setCreator(String creator) {
        this.creator = creator;
    }

    public String getModifier() {
        return modifier;
    }

    public void setModifier(String modifier) {
        this.modifier = modifier;
    }

    public Date getModifyDate() {
		return modifyDate;
	}

	public void setModifyDate(Date modifyDate) {
		this.modifyDate = modifyDate;
	}



    public String getChannel() {
        return channel;
    }

    public void setChannel(String channel) {
        this.channel = channel;
    }

    public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	/*public String getSynStatus() {
		return synStatus;
	}

	public void setSynStatus(String synStatus) {
		this.synStatus = synStatus;
	}*/

	public String getDelStatus() {
		return delStatus;
	}

	public void setDelStatus(String delStatus) {
		this.delStatus = delStatus;
	}

	public Date getCollaborateStartTime() {
		return collaborateStartTime;
	}

	public void setCollaborateStartTime(Date collaborateStartTime) {
		this.collaborateStartTime = collaborateStartTime;
	}

	public Date getCollaborateEndTime() {
		return collaborateEndTime;
	}

	public void setCollaborateEndTime(Date collaborateEndTime) {
		this.collaborateEndTime = collaborateEndTime;
	}

	public String getCommerceId() {
		return commerceId;
	}

	public void setCommerceId(String commerceId) {
		this.commerceId = commerceId;
	}

	/*public String getSpecial() {
		return special;
	}

	public void setSpecial(String special) {
		this.special = special;
	}*/

	/*public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}*/

    /*public long getCommId() {
        return commId;
    }

    public void setCommId(long commId) {
        this.commId = commId;
    }*/




    public Channel getChanIdRela() {
        return chanIdRela;
    }
    @JsonIgnore
    public void setChanIdRela(Channel chanIdRela) {
        this.chanIdRela = chanIdRela;
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

	public String getPayAccountId() {
		return payAccountId;
	}

	public void setPayAccountId(String payAccountId) {
		this.payAccountId = payAccountId;
	}

	public Integer getPayAccountStatus() {
		return payAccountStatus;
	}

	public void setPayAccountStatus(Integer payAccountStatus) {
		this.payAccountStatus = payAccountStatus;
	}

	public Long getChanId() {
		return chanId;
	}

	public void setChanId(Long chanId) {
		this.chanId = chanId;
	}
}
