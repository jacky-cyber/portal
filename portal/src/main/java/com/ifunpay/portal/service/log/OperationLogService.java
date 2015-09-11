package com.ifunpay.portal.service.log;

import com.ifunpay.portal.dao.BaseDao;
import com.ifunpay.portal.entity.log.OperationLogEntity;
import com.ifunpay.portal.enums.Module;
import com.ifunpay.portal.enums.RelativeType;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

/**
 * Created by yu on 15-6-16.
 */
@Service
public class OperationLogService {

    @Resource
    BaseDao baseDao;
    public static final String ROW_COUNT = "select count(*) from ";

    private static final Logger logger = Logger.getLogger(OperationLogService.class);

    @Transactional
     public void addLog(String userId, Module moduleName, RelativeType relativeType, String relateId, String operationName,String moduleId){
        try {
            OperationLogEntity entity = new OperationLogEntity();
            entity.setUserId(userId);
            entity.setModuleName(moduleName);
            entity.setOperateTime(new Date());
            entity.setRelateId(relateId);
            entity.setModuleId(moduleId);
            entity.setRelativeType(relativeType);
            entity.setOperationName(operationName);
            baseDao.save(entity);
        }catch (Exception e){
            logger.info("保存日志异常",e);
        }
    }

    /**
     * 退款
     * @param userId
     * @param orderId
     */
    public void refund(String userId, String orderId,String moduleId){
        addLog(userId, Module.ORDER, RelativeType.ORDER, orderId, "退款",moduleId);
    }

    /**
     * 重发凭证
     * @param userId
     * @param orderId
     */
    public void resendVoucher(String userId, String orderId,String moduleId){
        addLog(userId, Module.ORDER, RelativeType.ORDER, orderId, "重发凭证",moduleId);
    }

    /**
     * 消费凭证
     * @param userId
     * @param voucherId
     */
    public void consumeVoucher(String userId, String voucherId,String moduleId){
        addLog(userId, Module.VOUCHER, RelativeType.VOUCHER, voucherId, "消费凭证",moduleId);
    }

    /**
     * 新增渠道
     * @param userId
     * @param merchandiseId
     */
    public void addChannel(String userId, String merchandiseId,String moduleId){
        addLog(userId, Module.CHANNEL, RelativeType.CHANNEL, merchandiseId, "新增渠道",moduleId);
    }


    /**
     * 编辑渠道
     * @param userId
     * @param merchandiseId
     */
    public void editChannel(String userId, String merchandiseId,String moduleId){
        addLog(userId, Module.CHANNEL, RelativeType.CHANNEL, merchandiseId, "编辑渠道",moduleId);
    }

    /**
     * 渠道导入
     * @param userId
     * @param merchandiseId
     */
    public void importChannel(String userId, String merchandiseId,String moduleId){
        addLog(userId, Module.CHANNEL, RelativeType.CHANNEL, merchandiseId, "渠道导入",moduleId);
    }

    /**
     * 添加渠道操作员
     * @param userId
     * @param merchandiseId
     */
    public void addUserForChannel(String userId, String merchandiseId,String moduleId){
        addLog(userId, Module.CHANNEL, RelativeType.CHANNEL_USER, merchandiseId, "添加渠道操作员",moduleId);
    }

    /**
     * 编辑渠道操作员
     * @param userId
     * @param merchandiseId
     */
    public void editUserForChannel(String userId, String merchandiseId,String moduleId){
        addLog(userId, Module.CHANNEL, RelativeType.CHANNEL_USER, merchandiseId, "编辑渠道操作员",moduleId);
    }

    /**
     * 删除渠道操作员
     * @param userId
     * @param mallId
     */
    public void delUserForChannel(String userId, String mallId,String moduleId){
        addLog(userId, Module.CHANNEL, RelativeType.CHANNEL_USER, mallId, "删除渠道操作员",moduleId);
    }

    /**
     * 添加商户操作员
     * @param userId
     * @param mallId
     */
    public void addUserForCommerce(String userId, String mallId,String moduleId){
        addLog(userId, Module.COMMERCE, RelativeType.COMMERCE_USER, mallId, "添加商户操作员",moduleId);
    }

    /**
     * 编辑商户操作员
     * @param userId
     * @param mallMerchandiseId 活动商城商品
     */
    public void editUserForCommerce(String userId, String mallMerchandiseId,String moduleId){
        addLog(userId, Module.COMMERCE, RelativeType.COMMERCE_USER, mallMerchandiseId, "编辑商户操作员",moduleId);
    }

    /**
     * 删除商户操作员
     * @param userId
     * @param mallMerchandiseId
     */
    public void delUserForCommerce(String userId, String mallMerchandiseId,String moduleId){
        addLog(userId, Module.COMMERCE, RelativeType.COMMERCE_USER, mallMerchandiseId, "删除商户操作员",moduleId);
    }

    /**
     * 添加商户
     * @param userId
     * @param mallMerchandiseId
     */
    public void addCommerce(String userId, String mallMerchandiseId,String moduleId){
        addLog(userId, Module.COMMERCE, RelativeType.COMMERCE, mallMerchandiseId, "添加商户",moduleId);
    }

    /**
     * 编辑商户
     * @param userId
     * @param mallMerchandiseId
     */
    public void editCommerce(String userId, String mallMerchandiseId,String moduleId){
        addLog(userId, Module.COMMERCE, RelativeType.COMMERCE, mallMerchandiseId, "编辑商户",moduleId);
    }



    /**
     * 导入商户
     * @param userId
     * @param mallMerchandiseId
     */
    public void importCommerce(String userId, String mallMerchandiseId,String moduleId){
        addLog(userId, Module.COMMERCE, RelativeType.COMMERCE, mallMerchandiseId, "导入商户",moduleId);
    }
    /**
     * 编辑分类
     * @param userId
     * @param mallMerchandiseId
     */
    public void categorySeparateEdit(String userId, String mallMerchandiseId,String moduleId){
        addLog(userId, Module.SEPARATE, RelativeType.SEPARATE, mallMerchandiseId, "编辑分类",moduleId);
    }

    /**
     * 删除分类
     * @param userId
     * @param mallMerchandiseId
     */
    public void categorySeparateDelete(String userId, String mallMerchandiseId,String moduleId){
        addLog(userId, Module.SEPARATE, RelativeType.SEPARATE, mallMerchandiseId, "删除分类",moduleId);
    }


    /**
     * 添加类型管理
     * @param userId
     * @param mallMerchandiseId
     */
    public void typeManageAdd(String userId, String mallMerchandiseId,String moduleId){
        addLog(userId, Module.TYPE_MANAGE, RelativeType.TYPE_MANAGE, mallMerchandiseId, "添加类型管理",moduleId);
    }

    /**
     * 编辑类型管理
     * @param userId
     * @param mallMerchandiseId
     */
    public void typeManageEdit(String userId, String mallMerchandiseId,String moduleId){
        addLog(userId, Module.TYPE_MANAGE, RelativeType.TYPE_MANAGE, mallMerchandiseId, "编辑类型管理",moduleId);
    }

    /**
     * 删除类型管理
     * @param userId
     * @param mallMerchandiseId
     */
    public void typeManageDelete(String userId, String mallMerchandiseId,String moduleId){
        addLog(userId, Module.TYPE_MANAGE, RelativeType.TYPE_MANAGE, mallMerchandiseId, "删除类型管理",moduleId);
    }

    /**
     * 商品添加
     * @param userId
     * @param mallMerchandiseId
     */
    public void productAdd(String userId, String mallMerchandiseId,String moduleId){
        addLog(userId, Module.MERCHANDISE, RelativeType.MERCHANDISE, mallMerchandiseId, "商品添加",moduleId);
    }

    /**
     * 商品编辑
     * @param userId
     * @param mallMerchandiseId
     */
    public void productEdit(String userId, String mallMerchandiseId,String moduleId){
        addLog(userId, Module.MERCHANDISE, RelativeType.MERCHANDISE, mallMerchandiseId, "商品编辑",moduleId);
    }

    /**
     * 商品删除
     * @param userId
     * @param mallMerchandiseId
     */
    public void productDelete(String userId, String mallMerchandiseId,String moduleId){
        addLog(userId, Module.MERCHANDISE, RelativeType.MERCHANDISE, mallMerchandiseId, "商品删除",moduleId);
    }

    /**
     * 商品上架
     * @param userId
     * @param mallMerchandiseId
     */
    public void productOnline(String userId, String mallMerchandiseId,String moduleId){
        addLog(userId, Module.MERCHANDISE, RelativeType.MERCHANDISE, mallMerchandiseId, "商品上架",moduleId);
    }

    /**
     * 商品下架
     * @param userId
     * @param mallMerchandiseId
     */
    public void productOffline(String userId, String mallMerchandiseId,String moduleId){
        addLog(userId, Module.MERCHANDISE, RelativeType.MERCHANDISE, mallMerchandiseId, "商品下架",moduleId);
    }

    /**
     * 订单修改
     * @param userId
     * @param mallMerchandiseId
     */
    public void orderUpdate(String userId, String mallMerchandiseId,String moduleId){
        addLog(userId, Module.ORDER, RelativeType.ORDER, mallMerchandiseId, "订单修改",moduleId);
    }

    /**
     * 订单退款
     * @param userId
     * @param mallMerchandiseId
     */
    public void orderRefund(String userId, String mallMerchandiseId,String moduleId){
        addLog(userId, Module.ORDER, RelativeType.ORDER, mallMerchandiseId, "订单退款",moduleId);
    }

    /**
     * 订单删除
     * @param userId
     * @param mallMerchandiseId
     */
    public void orderDelete(String userId, String mallMerchandiseId,String moduleId){
        addLog(userId, Module.ORDER, RelativeType.ORDER, mallMerchandiseId, "订单删除",moduleId);
    }


    /**
     * 添加店面
     * @param userId
     * @param mallMerchandiseId
     */
    public void addStore(String userId, String mallMerchandiseId,String moduleId){
        addLog(userId, Module.STORE, RelativeType.STORE, mallMerchandiseId, "添加店面",moduleId);
    }

    /**
     * 编辑店面
     * @param userId
     * @param mallMerchandiseId
     */
    public void editStore(String userId, String mallMerchandiseId,String moduleId){
        addLog(userId, Module.STORE, RelativeType.STORE, mallMerchandiseId, "编辑店面",moduleId);
    }

    /**
     * 删除店面
     * @param userId
     * @param mallMerchandiseId
     */
    public void delStore(String userId, String mallMerchandiseId,String moduleId){
        addLog(userId, Module.STORE, RelativeType.STORE, mallMerchandiseId, "删除店面",moduleId);
    }

    /**
     * 导入店面
     * @param userId
     * @param mallMerchandiseId
     */
    public void importStore(String userId, String mallMerchandiseId,String moduleId){
        addLog(userId, Module.STORE, RelativeType.STORE, mallMerchandiseId, "导入店面",moduleId);
    }

    /**
     * 新增收款帐号
     * @param userId
     * @param accountId
     * @param moduleId
     */
    public void addBankPayInfoAccount(String userId, String accountId, String moduleId){
        addLog(userId, Module.RECEIVING_ACCOUNT, RelativeType.RECIEVING_ACCOUNT, accountId, "新增",moduleId);
    }

    /**
     * 修改收款帐号
     * @param userId
     * @param accountId
     * @param moduleId
     */
    public void modifyBankPayInfoAccount(String userId, String accountId, String moduleId){
        addLog(userId, Module.RECEIVING_ACCOUNT, RelativeType.RECIEVING_ACCOUNT, accountId, "修改",moduleId);
    }

    /**
     * 删除收款帐号
     * @param userId
     * @param accountId
     * @param moduleId
     */
    public void deleteBankPayInfoAccount(String userId, String accountId, String moduleId){
        addLog(userId, Module.RECEIVING_ACCOUNT, RelativeType.RECIEVING_ACCOUNT, accountId, "删除",moduleId);
    }

    @Transactional
    public List<OperationLogEntity> list(){
        return baseDao.getAll(OperationLogEntity.class);
    }
}
