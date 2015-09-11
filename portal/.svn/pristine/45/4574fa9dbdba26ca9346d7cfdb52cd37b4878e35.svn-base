package com.jspgou.cms.manager.impl;

import com.jspgou.cms.dao.ShopAdminDao;
import com.jspgou.cms.entity.ShopAdmin;
import com.jspgou.cms.manager.ShopAdminMng;
import com.jspgou.common.hibernate3.Updater;
import com.jspgou.common.page.Pagination;
import com.jspgou.core.entity.Admin;
import com.jspgou.core.entity.User;
import com.jspgou.core.entity.Website;
import com.jspgou.core.manager.AdminMng;
import com.jspgou.core.manager.UserMng;
import com.jspgou.core.manager.WebsiteMng;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
* This class should preserve.
* @preserve
*/
@Service
@Transactional
public class ShopAdminMngImpl implements ShopAdminMng {
	public ShopAdmin getByUserId(Long userId, Long webId) {
		Admin admin = adminMng.getByUserId(userId, webId);
		if (admin == null) {
			return null;
		}
		return findById(admin.getId());
	}

	public ShopAdmin register(String username, String password,Boolean viewonlyAdmin,String email,
			String ip, boolean disabled, Long webId, 
			ShopAdmin shopAdmin,String channelId,String channelName,String commerceId,String commerceName,String storeFront) {
		Website web = websiteMng.findById(webId);
		Admin admin = adminMng.register(username, password, email, ip,disabled,web,viewonlyAdmin,channelId,channelName,commerceId,commerceName,storeFront);
		shopAdmin.setAdmin(admin);
		shopAdmin.setWebsite(web);
		return save(shopAdmin);
	}

	@Transactional(readOnly = true)
	public Pagination getPage(Long webId, int pageNo, int pageSize) {
		Pagination page = dao.getPage(webId, pageNo, pageSize);
		return page;
	}

    @Transactional(readOnly = true)
    public Pagination getPageForChannel(String channelId,String commerceId,Long webId, int pageNo, int pageSize) {
        Pagination page = dao.getPageForChannel(channelId, commerceId, webId, pageNo, pageSize);
        return page;
    }

    @Transactional(readOnly = true)
    public Pagination getPageForChannelOnly(String channelId,String commerceId,Long webId, int pageNo, int pageSize) {
        Pagination page = dao.getPageForChannelOnly(channelId, commerceId, webId, pageNo, pageSize);
        return page;
    }

	@Transactional(readOnly = true)
	public ShopAdmin findById(Long id) {
		ShopAdmin entity = dao.findById(id);
		return entity;
	}

	public ShopAdmin save(ShopAdmin bean) {
		dao.save(bean);
		return bean;
	}

	public ShopAdmin update(ShopAdmin bean, String password, Boolean disabled,
			String email,Boolean viewonlyAdmin,String channelId,String channelName,String commerceId,String commerceName,String storeFront) {
		ShopAdmin entity = findById(bean.getId());
		Admin admin = entity.getAdmin();
		userMng.updateUser(admin.getUser().getId(), password, email,channelId,channelName,commerceId,commerceName,storeFront);
		if (disabled != null) {
			admin.setDisabled(disabled);
		}
		admin.setViewonlyAdmin(viewonlyAdmin);
		Updater<ShopAdmin> updater = new Updater<ShopAdmin>(bean);
		entity = dao.updateByUpdater(updater);
		return entity;
	}

	public ShopAdmin deleteById(Long id) {
		ShopAdmin bean = dao.deleteById(id);
		return bean;
	}

	public ShopAdmin[] deleteByIds(Long[] ids) {
		ShopAdmin[] beans = new ShopAdmin[ids.length];
		for (int i = 0, len = ids.length; i < len; i++) {
            beans[i] = deleteById(ids[i]);
            try {
                User user = beans[i].getAdmin().getUser();
                userMng.deleteById(user.getId());
            } catch (Exception e){
                logger.error("", e);
            }
        }
		return beans;
	}

	@Override
	public Admin findAdminId(Long id) {
		return dao.findAdminId(id);
	}

	private UserMng userMng;
	private WebsiteMng websiteMng;
	private AdminMng adminMng;
	private ShopAdminDao dao;

	@Autowired
	public void setDao(ShopAdminDao dao) {
		this.dao = dao;
	}

	@Autowired
	public void setAdminMng(AdminMng adminMng) {
		this.adminMng = adminMng;
	}

	@Autowired
	public void setWebsiteMng(WebsiteMng websiteMng) {
		this.websiteMng = websiteMng;
	}

	@Autowired
	public void setUserMng(UserMng userMng) {
		this.userMng = userMng;
	}

    private static final Logger logger = Logger.getLogger(ShopAdminMngImpl.class);
}