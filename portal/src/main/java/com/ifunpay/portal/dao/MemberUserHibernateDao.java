package com.ifunpay.portal.dao;

import com.ifunpay.portal.entity.MemberUserEntity;
import com.jspgou.common.hibernate3.Finder;
import com.jspgou.common.hibernate3.HibernateBaseDao;
import com.jspgou.common.page.Pagination;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.List;
import java.util.Optional;

/**
 * Created by yu on 4/8/15.
 */
@Component
public class MemberUserHibernateDao extends HibernateBaseDao<MemberUserEntity,Long> {

    private Logger logger = Logger.getLogger(MemberUserHibernateDao.class);

    @Override
    protected Class<MemberUserEntity> getEntityClass() {
        return MemberUserEntity.class;
    }

    public Pagination getPageForClientDao(String channelId, String commerceId, String phone, String registerIp, Integer origin, Date startTime, Date endTime, Long webId, int pageNo, int pageSize) {
        Finder f = Finder.create("from MemberUserEntity bean where 1=1 ");
        if(!StringUtils.isBlank(channelId)){
            f.append(" and bean.admin.user.channelId=:channelId");
            f.setParam("channelId", channelId);
        }
        if (StringUtils.isNotBlank(phone)){
            f.append(" and bean.phone like:phone");
            f.setParam("phone", "%"+phone+"%");
        }
        if (StringUtils.isNotBlank(registerIp)){
            f.append(" and bean.registerIp like:registerIp");
            f.setParam("registerIp", "%"+registerIp+"%");
        }
        if (origin!=null){
            f.append(" and bean.origin ="+origin+"");
        }
        if (null != startTime && !("").equals(startTime)){
            f.append(" and bean.registerDate>=:startTime");
            f.setParam("startTime", startTime);
        }
        if (null != endTime && !("").equals(endTime)){
            f.append(" and bean.registerDate<=:endTime");
            f.setParam("endTime", endTime);
        }
        f.append(" order by bean.id desc");
        return find(f, pageNo, pageSize);
    }
}
