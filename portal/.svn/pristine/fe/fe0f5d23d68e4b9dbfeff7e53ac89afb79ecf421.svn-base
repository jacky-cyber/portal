package com.ifunpay.portal.entity;


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * 
 * @author Xie Cong Long
 *
 */
@Entity
@Table(name = "t_order")
public class TerminalOrder extends AutoIdEntity{
		@Column(name = "name")
		private String name;
		
		@Column(name = "value")
		private String value;
		
		@Column(name = "order_id")
		private String orderId; // 订单号
		
		@Column(name = "t_mark")
		private String mark;

		public String getName() {
			return name;
		}

		public void setName(String name) {
			this.name = name;
		}

		public String getValue() {
			return value;
		}

		public void setValue(String value) {
			this.value = value;
		}

		public String getOrderId() {
			return orderId;
		}

		public void setOrderId(String orderId) {
			this.orderId = orderId;
		}

		public String getMark() {
			return mark;
		}

		public void setMark(String mark) {
			this.mark = mark;
		}

		@Override
		public String toString() {
			return "TerminalOrder [name=" + name + ", value=" + value
					+ ", orderId=" + orderId + ", mark=" + mark + "]";
		}

		public TerminalOrder() {
			super();
		}
}

