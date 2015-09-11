package com.jspgou.cms.dao.impl;

import com.jspgou.cms.dao.FavorableDao;
import com.jspgou.cms.entity.Favorable;
import com.jspgou.common.hibernate3.Finder;
import com.jspgou.common.hibernate3.HibernateBaseDao;
import com.jspgou.common.page.Pagination;
import org.apache.commons.lang.StringUtils;
import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

/**
 * Created by David on 2015/3/17.
 */
@Repository
public class FavorableDaoImpl extends HibernateBaseDao<Favorable, Long> implements FavorableDao {

    public Pagination getPage(int pageNo, int pageSize) {
        Finder f = Finder.create("from Favorable bean where 1=1");
        f.append(" order by bean.id desc");
        return find(f, pageNo, pageSize);
    }

    public Favorable save(Favorable bean) {
        getSession().save(bean);
        return bean;
    }


    public Favorable findById(Long id) {
        Favorable  entity = get(id);
        return entity;
    }


    public Favorable deleteById(Long id) {
        Favorable entity = super.get(id);

        if (entity != null) {
            entity.setDele(1);
            getSession().update(entity);
        }
        return entity;
    }


    public Pagination getPageByWebsite( int pageNo, int pageSize, boolean  cacheable, String channelId,String channelName,String name,Integer area,Integer favorableType,Integer amountType,Integer manner,Date startTime,Date endTime,ArrayList<Long> ids ,String productName ) {
        Finder f = getFinderForWebsite(cacheable,channelId,channelName, name, area, favorableType, amountType, manner, startTime, endTime,ids ,productName);
        return find(f, pageNo, pageSize);
    }

    @Override
    public List<Favorable> getFavorableByChannel(String channelId) {
        Finder f = Finder.create("from Favorable bean where 1=1");
        if(StringUtils.isNotBlank(channelId)){
            f.append(" and bean.channelId =:channelId");
            f.setParam("channelId", channelId);
        }
        f.append(" order by bean.id desc");
        return find(f);

    }


    private Finder getFinderForWebsite( boolean  cacheable,String channelId,String channelName,String name,Integer area,Integer favorableType,Integer amountType,Integer manner,Date startTime,Date endTime,ArrayList<Long> ids,String productName) {
        Finder f = Finder.create("select bean from Favorable bean where 1=1 and bean.dele =0 ");

        if (channelId != null && !"1".equals(channelId)) {
            f.append(" and bean.channelId=:channelId");
            f.setParam("channelId", channelId);
        }
        if (channelName != null && !"".equals(channelName)) {
            f.append(" and bean.channelName like:channelName");
            f.setParam("channelName","%"+channelName+"%");
        }
        if(name!=null&&!"".equals(name)){
            f.append(" and bean.name like:name");
            f.setParam("name", "%"+name+"%");
        }
        if (area != null) {
            f.append(" and bean.area=:area");
            f.setParam("area", area);
        }
        if (favorableType != null) {
            f.append(" and bean.favorableType=:favorableType");
            f.setParam("favorableType", favorableType);
        }
        if (amountType != null) {
            f.append(" and bean.amountType=:amountType");
            f.setParam("amountType", amountType);
        }
        if (manner != null) {
            f.append(" and bean.manner=:manner");
            f.setParam("manner", manner);
        }
        if (endTime != null) {
            f.append(" and bean.startTime<:endTime");
            f.setParam("endTime", endTime);
        }
        if (startTime != null) {
            f.append(" and bean.endTime>:startTime");
            f.setParam("startTime", startTime);
        }
        if (ids != null) {
           Long  id0 =ids.get(0);
            f.append(" and bean.id =:id0");
            f.setParam("id0", id0);
            for (int i = 1;i<ids.size();i++){
                f.append(" or bean.id =:id"+i);
                f.setParam("id"+i,ids.get(i) );
            }

        }
        if(null!=productName && !"".equals(productName)){
            StringBuffer sql = new StringBuffer("select pf.favorableId from ProductFavorable pf where pf.productName like '%"+productName+"%' ");
            Query query1 = this.getSession().createQuery(sql.toString());
            Collection<Object> favorableIds = query1.list();
            if(favorableIds.size()==0){
                f.append(" and bean.id =:id");
                f.setParam("id",null );
            }else {
                f.append(" and bean.id in :favorableIds");
                f.setParamList("favorableIds", favorableIds);
            }
        }

        f.append(" order by bean.id desc");

        f.setCacheable(cacheable);
        return f;
    }
    @Override
    protected Class<Favorable> getEntityClass() {
        return Favorable.class;
    }
}
