package com.jspgou.cms.dao;

import com.jspgou.common.hibernate3.Updater;
import com.jspgou.common.page.Pagination;
import com.jspgou.cms.entity.ShopAdmin;
import com.jspgou.core.entity.Admin;
import com.jspgou.core.entity.User;

/**
* This class should preserve.
* @preserve
*/
public interface ShopAdminDao {
	public Pagination getPage(Long webId, int pageNo, int pageSize);

    public Pagination getPageForChannel(String channelId,String commerceId,Long webId, int pageNo, int pageSize);

    public Pagination getPageForChannelOnly(String channelId,String commerceId,Long webId, int pageNo, int pageSize);

	public ShopAdmin findById(Long id);

	public ShopAdmin save(ShopAdmin bean);

	public ShopAdmin updateByUpdater(Updater<ShopAdmin> updater);

	public ShopAdmin deleteById(Long id);

	public Admin findAdminId(Long id);
}