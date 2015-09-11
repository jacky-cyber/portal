package com.jspgou.cms.manager.impl;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.jspgou.cms.dao.MemberCouponDao;
import com.jspgou.cms.entity.MemberCoupon;
import com.jspgou.cms.manager.MemberCouponMng;
/**
* This class should preserve.
* @preserve
*/
@Service
@Transactional
public class MemberCouponMngImpl implements MemberCouponMng {
	
	public List<MemberCoupon> getList(Long memberId) {
		List<MemberCoupon> list = dao.getList( memberId);
		return list;
	}
	
	public MemberCoupon findById(Long id){
		return dao.findById(id);
	}
	
	@Transactional(readOnly = true)
	public List<MemberCoupon> getList(Long memberId,BigDecimal price){
		return dao.getList(memberId, new Date(),price);
	}

	@Transactional(readOnly = true)
	public MemberCoupon findByCoupon(Long memberId,Long couponId){
		return dao.findByCoupon(memberId, couponId);	
	}
	
	public MemberCoupon save(MemberCoupon bean){
		return dao.save(bean);
	}
	
	public MemberCoupon update(MemberCoupon bean){
		return dao.update(bean);
	}

	@Autowired
	private MemberCouponDao dao;
}