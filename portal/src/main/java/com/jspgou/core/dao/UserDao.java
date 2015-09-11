package com.jspgou.core.dao;

import com.jspgou.common.hibernate3.Updater;
import com.jspgou.common.page.Pagination;
import com.jspgou.core.entity.User;

import java.util.List;

/**
* This class should preserve.
* @preserve
*/
public interface UserDao{
    public User getByUsername(String username);

    public User getByEmail(String email);

    public Pagination getPage(int pageNo, int pageSize);

    public User findById(Long id);

    public User save(User bean);

    public User updateByUpdater(Updater<User> updater);

    public User deleteById(Long id);

    public Pagination getAllUsersByChannelId(String channelId,int pageNo, int pageSize);

    public java.util.List<User> getAllUsers();

    public List<User> getUserByStoreId(String storeId);
}
