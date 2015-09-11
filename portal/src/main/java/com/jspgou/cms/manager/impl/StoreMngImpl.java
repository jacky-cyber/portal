package com.jspgou.cms.manager.impl;

import com.ifunpay.portal.entity.Commerce;
import com.ifunpay.portal.service.commerce.CommerceService;
import com.ifunpay.portal.service.log.OperationLogService;
import com.jspgou.cms.dao.StoreDao;
import com.jspgou.cms.entity.Store;
import com.jspgou.cms.entity.StoreModel;
import com.jspgou.cms.manager.StoreMng;
import com.jspgou.common.page.Pagination;
import com.jspgou.common.util.ExcelReader;
import com.jspgou.common.web.session.SessionProvider;
import com.jspgou.core.entity.Admin;
import com.jspgou.core.manager.AdminMng;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;

/**
 * Created by zhengjiang on 2015-07-09.
 */
public class StoreMngImpl implements StoreMng {

    public Pagination getPage(String storeName, Long id, Integer storeStatus, String commerceName,
                               Date startTime, Date endTime,Integer pageSize,Integer pageNo, Long channelId, Long commerceId) {
        return dao.getPage(storeName, id, storeStatus, commerceName, startTime, endTime, pageSize, pageNo, channelId, commerceId);
    }

    @Override
    public void save(Store store) {
        dao.save(store);
    }

    @Override
    public Boolean checkName(String storeName, Object... values) {
        return dao.checkName(storeName, values);
    }

    @Override
    public Store getStoreById(Long id) {
        return dao.getStoreById(id);
    }

    @Override
    public void update(Store store) {
        dao.update(store);
    }

    @Override
    public List<StoreModel> getStoreToExcel(String commerceName, String storeName, Long id, String startTime, String endTime) {
        return dao.getStoreToExcel(commerceName, storeName, id, startTime, endTime);
    }

    @Override
    public void saveStoreFromExcel(MultipartFile file, Store store,HttpServletRequest request) {
        String storeId = "";
        ExcelReader excelReader = new ExcelReader(file);
        Commerce commerce = commerceService.getCommerceById(store.getCommerceId());
        List<String[]> arr = excelReader.getAllData(0);
        for (int i=1; i<arr.size(); i++){
            if (StringUtils.isBlank(arr.get(i)[1]) || StringUtils.isBlank(arr.get(i)[2])){
                continue;
            }
            Store store1 = new Store();
            try {
                store1.setStoreName(arr.get(i)[1]);
                store1.setCreateDate(new Date());
                store1.setStoreStatus(store.getStoreStatus());
                store1.setCommerceId(store.getCommerceId());
                store1.setCommerceName(commerce.getName());
                store1.setMobile(arr.get(i)[2]);
                store1.setCity(store.getCity());
                store1.setProvince(store.getProvince());
                store1.setDetail(store.getDetail());
                store1.setEmail(arr.get(i)[3]);
                store1.setDescription(arr.get(i)[4]);
                save(store1);
                if(i==1){
                    storeId +=store1.getId()+",";
                }else if(i==arr.size()-1){
                    storeId +=store1.getId();
                }
            } catch (Exception e){
                logger.error("导入店面失败，店面名称："+ arr.get(i)[1], e);
            }
        }
        long adminId = (long)session.getAttribute(request,"_admin_id_key");
        logger.info("adminId = " + adminId);
        Admin admin = adminMng.findById(adminId);
        operationLogService.importChannel(admin.getUsername(), storeId, storeId);
    }

    @Override
    public List<Store> getAllStore() {
        return dao.getAllStore();
    }

    @Override
    public Store[] deleteByIds(Long[] ids) {
        Store[] beans = new Store[ids.length];
        for (int i = 0, len = ids.length; i < len; i++) {
            beans[i] = deleteById(ids[i]);
        }
        return beans;
    }

    @Override
    public List<Store> getStore(Long channelId, Long commerceId) {
        return dao.getStore(channelId, commerceId);
    }

    public Store deleteById(Long id) {
        Store bean = dao.deleteById(id);
        return bean;
    }

    @Autowired
    private StoreDao dao;
    @Autowired
    private CommerceService commerceService;
    @Resource
    private SessionProvider session;
    @Resource
    private OperationLogService operationLogService;
    @Resource
    private AdminMng adminMng;
    private static final Logger logger = Logger.getLogger(StoreMngImpl.class);
}
