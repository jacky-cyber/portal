package com.jspgou.cms.manager;

import com.jspgou.cms.entity.Store;
import com.jspgou.cms.entity.StoreModel;
import com.jspgou.common.page.Pagination;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;

/**
 * Created by zhengjiang on 2015-07-09.
 */
public interface StoreMng {
    public Pagination getPage(String storeName, Long id, Integer storeStatus, String commerceName,
                              Date startTime, Date endTime,Integer pageSize,Integer pageNo, Long channelId, Long commerceId);

    public void save(Store store);

    public Boolean checkName(String storeName, Object... values);

    public Store getStoreById(Long id);

    public void update(Store store);

    public List<StoreModel> getStoreToExcel(String commerceName, String storeName, Long id, String startTime, String endTime);

    public void saveStoreFromExcel(MultipartFile file, Store store,HttpServletRequest request);

    public List<Store> getAllStore();

    Store[] deleteByIds(Long[] ids);

    List<Store> getStore(Long channelId, Long commerceId);
}
