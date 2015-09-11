package com.jspgou.core.dao.impl;

import com.jspgou.common.hibernate3.Finder;
import com.jspgou.common.hibernate3.HibernateBaseDao;
import com.jspgou.common.page.Pagination;
import com.jspgou.core.dao.UserDao;
import com.jspgou.core.entity.User;
import org.apache.commons.lang.StringUtils;
import org.hibernate.Criteria;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
* This class should preserve.
* @preserve
*/
@Repository
public class UserDaoImpl extends HibernateBaseDao<User, Long>
             implements UserDao{
    public User getByUsername(String username){
        try {
            return (User)findUniqueByProperty("username", username);
        } catch (Exception e){
            log.error("query user failed!");
        }
        return null;
    }

    public User getByEmail(String email){
        return (User)findUniqueByProperty("email", email);
    }

    public Pagination getPage(int pageNo, int pageSize){
        Criteria criteria = createCriteria(new Criterion[0]);
        Pagination page = findByCriteria(criteria, pageNo,pageSize);
        return page;
    }

    public User findById(Long id){
        User entity =get(id);
        return entity;
    }

    public User save(User bean){
        getSession().save(bean);
        return bean;
    }

    public User deleteById(Long id){
        User entity =super.get(id);
        if(entity != null)
            getSession().delete(entity);
        return entity;
    }

    public Pagination getAllUsersByChannelId(String channelId,int pageNo, int pageSize){
        StringBuffer sb = new StringBuffer("from User u where 1=1 ");
        if (!StringUtils.isBlank(channelId)){
           sb.append(" and u.channelId ='"+channelId+"'");
        }
        Finder f = Finder.create(sb.toString());
        return find(f, pageNo, pageSize);
    }

    public java.util.List<User> getAllUsers(){
        StringBuffer sb = new StringBuffer("from User u where 1=1 order by id asc ");
        return getSession().createQuery(sb.toString()).list();
    }

    public List<User> getUserByStoreId(String storeId){
        Criteria criteria = createCriteria();
        criteria.add(Restrictions.eq("storeFront", storeId));
        return criteria.list();
    }

	@Override
	protected Class<User> getEntityClass() {
		return User.class;
	}
}
