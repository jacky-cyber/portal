package com.ifunpay.portal.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.search.annotations.Indexed;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 渠道。
 */
@Entity
@Table(name = "T_CHANNEL")
@Indexed
@JsonIgnoreProperties(value={"hibernateLazyInitializer"})
public class Channel{

    // @NotNull
    // @Column(name = "CHANNEL_ID_VAL")
    // @Field(analyze = Analyze.NO)
    // private String channelIdVal;// 渠道ID定义值

    @Id
    @GeneratedValue
    @Column(name = "id")
    private Long id;

    @Column(name="uuid")
    private String uuid;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "chan_parent_id")
    private Channel chanParentId;

    @Column(name="CHANNEL_ID")
    @LogDescCN(chineseName = "渠道ID")
    private String channelId;

    @Column(name = "CHANNEL_NAME")
    @LogDescCN(chineseName = "渠道名称")
    private String channelName;// 名称
//	@NotNull
//	@Column(name = "CHANNEL_CODE")
//	@Field(analyze = Analyze.NO)
//	@LogDescCN(chineseName = "渠道编号")
//	private String channelCode;// 渠道编号
    // private String channelParent;//父渠道
    /** 上级渠道 */
	/*@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CHANNEL_PARENT")*/

    @Column(name = "CHANNEL_PARENT")
    private String parent;

    /** 下级渠道 *//*
	@OneToMany(mappedBy = "chan_parent_id", fetch = FetchType.LAZY, cascade = CascadeType.ALL, orphanRemoval = true)
	private List<Channel> childs = new ArrayList<Channel>();*/

    private String description;// 描述
    @Column(name = "CREATE_DATE")
    @LogDescCN(chineseName = "创建时间")
    private Date createDate;
    // @Column(name = "CREATOR_ID")
    // private String CreatorId;
    /** 关联用户 */
    @Column(name = "CREATOR_ID")
    @LogDescCN(chineseName = "创建人")
    private String creator;

    @Column(name = "MODIFY_DATE")
    @LogDescCN(chineseName = "修改时间")
    private Date modifyDate;
    // @Column(name = "MODIFIER_ID")
    // private String ModifierId;
    /** 关联用户 */
    @Column(name = "MODIFIER_ID")
    @LogDescCN(chineseName = "修改人")
    private String modifier;

  /*  @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "operator_id")*/
    @Column(name = "operator_id")
    @LogDescCN(chineseName = "操作员")
    private Long operator;

    @Column(name = "STATUS")
    @LogDescCN(chineseName = "渠道状态")
    private String status;// 状态

    @LogDescCN(chineseName = "渠道删除状态")
    private String delStatus;// 删除状态 默认是正常的
    @Column(name = "collaborate_start_time")
    @LogDescCN(chineseName = "合作开始时间")
    private Date collaborateStartTime;// 合作开始时间
    @Column(name = "collaborate_end_time")
    @LogDescCN(chineseName = "合作结束时间")
    private Date collaborateEndTime;// 合作结束时间
    @Column(name = "PAY_METHOD")
    @LogDescCN(chineseName = "支付方式集合")
    private String payMethod;// 支付方式集合

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "bank_pay_info_id", insertable = false, updatable = false)
    private BankPayInfo bankPayInfo;

    @Column(name = "bank_pay_info_id")
    private String bankPayInfoId;

    public String getPayMethod() {
        return payMethod;
    }

    public void setPayMethod(String payMethod) {
        this.payMethod = payMethod;
    }

    /* 关联商户 */
    @OneToMany(mappedBy = "channel", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private List<Commerce> commerces = new ArrayList<Commerce>();

    // public String getChannelIdVal() {
    // return channelIdVal;
    // }
    //
    // public void setChannelIdVal(String channelIdVal) {
    // this.channelIdVal = channelIdVal;
    // }

    public String getChannelName() {
        return channelName;
    }

    public String getChannelId() {
        return channelId;
    }

    public void setChannelId(String channelId) {
        this.channelId = channelId;
    }

    public void setChannelName(String channelName) {
        this.channelName = channelName;
    }

//	public String getChannelCode() {
//		return channelCode;
//	}
//
//	public void setChannelCode(String channelCode) {
//		this.channelCode = channelCode;
//	}

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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

    public Long getOperator() {
        return operator;
    }

    public void setOperator(Long operator) {
        this.operator = operator;
    }

    public Date getModifyDate() {
        return modifyDate;
    }

    public void setModifyDate(Date modifyDate) {
        this.modifyDate = modifyDate;
    }



    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @JsonIgnore
    public List<Commerce> getCommerces() {
        return commerces;
    }

    public String getDelStatus() {
        return delStatus;
    }

    public void setDelStatus(String delStatus) {
        this.delStatus = delStatus;
    }

    public void setCommerces(List<Commerce> commerces) {
        this.commerces = commerces;
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

    @JsonIgnore
    public BankPayInfo getBankPayInfo() {
        return bankPayInfo;
    }

    public void setBankPayInfo(BankPayInfo bankPayInfo) {
        this.bankPayInfo = bankPayInfo;
    }

    public String getBankPayInfoId() {
        return bankPayInfoId;
    }

    public void setBankPayInfoId(String bankPayInfoId) {
        this.bankPayInfoId = bankPayInfoId;
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

    public Channel getChanParentId() {
        return chanParentId;
    }

    @JsonIgnore
    public void setChanParentId(Channel chanParentId) {
        this.chanParentId = chanParentId;
    }

    public void setParent(String parent) {
        this.parent = parent;
    }

    public String getParent() {
        return parent;
    }
}
