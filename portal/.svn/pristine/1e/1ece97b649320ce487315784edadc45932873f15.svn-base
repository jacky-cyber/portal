package com.jspgou.cms.dao.impl;

import org.springframework.stereotype.Repository;

import com.jspgou.common.hibernate3.Finder;
import com.jspgou.common.hibernate3.HibernateBaseDao;
import com.jspgou.common.page.Pagination;
import com.jspgou.cms.dao.ShopMemberDao;
import com.jspgou.cms.entity.ShopMember;

/**
* This class should preserve.
* @preserve
*/
@Repository
public class ShopMemberDaoImpl extends HibernateBaseDao<ShopMember, Long> implements ShopMemberDao {
	public Pagination getPage(Long webId, int pageNo, int pageSize) {
        try {
            Finder f = Finder.create("from ShopMember bean where bean.website.id=:webId order by bean.id desc");
            f.setParam("webId", webId);
            return find(f, pageNo, pageSize);
        }catch (Exception e){
            return new Pagination();
        }
	}

	public ShopMember findById(Long id) {
		ShopMember entity = get(id);
		return entity;
	}

	public ShopMember save(ShopMember bean) {
		getSession().save(bean);
		return bean;
	}

	public ShopMember deleteById(Long id) {
		ShopMember entity = super.get(id);
		if (entity != null) {
			getSession().delete(entity);
		}
		return entity;
	}

	@Override
	protected Class<ShopMember> getEntityClass() {
		return ShopMember.class;
	}
}