package com.jspgou.cms.entity.base;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.ifunpay.portal.entity.MemberUserEntity;
import com.jspgou.cms.entity.Product;

import java.io.Serializable;


/**
 * This is an object that contains data related to the jc_shop_order table.
 * Do not modify this class because it will be overwritten if the configuration file
 * related to this class is modified.
 *
 * @hibernate.class
 *  table="jc_shop_order"
 * This class should preserve.
 * @preserve
 */

public abstract class BaseOrder  implements Serializable {

	public static String REF = "Order";
	public static String PROP_IP = "ip";
	public static String PROP_MEMBER = "member";
	public static String PROP_COMMENTS = "comments";
	public static String PROP_WEBSITE = "website";
	public static String PROP_RETURN_REASON = "returnReason";
	public static String PROP_FREIGHT = "freight";
	public static String PROP_CODE = "code";
	public static String PROP_PAYMENT = "payment";
	public static String PROP_PRODUCT_PRICE = "productPrice";
	public static String PROP_COUPON_PRICE = "couponPrice";
	public static String PROP_STATUS = "status";
	public static String PROP_SHIPPING_TIME = "shippingTime";
	public static String PROP_FINISHED_TIME = "finishedTime";
	public static String PROP_WEIGHT = "weight";
	public static String PROP_CREATE_TIME = "createTime";
	public static String PROP_ID = "id";
	public static String PROP_SHOP_DIRECTORY = "shopDirectory";
	public static String PROP_SHIPPING = "shipping";
	public static String PROP_PRODUCT_NAME = "productName";
	public static String PROP_LAST_MODIFIED = "lastModified";
	public static String PROP_SCORE = "score";
	public static String PROP_TOTAL = "total";
    public static String PROP_TERMINAL_ORDER_ID = "terminalOrderId";
    public static String PROP_SERIAL_NO = "serialNo";
	public static String PROP_ORIGINAL_PRICE ="originalPrice";
	public static String PROP_DIFF_PRICE = "diffPrice";
	public static String PROP_PAY_ACCOUNT_NAME = "payAccountName";


	// constructors
	public BaseOrder () {
		initialize();
	}

	/**
	 * Constructor for primary key
	 */
	public BaseOrder (java.lang.Long id) {
		this.setId(id);
		initialize();
	}

	/**
	 * Constructor for required fields
	 */
	public BaseOrder (
		java.lang.Long id,
		com.jspgou.core.entity.Website website,
		com.jspgou.cms.entity.ShopMember member,
        com.ifunpay.portal.entity.MemberUserEntity memberUserEntity,
		com.jspgou.cms.entity.Payment payment,
		com.jspgou.cms.entity.Shipping shipping,
		com.jspgou.cms.entity.Shipping shopDirectory,
        com.jspgou.cms.entity.Product product,
		String  code,
		java.lang.String ip,
		java.util.Date createTime,
		java.util.Date lastModified,
		java.lang.Long total,
		java.lang.Integer score,
        java.lang.Integer del,
        java.lang.Integer orderType,
        java.lang.String terminalId,
        java.lang.String terminalOrderId,
		java.lang.Double weight,
        java.lang.String serialNo,
		Long originalPrice,
		Long diffPrice,
		String payAccountName
	) {

		this.setId(id);
		this.setWebsite(website);
		this.setMember(member);
        this.setMemberUserEntity(memberUserEntity);
		this.setPayment(payment);
		this.setShipping(shipping);
		
		this.setCode(code);
		this.setIp(ip);
		this.setCreateTime(createTime);
		this.setLastModified(lastModified);
		this.setTotal(total);
		this.setScore(score);
        this.setOrderType(orderType);
        this.setDel(del);
		this.setWeight(weight);
        this.setTerminalId(terminalId);
        this.setTerminalOrderId(terminalOrderId);
        this.setSerialNo(serialNo);
		initialize();
	}

	protected void initialize () {}



	private int hashCode = Integer.MIN_VALUE;

	// primary key
	private java.lang.Long id;

	// fields
	private java.lang.String code;
	private java.lang.String comments;
	private java.lang.String ip;
	private java.util.Date createTime;
	private java.util.Date shippingTime;
	private java.util.Date finishedTime;
	private java.util.Date lastModified;
	private java.lang.Long productPrice;
	private java.lang.Double freight;
	private java.lang.Long total;
	private java.lang.Integer score;
	private java.lang.Double weight;
	private java.lang.Double couponPrice;
	private java.lang.String productName;
	private java.lang.Integer paymentStatus;//支付状态 :1-未支付，2-已支付，3- 已退款，4-退款失败
	private java.lang.Integer shippingStatus;//1-未发货，2-已发货，3-已退货，4-出货成功，5-出货失败
	private java.lang.Integer status;
	private java.lang.String receiveName;
	private java.lang.String receiveAddress;
	private java.lang.String receiveZip;
	private java.lang.String receivePhone;
	private java.lang.String receiveMobile;
	private java.lang.String tradeNo;
	private java.lang.String paymentCode;
    private java.lang.Integer orderType;
    private java.lang.Integer del;
    private java.lang.String terminalId;
    private java.lang.String terminalOrderId;
    private java.lang.String serialNo;
	private Long originalPrice;
	private Long diffPrice;
	private String payAccountName;
	// many to one
	private com.jspgou.core.entity.Website website;
	private com.jspgou.cms.entity.ShopMember member;
    private com.ifunpay.portal.entity.MemberUserEntity memberUserEntity;
	private com.jspgou.cms.entity.Payment payment;
	private com.jspgou.cms.entity.Shipping shipping;
	private com.jspgou.cms.entity.OrderReturn returnOrder;
    private com.jspgou.cms.entity.Product product;
	
	// collections
	private java.util.Set<com.jspgou.cms.entity.OrderItem> items;

	/**
	 * Return the unique identifier of this class
     * @hibernate.id
     *  generator-class="native"
     *  column="order_id"
     */
	public java.lang.Long getId () {
		return id;
	}

	/**
	 * Set the unique identifier of this class
	 * @param id the new ID
	 */
	public void setId (java.lang.Long id) {
		this.id = id;
		this.hashCode = Integer.MIN_VALUE;
	}

	public String getPayAccountName() {
		return payAccountName;
	}

	public void setPayAccountName(String payAccountName) {
		this.payAccountName = payAccountName;
	}

	public Long getOriginalPrice() {
		return originalPrice;
	}

	public void setOriginalPrice(Long originalPrice) {
		this.originalPrice = originalPrice;
	}

	public Long getDiffPrice() {
		return diffPrice;
	}

	public void setDiffPrice(Long diffPrice) {
		this.diffPrice = diffPrice;
	}

	/**
	 * Return the value associated with the column: code
	 */
	public String getCode () {
		return code;
	}

	/**
	 * Set the value related to the column: code
	 * @param code the code value
	 */
	public void setCode (java.lang.String code) {
		this.code = code;
	}

	/**
	 * Return the value associated with the column: comments
	 */
	public java.lang.String getComments () {
		return comments;
	}

	/**
	 * Set the value related to the column: comments
	 * @param comments the comments value
	 */
	public void setComments (java.lang.String comments) {
		this.comments = comments;
	}


	/**
	 * Return the value associated with the column: ip
	 */
	public java.lang.String getIp () {
		return ip;
	}

	/**
	 * Set the value related to the column: ip
	 * @param ip the ip value
	 */
	public void setIp (java.lang.String ip) {
		this.ip = ip;
	}


	/**
	 * Return the value associated with the column: create_time
	 */
	public java.util.Date getCreateTime () {
		return createTime;
	}

	/**
	 * Set the value related to the column: create_time
	 * @param createTime the create_time value
	 */
	public void setCreateTime (java.util.Date createTime) {
		this.createTime = createTime;
	}

	/**
	 * Return the value associated with the column: shipping_time
	 */
	public java.util.Date getShippingTime () {
		return shippingTime;
	}

	/**
	 * Set the value related to the column: shipping_time
	 * @param shippingTime the shipping_time value
	 */
	public void setShippingTime (java.util.Date shippingTime) {
		this.shippingTime = shippingTime;
	}


	/**
	 * Return the value associated with the column: finished_time
	 */
	public java.util.Date getFinishedTime () {
		return finishedTime;
	}

	/**
	 * Set the value related to the column: finished_time
	 * @param finishedTime the finished_time value
	 */
	public void setFinishedTime (java.util.Date finishedTime) {
		this.finishedTime = finishedTime;
	}


	/**
	 * Return the value associated with the column: last_modified
	 */
	public java.util.Date getLastModified () {
		return lastModified;
	}

	/**
	 * Set the value related to the column: last_modified
	 * @param lastModified the last_modified value
	 */
	public void setLastModified (java.util.Date lastModified) {
		this.lastModified = lastModified;
	}


	/**
	 * Return the value associated with the column: product_price
	 */
	public java.lang.Long getProductPrice () {
		return productPrice;
	}

	/**
	 * Set the value related to the column: product_price
	 * @param productPrice the product_price value
	 */
	public void setProductPrice (java.lang.Long productPrice) {
		this.productPrice = productPrice;
	}


	/**
	 * Return the value associated with the column: freight
	 */
	public java.lang.Double getFreight () {
		return freight;
	}

	/**
	 * Set the value related to the column: freight
	 * @param freight the freight value
	 */
	public void setFreight (java.lang.Double freight) {
		this.freight = freight;
	}


	/**
	 * Return the value associated with the column: total
	 */
	public java.lang.Long getTotal () {
		return total;
	}

	/**
	 * Set the value related to the column: total
	 * @param total the total value
	 */
	public void setTotal (java.lang.Long total) {
		this.total = total;
	}


	/**
	 * Return the value associated with the column: score
	 */
	public java.lang.Integer getScore () {
		return score;
	}

	/**
	 * Set the value related to the column: score
	 * @param score the score value
	 */
	public void setScore (java.lang.Integer score) {
		this.score = score;
	}


	/**
	 * Return the value associated with the column: weight
	 */
	public java.lang.Double getWeight () {
		return weight;
	}

	/**
	 * Set the value related to the column: weight
	 * @param weight the weight value
	 */
	public void setWeight (java.lang.Double weight) {
		this.weight = weight;
	}

	/**
	 * Return the value associated with the column: coupon_price
	 */
	public java.lang.Double getCouponPrice () {
		return couponPrice;
	}

	/**
	 * Set the value related to the column: coupon_price
	 * @param couponPrice the coupon_price value
	 */
	public void setCouponPrice (java.lang.Double couponPrice) {
		this.couponPrice = couponPrice;
	}


	/**
	 * Return the value associated with the column: productName
	 */
	public java.lang.String getProductName () {
		return productName;
	}

	/**
	 * Set the value related to the column: productName
	 * @param productName the productName value
	 */
	public void setProductName (java.lang.String productName) {
		this.productName = productName;
	}

	/**
	 * Return the value associated with the column: website_id
	 */
    @JsonIgnore
	public com.jspgou.core.entity.Website getWebsite () {
		return website;
	}

	/**
	 * Set the value related to the column: website_id
	 * @param website the website_id value
	 */
	public void setWebsite (com.jspgou.core.entity.Website website) {
		this.website = website;
	}


	/**
	 * Return the value associated with the column: member_id
	 */
    @JsonIgnore
	public com.jspgou.cms.entity.ShopMember getMember () {
		return member;
	}

	/**
	 * Set the value related to the column: member_id
	 * @param member the member_id value
	 */
	public void setMember (com.jspgou.cms.entity.ShopMember member) {
		this.member = member;
	}


	/**
	 * Return the value associated with the column: payment_id
	 */
    @JsonIgnore
	public com.jspgou.cms.entity.Payment getPayment () {
		return payment;
	}

	/**
	 * Set the value related to the column: payment_id
	 * @param payment the payment_id value
	 */
	public void setPayment (com.jspgou.cms.entity.Payment payment) {
		this.payment = payment;
	}


    public java.lang.Integer getOrderType(){return orderType;}

    public void setOrderType(java.lang.Integer orderType){
        this.orderType  = orderType;
    }


    public Integer getDel() {
        return del;
    }

    public void setDel(java.lang.Integer del){
        this.del = del;
    }
	/**
	 * Return the value associated with the column: shipping_id
	 */
    @JsonIgnore
	public com.jspgou.cms.entity.Shipping getShipping () {
		return shipping;
	}

	/**
	 * Set the value related to the column: shipping_id
	 * @param shipping the shipping_id value
	 */
	public void setShipping (com.jspgou.cms.entity.Shipping shipping) {
		this.shipping = shipping;
	}

	/**
	 * Return the value associated with the column: items
	 */
    @JsonIgnore
	public java.util.Set<com.jspgou.cms.entity.OrderItem> getItems () {
		return items;
	}

	/**
	 * Set the value related to the column: items
	 * @param items the items value
	 */
	public void setItems (java.util.Set<com.jspgou.cms.entity.OrderItem> items) {
		this.items = items;
	}

	public boolean equals (Object obj) {
		if (null == obj) return false;
		if (!(obj instanceof com.jspgou.cms.entity.Order)) return false;
		else {
			com.jspgou.cms.entity.Order order = (com.jspgou.cms.entity.Order) obj;
			if (null == this.getId() || null == order.getId()) return false;
			else return (this.getId().equals(order.getId()));
		}
	}

	public int hashCode () {
		if (Integer.MIN_VALUE == this.hashCode) {
			if (null == this.getId()) return super.hashCode();
			else {
				String hashStr = this.getClass().getName() + ":" + this.getId().hashCode();
				this.hashCode = hashStr.hashCode();
			}
		}
		return this.hashCode;
	}


	public String toString () {
		return super.toString();
	}

	public void setPaymentStatus(java.lang.Integer paymentStatus) {
		this.paymentStatus = paymentStatus;
	}

	public java.lang.Integer getPaymentStatus() {
		return paymentStatus;
	}

	public void setShippingStatus(java.lang.Integer shippingStatus) {
		this.shippingStatus = shippingStatus;
	}

	public java.lang.Integer getShippingStatus() {
		return shippingStatus;
	}

	public void setStatus(java.lang.Integer status) {
		this.status = status;
	}

	public java.lang.Integer getStatus() {
		return status;
	}

	public void setReturnOrder(com.jspgou.cms.entity.OrderReturn returnOrder) {
		this.returnOrder = returnOrder;
	}

    @JsonIgnore
	public com.jspgou.cms.entity.OrderReturn getReturnOrder() {
		return returnOrder;
	}

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public void setReceiveName(java.lang.String receiveName) {
		this.receiveName = receiveName;
	}

	public java.lang.String getReceiveName() {
		return receiveName;
	}

	public void setReceiveAddress(java.lang.String receiveAddress) {
		this.receiveAddress = receiveAddress;
	}

	public java.lang.String getReceiveAddress() {
		return receiveAddress;
	}

	public void setReceiveZip(java.lang.String receiveZip) {
		this.receiveZip = receiveZip;
	}

	public java.lang.String getReceiveZip() {
		return receiveZip;
	}

	public void setReceivePhone(java.lang.String receivePhone) {
		this.receivePhone = receivePhone;
	}

	public java.lang.String getReceivePhone() {
		return receivePhone;
	}

	public void setReceiveMobile(java.lang.String receiveMobile) {
		this.receiveMobile = receiveMobile;
	}

	public java.lang.String getReceiveMobile() {
		return receiveMobile;
	}

	public void setTradeNo(java.lang.String tradeNo) {
		this.tradeNo = tradeNo;
	}

	public java.lang.String getTradeNo() {
		return tradeNo;
	}

	public void setPaymentCode(java.lang.String paymentCode) {
		this.paymentCode = paymentCode;
	}

	public java.lang.String getPaymentCode() {
		return paymentCode;
	}

    public String getTerminalId() {
        return terminalId;
    }

    public void setTerminalId(String terminalId) {
        this.terminalId = terminalId;
    }

    public MemberUserEntity getMemberUserEntity() {
        return memberUserEntity;
    }

    public void setMemberUserEntity(MemberUserEntity memberUserEntity) {
        this.memberUserEntity = memberUserEntity;
    }

    public String getTerminalOrderId() {
        return terminalOrderId;
    }

    public void setTerminalOrderId(String terminalOrderId) {
        this.terminalOrderId = terminalOrderId;
    }

    public String getSerialNo() {
        return serialNo;
    }

    public void setSerialNo(String serialNo) {
        this.serialNo = serialNo;
    }
}