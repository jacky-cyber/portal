package com.jspgou.cms.dao.impl;

import com.ifunpay.portal.ProjectXml;
import com.ifunpay.portal.dao.BaseDao;
import com.jspgou.cms.dao.StoreDao;
import com.jspgou.cms.entity.Store;
import com.jspgou.cms.entity.StoreModel;
import com.jspgou.common.hibernate3.Finder;
import com.jspgou.common.hibernate3.HibernateBaseDao;
import com.jspgou.common.page.Pagination;
import com.jspgou.core.dao.UserDao;
import com.jspgou.core.entity.User;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by zhengjiang on 2015-07-09.
 */
@Repository
public class StoreDaoImpl extends HibernateBaseDao<Store, Long> implements StoreDao {
    public Pagination getPage(String storeName, Long id, Integer storeStatus, String commerceName,
                              Date startTime, Date endTime,Integer pageSize,Integer pageNo, Long channelId, Long commerceId){
        Finder f = Finder.create("select bean from Store bean, Commerce c where bean.storeStatus<>3 AND bean.commerceId=c.id ");
        if (null != commerceId){
            f.append(" and bean.commerceId=:commerceId").setParam("commerceId", commerceId);
        }
        if (null != channelId){
            f.append(" and c.chanIdRela.id=:channelId").setParam("channelId", channelId);
        }
        if(StringUtils.isNotBlank(storeName)){
            f.append(" and bean.storeName like :name").setParam("name", "%"+storeName+"%");
        }
        if(storeStatus!=null){
            f.append(" and bean.storeStatus=:storeStatus").setParam("storeStatus", storeStatus);
        }
        if(StringUtils.isNotBlank(commerceName)){
            f.append(" and bean.commerceName like :commerceName").setParam("commerceName", "%"+commerceName+"%");
        }
        if(startTime!=null){
            f.append(" and bean.createDate>=:startTime");
            f.setParam("startTime", startTime);
        }
        if(endTime!=null){
            f.append(" and bean.createDate<=:endTime");
            f.setParam("endTime", endTime);
        }
        if (null != id){
            f.append(" and bean.id=:id");
            f.setParam("id", id);
        }
        f.append(" order by bean.id desc");
        return find(f, pageNo, pageSize);
    }

    @Transactional
    public void save(Store store) {
        baseDao.save(store);
    }

    @Override
    public Boolean checkName(String storeName, Object... values) {
        Criteria criteria = baseDao.getSession().createCriteria(Store.class);
        criteria.add(Restrictions.eq("storeName", storeName));
        if (0<values.length){
            criteria.add(Restrictions.ne("id", values[0]));
        }
        if (1 <= criteria.list().size()) {
            return true;
        }
        return false;
    }

    @Override
    public Store getStoreById(Long id) {
        return baseDao.get(id, Store.class);
    }

    @Override
    public void update(Store store) {
        baseDao.update(store);
    }

    @Override
    public List<StoreModel> getStoreToExcel(String commerceName, String storeName, Long id, String startTime, String endTime) {
        Criteria criteria = baseDao.getSession().createCriteria(Store.class);
        criteria.add(Restrictions.ne("storeStatus", 3));
        if (StringUtils.isNotBlank(commerceName)){
            criteria.add(Restrictions.like("commerceName", commerceName, MatchMode.ANYWHERE));
        }
        if (StringUtils.isNotBlank(storeName)){
            criteria.add(Restrictions.like("storeName", storeName, MatchMode.ANYWHERE));
        }
        if (StringUtils.isNotBlank(startTime)){
            criteria.add(Restrictions.gt("createDate", startTime));
        }
        if (StringUtils.isNotBlank(endTime)){
            criteria.add(Restrictions.le("createDate", endTime));
        }
        if (null != id){
            criteria.add(Restrictions.eq("id", id));
        }

        Integer size = 1000;
        try {
            size = Integer.parseInt(ProjectXml.getValue("export_excel_max_row_size"));
        } catch (Exception e) {
            log.error("", e);
        }

        criteria.setMaxResults(size);

        List<StoreModel> storeModels = new ArrayList<>();
        List<Store> list = criteria.list();
        for (int i=0; i<list.size(); i++){
            StoreModel storeModel = new StoreModel();
            storeModel.setId(list.get(i).getId());
            storeModel.setStoreName(list.get(i).getStoreName());
            storeModel.setCommerceId(list.get(i).getCommerceId());
            storeModel.setCommerceName(list.get(i).getCommerceName());
            storeModel.setMobile(list.get(i).getMobile());
            storeModel.setCreateDate(list.get(i).getCreateDate());
            storeModel.setStoreStatus(list.get(i).getStoreStatus());

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            storeModel.setDate(sdf.format(list.get(i).getCreateDate()));

//            1.启用 2.禁用 3.删除
            Integer status = list.get(i).getStoreStatus();
            switch (status) {
                case 1:
                    storeModel.setStatus("启用");
                    break;
                case 2:
                    storeModel.setStatus("禁用");
                    break;
                case 3:
                    storeModel.setStatus("删除");
                    break;
                default:
                    storeModel.setStatus("未知状态");
            }
            storeModels.add(storeModel);
        }
        return storeModels;
    }

    @Override
    public List<Store> getAllStore() {
        return baseDao.getSession().createCriteria(Store.class).list();
    }

    @Override
    public Store deleteById(Long id) {
        Store store = baseDao.get(id, Store.class);
        if (ifRelatedByUser(id)){
            log.error("Delete failed! The store already related by user.");
            return store;
        }
        baseDao.delete(store);
        return store;
    }

    @Override
    public List<Store> getStore(Long channelId, Long commerceId) {
        Finder f = Finder.create("select store from Store store, Commerce comm where store.commerceId=comm.id ");
        if (null != channelId){
            f.append("AND comm.chanIdRela.id=:channelId").setParam("channelId", channelId);
        }
        if (null != commerceId){
            f.append("AND comm.id=:commerceId").setParam("commerceId", commerceId);
        }
        return find(f);
    }

    /**
     * check if the store related by user
     * @param id
     * @return
     */
    private Boolean ifRelatedByUser(Long id){
        List<User> users = userDao.getUserByStoreId(Long.toString(id));
        if (0 <= users.size()){
            return true;
        }
        return false;
    }

    @Override
    protected Class<Store> getEntityClass() {
        return null;
    }
    @Autowired
    private BaseDao baseDao;
    @Autowired
    private UserDao userDao;
}
