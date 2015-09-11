package com.jspgou.cms.manager;

import com.jspgou.cms.entity.ShopAdmin;
import com.jspgou.common.page.Pagination;
import com.jspgou.core.entity.Admin;
import com.jspgou.core.entity.User;

/**
* This class should preserve.
* @preserve
*/
public interface ShopAdminMng {
	public ShopAdmin getByUserId(Long userId, Long webId);

	public ShopAdmin register(String username, String password,Boolean viewonlyAdmin, String email,
			String ip, boolean disabled, Long webId, 
			ShopAdmin shopAdmin ,String channelId,String channelName,String commerceId,String commerceName,String storeFront);

	public Pagination getPage(Long webId, int pageNo, int pageSize);

    public Pagination getPageForChannel(String channelId,String commerceId,Long webId, int pageNo, int pageSize);

    public Pagination getPageForChannelOnly(String channelId,String commerceId,Long webId, int pageNo, int pageSize);

	public ShopAdmin findById(Long id);

	public ShopAdmin save(ShopAdmin bean);

	public ShopAdmin update(ShopAdmin bean, String password, Boolean disabled,
			String email,Boolean viewonlyAdmin,String channelId,String channelName,String commerceId,String commerceName,String storeFront);

	public ShopAdmin deleteById(Long id);

	public ShopAdmin[] deleteByIds(Long[] ids);

	public Admin findAdminId(Long id);
}