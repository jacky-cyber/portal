package com.jspgou.cms.dao.impl;

import java.util.Date;
import java.util.List;

import com.ifunpay.portal.ProjectXml;
import com.ifunpay.portal.entity.OrderPayRefundEntity;
import com.ifunpay.util.common.StringUtil;
import org.apache.commons.lang.StringUtils;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.jspgou.common.hibernate3.Finder;
import com.jspgou.common.hibernate3.HibernateBaseDao;
import com.jspgou.common.page.Pagination;
import com.jspgou.cms.dao.GatheringDao;
import com.jspgou.cms.entity.Gathering;

/**
* This class should preserve.
* @preserve
*/
@Repository
public class GatheringDaoImpl extends HibernateBaseDao<Gathering, Long> implements GatheringDao {
	public Pagination getPage(Long channelId, Long commerceId,String accountNumber,String code,int pageNo, int pageSize) {
		//Criteria crit = createCriteria();
        StringBuffer sb = new StringBuffer("from OrderPayRefundEntity bean where 1=1");

        if (!StringUtils.isBlank(code)) {
            sb.append(" and bean.code like '%"+code+"%'");
        }

        if (!StringUtils.isBlank(accountNumber)) {
            sb.append(" and bean.accountNumber like '%"+accountNumber+"%'");
        }
		if(channelId!=null){
			sb.append(" and bean.entity.channel.id = "+channelId+"");
		}
		if(commerceId!=null){
			sb.append(" and bean.commerce.id = "+commerceId+"");
		}

        sb.append(" order by bean.payTime desc");
        Finder f = Finder.create(sb.toString());
		//Pagination page = findByCriteria(f, pageNo, pageSize);
        Pagination page = find(f, pageNo, pageSize);
		return page;
	}

	public List<OrderPayRefundEntity> getAllPayRefundToExcel(String accountNumber,String code){
		StringBuffer sb = new StringBuffer("from OrderPayRefundEntity bean where 1=1");
		if (!StringUtils.isBlank(code)) {
			sb.append(" and bean.code like '%"+code+"%'");
		}

		if (!StringUtils.isBlank(accountNumber)) {
			sb.append(" and bean.accountNumber like '%"+accountNumber+"%'");
		}
		sb.append(" order by bean.payTime desc");
		Query qr = getSession().createQuery(sb.toString());
		Integer size = 1000;
		try {
			size = Integer.parseInt(ProjectXml.getValue("export_excel_max_row_size"));
		} catch (Exception e) {
			log.error("", e);
		}
		qr.setMaxResults(size);

		return qr.list();
	}
	
	public List<Gathering> getlist(Long orderId) {
		Finder f = Finder.create("from Gathering bean where bean.indent.id=:id");
        f.setParam("id", orderId);
		return find(f);
	}

	public Gathering findById(Long id) {
		Gathering entity = get(id);
		return entity;
	}

	public Gathering save(Gathering bean) {
		getSession().save(bean);
		return bean;
	}

	public Gathering deleteById(Long id) {
		Gathering entity = super.get(id);
		if (entity != null) {
			getSession().delete(entity);
		}
		return entity;
	}
	
	@Override
	protected Class<Gathering> getEntityClass() {
		return Gathering.class;
	}
}