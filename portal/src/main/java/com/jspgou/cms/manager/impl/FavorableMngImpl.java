package com.jspgou.cms.manager.impl;

import com.jspgou.cms.dao.FavorableDao;
import com.jspgou.cms.entity.Favorable;
import com.jspgou.cms.manager.FavorableMng;
import com.jspgou.common.hibernate3.Updater;
import com.jspgou.common.page.Pagination;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by David on 2015/3/17.
 */
@Service
@Transactional
public class FavorableMngImpl implements FavorableMng {
    @Transactional(readOnly = true)
    public Pagination getPage(int pageNo, int pageSize) {
        Pagination page = dao.getPage(pageNo, pageSize);
        return page;
    }


    public Pagination getPage( int pageNo, int pageSize, String channelId, String channelName,String name,Integer area,Integer favorableType,Integer amountType,Integer manner,Date startTime,Date endTime,ArrayList<Long> ids,String productName) {
        Pagination page = dao.getPageByWebsite(pageNo,pageSize, false, channelId,channelName,name, area, favorableType, amountType, manner, startTime, endTime,ids,productName);
        return page;
    }


    public Favorable save(Favorable bean) {

        return dao.save(bean);
    }


    public Favorable findById(Long id) {
        return dao.findById(id);
    }


    public Favorable update(Favorable bean) {
        Updater<Favorable> updater = new Updater<Favorable>(bean);

        return dao.updateByUpdater(updater);
    }
    public Favorable deleteById(Long id) {
        Favorable bean = dao.deleteById(id);
        return bean;
    }

    public Favorable[] deleteByIds(ArrayList<Long> ids) {
        Favorable[] beans = new Favorable[ids.size()];
        for (int i = 0,len = ids.size(); i < len; i++) {
            beans[i] = deleteById(ids.get(i));
        }
        return beans;
    }


    public List<Favorable> getFavorableByChannel(String channelId) {

       return dao.getFavorableByChannel(channelId);
    }


    @Autowired
    private FavorableDao dao;
}
