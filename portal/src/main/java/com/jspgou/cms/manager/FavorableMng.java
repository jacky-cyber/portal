package com.jspgou.cms.manager;

import com.jspgou.cms.entity.Favorable;
import com.jspgou.common.page.Pagination;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by David on 2015/3/17.
 */
public interface FavorableMng {

   public Pagination getPage(int cpn, int pageSize);

   public Pagination getPage(int pageNo, int pageSize,String channelId,String channelName,String name,Integer area,Integer favorableType,Integer amountType,Integer manner,Date startTime,Date endTime,ArrayList<Long> ids,String productName);

   public Favorable save(Favorable bean);

   public Favorable findById(Long id);

   public Favorable update(Favorable bean);

   public Favorable[] deleteByIds(ArrayList<Long> ids);

    public List<Favorable> getFavorableByChannel(String channelId);
}
