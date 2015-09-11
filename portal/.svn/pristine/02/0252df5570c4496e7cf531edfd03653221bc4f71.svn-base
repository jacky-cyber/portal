package com.ifunpay.portal.dao;

import com.ifunpay.portal.ProjectXml;
import com.ifunpay.portal.entity.Commerce;
import com.ifunpay.portal.entity.lottery.CommerceModel;
import com.jspgou.common.hibernate3.Finder;
import com.jspgou.common.hibernate3.HibernateBaseDao;
import com.jspgou.common.page.Pagination;
import org.apache.commons.lang.StringUtils;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by Conglong Xie on 2015/4/21.
 */
@Component
public class CommerceDao extends HibernateBaseDao<Commerce,Long> {

    private static Logger logger = LoggerFactory.getLogger(CommerceDao.class);

    public Commerce getByCommerceId(String commerceId){
        StringBuffer sb = new StringBuffer("from Commerce com where com.id ="+commerceId+" ");
        Query query = getSession().createQuery(sb.toString());
        Commerce commerce = (Commerce)query.uniqueResult();
        return commerce;
    }


    public Pagination getPageForCommerce(Long channelId,Long commerceId,String channelName,String commerceName, Date startTime, Date endTime, int pageNo, int pageSize) {
        StringBuffer sb = new StringBuffer("from Commerce bean where 1=1 ");

        if(!StringUtils.isBlank(channelName)){
            sb.append(" and bean.chanIdRela.channelName like '%"+channelName+"%' ");
        }

        if(channelId!=null){
            sb.append(" and bean.chanIdRela.id = '"+channelId+"' ");
        }

        if(commerceId!=null){
            sb.append(" and bean.id = '"+commerceId+"' ");
        }

        if (null != startTime && !("").equals(startTime)){
            sb.append(" and bean.createDate>='" + startTime + "' ");
        }
        if (null != endTime && !("").equals(endTime)){
            sb.append(" and bean.createDate<='" + endTime + "' ");
        }

        if (!StringUtils.isBlank(commerceName)){
            sb.append(" and bean.name like '%"+commerceName+"%' ");
        }

        sb.append(" order by bean.id desc ");

        Finder f = Finder.create(sb.toString());
        return find(f, pageNo, pageSize);
    }

    public void saveCommerce(Commerce commerce){
        baseDao.save(commerce);
    }

    public void updateCommerce(Commerce commerce){
        baseDao.update(commerce);
    }


    public Commerce getCommerceById(Long id){
        StringBuffer sb = new StringBuffer("from Commerce com where com.id = "+id+"");
        Query query = getSession().createQuery(sb.toString());
        return (Commerce)query.uniqueResult();
    }

    public Commerce deleteById(Long id){
        Commerce entity = getCommerceById(id);
        if (entity != null) {
            baseDao.delete(entity);
        }
        return entity;
    }

    public java.util.List<Commerce> getAllCommerces(){
        return baseDao.getAll(Commerce.class);
    }

    /**
     * Get Commerce By Name
     * @param name
     * @return
     */
    public Commerce getCommerceByName(String name){
        StringBuffer sb = new StringBuffer("from Commerce com where com.name = '"+name+"'");
        Query query = getSession().createQuery(sb.toString());
        return (Commerce)query.uniqueResult();
    }

    public List<CommerceModel> getCommerceToExcel(String channelName, String commerceName, Long channelId, Long commerceId, Date startTime, Date endTime){
        StringBuffer sb = new StringBuffer("from Commerce com where 1=1 ");
        if (StringUtils.isNotBlank(commerceName)){
            sb.append("AND com.name like '%" + commerceName + "%' ");
        }
        if (StringUtils.isNotBlank(channelName)){
            sb.append("AND com.chanIdRela.channelName like '%" + channelName + "%' ");
        }
        if (null != commerceId){
            sb.append("AND com.id='"+ commerceId +"' ");
        }
        if (null != channelId){
            sb.append("AND com.chanIdRela.id='" + channelId + "' ");
        }
        if (null != startTime && !("").equals(startTime)){
            sb.append(" and com.createDate>='" + startTime + "' ");
        }
        if (null != endTime && !("").equals(endTime)){
            sb.append(" and com.createDate<='" + endTime + "' ");
        }
        sb.append("order by com.id desc");
        Query query = getSession().createQuery(sb.toString());
        Integer size = 1000;
        try {
            size = Integer.parseInt(ProjectXml.getValue("export_excel_max_row_size"));
        } catch (Exception e) {
            log.error("", e);
        }
        query.setMaxResults(size);

        List<Commerce> commerces = query.list();
        List<CommerceModel> list = new ArrayList<>();
        for (int i=0; i<commerces.size(); i++){
            CommerceModel commerceModel = new CommerceModel();
            commerceModel.setId(commerces.get(i).getId());
            commerceModel.setCommerceId(commerces.get(i).getCommerceId());
            commerceModel.setCommerceName(commerces.get(i).getName());
            commerceModel.setMobile(commerces.get(i).getMobilePhone());
            commerceModel.setChannelName(commerces.get(i).getChanIdRela().getChannelName());
            commerceModel.setCreateDate(commerces.get(i).getCreateDate());
            list.add(commerceModel);
        }
        return list;
    }

    @Override
    protected Class<Commerce> getEntityClass() {
        return null;
    }

    @Resource
    private BaseDao baseDao;

    public List<Commerce> getCommerces(Long channelId, Long commerceId) {
        Criteria criteria = getSession().createCriteria(Commerce.class);
        if (null != commerceId){
            criteria.add(Restrictions.eq("id", commerceId));
        }
        if (null != channelId){
            criteria.add(Restrictions.eq("chanIdRela.id", channelId));
        }
        return criteria.list();
    }
}
