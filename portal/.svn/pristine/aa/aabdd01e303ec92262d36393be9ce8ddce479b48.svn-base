package com.ifunpay.portal.service.order;

import com.ifunpay.portal.ProjectXml;
import com.ifunpay.portal.dao.OrderPayRefundDao;
import com.ifunpay.portal.dao.order.OrderEntityDao;
import com.ifunpay.portal.dao.order.OrderRecoveryKV;
import com.ifunpay.portal.entity.MemberUserEntity;
import com.ifunpay.portal.entity.OrderPayRefundEntity;
import com.ifunpay.portal.entity.order.OrderEntity;
import com.ifunpay.util.enums.PayMethodEnum;
import com.jspgou.cms.entity.OrderExport;
import com.jspgou.cms.manager.ProductMng;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by CongLong Xie on 2015/7/24.
 */
@Service
@Log4j
public class OrderEntityService {
    @Resource
    private OrderEntityDao orderEntityDao;

    @Resource
    private OrderPayRefundDao orderPayRefundDao;

    @Resource
    private ProductMng productMng;

    /**
     *
     * @param proIds 商品id集合
     * @param payMethod 支付方式
     * @param memberUserEntity 用户
     * @param terminalId 终端机编号
     * @param serialNo 流水号
     * @param quantity 商品数量集合
     * @param receiveName 收货人姓名
     * @param phone 收货人电话
     * @param province
     * @param city
     * @param addressDetails
     * @return
     */
    @Transactional
     public OrderEntity buildOrderEntity(Long[] proIds,PayMethodEnum payMethod,MemberUserEntity memberUserEntity,String terminalId,String serialNo,Integer[] quantity,String receiveName,String phone,String province ,String city,String addressDetails,String deviceName){
        OrderEntity orderEntity = orderEntityDao.buildOrderEntity(proIds,payMethod,memberUserEntity,terminalId,serialNo,quantity,receiveName,phone,province,city,addressDetails,deviceName);
        //reduce inventory
        for (int i=0;i<proIds.length;i++){
            if(productMng.findById(proIds[i]).getProductStamp() ==3 ){
                //商城商品减少库存
                productMng.reduceInventory(proIds,quantity);
            }
        }
        return orderEntity;
    }

    /**
     * Find OrderEntity Object By OrderId
     * @param orderId
     * @return
     */
    public OrderEntity findOrderEntityByOrderId(String orderId){
        return orderEntityDao.findByOrderId(orderId);
    }

    /**
     * Update Order Entity via Entity
     * @param orderEntity
     */
    public void updateOrderEntity(OrderEntity orderEntity){
        orderEntityDao.updateOrderEntity(orderEntity);
    }


    /**
     * update new order pay status and pay refund 's status
     */
    public void updateOrderEntityAndPayRefundEntity(OrderEntity orderEntity,OrderPayRefundEntity orderPayRefundEntity){
        orderEntityDao.updateOrderEntity(orderEntity);
        orderPayRefundDao.update(orderPayRefundEntity);
    }

    /**
     * Find OrderEntity Object By Id
     * @param id
     * @return
     */
    public OrderEntity findOrderEntityById(Long id){
        return  orderEntityDao.findById(id);
    }

    /**
     * Compose export data
     * @param orderId
     * @param phone
     * @param channelName
     * @param commerceName
     * @param productName
     * @param startTime
     * @param endTime
     * @param payMethod
     * @param paymentStatus
     * @param shippingStatus
     * @param orderStatus
     * @return
     */
    public List<OrderExport> newOrderExport(String orderId,String phone,String channelName,String commerceName,String productName,String startTime, String endTime, String payMethod, String paymentStatus,String shippingStatus,String orderStatus){
        return orderEntityDao.newOrderExport(orderId, phone, channelName, commerceName, productName, startTime, endTime, payMethod, paymentStatus, shippingStatus, orderStatus);
    }

    /**
     * Logical delete order by ids
     * @param ids
     * @return
     */
    public OrderEntity[] deleteByIdsUpdateOrderDelStatus(Long[] ids) {
        OrderEntity[] beans = new OrderEntity[ids.length];
        for (int i = 0, len = ids.length; i < len; i++) {
            beans[i] = orderEntityDao.deleteByIdUpdateDelStatus(ids[i]);
        }
        return beans;
    }

    public List<OrderEntity> findOrderEntityByTerminalIdAndSerialNo(String terminalId,String serialNo){
        return orderEntityDao.findOrderEntityByTerminalIdAndSerialNo(terminalId,serialNo);
    }

    public List<OrderEntity> getlistByCommerceAndmember(String commerceId, Long memberId) {
        return orderEntityDao.getlistByCommerceAndmember(commerceId, memberId);
    }


    /**
     * 修改订单状态，修改库存
     */
    @Transactional
    public void updateOrderEntityExpireAndRecoveryInventory() {

        try {
            Date curDate = new Date();
            String dateStart = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date(curDate.getTime() - 24 * 60 * 60 * 1000));
            long expTime = Long.parseLong(ProjectXml.getValue("order_expire_time"));
            String dateEnd = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date(curDate.getTime() - expTime));
            List<OrderRecoveryKV> lists = orderEntityDao.getAllOrderRecoveryKeyValue(dateStart, dateEnd);

            if(null!=lists && !lists.isEmpty()) {
                for(int i =0;i<lists.size();i++){
                    log.info(lists.get(i).toString());
                }
                orderEntityDao.recoveryInventoryForActivityProduct(lists);
                int updateSize = orderEntityDao.updateOrderStatusToCanceled(dateStart, dateEnd);
                log.info("update to cancel size (equals to recovery value) = "+updateSize);
            }

        } catch (Exception e) {
            log.error("", e);
        }
    }
}
