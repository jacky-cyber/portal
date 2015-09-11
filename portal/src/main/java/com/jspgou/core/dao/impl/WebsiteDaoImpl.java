package com.jspgou.core.dao.impl;

import com.jspgou.common.hibernate3.HibernateBaseDao;
import com.jspgou.common.page.Pagination;
import com.jspgou.core.dao.WebsiteDao;
import com.jspgou.core.entity.Website;
import java.util.List;
import org.hibernate.*;
import org.springframework.stereotype.Repository;
/**
* This class should preserve.
* @preserve
*/
@Repository
public class WebsiteDaoImpl extends HibernateBaseDao<Website, Long>
        implements WebsiteDao{
    public Website getUniqueWebsite(){
        String hql= "select bean from Website bean";
        return (Website)getSession().createQuery(hql).uniqueResult();
    }

    public Website findByDomain(String s){
        return (Website)findUniqueByProperty(Website.PROP_DOMAIN, s);
    }

    public int countWebsite(){
        String hql = "select count(*) from Website";
        return ((Number)getSession().createQuery(hql).iterate().next()).intValue();
    }

    public Pagination getAllPage(int pageNo, int pageSize){
        Criteria crit = createCriteria();
        Pagination page = findByCriteria(crit, pageNo, pageSize);
        return page;
    }

    @SuppressWarnings("unchecked")
	public List<Website> getAllList(){
        Criteria crit = createCriteria();
        List<Website> list = crit.list();
        return list;
    }

    public Website findById(Long id){
        Website entity =get(id);
        Hibernate.initialize(entity);
        return entity;
    }

    public Website save(Website bean){
        getSession().save(bean);
        return bean;
    }

    public Website deleteById(Long id) {
        Website entity =super.get(id);
        if(entity != null){
            getSession().delete(entity);
        }
        return entity;
    }

	@Override
	protected Class<Website> getEntityClass() {
		return Website.class;
	}
}
