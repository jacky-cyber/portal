package com.ifunpay.portal.dao.order;

import com.ifunpay.portal.ProjectXml;
import com.ifunpay.portal.dao.BaseDao;
import com.ifunpay.portal.dao.OrderPayRefundDao;
import com.ifunpay.portal.entity.Channel;
import com.ifunpay.portal.entity.MemberUserEntity;
import com.ifunpay.portal.entity.OrderPayRefundEntity;
import com.ifunpay.portal.entity.order.OrderEntity;
import com.ifunpay.portal.entity.order.OrderPostInfo;
import com.ifunpay.util.enums.OrderStatusEnum;
import com.ifunpay.util.enums.PayMethodEnum;
import com.ifunpay.util.enums.PaymentStatusEnum;
import com.ifunpay.portal.service.commerce.ChannelService;
import com.ifunpay.portal.util.Arith;
import com.ifunpay.util.enums.ShipmentStatusEnum;
import com.jspgou.cms.dao.SequenceDao;
import com.jspgou.cms.entity.OrderExport;
import com.jspgou.cms.entity.Product;
import com.jspgou.cms.manager.ProductMng;
import com.jspgou.common.hibernate3.Finder;
import com.jspgou.common.hibernate3.HibernateBaseDao;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by CongLongXie on 2015/7/24.
 */
@Service
public class OrderEntityDao extends HibernateBaseDao<OrderEntity, Long> {

    private static Logger logger = Logger.getLogger(OrderEntityDao.class);

    @Resource
    private BaseDao baseDao;

    @Resource
    private ProductMng productMng;

    @Resource
    private SequenceDao sequenceDao;

    @Resource
    private OrderProductDao orderProductDao;

    @Resource
    private OrderPostInfoDao orderPostInfoDao;

    @Resource
    private OrderPayRefundDao orderPayRefundDao;

    @Resource
    private ChannelService channelService;

    public OrderEntity buildOrderEntity(Long[] prods, PayMethodEnum payMethod, MemberUserEntity memberUserEntity, String terminalId, String serialNo, Integer[] quantity, String receiveName, String phone, String province, String city, String addressDetails, String deviceName) {
        OrderEntity orderEntity = new OrderEntity();
        String orderId = sequenceDao.getSequenceOrderId();
        orderEntity.setCode(orderId);
        orderEntity.setTerminalId(terminalId);
        orderEntity.setPaymentStatus(PaymentStatusEnum.NotPay);
        orderEntity.setStatus(OrderStatusEnum.NotConfirm);
        orderEntity.setShipmentStatus(ShipmentStatusEnum.NotShip);
        orderEntity.setPayMethod(payMethod);
        orderEntity.setDel(0);
        orderEntity.setCreateTime(new Date());
        orderEntity.setSerialNo(serialNo);
        orderEntity.setDeviceName(deviceName);
        if (memberUserEntity != null) {
            orderEntity.setMemberUserEntity(memberUserEntity);
            orderEntity.setPhone(memberUserEntity.getPhone());
        }
        long diff = 0;
        long original = 0;
        long totalAmount = 0;
        for (int i = 0; i < prods.length; i++) {
            Product product = productMng.findById(prods[i]);
            totalAmount += new Double(Arith.mul(product.getScanningPrice(), 100 * quantity[i])).longValue();
            original += new Double(Arith.mul(product.getCostPrice(), 100)).longValue();
            diff += (new Double(Arith.mul(product.getScanningPrice(), 100)).longValue() - new Double(Arith.mul(product.getCostPrice(), 100)).longValue());
            orderEntity.setChannelName(product.getChannelName());
            Channel channel = channelService.getChannelByChannelId(Long.parseLong(product.getChannelId()));
            orderEntity.setChannel(channel);
            orderEntity.setPayAccountName(channel.getBankPayInfoId());
        }
        orderEntity.setTotalAmount(totalAmount);
        orderEntity.setOriginalPrice(original);
        orderEntity.setDiffPrice(diff);

        baseDao.save(orderEntity);

        //Build Order Product Relation Table
        for (int i = 0; i < prods.length; i++) {
            Product product = productMng.findById(prods[i]);
            //一个订单下可以有多个商品，生成订单商品关联表
            orderProductDao.buildOrderProduct(product, orderEntity, quantity[i]);

            //为商城商品保存邮寄信息
            if (product.getProductStamp() == 3) {
                //商城商品
                OrderPostInfo orderPostInfo = new OrderPostInfo();
                orderPostInfo.setOrderEntity(orderEntity);
                orderPostInfo.setReceivePhone(phone);
                orderPostInfo.setReceiveName(receiveName);
                if(province ==null){
                    province ="";
                }
                if(city == null){
                    city ="";
                }
                if(addressDetails == null){
                    addressDetails ="";
                }
                orderPostInfo.setReceiveAddress(province + city + addressDetails);
                orderPostInfo.setCreateTime(new Date());
                orderPostInfo.setOrderNumber(orderEntity.getCode());
                orderPostInfoDao.saveOrderPostInfo(orderPostInfo);
            }
        }

        //


        return orderEntity;
    }


    /**
     * 终端机本地商品生成订单
     *
     * @param prodId
     * @param price
     * @param productCount
     * @param payMethod
     * @param terminalId
     * @param deliverStatus
     * @param createTime
     * @param serialNumber
     * @param userAccount
     * @return
     */
    public OrderEntity terminalBuildOrderEntity(Long[] prodId, Long price, Integer[] productCount, String payMethod, String terminalId, Integer deliverStatus, Date createTime,Long payTime, String serialNumber, String userAccount,String terminalOrderId) {
        OrderEntity orderEntity = new OrderEntity();
        String orderId = sequenceDao.getSequenceOrderId();
        orderEntity.setCode(orderId);
        orderEntity.setTerminalOrderId(terminalOrderId);
        orderEntity.setTerminalId(terminalId);
        //支付成功的订单才会存入后台
        //支付状态 1-未支付，2-已支付，3-已退款，4-退款失败
        orderEntity.setPaymentStatus(PaymentStatusEnum.PaySucceeded);
        orderEntity.setStatus(OrderStatusEnum.NotConfirm);
        orderEntity.setShipmentStatus(ShipmentStatusEnum.NotShip);
        if (0 == deliverStatus) {
            orderEntity.setShipmentStatus(ShipmentStatusEnum.Delivery);//已签收
            //订单状态 1-未确认，2-已确认，3-已取消，4-已完成.
            orderEntity.setStatus(OrderStatusEnum.Finished);//已完成。
        } else if (2 == deliverStatus) {
            orderEntity.setPaymentStatus(PaymentStatusEnum.RefundSucceeded);//已退款
            orderEntity.setStatus(OrderStatusEnum.Cancelled);//已取消
            orderEntity.setShipmentStatus(ShipmentStatusEnum.ShipError);
        } else {
            orderEntity.setStatus(OrderStatusEnum.NotConfirm);//未确认
            orderEntity.setShipmentStatus(ShipmentStatusEnum.ShipError);//未发货
        }
        PayMethodEnum payMethodEnum = PayMethodEnum.InsertCard;
        switch (payMethod) {
            case ("FlashPay"):
                payMethodEnum = PayMethodEnum.FlashPay;
                break;
            case ("Pos"):
                payMethodEnum = PayMethodEnum.InsertCard;
                break;
            case ("QrCode "):
                payMethodEnum = PayMethodEnum.QrCode;
                break;
            case ("ScanPay"):
                payMethodEnum = PayMethodEnum.AShotToPay;
                break;
            default:
                break;
        }
        orderEntity.setPayMethod(payMethodEnum);
        orderEntity.setDel(0);
        orderEntity.setCreateTime(createTime);
        orderEntity.setSerialNo(serialNumber);
        long diff = 0;
        long original = 0;
        long totalAmount = 0;
        for(int i=0;i<prodId.length;i++) {
            Product product = productMng.findById(prodId[i]);
            if (product == null) {
                throw new NullPointerException("no such merchandise: " + prodId);
            }
            totalAmount = new Double(Arith.mul(product.getScanningPrice(), 100 * productCount[i])).longValue();
            original = new Double(Arith.mul(product.getSalePrice(), 100)).longValue();
            diff = price - new Double(Arith.mul(product.getSalePrice(), 100)).longValue();
            orderEntity.setChannelName(product.getChannelName());
            orderEntity.setChannel(channelService.getChannelByChannelId(Long.parseLong(product.getChannelId())));
        }
        orderEntity.setTotalAmount(price);
        orderEntity.setOriginalPrice(original);
        orderEntity.setDiffPrice(diff);
        baseDao.save(orderEntity);

        for(int j=0;j<prodId.length;j++) {
            orderProductDao.buildOrderProduct(productMng.findById(prodId[j]), orderEntity, productCount[j]);
        }
        if(orderEntity.getPaymentStatus() == PaymentStatusEnum.PaySucceeded||orderEntity.getPaymentStatus()==PaymentStatusEnum.RefundSucceeded) {
            OrderPayRefundEntity orderPayRefundEntity = new OrderPayRefundEntity();
            orderPayRefundEntity.setId(sequenceDao.getOrderRefundEntityId());
            orderPayRefundEntity.setPayMethod(orderEntity.getPayMethod());
            orderPayRefundEntity.setCode(orderEntity.getCode());
            orderPayRefundEntity.setSerialNumber(serialNumber);
            orderPayRefundEntity.setIsPay("1".charAt(0));
            orderPayRefundEntity.setAccountNumber(userAccount);
            orderPayRefundEntity.setAmount(price);

            orderPayRefundEntity.setPayStatus(PaymentStatusEnum.PaySucceeded);//已付款
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String tempDate = format.format(payTime);
            Date date = null;
            try {
                date = format.parse(tempDate);
            } catch (ParseException e) {
                logger.info("change date error" + e);
            }
            orderPayRefundEntity.setPayTime(date);

            orderPayRefundDao.savePayInfo(orderPayRefundEntity);
        }


        return orderEntity;
    }

    /**
     * 终端机商城商品修改订单
     *
     * @param orderId
     * @param price
     * @param payMethod
     * @param deliverStatus
     * @param serialNumber
     * @param userAccount
     * @return
     */
    public OrderEntity terminalUpdateOrderEntity(String orderId, Long price, String payMethod, String serialNumber, String userAccount, String posNumber, Integer deliverStatus) {
        OrderEntity orderEntity = findByOrderId(orderId);
        orderEntity.setTotalAmount(price);
        PayMethodEnum payMethodEnum = null;
        switch (payMethod) {
            case ("FlashPay"):
                payMethodEnum = PayMethodEnum.FlashPay;
                break;
            case ("Pos"):
                payMethodEnum = PayMethodEnum.InsertCard;
                break;
            case ("QrCode"):
                payMethodEnum = PayMethodEnum.QrCode;
                break;
            case ("ScanPay"):
                payMethodEnum = PayMethodEnum.AShotToPay;
                break;
            default:
                break;

        }
        orderEntity.setPayMethod(payMethodEnum);

        if (0 == deliverStatus) {
            orderEntity.setShipmentStatus(ShipmentStatusEnum.Delivery);//已签收
            //支付状态 1-未支付，2-已支付，3-已退款，4-退款失败
            orderEntity.setPaymentStatus(PaymentStatusEnum.PaySucceeded);//已支付
            //订单状态 1-未确认，2-已确认，3-已取消，4-已完成.
            orderEntity.setStatus(OrderStatusEnum.Finished);//已完成。
        } else {
            orderEntity.setStatus(OrderStatusEnum.NotConfirm);//未确认
            orderEntity.setShipmentStatus(ShipmentStatusEnum.NotShip);//未发货
            orderEntity.setPaymentStatus(PaymentStatusEnum.NotPay);//未支付
        }
        baseDao.update(orderEntity);

        OrderPayRefundEntity orderPayRefundEntity = orderPayRefundDao.findByOrderId(orderId);

        orderPayRefundEntity.setPayMethod(orderEntity.getPayMethod());
        orderPayRefundEntity.setCode(orderEntity.getCode());
        orderPayRefundEntity.setSerialNumber(serialNumber);
        orderPayRefundEntity.setIsPay("1".charAt(0));
        orderPayRefundEntity.setAccountNumber(userAccount);
        orderPayRefundEntity.setAmount(price);
        orderPayRefundEntity.setPayTime(new Date());
        orderPayRefundEntity.setPosNumber(posNumber);
        orderPayRefundEntity.setPayStatus(orderEntity.getPaymentStatus());//已付款

        if (orderPayRefundEntity == null) {
            orderPayRefundEntity.setId(sequenceDao.getOrderRefundEntityId());
            orderPayRefundDao.savePayInfo(orderPayRefundEntity);
        } else {
            orderPayRefundDao.updatePayRefundEntity(orderPayRefundEntity);
        }


        return orderEntity;
    }

    public OrderEntity findByOrderId(String orderId) {
        Query query = getSession().createQuery("from OrderEntity bean where bean.code = '" + orderId + "'");
        return (OrderEntity) query.uniqueResult();
    }

    public void updateOrderEntity(OrderEntity orderEntity) {
        baseDao.update(orderEntity);
    }

    public OrderEntity findById(Long id) {
        Query query = getSession().createQuery("from OrderEntity bean where bean.id = " + id + "");
        return (OrderEntity) query.uniqueResult();
    }

    public List<OrderExport> newOrderExport(String orderId, String phone, String channelName, String commerceName, String productName, String startTime, String endTime, String payMethod, String paymentStatus, String shippingStatus, String orderStatus) {
        StringBuffer sql = new StringBuffer("select n.order_id,n.phone,n.channel_name,nop.commerce_name,nop.product_name,n.create_time,n.pay_method,n.pay_status,n.ship_status,n.order_status,n.total_amount,n.terminal_id,n.serial_no from n_order n ,n_order_product nop ,jc_shop_product pro where pro.product_id = nop.product_id and nop.order_id = n.id and n.del =0 ");

        if (StringUtils.isNotBlank(orderId)) {
            sql.append(" and n.order_id like '%" + orderId + "%'");
        }

        if (StringUtils.isNotBlank(phone)) {
            sql.append(" and n.phone like '%" + phone + "%'");
        }

        if (StringUtils.isNotBlank(channelName)) {
            sql.append(" and n.channel_name like '%" + channelName + "%'");
        }

        if (StringUtils.isNotBlank(commerceName)) {
            sql.append(" and nop.commerce_name like '%" + commerceName + "%'");
        }

        if (StringUtils.isNotBlank(productName)) {
            sql.append(" and nop.product_name like '%" + productName + "%'");
        }

        if (StringUtils.isNotBlank(startTime)) {
            sql.append(" and n.create_time >= '" + startTime + "'");
        }

        if (StringUtils.isNotBlank(endTime)) {
            sql.append(" and n.create_time < '" + endTime + "'");
        }

        if (StringUtils.isNotBlank(payMethod)) {
            sql.append(" and n.pay_method = '" + payMethod + "'");
        }

        if (StringUtils.isNotBlank(paymentStatus)) {
            sql.append(" and n.pay_status = '" + paymentStatus + "'");
        }

        if (StringUtils.isNotBlank(shippingStatus)) {
            sql.append(" and n.ship_status = '" + shippingStatus + "'");
        }

        if (StringUtils.isNotBlank(orderStatus)) {
            sql.append(" and n.order_status = '" + orderStatus + "'");
        }

        sql.append(" order by n.create_time desc ");

        logger.info("sql=" + sql.toString());
        Query query = getSession().createSQLQuery(sql.toString());
        int maxSize = Integer.parseInt(ProjectXml.getValue("export_excel_max_row_size"));
        logger.info("maxSize =" + maxSize);
        query.setMaxResults(maxSize);
        List<OrderExport> orderExports = new ArrayList<OrderExport>();
        List<?> list = (List<?>) query.list();
        for (Object object : list) {
            Object[] data = (Object[]) object;
            OrderExport export = new OrderExport();
            logger.info("data=" + (String) data[0]);
            export.setCode((String) data[0]);
            export.setPhone((String) data[1]);
            export.setChannelName((String) data[2]);
            export.setCommerceName((String) data[3]);
            export.setProductName((String) data[4]);
            export.setCreateTime((Date) data[5]);
            export.setPayMethod(PayMethodEnum.valueOf((String) data[6]).getDisplayName());
            export.setPayStatus(PaymentStatusEnum.valueOf((String) data[7]).getDisplayName());
            export.setShipStatus(ShipmentStatusEnum.valueOf((String) data[8]).getDisplayName());
            export.setOrderStatus(OrderStatusEnum.valueOf((String) data[9]).getDisplayName());
            export.setAmount(Long.parseLong((Integer) data[10] + ""));
            export.setTerminalId((String) data[11]);
            export.setSerialNo((String) data[12]);
            orderExports.add(export);
        }
        return orderExports;
    }


    public OrderEntity deleteByIdUpdateDelStatus(Long id) {
        OrderEntity orderEntity = findById(id);
        orderEntity.setDel(1);//设置成已删除
        updateOrderEntity(orderEntity);
        return orderEntity;
    }

    public List<OrderEntity> findOrderEntityByTerminalIdAndSerialNo(String terminalId,String serialNo){
        StringBuffer sql = new StringBuffer("from OrderEntity where terminalId ='"+terminalId+"' and serialNo ='"+serialNo+"' ");
        logger.info("findOrderEntityByTerminalIdAndSerialNo sql=" + sql.toString());
        return getSession().createQuery(sql.toString()).list();
    }

    public List<OrderEntity> getlistByCommerceAndmember(String commerceId, Long memberId) {
        Finder f = Finder
                .create("from OrderEntity bean where 1=1 ");
        if (null!=memberId) {
            f.append("and bean.memberUserEntity.name=:memberId");
            f.setParam("memberId", memberId.toString());
        }
        if (!StringUtils.isBlank(commerceId)) {
            f.append(" and bean.product.commerceId=:commerceId");
            f.setParam("commerceId", commerceId);
        }
        f.append(" order by bean.id desc");
        return find(f);
    }

    public List<OrderRecoveryKV> getAllOrderRecoveryKeyValue(String dateStart,String dateEnd){
       /* String sql ="SELECT np.product_id,count(np.product_id),tap.inventory FROM n_order n,n_order_product np ,t_activity_product tap " +
                " where (n.created_date<='"+dateEnd+"' AND n.created_date>= '"+dateStart+"' )" +
                " and (n.payment_status = '"+PaymentStatusEnum.NotPay.name()+"' or n.payment_status = '"+PaymentStatusEnum.PayFailed.name()+"') and n.order_status !='"+OrderStatusEnum.Canceled.name()+"' and n.id = np.order_id and tap.id = np.product_id GROUP BY product_id;";
*/
        String sql = "select nop.product_id,count(nop.product_id),product.stock_count FROM n_order_product nop ,jc_shop_product product,n_order ord WHERE  " +
                " nop.product_id = product.product_id AND nop.order_id = ord.id and product.productStamp = '3' AND ord.order_status != 'Cancelled'  " +
                " AND (ord.pay_status ='"+PaymentStatusEnum.NotPay+"' or ord.pay_status ='"+PaymentStatusEnum.RefundSucceeded+"' or ord.pay_status ='"+PaymentStatusEnum.PayFailed+"')" +
                " AND (ord.create_time<='"+dateEnd+"' AND ord.create_time>= '"+dateStart+"' ) "+
                " AND ord.del = 0 "+
                " GROUP BY nop.product_id";

        Query query = baseDao.getSession().createSQLQuery(sql.toString());
        List<?> list = (List<?>)query.list();
        if(null==list || list.isEmpty() ){
            logger.info("getAllOrderRecoveryKeyValue size 0 or null = " + sql);
            return null;
        }

        logger.info("size["+list.size()+"]getAllOrderRecoveryKeyValue "+sql);

        List<OrderRecoveryKV> orderRecoveryKVs = new ArrayList<>();
        for (Object object: list){
            Object[] data = (Object[]) object;
            OrderRecoveryKV orderRecoveryKV = new OrderRecoveryKV();
            orderRecoveryKV.setActivityProductId(Long.parseLong(data[0].toString()));
            orderRecoveryKV.setRecoveryValue(Long.parseLong(data[1].toString()));
            orderRecoveryKV.setOriginalInventory(Long.parseLong(data[2].toString()));
            orderRecoveryKVs.add(orderRecoveryKV);
        }
        return orderRecoveryKVs;
    }

    public void recoveryInventoryForActivityProduct(List<OrderRecoveryKV> lists){
        StringBuffer updateInventorySql = new StringBuffer("UPDATE jc_shop_product tap SET tap.stock_count = CASE tap.product_id ");
        String ids ="";
        for (int i = 0; i < lists.size(); i++) {
            OrderRecoveryKV kv = lists.get(i);
            logger.info("inventory = "+kv.getOriginalInventory()+";recovery value = "+kv.getRecoveryValue());
            updateInventorySql.append(" WHEN '" + kv.getActivityProductId() + "' THEN " + (kv.getOriginalInventory() + kv.getRecoveryValue()) + " ");
            if (i == lists.size() - 1) {
                ids += "'" + kv.getActivityProductId() + "'";
            } else {
                ids += "'" + kv.getActivityProductId() + "',";
            }
        }
        updateInventorySql.append(" END WHERE tap.product_id in (" + ids + ")");
        Query query = baseDao.getSession().createSQLQuery(updateInventorySql.toString());
        int size = query.executeUpdate();
        logger.info("size:["+size+"],updateInventorySql = "+updateInventorySql);
    }

    public int updateOrderStatusToCanceled(String dateStart,String dateEnd){
        String sql ="update n_order n set n.order_status='"+OrderStatusEnum.Cancelled+"'" +
                " where (n.create_time<='"+dateEnd+"' AND n.create_time>= '"+dateStart+"' )" +
                " and (n.pay_status = '"+PaymentStatusEnum.NotPay+"' or n.pay_status = '"+PaymentStatusEnum.PayFailed+"' or n.pay_status = '"+PaymentStatusEnum.RefundSucceeded+"') " +
                " AND n.del = 0 "+
                " and n.order_status !='"+OrderStatusEnum.Cancelled+"';";
        Query query = baseDao.getSession().createSQLQuery(sql);
        int size = query.executeUpdate();
        logger.info("size:["+size+"], updateOrderStatusToCanceled sql = "+sql);
        return size;
    }

    @Override
    protected Class<OrderEntity> getEntityClass() {
        return null;
    }
}
