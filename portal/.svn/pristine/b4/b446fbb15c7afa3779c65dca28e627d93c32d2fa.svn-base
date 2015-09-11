package com.jspgou.core.dao.impl;

import com.ifunpay.portal.dao.BaseDao;
import com.jspgou.common.hibernate3.Finder;
import org.apache.commons.lang.StringUtils;
import org.hibernate.Criteria;
import org.springframework.stereotype.Repository;

import com.jspgou.common.hibernate3.HibernateBaseDao;
import com.jspgou.common.page.Pagination;
import com.jspgou.core.dao.LogDao;
import com.jspgou.core.entity.Log;

import javax.annotation.Resource;
import java.awt.*;
import java.util.Date;

/**
* This class should preserve.
* @preserve
*/
@Repository
public class LogDaoImpl extends HibernateBaseDao<Log, Long> implements LogDao {
	@Resource
	private BaseDao baseDao;

	public Pagination getPageOfOperateLog(int pageNo, int pageSize, Date startTime, Date endTime, String userId, String moduleId, String relateId){
		StringBuffer sb = new StringBuffer("from OperationLogEntity bean where 1=1 ");
		if (null != startTime && !("").equals(startTime)){
			sb.append(" AND bean.operateTime>='" + startTime + "' ");
		}
		if (null != endTime && !("").equals(endTime)){
			sb.append(" AND bean.operateTime<='" + endTime + "' ");
		}
		if (StringUtils.isNotBlank(userId)){
			sb.append(" AND bean.userId like '%" + userId + "%' ");
		}
		if (StringUtils.isNotBlank(moduleId)){
			sb.append(" AND bean.moduleId like '%" + moduleId + "%' ");
		}
		if (StringUtils.isNotBlank(relateId)){
			sb.append(" AND bean.relateId like '%" + relateId + "%' ");
		}

		sb.append(" order by operateTime desc ");

		Finder f = Finder.create(sb.toString());

		return find(f, pageNo, pageSize);
	}

	public Pagination getPage(int pageNo, int pageSize) {
		Criteria crit = createCriteria();
		Pagination page = findByCriteria(crit, pageNo, pageSize);
		return page;
	}

	public Log findById(Long id) {
		Log entity = get(id);
		return entity;
	}

	public Log save(Log bean) {
		getSession().save(bean);
		return bean;
	}

	public Log deleteById(Long id) {
		Log entity = super.get(id);
		if (entity != null) {
			getSession().delete(entity);
		}
		return entity;
	}
	
	@Override
	protected Class<Log> getEntityClass() {
		return Log.class;
	}
}