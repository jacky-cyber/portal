package com.jspgou.cms.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.jspgou.common.hibernate3.HibernateBaseDao;
import com.jspgou.cms.dao.ShopMemberGroupDao;
import com.jspgou.cms.entity.ShopMemberGroup;

/**
* This class should preserve.
* @preserve
*/
@Repository
public class ShopMemberGroupDaoImpl extends
		HibernateBaseDao<ShopMemberGroup, Long> implements ShopMemberGroupDao {
	@SuppressWarnings("unchecked")
	public List<ShopMemberGroup> getList(Long webId, boolean cacheable) {
		String hql = "from ShopMemberGroup bean where bean.website.id=:webId order by bean.score";
		return getSession().createQuery(hql).setParameter("webId", webId)
				.setCacheable(cacheable).list();
	}

	public ShopMemberGroup findById(Long id) {
		ShopMemberGroup entity = get(id);
		return entity;
	}

	public ShopMemberGroup save(ShopMemberGroup bean) {
		getSession().save(bean);
		return bean;
	}

	public ShopMemberGroup deleteById(Long id) {
		ShopMemberGroup entity = super.get(id);
		if (entity != null) {
			getSession().delete(entity);
		}
		return entity;
	}

	@Override
	protected Class<ShopMemberGroup> getEntityClass() {
		return ShopMemberGroup.class;
	}
}