package com.jspgou.cms.entity;

import com.jspgou.cms.entity.base.BaseOrder;

import java.sql.Timestamp;
import java.util.Date;
import java.util.LinkedHashSet;
import java.util.Set;
/**
* This class should preserve.
* @preserve
*/
public class Order extends BaseOrder {
	private static final long serialVersionUID = 1L;
	
	/**
	 * 计算重量
	 * 
	 * @return
	 */
	public int calWeight() {
		int weight = 0;
		for (OrderItem item : getItems()) {
			weight += item.getProduct().getWeight();
		}
		return weight;
	}

	/**
	 * 获得购物车中商品总重量，免运费的商品不记重量。
	 * 
	 * @return
	 */
	public Double getWeightForFreight() {
		Double weight = 0.0;
		for (OrderItem item : getItems()) {
			weight += item.getWeightForFreight();
		}
		return weight;
	}

	/**
	 * 获得购物车中商品总数量，免运费的商品不计数量。
	 * 
	 * @return
	 */
	public int getCountForFreight() {
		int count = 0;
		for (OrderItem item : getItems()) {
			count += item.getCountForFreigt();
		}
		return count;
	}

	public void addToItems(OrderItem item) {
		Set<OrderItem> items = getItems();
		if (items == null) {
			items = new LinkedHashSet<OrderItem>();
			setItems(items);
		}
		item.setOrdeR(this);
		items.add(item);
	}

	public void init() {
		Date now = new Timestamp(System.currentTimeMillis());
		if (getCreateTime() == null) {
			setCreateTime(now);
		}
		if (getLastModified() == null) {
			setLastModified(now);
		}
	}

	/* [CONSTRUCTOR MARKER BEGIN] */
	public Order () {
		super();
	}

	/**
	 * Constructor for primary key
	 */
	public Order (java.lang.Long id) {
		super(id);
	}

	/**
	 * Constructor for required fields
	 */
	public Order (
		java.lang.Long id,
		com.jspgou.core.entity.Website website,
		com.jspgou.cms.entity.ShopMember member,
        com.ifunpay.portal.entity.MemberUserEntity memberUserEntity,
		com.jspgou.cms.entity.Payment payment,
		com.jspgou.cms.entity.Shipping shipping,
		com.jspgou.cms.entity.Shipping shopDirectory,
        com.jspgou.cms.entity.Product product,
		java.lang.String code,
		java.lang.String ip,
		java.util.Date createTime,
		java.util.Date lastModified,
		java.lang.Long total,
		java.lang.Integer score,
        java.lang.Integer del,
		java.lang.Double weight,
        java.lang.Integer orderType,
        java.lang.String terminalId,//终端机编号
        java.lang.String terminalOrderId,
		java.lang.Integer status,
        java.lang.String serialNo,
		Long originalPrice,
		Long diffPrice,
		String payAccountName
	) {

        super (
                id,
                website,
                member,
                memberUserEntity,
                payment,
                shipping,
                shopDirectory,
                product,
                code,
                ip,
                createTime,
                lastModified,
                total,
                score,
                orderType,
                del,
                terminalId,
                terminalOrderId,
                weight,
                serialNo,
				originalPrice,
				diffPrice,
				payAccountName
                );
    }

	/* [CONSTRUCTOR MARKER END] */

}