package com.jspgou.cms.dao;

import com.jspgou.cms.entity.Favorable;
import com.jspgou.common.hibernate3.Updater;
import com.jspgou.common.page.Pagination;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by David on 2015/3/17.
 */
public interface FavorableDao {

    public Pagination getPage(int pageNo, int pageSize) ;

    public  Favorable save(Favorable bean);

    public Favorable findById(Long id);

    public Favorable updateByUpdater(Updater<Favorable> updater);

    public Favorable deleteById(Long id);

    public Pagination getPageByWebsite( int pageNo, int pageSize, boolean cacheable, String channelId,String channelName,String name,Integer area,Integer favorableType,Integer amountType,Integer manner,Date startTime,Date endTime,ArrayList<Long> ids,String productName);

    public List<Favorable> getFavorableByChannel(String channelId);
}
