package com.ifunpay.portal.service;

import com.ifunpay.portal.dao.TerminalOrderDao;
import com.ifunpay.portal.entity.TerminalOrder;
import com.ifunpay.util.jackson.JsonUtil;
import org.apache.commons.io.IOUtils;
import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

/**
 * 
 * @author Xie Cong Long
 *
 */
@Service
public class TerminalOrderService {
	@Resource
	private TerminalOrderDao terminalOrderDao;

	private static final Logger log = Logger.getLogger(TerminalOrderService.class); 
	
	/**
	 * save Terminal Order
	 */
	@Transactional
	public void saveTerminalOrder(TerminalOrder terminalOrder){
		terminalOrderDao.save(terminalOrder);
	}
	
	/**
	 * find by order id
	 */
	@Transactional
	public List<TerminalOrder> findByTerminalOrder(String orderId){
		String hql="from TerminalOrder to where to.orderId='"+orderId+"'";
		Query query=terminalOrderDao.getSession().createQuery(hql);
		return query.list();
	}
	
	/** get order by value **/
	@SuppressWarnings("unchecked")
	public List<TerminalOrder> getByValue(String value) {
		try {
			String hqlStr = "from TerminalOrder TO where TO.value='"+value+"'";
			List<TerminalOrder> terminalOrders = terminalOrderDao.getSession().createQuery(hqlStr).list();
//			log.info("----- terminalOrders -----"+terminalOrders.size());
			return terminalOrders;
		} catch (Exception e) {
			log.error("-- 查找订单   "+value+" 失败---", e);
		}
		return null;
	}

    /**
     * 充值成功  在t_order 插入 年年卡方的  交易流水号
     * @param terminalOrder
     */
    @Transactional
    public void insert(TerminalOrder terminalOrder) {
        terminalOrderDao.save(terminalOrder);
    }


	/**
	 * 终端机出货反馈
	 */
//	public void deliverFeedback(String json){
//		Map<String, Object> result = new HashMap<>();
//		result.put("success", false);
//		try {
//			Map<String, Object> map = JsonUtil.toObject(json);
//			Map<String, Object> body = (Map<String, Object>) map.get("body");
//			String terminalId = (String) body.get("terminalId");
//			String serial = (String) body.get("serial");
//			Integer state = (Integer) body.get("state");
//			String errorMessage = (String) body.get("errorMessage");
//			OrderEntity orderEntity = orderDao.getOrderByTerminalSerial(terminalId, serial);
//			if (orderEntity == null) {
//				result.put("message", "no such order");
//			} else {
//				if (orderEntity.getShipStatus() == ShipmentStatusEnum.Received ) {
//					//ignore
//				} else {
//					if (state == 0) {
//						TerminalStorageRack terminalStorageRack = orderDao.getStorageRack(orderEntity);
//						if( terminalStorageRack == null){
//							logger.info("storage info: 没有库存信息 TERMINAL[" + terminalId + "], ORDER[" + orderEntity.getId() + "]");
//						}else{
//							int storage = terminalStorageRack.getCellStockCurrent();
//							if(storage <= 0){
//								logger.info("storage info: 库存量： " + storage);
//							}else{
//								terminalStorageRack.setCellStockCurrent(storage - 1);
//								logger.info("storage info: 库存量改为：" + (storage - 1));
//								orderDao.save(terminalStorageRack);
//							}
//						}
//						orderEntity.setShipStatus(ShipmentStatusEnum.Received);
//					}else {
//						orderEntity.setShipStatus(ShipmentStatusEnum.DeliverFailed);
//						orderEntity.setFeedbackMessage(errorMessage);
//					}
//					orderDao.save(orderEntity);
//				}
//				result.put("success", true);
//			}
//		} catch (Exception e) {
//			String message = e.getClass().getSimpleName() + ": " + e.getMessage();
//			result.put("message", message);
//		}
//		return result;
//	}
}
