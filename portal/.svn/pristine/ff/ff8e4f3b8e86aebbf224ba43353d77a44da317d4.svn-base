package com.ifunpay.portal.dao;

import com.ifunpay.portal.ProjectXml;
import com.ifunpay.portal.entity.BankPayInfo;
import com.ifunpay.portal.entity.Channel;
import com.jspgou.common.hibernate3.Finder;
import com.jspgou.common.hibernate3.HibernateBaseDao;
import com.jspgou.common.page.Pagination;
import org.apache.commons.lang.StringUtils;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

/**
 * Created by Cong Long Xie on 2015/4/21.
 */
@Component
public class ChannelDao extends HibernateBaseDao<Channel,String>{

    @Resource
    private BaseDao baseDao;

    public Pagination getPageForChannel(Long channelId,String channelName, Date startTime, Date endTime, int pageNo, int pageSize) {
        Finder f = Finder.create("from Channel bean where 1=1 and bean.channelName !='无' ");

        if(!StringUtils.isBlank(channelName)){
            f.append(" and bean.channelName like '%"+channelName+"%' ");
        }

        if (channelId!=null){
            f.append(" and bean.id=:channelId ");
            f.setParam("channelId", channelId);
        }
        if (null != startTime && !("").equals(startTime)){
            f.append(" and bean.createDate>=:startTime");
            f.setParam("startTime", startTime);
        }
        if (null != endTime && !("").equals(endTime)){
            f.append(" and bean.createDate<=:endTime");
            f.setParam("endTime", endTime);
        }

        f.append(" order by bean.id desc");
        return find(f, pageNo, pageSize);
    }

    public java.util.List<Channel> getAllChannel(){
        StringBuffer sb = new StringBuffer("from Channel ch order by ch.channelId ");
        Query query = getSession().createQuery(sb.toString());
        return query.list();
    }

    public java.util.List<BankPayInfo> getAllBankPayInfo(){
        StringBuffer sb = new StringBuffer("from BankPayInfo where type='0'");
        Query query = getSession().createQuery(sb.toString());
        return query.list();
    }

    public void saveChannel(Channel channel){
            baseDao.saveOrUpdate(channel);
    }
    public Channel getChannelById(long id){
        StringBuffer sb = new StringBuffer("from Channel chan where chan.id ="+id+" ");
        Query query = getSession().createQuery(sb.toString());
        return (Channel)query.uniqueResult();
    }

    public Channel getChannelByName(String name){
        StringBuffer sb = new StringBuffer("from Channel chan where chan.channelName ='"+name+"' ");
        Query query = getSession().createQuery(sb.toString());
        return (Channel)query.uniqueResult();
    }

    public Channel deleteById(long id){
        Channel entity = getChannelById(id);
        if (entity != null) {
            baseDao.delete(entity);
        }
        return entity;
    }

    public List<Channel> getChannel(String channelName){
        StringBuffer sb = new StringBuffer("from Channel chan where 1=1 ");
        if (StringUtils.isNotBlank(channelName)){
            sb.append("AND chan.channelName like  '%"+ channelName +"%' ");
        }
        sb.append("order by chan.id desc");
        Query query = getSession().createQuery(sb.toString());
        return query.list();
    }

    public List<Channel> getChannelToExcel(String channelName, Long channelId,String startTime,String endTime){
        StringBuffer sb = new StringBuffer("from Channel chan where 1=1 ");
        if (StringUtils.isNotBlank(channelName)){
            sb.append("AND chan.channelName like  '%"+ channelName +"%' ");
        }
        if (null != channelId){
            sb.append("AND chan.id='" + channelId+"' ");
        }
        if(startTime !=null){
            sb.append("AND chan.createDate>='" + startTime+"' ");
        }
        if(endTime!=null){
            sb.append("AND chan.createDate<'" + endTime+"' ");
        }
        sb.append("order by chan.id desc");
        Query query = getSession().createQuery(sb.toString());
        log.info("getChannelToExcel sql = "+sb.toString());
        Integer size = 1000;
        try {
            size = Integer.parseInt(ProjectXml.getValue("export_excel_max_row_size"));
        } catch (Exception e) {
            log.error("", e);
        }
        query.setMaxResults(size);
        return query.list();
    }

    public void updateChannel(Channel channel){
        baseDao.update(channel);
    }

    @Override
    protected Class<Channel> getEntityClass() {
        return null;
    }

    public List<Channel> getChannelExceptNull() {
        Criteria criteria = super.getSession().createCriteria(Channel.class);
        criteria.add(Restrictions.ne("channelName", "无"));
        return criteria.list();
    }
}
