package com.ifunpay.portal.dao;

import com.ifunpay.portal.entity.MemberUserEntity;
import org.apache.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

/**
 * Created by yu on 4/8/15.
 */
@Component
public class MemberUserDao extends BaseDao {

    private Logger logger = Logger.getLogger(MemberUserDao.class);

    public Optional<MemberUserEntity> get(String id){
        return get(MemberUserEntity.class, id);
    }

    public List<MemberUserEntity> fetch(
            Optional<String> id,
            Optional<String> username,
            Optional<String> phone,
            int start,
            int size
            ){
        Criteria criteria = getSession().createCriteria(MemberUserEntity.class);
        id.ifPresent(i -> criteria.add(Restrictions.eq("id", i)));
        username.ifPresent(u -> criteria.add(Restrictions.like("name", u, MatchMode.ANYWHERE)));

        phone.ifPresent(p -> criteria.add(Restrictions.eq("phone", p)));
        List<MemberUserEntity> list = criteria.setFirstResult(start).setMaxResults(size).addOrder(Order.asc("id")).list();
        logger.debug("fetch " + list.size() + " users");
        return list;
    }

    public long fetchCount(
            Optional<String> id,
            Optional<String> username,
            Optional<String> phone
    ){
        Criteria criteria = getSession().createCriteria(MemberUserEntity.class);
        id.ifPresent(i -> criteria.add(Restrictions.eq("id", i)));
        username.ifPresent(u -> criteria.add(Restrictions.like("name", u, MatchMode.ANYWHERE)));
        phone.ifPresent(p -> criteria.add(Restrictions.eq("phone", p)));
        long count = (long) criteria.setProjection(Projections.rowCount()).uniqueResult();
        logger.debug("fetch count: " + count);
        return count;
    }



    @Transactional
    public MemberUserEntity getEntityName(String username) {
        MemberUserEntity memberUserEntity = get("name", username, MemberUserEntity.class);
        return memberUserEntity;
    }
    public MemberUserEntity getEntityByUuid(String member_user_id) {
        MemberUserEntity memberUserEntity = findUnique("uuid",member_user_id, MemberUserEntity.class);
        return memberUserEntity;
    }
    public Integer findCount() {

        String hql = "select count(*)  from MemberUserEntity ";
        Query query = getSession().createQuery(hql);
        int count = ((Long) query.iterate().next()).intValue();
        return count;
    }

    public List<MemberUserEntity> getAllMemberUser(){
       return getAll(MemberUserEntity.class);
    }


}
