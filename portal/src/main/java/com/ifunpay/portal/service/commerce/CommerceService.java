package com.ifunpay.portal.service.commerce;

import com.ifunpay.portal.dao.CommerceDao;
import com.ifunpay.portal.entity.BankPayInfo;
import com.ifunpay.portal.entity.Channel;
import com.ifunpay.portal.entity.Commerce;
import com.ifunpay.portal.entity.lottery.CommerceModel;
import com.ifunpay.portal.service.log.OperationLogService;
import com.jspgou.cms.dao.SequenceDao;
import com.jspgou.cms.entity.ShopAdmin;
import com.jspgou.cms.manager.BankPayInfoMng;
import com.jspgou.cms.manager.ShopAdminMng;
import com.jspgou.common.page.Pagination;
import com.jspgou.common.util.ExcelReader;
import com.jspgou.common.web.session.SessionProvider;
import com.jspgou.core.entity.Admin;
import com.jspgou.core.entity.Website;
import com.jspgou.core.manager.AdminMng;
import org.apache.commons.lang.StringUtils;
import org.bouncycastle.asn1.cms.PasswordRecipientInfo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;

/**
 * Created by Conglong Xie on 2015/4/21.
 */
@Service
public class CommerceService {
    private static Logger logger = LoggerFactory.getLogger(CommerceService.class);

    @Resource
    private CommerceDao commerceDao;
    @Resource
    private SequenceDao sequenceDao;

    @Resource
    private ChannelService channelService;

    @Autowired
    private AdminMng adminMng;

    @Autowired
    private ShopAdminMng shopAdminMng;

    @Resource
    private SessionProvider session;
    @Resource
    private OperationLogService operationLogService;

    @Transactional
    public Commerce getCommerceByCommerceId(String commerceId){
        return commerceDao.getByCommerceId(commerceId);
    }



    public Pagination getCommercePaging(Long channelId, Long commerceId, String channelName,String commerceName, Date startTime, Date endTime, int pageNo, int pageSize) {
        return commerceDao.getPageForCommerce(channelId, commerceId, channelName, commerceName, startTime, endTime, pageNo, pageSize);
    }

    @Transactional
    public void saveCommerceEntity(Commerce commerce){
        commerceDao.saveCommerce(commerce);
    }

    @Transactional
    public void updateCommerceEntity(Commerce commerce){
        commerceDao.updateCommerce(commerce);
    }


    @Transactional
    public java.util.List<Commerce> getAllCommerces(){
        return commerceDao.getAllCommerces();
    }


    @Transactional
    public Commerce getCommerceById(Long id){
        return commerceDao.getCommerceById(id);
    }

    @Transactional
    public Commerce[] deleteByIds(Long[] ids) {
        Commerce[] beans = new Commerce[ids.length];
        for (int i = 0, len = ids.length; i < len; i++) {
            beans[i] = deleteById(ids[i]);
        }
        return beans;
    }

    public Commerce deleteById(Long id) {
        Commerce bean = commerceDao.deleteById(id);
        return bean;
    }

    @Transactional
    public List<Commerce> getAllCommerce(){
        return commerceDao.getAllCommerces();
    }

    /**
     * get Commerce By Name
     * @param name
     * @return
     */
    @Transactional
    public Commerce getCommerceByNameService(String name){
        return commerceDao.getCommerceByName(name);
    }

    public List<CommerceModel> getCommerceToExcel(String channelName, String commerceName, Long channelId, Long commerceId, Date startTime, Date endTime) {
        return commerceDao.getCommerceToExcel(channelName, commerceName, channelId, commerceId, startTime, endTime);
    }

    @Transactional
    public void saveCommerceFromFile(MultipartFile file, Commerce bean ,HttpServletRequest request) {
        String commId = "";
        ExcelReader excelReader = new ExcelReader(file);
        Channel channel = channelService.getChannelByChannelId(bean.getChanIdRela().getId());
        List<String[]> arr = excelReader.getAllData(0);
        for (int i=1; i<arr.size(); i++){
            if (StringUtils.isBlank(arr.get(i)[1]) || StringUtils.isBlank(arr.get(i)[2]) || StringUtils.isBlank(arr.get(i)[3])){
                continue;
            }
            Commerce commerce = new Commerce();
            try {
                commerce.setCreateDate(new Date());
                commerce.setChecked("1");//未审核
                commerce.setDelStatus("0");//正常
                commerce.setStatus("0");
                commerce.setCommerceId(sequenceDao.getCommerceId());
                commerce.setName(arr.get(i)[1]);
                commerce.setLinkMan(arr.get(i)[2]);
                commerce.setMobilePhone(arr.get(i)[3]);
                commerce.setAccount(arr.get(i)[4]);
                try {
                    commerce.setRoundDay(Integer.valueOf((String) arr.get(i)[5]));
                } catch (Exception e){
                    commerce.setRoundDay(null);
                }

                try {
                    commerce.setRate(Double.valueOf((String) arr.get(i)[6]));
                } catch (NumberFormatException e){
                    commerce.setRate(null);
                }
                commerce.setDescription(arr.get(i)[7]);
                commerce.setDetailed(arr.get(i)[8]);
                commerce.setChannel(String.valueOf(channel.getId()));
                commerce.setEmail(bean.getEmail());
                commerce.setChanIdRela(channel);
                commerce.setCode(bean.getCode());
//                commerce.setSynStatus("2");
                commerce.setCollaborateStartTime(bean.getCollaborateStartTime());
                commerce.setCollaborateEndTime(bean.getCollaborateEndTime());
                commerce.setDescription(bean.getDescription());
                commerce.setPro(bean.getPro());
                commerce.setCity(bean.getCity());
//                commerce.setExpress(bean.getExpress());
                saveCommerceEntity(commerce);
                if(i==1){
                    commId +=commerce.getCommerceId()+",";
                }else if(i==arr.size()-1){
                    commId +=commerce.getCommerceId();
                }
            } catch (Exception e){
                logger.error("导入商户失败，商户名称："+ arr.get(i)[1], e);
            }
        }
        long adminId = (long)session.getAttribute(request,"_admin_id_key");
        logger.info("adminId = " + adminId);
        Admin admin = adminMng.findById(adminId);
        operationLogService.importCommerce(admin.getUsername(), commId, commId);
    }

    public Long saveOperators(MultipartFile file, Boolean viewOnlyAdmin, String storeFront, Boolean disabled, Integer[] roleIds, String commerceId, String ip, Website web) {
        Commerce commerceIndex = getCommerceById(Long.parseLong(commerceId));
        Channel channel = commerceIndex.getChanIdRela();
        ExcelReader excelReader = new ExcelReader(file);
        List<String[]> arr = excelReader.getAllData(0);
        for (int i=1; i<arr.size(); i++) {
            if (StringUtils.isBlank(arr.get(i)[1]) || StringUtils.isBlank(arr.get(i)[2])){
                continue;
            }
            try {
                ShopAdmin shopAdmin = new ShopAdmin();
                shopAdmin.setFirstname(arr.get(i)[3]);
                shopAdmin = shopAdminMng.register(arr.get(i)[1], arr.get(i)[2], viewOnlyAdmin, arr.get(i)[4], ip,
                        disabled, web.getId(), shopAdmin, String.valueOf(channel.getId()), channel.getChannelName(), commerceId, commerceIndex.getName(), storeFront);
                adminMng.addRole(shopAdmin.getAdmin(), roleIds);
            } catch (Exception e){
                logger.error("导入操作员失败，操作员名称："+arr.get(i)[1], e);
            }
        }
        return channel.getId();
    }

    @Transactional
    public void setPayAccount(Long commerceId, BankPayInfo bankPayInfo, Integer payAccountStatus) {
        String payAccount = bankPayInfo.getName();
        if (StringUtils.isBlank(bankPayInfo.getId())){
            bankPayInfoMng.save(bankPayInfo);
        } else {
            bankPayInfoMng.update(bankPayInfo);
        }
        Commerce commerce = getCommerceById(commerceId);
        commerce.setPayAccountId(payAccount);
        commerce.setPayAccountStatus(payAccountStatus);
        updateCommerceEntity(commerce);
    }

    @Autowired
    private BankPayInfoMng bankPayInfoMng;

    public void deletePayAccount(Long commerceId) {
        Commerce commerce = getCommerceById(commerceId);
        String payAccount = commerce.getPayAccountId();

        commerce.setPayAccountId(null);
        // set merchant's pay account is forbidden
        commerce.setPayAccountStatus(null);
        updateCommerceEntity(commerce);

        try {
            bankPayInfoMng.deleteById(payAccount);
        } catch (Exception e){
            logger.error("", e);
        }
    }

    public List<Commerce> getCommerces(Long channelId, Long commerceId) {
        return commerceDao.getCommerces(channelId, commerceId);
    }
}
