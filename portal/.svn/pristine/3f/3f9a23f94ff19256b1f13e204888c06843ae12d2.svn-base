package com.jspgou.cms.manager.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jspgou.common.hibernate3.Updater;
import com.jspgou.common.page.Pagination;
import com.jspgou.cms.dao.OrderItemDao;
import com.jspgou.cms.entity.OrderItem;
import com.jspgou.cms.manager.OrderItemMng;
/**
* This class should preserve.
* @preserve
*/
@Service
@Transactional
public class OrderItemMngImpl implements OrderItemMng{

	public List<Object[]> profitTop(Long ctgid,Long typeid,Integer pageNo,Integer pageSize) {
		return dao.profitTop(ctgid,typeid,pageNo,pageSize);
	}

	public Integer totalCount(Long ctgid,Long typeid) {
		return dao.totalCount(ctgid,typeid);
	}
	
	public OrderItem findById(Long id){
		return dao.findById(id);
	}
	
	public OrderItem updateByUpdater(OrderItem bean) {
		Updater<OrderItem> updater = new Updater<OrderItem>(bean);
		return dao.updateByUpdater(updater);
	}
	
	@SuppressWarnings("unchecked")
	public Pagination getPageByMember(Integer status,Long memberId,int pageNo,int pageSize){
		return dao.getPageForMember(memberId, status, pageNo, pageSize);
	}
	
	public List<Object[]> getOrderItem(){
		List<Object[]> orderItemList=dao.getOrderItem();
		return orderItemList;
	}
	

	public OrderItem findByMember(Long memberId,Long productId){
		return dao.findByMember(memberId, productId);
	}
	
	public Pagination getOrderItem(Integer pageNo,Integer pageSize,Long productId){
		return dao.getPageForProuct(productId, pageNo, pageSize);
	}
	
	@Autowired
	private OrderItemDao dao;
	
}

