package com.ifunpay.portal.dao;

import com.ifunpay.portal.ProjectXml;
import com.ifunpay.portal.entity.OrderVoucher;
import com.ifunpay.portal.enums.VoucherStatus;
import com.ifunpay.portal.util.DESEncodeForString;
import com.jspgou.cms.dao.OrderDao;
import com.jspgou.cms.dao.SequenceDao;
import com.jspgou.cms.entity.Order;
import com.jspgou.cms.manager.OrderMng;
import com.jspgou.common.hibernate3.Finder;
import com.jspgou.common.page.Pagination;
import com.jspgou.common.web.session.SessionProvider;
import com.jspgou.core.entity.User;
import com.jspgou.core.manager.UserMng;
import org.apache.commons.lang.StringUtils;
import org.hibernate.Query;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import java.util.Date;
import java.util.List;

import static com.jspgou.core.web.Constants.SESSION_USER_ID_KEY;

/**
 * Created by Yu on 2014/12/8.
 */
@Service
public class NewOrderVoucherDao extends BaseDao {



    private Logger logger = LoggerFactory.getLogger(NewOrderVoucherDao.class);


    @Resource
    private OrderDao orderDao;

    @Resource
    private SequenceDao SequenceDao;

    @Resource
    private SessionProvider session;

    @Resource
    private UserMng userMng;




    @Transactional
    public OrderVoucher findOrderVoucherByVoucherCode(String orderId){
        OrderVoucher orderVoucher = new OrderVoucher();
        StringBuffer sb= new StringBuffer("from OrderVoucher ov where ov.code ='"+orderId+"'");
        Query query = getSession().createQuery(sb.toString());
        return (OrderVoucher) query.uniqueResult();
    }

    @Transactional
    public OrderVoucher findByVoucherCode(String voucherCode){
        OrderVoucher orderVoucher = new OrderVoucher();
        StringBuffer sb= new StringBuffer("from OrderVoucher ov where ov.voucherCode ='"+voucherCode+"' and ov.status ='"+VoucherStatus.NotUsed+"' ");
        Query query = getSession().createQuery(sb.toString());
        return (OrderVoucher) query.uniqueResult();
    }

    @Transactional
    public void updateOrderVoucher(OrderVoucher orderVoucher){
       try{
           update(orderVoucher);
       }catch (Exception e){
           logger.info( "更新失败",e);
       }

    }


    @Transactional
    public OrderVoucher findByVoucherCodeForAllStatus(String voucherCode){
        OrderVoucher orderVoucher = new OrderVoucher();
        StringBuffer sb= new StringBuffer("from OrderVoucher ov where ov.voucherCode ='"+voucherCode+"'");
        Query query = getSession().createQuery(sb.toString());
        return (OrderVoucher) query.uniqueResult();
    }


    @Transactional
    public java.util.List<OrderVoucher> findByAllVoucherCodeByTimeOrder(String voucherCode){
        OrderVoucher orderVoucher = new OrderVoucher();
        StringBuffer sb= new StringBuffer("from OrderVoucher ov where ov.voucherCode ='"+voucherCode+"' order by ov.sendTime desc");
        Query query = getSession().createQuery(sb.toString());
        return query.list();
    }

    public OrderVoucher findNotUserVoucherByVoucherCode(String code){
        StringBuffer sql = new StringBuffer("from OrderVoucher ov where ov.code ='"+code+"' and ov.status ='"+ VoucherStatus.NotUsed+"' ");
        return (OrderVoucher)getSession().createQuery(sql.toString()).uniqueResult();
    }

    /**
     * 验证凭证
     *
     */
    public boolean validateVoucherCodeForOrder(User user,String voucherCode){


        logger.info("user name=="+user.getUsername()+";user id = "+user.getId());
        logger.info("user storeFront name = "+user.getStoreFront());

        OrderVoucher orderVoucher = findByVoucherCode(voucherCode);
        if(orderVoucher !=null){
            logger.info("code == "+orderVoucher.getVoucherCode());
            orderVoucher.setStatus(VoucherStatus.Used);
            orderVoucher.setOperator(user.getUsername());
            orderVoucher.setStoreName(user.getStoreFront());
            orderVoucher.setUseTime(new Date());//使用时间
            updateOrderVoucher(orderVoucher);
            return true;
        }
        return false;
    }

    /**
     * 获取已消费的凭证
     *
     */
    @Transactional
    public OrderVoucher customerVoucher(String voucherCode){
        StringBuffer sql = new StringBuffer("from OrderVoucher where status='"+VoucherStatus.Used+"' and code ='"+voucherCode+"' ");
        return (OrderVoucher)getSession().createQuery(sql.toString()).uniqueResult();
    }

    public void updateVoucherStatusToUseless(String orderId){
        StringBuffer sql = new StringBuffer("update t_n_voucher n set n.STATUS ='"+VoucherStatus.Useless+"' where n.STATUS ='"+VoucherStatus.NotUsed+"' and n.order_number ='"+orderId+"' ");
        Query query = getSession().createSQLQuery(sql.toString());
        int size = query.executeUpdate();
        logger.info("sql="+sql.toString()+";updated size ="+size);
    }


    public List<OrderVoucher> getAllOrderVoucher(String recepPhone,String productName,String commerceName,String voucherCode ,String status,String code) {
        StringBuffer sb = new StringBuffer("from OrderVoucher voucher where 1=1 ");

        logger.info("order Id is " + code);

        if (!StringUtils.isBlank(code)) {
            sb.append(" and voucher.code like '%"+code+"%'");
        }

        if (!StringUtils.isBlank(voucherCode)) {
            sb.append(" and voucher.voucherCode like '%"+voucherCode+"%'");
        }

        if (!StringUtils.isBlank(recepPhone)) {
            sb.append(" and voucher.recepPhone like '%"+recepPhone+"%'");
        }

        if (!StringUtils.isBlank(commerceName)) {
            sb.append(" and voucher.commerceName like '%"+commerceName+"%'");
        }

        if (!StringUtils.isBlank(productName)) {
            sb.append(" and voucher.productName like '%"+productName+"%'");
        }


        if (!StringUtils.isBlank(status)) {
            sb.append(" and voucher.status='"+VoucherStatus.valueOf(status)+"'");
        }

      /*  f.append(" and bean.del=:del");
        f.setParam("del",0);*/

        sb.append(" order by voucher.id desc");

        Integer size = 1000;
        try {
            size = Integer.parseInt(ProjectXml.getValue("export_excel_max_row_size"));
        } catch (Exception e) {
            logger.error("", e);
        }

        return getSession().createQuery(sb.toString()).setFirstResult(0).setMaxResults(size).list();
    }

    /**
     * 修改凭证状态，发送凭证
     * @param orderVoucher
     * @param mobile
     * @param orderId
     *//*
    @Transactional
    public void updateOrderVoucherAndSendMsg(OrderVoucher orderVoucher ,String mobile,String orderId){
        orderVoucher.setSendMobile(mobile);
        orderVoucher.setSendTime(new Date());
        update(orderVoucher);


        List<OrderCertificate> certificates = orderCertificationDao.findCertificationByOrderId(orderId);

        if (certificates.size() > 0) {
            OrderCertificate orderCertificate = certificates.get(0);
            orderCertificate.setReceivedPhone(mobile);
            orderCertificate.setIssuedTime(new Date());//下发时间
            orderCertificate.setStatus("0");//未使用
            orderCertificate.setCreateTime(new Date());
            orderCertificationDao.update(orderCertificate);
        }


        threadPoolService.execute(new Runnable() {
            @Override
            public void run() {
                try {
                    String smsModel = pubMouldService.getPubMouldByCode("SMS_SEND_VOUCHER_SERVICE_TEXT_IFP");
                    Map<String, String> smsValue = new HashMap<>();
                    smsValue.put("product_name", orderVoucher.getProductName());
                    smsValue.put("start_date", orderVoucher.getStartTime().toString());
                    smsValue.put("voucher_code", orderVoucher.getVoucherCode());
                    smsValue.put("end_date", orderVoucher.getEndTime().toString());
                    String smsContent = FreemakerUtil.process(smsValue, smsModel);
                    SmsCenterResponse smsCenterResponse =  smsClient.sendMessage(mobile, smsContent);
                    if(smsCenterResponse.isSuccess()){
                        logger.info("send msg success");
                    }else {
                        logger.info("send msg error" + smsCenterResponse.getMessage());
                    }
                    logger.info("<========发送Voucher短信：" + smsContent + "==========>");
                } catch (Exception e) {
                    org.apache.woden.resolver.URIResolver s;
                    SecurityUtils.getSubject();
                }
            }
        });
    }*/

   }
