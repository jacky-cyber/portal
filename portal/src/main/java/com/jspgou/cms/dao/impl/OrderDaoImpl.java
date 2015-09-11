package com.jspgou.cms.dao.impl;

import com.ifunpay.portal.ProjectXml;
import com.ifunpay.portal.enums.*;
import com.ifunpay.portal.util.SessionUtil;
import com.ifunpay.util.enums.OrderStatusEnum;
import com.ifunpay.util.enums.PayMethodEnum;
import com.ifunpay.util.enums.PaymentStatusEnum;
import com.ifunpay.util.enums.ShipmentStatusEnum;
import com.jspgou.cms.dao.OrderDao;
import com.jspgou.cms.entity.*;
import com.jspgou.common.hibernate3.Finder;
import com.jspgou.common.hibernate3.HibernateBaseDao;
import com.jspgou.common.hibernate3.SqlFinder;
import com.jspgou.common.page.Pagination;
import com.jspgou.common.web.session.SessionProvider;
import org.apache.commons.lang.StringUtils;
import org.hibernate.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * This class should preserve.
 * @preserve
 */
@Repository
public class OrderDaoImpl extends HibernateBaseDao<Order, Long> implements OrderDao {
    public Pagination getPageForMember(Long memberId, int pageNo, int pageSize) {//会员中心(我的王成订单)
        Finder f = Finder
                .create("from Order bean where bean.member.id=:memberId");
        f.setParam("memberId", memberId);
        f.append(" and bean.status=40");
        f.append(" order by bean.id desc");
        return find(f, pageNo, pageSize);
    }


    public Pagination getPageForOrderReturn(Long memberId, int pageNo, int pageSize) {//会员中心(退货订单)
        Finder f = Finder.create("from Order bean where bean.returnOrder.id is not null");
        if(memberId!=null){
            f.append(" and bean.member.id=:memberId");
            f.setParam("memberId", memberId);
        }
        f.append(" order by bean.id desc");
        return find(f, pageNo, pageSize);
    }


    public Pagination getPageForMember1(Long memberId, int pageNo, int pageSize) {//会员中心(我的待付款订单)
        Finder f = Finder
                .create("from Order bean where bean.member.id=:memberId");
        f.setParam("memberId", memberId);
        f.append(" and bean.status>=10 and bean.status<=19");
        f.append(" order by bean.id desc");
        return find(f, pageNo, pageSize);
    }
    public Pagination getPageForMember2(Long memberId, int pageNo, int pageSize) {//会员中心(我的处理中订单)
        Finder f = Finder
                .create("from Order bean where bean.member.id=:memberId");
        f.setParam("memberId", memberId);
        f.append(" and bean.status>=20 and bean.status<=29");
        f.append(" order by bean.id desc");
        return find(f, pageNo, pageSize);
    }

    public List<Order> getlist(Date endDate) {
        Finder f = Finder.create("from Order bean where bean.payment.type=1");
        f.append(" and bean.paymentStatus=:paymentStatus");
        f.append(" and bean.createTime<:endTime");
        f.append(" and (bean.status=:checking or bean.status=:checked)");
        f.setParam("checking", CHECKING);
        f.setParam("checked", CHECKED);
        f.setParam("endTime", endDate);
        f.setParam("paymentStatus", CHECKING);
        return find(f);
    }



    public Pagination getPageForMember3(Long memberId, int pageNo, int pageSize) {//会员中心(全部订单)
        Finder f = Finder
                .create("from Order bean where bean.member.id=:memberId");
        f.setParam("memberId", memberId);
        f.append(" order by bean.id desc");
        return find(f, pageNo, pageSize);
    }

    public Pagination getPageForNewOrder(Long channelId,Long commerceId,String code,String phone,String channelName,String commerceName,String productName,String startTime,String endTime,String payMethod,String paymentStatus,String shippingStatus,String status,int pageNo,int pageSize){


        StringBuffer sql = new StringBuffer("from OrderProduct bean where 1=1 and bean.entity.del =0");
        if (StringUtils.isNotBlank(code)) {
            sql.append(" and bean.entity.code like '%"+code+"%'");
        }
        if(StringUtils.isNotBlank(phone)){
            log.info("add phone condition ," + phone);
            sql.append(" and bean.entity.phone like '%" + phone + "%'");
        }

        if(StringUtils.isNotBlank(channelName)){
            sql.append(" and bean.entity.channelName like '%" + channelName + "%'");
        }
        if(channelId!=null){
            sql.append(" and bean.entity.channel.id = " + channelId + "");
        }
        if(StringUtils.isNotBlank(commerceName)){
            sql.append(" and bean.commerceName like '%" + commerceName + "%'");
        }
        if(commerceId!=null){
            sql.append(" and bean.commerce.id = " + commerceId + "");
        }
        if(StringUtils.isNotBlank(productName)){
            sql.append(" and bean.productName like '%" + productName + "%'");
        }
        if(StringUtils.isNotBlank(startTime)){
            sql.append(" and bean.entity.createTime >= '" + startTime + "'");
        }
        if(StringUtils.isNotBlank(endTime)){
            sql.append(" and bean.entity.createTime < '" + endTime + "'");
        }
        if(StringUtils.isNotBlank(payMethod)){
            sql.append(" and bean.entity.payMethod = '" + PayMethodEnum.valueOf(payMethod) + "'");
        }
        if(StringUtils.isNotBlank(shippingStatus)){
            sql.append(" and bean.entity.shipmentStatus = '" + ShipmentStatusEnum.valueOf(shippingStatus) + "'");
        }
        if(StringUtils.isNotBlank(paymentStatus)){
            sql.append(" and bean.entity.paymentStatus = '" + PaymentStatusEnum.valueOf(paymentStatus) + "'");
        }
        if(StringUtils.isNotBlank(status)){
            sql.append(" and bean.entity.status = '" + OrderStatusEnum.valueOf(status) + "'");
        }

        sql.append(" order by bean.entity.createTime desc");

        log.info("pagination Sql = " + sql.toString());

        Finder f = Finder.create(sql.toString());
        Pagination page = find(f, pageNo, pageSize);
        return page;
    }

    public Pagination getPage(String channelName,String commerceName,String phone,String channelId,String commerceId,Long webId,Long memberId,String productName, String userName,
                              Long paymentId, Long shippingId, Date startTime,Date endTime,
                              Double startOrderTotal,Double endOrderTotal,Integer status,Integer paymentStatus,Integer shippingStatus,String code,
                              int pageNo, int pageSize) {
        Finder f = Finder.create("from Order bean where 1=1 ");
        if(webId!=null){
           /* f.append(" and bean.website.id=:webId");
            f.setParam("webId", webId);*/
        }
        if(memberId!=null){
            f.append(" and bean.member.id=:memberId");
            f.setParam("memberId", memberId);
        }
        if (!StringUtils.isBlank(userName)) {
            f.append(" and bean.receiveName like:userName");
            f.setParam("userName", "%" + userName + "%");
        }
        if (!StringUtils.isBlank(channelId)) {
            f.append(" and bean.product.channelId =:channelId");
            f.setParam("channelId", channelId);
        }

        if (!StringUtils.isBlank(commerceId)) {
            f.append(" and bean.product.commerceId =:commerceId");
            f.setParam("commerceId", commerceId);
        }

        if (!StringUtils.isBlank(channelName)) {
            f.append(" and bean.product.channelName like:channelName");
            f.setParam("channelName", "%" + channelName + "%");
        }

        if (!StringUtils.isBlank(commerceName)) {
            f.append(" and bean.product.commerceName like:commerceName");
            f.setParam("commerceName", "%" + commerceName + "%");
        }

        if (!StringUtils.isBlank(productName)) {
            f.append(" and bean.productName like:productName");
            f.setParam("productName", "%" + productName + "%");
        }

        if(paymentId!=null){
            f.append(" and bean.payment.id=:paymentId");
            f.setParam("paymentId", paymentId);
        }
        if(shippingId!=null){
            f.append(" and bean.shipping.id=:shippingId");
            f.setParam("shippingId", shippingId);
        }
        if(startTime!=null){
            f.append(" and bean.createTime>:startTime");
            f.setParam("startTime", startTime);
        }
        if(endTime!=null){
            f.append(" and bean.createTime<:endTime");
            f.setParam("endTime", endTime);
        }
        if(startOrderTotal!=null){
            f.append(" and bean.total>=:startOrderTotal");
            f.setParam("startOrderTotal", startOrderTotal);
        }
        if(endOrderTotal!=null){
            f.append(" and bean.total<=:endOrderTotal");
            f.setParam("endOrderTotal", endOrderTotal);
        }
        if (status !=null ) {
            if(status == 5){
                f.append(" and (bean.status=:checking or bean.status=:checked)");
                f.append(" and bean.paymentStatus=:payment");
                f.setParam("checking", CHECKING);
                f.setParam("checked", CHECKED);
                f.setParam("payment", CHECKING);
            }else if(status==6){
                f.append(" and ((bean.payment.type=1 and bean.paymentStatus=:payment)or(bean.payment.type=2))");
                f.append(" and bean.status=:checked");
                f.append(" and bean.shippingStatus=:shipping");
                f.setParam("checked", CHECKED);
                f.setParam("shipping", CHECKING);
                f.setParam("payment", CHECKING);
            }else{
                f.append(" and bean.status=:status");
                f.setParam("status", status);
            }
        }
        if (paymentStatus !=null) {
            f.append(" and bean.paymentStatus=:paymentStatus");
            f.setParam("paymentStatus", paymentStatus);
        }
        if (shippingStatus !=null) {
            f.append(" and bean.shippingStatus=:shippingStatus");
            f.setParam("shippingStatus", shippingStatus);
        }
        if (!StringUtils.isBlank(code)) {
            f.append(" and bean.code like:code");
            f.setParam("code", "%" + code + "%");
        }
        if (!StringUtils.isBlank(phone)) {
            f.append(" and bean.receivePhone like:phone");
            f.setParam("phone", "%" + phone + "%");
        }

        f.append(" and bean.del=:del");
        f.setParam("del", 0);

        f.append(" order by bean.id desc");
        return find(f, pageNo, pageSize);
    }

    public java.util.List<Order> getAllOrderToExcel(String channelName,String commerceName,String name,String phone,String channelId,String commerceId,
                              Long paymentId,  Date startTime,Date endTime, Integer status,Integer paymentStatus,Integer shippingStatus,String code) {
        StringBuffer f = new StringBuffer("from Order bean where 1=1 ");


        if (!StringUtils.isBlank(channelId)) {
            f.append(" and bean.product.channelId ='" + channelId + "'");
        }

        if (!StringUtils.isBlank(commerceId)) {
            f.append(" and bean.product.commerceId = '" + commerceId + "'");
        }


        if(paymentId!=null){
            f.append(" and bean.payment.id= " + paymentId + "");
        }

        if(startTime!=null){
            f.append(" and bean.createTime> '" + startTime + "'");
        }
        if(endTime!=null){
            f.append(" and bean.createTime< '" + endTime + "'");
        }

        if (status !=null ) {
                f.append(" and bean.status= " + status + "");

        }
        if (paymentStatus !=null) {
            f.append(" and bean.paymentStatus= '" + paymentStatus + "'");
        }
        if (shippingStatus !=null) {
            f.append(" and bean.shippingStatus= '" + shippingStatus + "'");
        }
        if (!StringUtils.isBlank(code)) {
            f.append(" and bean.code like '%" + code + "%'");
        }
        if (!StringUtils.isBlank(commerceName)) {
            f.append(" and bean.product.commerceName like '%" + commerceName + "%'");
        }
        if (!StringUtils.isBlank(channelName)) {
            f.append(" and bean.product.channelName like '%" + channelName + "%'");
        }
        if (!StringUtils.isBlank(name)) {
            f.append(" and bean.product.name like '%" + name + "%'");
        }
        if (!StringUtils.isBlank(phone)) {
            f.append(" and bean.receivePhone like '%" + phone + "%'");
        }

        f.append(" and bean.del=0 ");

        f.append(" order by bean.id desc");

        Integer size = 1000;
        try {
            size = Integer.parseInt(ProjectXml.getValue("export_excel_max_row_size"));
        } catch (Exception e) {
            log.error("", e);
        }

        return getSession().createQuery(f.toString()).setMaxResults(size).list();
    }


    public Pagination getPageForVoucher(Long channelId,Long commerceId,String recepPhone,String productName,String commerceName,String voucherCode ,String status,String code, int pageNo, int pageSize) {
        Finder f = Finder.create("from OrderVoucher voucher where 1=1 ");

        log.info("order Id is "+code);

        if (!StringUtils.isBlank(code)) {
            f.append(" and voucher.code like:code");
            f.setParam("code", "%" + code + "%");
        }

        if (!StringUtils.isBlank(voucherCode)) {
            f.append(" and voucher.voucherCode like:voucherCode");
            f.setParam("voucherCode", "%" + voucherCode + "%");
        }

        if (!StringUtils.isBlank(recepPhone)) {
            f.append(" and voucher.recepPhone like:recepPhone");
            f.setParam("recepPhone", "%" + recepPhone + "%");
        }

        if (!StringUtils.isBlank(commerceName)) {
            f.append(" and voucher.commerceName like:commerceName");
            f.setParam("commerceName", "%" + commerceName + "%");
        }
        //TODO
        if(commerceId!=null){
            f.append(" and voucher.commerce.id =" + commerceId + "");
        }
        if(channelId!=null){
            f.append(" and voucher.channel.id ="+channelId+"");
        }

        if (!StringUtils.isBlank(productName)) {
            f.append(" and voucher.productName like:productName");
            f.setParam("productName", "%" + productName + "%");
        }


        if (!StringUtils.isBlank(status)) {
            f.append(" and voucher.status=:status");
            f.setParam("status", VoucherStatus.valueOf(status));
        }

      /*  f.append(" and bean.del=:del");
        f.setParam("del",0);*/

        f.append(" order by voucher.id desc");
        log.info("sql = "+f.toString());
        return find(f, pageNo, pageSize);
    }

    public Pagination getPage(Long webId,Long memberId,String productName, String userName,
                              Long paymentId, Long shippingId, Date startTime,Date endTime,
                              Double startOrderTotal,Double endOrderTotal,Integer status,Long code,
                              int pageNo, int pageSize) {
        Finder f = Finder.create("from Order bean where 1=1 ");
        if(webId!=null){
            f.append(" and bean.website.id=:webId");
            f.setParam("webId", webId);
        }
        if(memberId!=null){
            f.append(" and bean.member.id=:memberId");
            f.setParam("memberId", memberId);
        }
        if (!StringUtils.isBlank(userName)) {
            f.append(" and bean.receiveName like:userName");
            f.setParam("userName", "%"+userName+"%");
        }
        if (!StringUtils.isBlank(productName)) {
            f.append(" and bean.productName like:productName");
            f.setParam("productName", "%"+productName+"%");
        }
        if(paymentId!=null){
            f.append(" and bean.payment.id=:paymentId");
            f.setParam("paymentId", paymentId);
        }
        if(shippingId!=null){
            f.append(" and bean.shipping.id=:shippingId");
            f.setParam("shippingId", shippingId);
        }
        if(startTime!=null){
            f.append(" and bean.createTime>:startTime");
            f.setParam("startTime", startTime);
        }
        if(endTime!=null){
            f.append(" and bean.createTime<:endTime");
            f.setParam("endTime", endTime);
        }
        if(startOrderTotal!=null){
            f.append(" and bean.total>=:startOrderTotal");
            f.setParam("startOrderTotal", startOrderTotal);
        }
        if(endOrderTotal!=null){
            f.append(" and bean.total<=:endOrderTotal");
            f.setParam("endOrderTotal", endOrderTotal);
        }
        if (status !=null ) {
            if(status == 5){
                f.append(" and (bean.status=:checking or bean.status=:checked)");
                f.append(" and bean.paymentStatus=:payment");
                f.setParam("checking", CHECKING);
                f.setParam("checked", CHECKED);
                f.setParam("payment", CHECKING);
            }else if(status==6){
                f.append(" and (bean.status=:checking or bean.status=:checked)");
                f.append(" and bean.shippingStatus=:shipping");
                f.setParam("checking", CHECKING);
                f.setParam("checked", CHECKED);
                f.setParam("shipping", CHECKED);
            }else{
                f.append(" and bean.status=:status");
                f.setParam("status", status);
            }

        }
        if (code !=null) {
            f.append(" and bean.code=:code");
            f.setParam("code",code);
        }
        f.append(" order by bean.id desc");
        return find(f, pageNo, pageSize);
    }



    public List<Object> getTotlaOrder(HttpServletRequest request){//后台首页统计函数（wang ze wu）
        Long channelId = sessionUtil.getChannelId(request);
        Long commerceId = sessionUtil.getCommerceId(request);
        log.info("channelId = "+channelId+";commerceId = "+commerceId);
        List<Object> o=new ArrayList<Object>();
        StringBuffer totalOrderSB = new StringBuffer("select count(*) from OrderProduct bean where 1=1 and bean.entity.del =0");
        if (null != channelId) {
            totalOrderSB.append(" and bean.entity.channel.id ='"+channelId+"'");
        }
        if (null != commerceId) {
            totalOrderSB.append(" and bean.commerce.id ='"+commerceId+"'");
        }
        Long totalOrder=(Long)this.getSession().createQuery(totalOrderSB.toString()).uniqueResult();

        StringBuffer noCompleteOrderSB = new StringBuffer("select count(*) from OrderProduct bean where bean.entity.del =0 and bean.entity.status!='"+OrderStatusEnum.Finished+"' ");
        if (null != channelId) {
            noCompleteOrderSB.append(" and bean.entity.channel.id ='"+channelId+"'");
        }
        if (null != commerceId) {
            noCompleteOrderSB.append(" and bean.commerce.id ='"+commerceId+"'");
        }

        Long noCompleteOrder=(Long)this.getSession().createQuery(noCompleteOrderSB.toString()).uniqueResult();
        Calendar c=Calendar.getInstance();
        String month=(c.get(Calendar.MONTH)+1)+"";
        String year=c.get(Calendar.YEAR)+"";
        if(month.length()==1){
            month="0"+month;
        }else{
            month=month;
        }
        String str=year+"-"+month;

        StringBuffer thisMontyOrderSB = new StringBuffer("select count(*) from OrderProduct bean where bean.entity.createTime like :time  ");
        if (null != channelId) {
            thisMontyOrderSB.append(" and bean.entity.channel.id ='"+channelId+"'");
        }
        if (null != commerceId) {
            thisMontyOrderSB.append(" and bean.commerce.id ='"+commerceId+"'");
        }

        Long thisMontyOrder=(Long)this.getSession().createQuery(thisMontyOrderSB.toString()).setString("time", "%"+str+"%").uniqueResult();
        SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd");
        String tady=sf.format(new Date());


        StringBuffer todayOrderSB = new StringBuffer("select count(*) from OrderProduct bean where bean.entity.createTime like :tody  ");
        StringBuffer totalProductSB = new StringBuffer("select count(*) from Product bean where 1=1  ");
        StringBuffer newProductMonthSB = new StringBuffer("select count(*) from Product bean where bean.createTime like :time  ");
        StringBuffer dateProductSB = new StringBuffer("select count(*) from Product bean where bean.createTime like :time  ");
        StringBuffer putawayProductSB = new StringBuffer("select count(*) from Product bean where bean.onSale=true  ");
        if (null != channelId) {
            todayOrderSB.append(" and bean.entity.channel.id ='"+channelId+"'");
            totalProductSB.append(" and bean.channelId ='"+channelId+"'");
            newProductMonthSB.append(" and bean.channelId ='"+channelId+"'");
            dateProductSB.append(" and bean.channelId ='"+channelId+"'");
            putawayProductSB.append(" and bean.channelId ='"+channelId+"'");
        }
        if (null != commerceId) {
            todayOrderSB.append(" and bean.commerce.id ='"+commerceId+"'");
            totalProductSB.append(" and bean.commerceId ='"+commerceId+"'");
            newProductMonthSB.append(" and bean.commerceId ='"+commerceId+"'");
            dateProductSB.append(" and bean.commerceId ='"+commerceId+"'");
            putawayProductSB.append(" and bean.commerceId ='"+commerceId+"'");
        }


        Long todayOrder=(Long)this.getSession().createQuery(todayOrderSB.toString()).setString("tody", "%"+tady+"%").uniqueResult();
        Long totalProduct=(Long)this.getSession().createQuery(totalProductSB.toString()).uniqueResult();
        Long newProductMonth=(Long)this.getSession().createQuery(newProductMonthSB.toString()).setString("time", "%" + str+"%").uniqueResult();
        Long dateProduct=(Long)this.getSession().createQuery(dateProductSB.toString()).setString("time", "%" + tady+"%").uniqueResult();
        Long putawayProduct=(Long)this.getSession().createQuery(putawayProductSB.toString()).uniqueResult();


        StringBuffer totalMemberSB = new StringBuffer("select count(*) from ShopMember bean where 1=1  ");
       /* if (!StringUtils.isBlank(channelId)) {
            thisMontyOrderSB.append(" and bean.member.user.channelId ='"+channelId+"'");
        }
        if (!StringUtils.isBlank(commerceId)) {
            thisMontyOrderSB.append(" and bean.member.user.commerceId ='"+commerceId+"'");
        }*/

        Long totalMember=(Long)this.getSession().createQuery(totalMemberSB.toString()).uniqueResult();
        Long totalMonthMember=(Long)this.getSession().createQuery("select count(*) from Member bean where bean.createTime like :time").setString("time", "%"+str+"%").uniqueResult();
        Long totalDateMember=(Long)this.getSession().createQuery("select count(*) from Member bean where bean.createTime like :time").setString("time", "%"+tady+"%").uniqueResult();
        c.add(Calendar.DATE, -7);
        Date oldDate= c.getTime();
        Long date7Member=(Long)this.getSession().  createQuery("select count(*) from Member bean where bean.createTime >:time").setParameter("time", oldDate).uniqueResult();


        Long[] cc=new Long[12];
        cc[0]=totalOrder==null?0:totalOrder;
        cc[1]=noCompleteOrder==null?0:noCompleteOrder;
        cc[2]=thisMontyOrder==null?0:thisMontyOrder;
        cc[3]=todayOrder==null?0:todayOrder;

        cc[4]=totalProduct==null?0:totalProduct;
        cc[5]=newProductMonth==null?0:newProductMonth;
        cc[6]=dateProduct==null?0:dateProduct;


        cc[7]=totalMember==null?0:totalMember;
        cc[8]=totalMonthMember==null?0:totalMonthMember;
        cc[9]=totalDateMember==null?0:totalDateMember;
        cc[10]=date7Member==null?0:date7Member;
        cc[11]=putawayProduct==null?0:putawayProduct;

        o.add(cc);
        return o;
    }

    public BigDecimal getMemberMoneyByYear(Long memberId){//会员今年的消费(wang ze wu)
        Calendar c=Calendar.getInstance();
        String year=""+c.get(Calendar.YEAR);
        Query q=this.getSession().createQuery("select sum((bean.salePrice)* bean.count) from OrderItem bean" +
                " where bean.ordeR.member.id=:id and bean.ordeR.createTime like:time and bean.ordeR.status=4");
        q.setParameter("id", memberId).setString("time", "%"+year+"%");
        Double v1 =(Double) q.uniqueResult();
        if(v1==null){
            v1=0.0;
        }
        return new BigDecimal(v1);
    }

    public Integer[] getOrderByMember(Long memberId){//会员我的订单（完成，未完成）
        Long succOrder=(Long)this.getSession().createQuery("select count(*) from Order bean where bean.member.id=:id")
                .setParameter("id", memberId).uniqueResult();
        Long failOrder=(Long)this.getSession().createQuery("select count(*) from Order bean where bean.member.id=:id")
                .setParameter("id", memberId).uniqueResult();

        Long totalOrder=(Long)this.getSession().createQuery("select count(*) from Order bean where bean.member.id=:id")//全部订单
                .setParameter("id", memberId).uniqueResult();

        Long pendIngOrder=(Long)this.getSession().createQuery("select count(*) from Order bean where bean.member.id=:id")//待付款订单
                .setParameter("id", memberId).uniqueResult();

        Long proceOrder=(Long)this.getSession().createQuery("select count(*) from Order bean where bean.member.id=:id")//待处理订单
                .setParameter("id", memberId).uniqueResult();

        Integer[] orders = new Integer[5];
        orders[0] = succOrder.intValue();
        orders[1] = failOrder.intValue();//退回订单
        orders[2] = totalOrder.intValue();
        orders[3] = pendIngOrder.intValue();
        orders[4] = proceOrder.intValue();
        return orders;
    }

    public Pagination getOrderByReturn(Long memberId,Integer pageNo,Integer pageSize){//会员中心，退回订单
        Finder f = Finder.create("from Order bean where bean.member.id=:id and bean.status=41");
        f.setParam("id", memberId);
        return this.find(f, pageNo, pageSize);
    }

    public Order findById(Long id) {
        Order entity = get(id);
        return entity;
    }

    public Order save(Order bean) {
        getSession().save(bean);
        return bean;
    }

    public Order deleteById(Long id) {
        Order entity = super.get(id);
        if (entity != null) {
            getSession().delete(entity);
        }
        return entity;
    }

    public Order updateOrderDelStatus(Long id) {
        Order entity = super.get(id);
        entity.setDel(1);
        if (entity != null) {
            getSession().update(entity);
        }
        return entity;
    }

    @Transactional
    public void updateOrderEntity(Order order) {

        getSession().update(order);

    }

    /**
     * 获取渠道报表信息
     * @param name
     * @param startTime
     * @param endTime
     * @param pageNo
     * @param pageSize
     * @return
     */
    public Pagination getChannelReport(String name, Date startTime, Date endTime, int pageNo, int pageSize, Long channelId, Long commerceId) {
        String reportSql = buildChannelReportSql(name, startTime, endTime, channelId, commerceId);
        if (null == reportSql) {
            return new Pagination();
        }

        SqlFinder sqlFinder =  SqlFinder.create(reportSql);
        Pagination pagination = findBySql(sqlFinder, pageNo, pageSize);

        Pagination reportPage = new Pagination(pagination.getPageNo(), pagination.getPageSize(), pagination.getTotalCount());
        List list = pagination.getList();
        List<Settlement> settlements = new ArrayList<>();
        for (Object object: list) {
            Object[] data = (Object[]) object;
            Settlement settlement = new Settlement();
            settlement.setId(Integer.parseInt(data[0].toString()));
            settlement.setChannelName((String) data[1]);
            settlement.setTotalOrder(Integer.parseInt(data[2].toString()));
            settlement.setTotalSellAmount(new BigDecimal(data[3].toString()).setScale(2, BigDecimal.ROUND_UP));
            settlement.setTotalRefundAmount(new BigDecimal(data[4].toString()).setScale(2, BigDecimal.ROUND_UP));
            settlement.setTotalPaiedAmount(new BigDecimal(data[5].toString()).setScale(2, BigDecimal.ROUND_UP));
            settlements.add(settlement);
        }
        reportPage.setList(settlements);

        return reportPage;
    }

    /**
     * 获取商户报表数据
     * @param name
     * @param startTime
     * @param endTime
     * @param pageNo
     * @param pageSize
     * @return
     */
    public Pagination getCommerceReport(String name, String channelName, Date startTime, Date endTime, int pageNo, int pageSize, Long channelId, Long commerceId) {
        String reportSql = buildNewCommerceReport(name, channelName, startTime, endTime, channelId, commerceId);
        SqlFinder sqlFinder =  SqlFinder.create(reportSql);
        Pagination pagination = findBySql(sqlFinder, pageNo, pageSize);

        Pagination reportPage = new Pagination(pagination.getPageNo(), pagination.getPageSize(), pagination.getTotalCount());
        List list = pagination.getList();

        List<Settlement> settlements = new ArrayList<>();
        for (Object object: list) {
            Object[] data = (Object[]) object;
            Settlement settlement = new Settlement();
            settlement.setId(Integer.parseInt(data[0].toString()));
            settlement.setCommerceName((String) data[1]);
            settlement.setChannelName((String) data[2]);
            settlement.setTotalOrder(Integer.parseInt(data[3].toString()));
            settlement.setTotalSellAmount(new BigDecimal(data[4].toString()).setScale(2, BigDecimal.ROUND_UP));
            settlement.setTotalRefundAmount(new BigDecimal(data[5].toString()).setScale(2, BigDecimal.ROUND_UP));
            settlement.setTotalPaiedAmount(new BigDecimal(data[6].toString()).setScale(2, BigDecimal.ROUND_UP));
            settlements.add(settlement);
        }
        reportPage.setList(settlements);
        return reportPage;
    }

    private String buildChannelReportSql(String name, Date startTime, Date endTime, Long channelId, Long commerceId) {
        StringBuffer sqlStr = new StringBuffer("SELECT a.channel_id, a.channel_name, \n" +
                "(SUM(CASE a.pay_status WHEN 'PaySucceeded' THEN 1 ELSE 0 END) + SUM(CASE a.pay_status WHEN 'RefundSucceeded' THEN 1 ELSE 0 END)) totalOrder, \n" +
                "(SUM(CASE a.pay_status WHEN 'PaySucceeded' THEN a.total_amount ELSE 0 END) + SUM(CASE a.pay_status WHEN 'RefundSucceeded' THEN a.total_amount ELSE 0 END))/100 totalAmount, \n" +
                "(SUM(CASE a.pay_status WHEN 'RefundSucceeded' THEN a.total_amount ELSE 0 END))/100 returnAmount, \n" +
                "(SUM(CASE a.pay_status WHEN 'PaySucceeded' THEN a.total_amount ELSE 0 END))/100 paiedAmount \n" +
                "FROM n_order a, n_order_product b where a.id=b.order_id ");

        if (StringUtils.isNotBlank(name)) {
            sqlStr.append(" and a.channel_name like '%"+ name+"%'");
        }

        if (null != channelId){
            sqlStr.append(" and a.channel_id='" + channelId + "' ");
        }
        if (null != commerceId){
            sqlStr.append(" and b.commerce_id='" + commerceId + "' ");
        }

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        if (null != startTime && !("").equals(startTime)) {
            sqlStr.append(" and a.create_time>='"+sdf.format(startTime)+"'");
            if (null != endTime && !("").equals(endTime)) {
                sqlStr.append(" and a.create_time<='"+sdf.format(endTime)+"'");
            }
        } else {
            if (null != endTime && !("").equals(endTime)){
                sqlStr.append(" and a.create_time<='"+sdf.format(endTime)+"'");
            }
        }
        sqlStr.append(" GROUP BY a.channel_id order by a.channel_name desc");
        return sqlStr.toString();
    }

    private String buildCommerceReport(String name, Date startTime, Date endTime) {
        StringBuffer sqlStr = new StringBuffer("select b.commerceId, b.commerceName, count(a.order_id) totalOrder, " +
                "(SUM(CASE a.payment_status WHEN 2 THEN a.product_price ELSE 0 END) + SUM(CASE a.payment_status WHEN 3 THEN a.product_price ELSE 0 END)) totalSellAmount, " +
                "SUM(CASE a.payment_status WHEN 3 THEN a.product_price ELSE 0 END) totalRefundAmount, " +
                "SUM(CASE a.payment_status WHEN 2 THEN a.product_price ELSE 0 END) totalPaiedAmount " +
                "from jc_shop_order a, jc_shop_product b  " +
                "where a.product_id=b.product_id ");
        sqlStr.append("and a.payment_status in (2, 3) ");
//        sqlStr.append("and a.status=4 ");

        if (null != name && !("").equals(name)) {
            sqlStr.append(" and b.commerceName like '%"+ name+"%'");
        }

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        if (null != startTime && !("").equals(startTime)) {
            sqlStr.append(" and a.create_time>='"+sdf.format(startTime) + "'");
            if (null != endTime && !("").equals(endTime)) {
                sqlStr.append(" and a.create_time<='" + sdf.format(endTime) + "'");
            }
        } else if (null != endTime && !("").equals(endTime)) {
            sqlStr.append(" and a.create_time<='" + sdf.format(endTime) + "'");
        }
        sqlStr.append(" group by b.commerceId order by b.commerceName desc");
        return sqlStr.toString();
    }

    public List<Settlement> getChannelReport(String name, Date startTime, Date endTime, Long channelId, Long commerceId) {
        String reportSql = buildChannelReportSql(name, startTime, endTime, channelId, commerceId);
        List<Settlement> settlements = new ArrayList<>();
        if (null == reportSql) {
            return settlements;
        }

        Query query = this.getSession().createSQLQuery(reportSql);
        Integer size = 1000;
        try {
            size = Integer.parseInt(ProjectXml.getValue("export_excel_max_row_size"));
        } catch (Exception e) {
            log.error("", e);
        }
        query.setMaxResults(size);
        List<Settlement> list = query.list();
        for (Object object: list) {
            Object[] data = (Object[]) object;
            Settlement settlement = new Settlement();
            settlement.setId(Integer.parseInt(data[0].toString()));
            settlement.setChannelName((String) data[1]);
            settlement.setTotalOrder(Integer.parseInt(data[2].toString()));
            settlement.setTotalSellAmount(new BigDecimal(data[3].toString()).setScale(2, BigDecimal.ROUND_UP));
            settlement.setTotalRefundAmount(new BigDecimal(data[4].toString()).setScale(2, BigDecimal.ROUND_UP));
            settlement.setTotalPaiedAmount(new BigDecimal(data[5].toString()).setScale(2, BigDecimal.ROUND_UP));
            settlements.add(settlement);
        }
        return settlements;
    }

    public List<Settlement> getCommerceReport(String name, String channelName, Date startTime, Date endTime, Long channelId, Long commerceId) {
        String reportSql = buildNewCommerceReport(name, channelName, startTime, endTime, channelId, commerceId);
        List<Settlement> settlements = new ArrayList<>();
        if (null == reportSql) {
            return settlements;
        }

        Query query = this.getSession().createSQLQuery(reportSql);
        Integer size = 1000;
        try {
            size = Integer.parseInt(ProjectXml.getValue("export_excel_max_row_size"));
        } catch (Exception e) {
            log.error("", e);
        }
        query.setMaxResults(size);
        List<Settlement> list = query.list();
        for (Object object: list) {
            Object[] data = (Object[]) object;
            Settlement settlement = new Settlement();
            settlement.setId(Integer.parseInt(data[0].toString()));
            settlement.setCommerceName((String) data[1]);
            settlement.setChannelName((String) data[2]);
            settlement.setTotalOrder(Integer.parseInt(data[3].toString()));
            settlement.setTotalSellAmount(new BigDecimal(data[4].toString()).setScale(2, BigDecimal.ROUND_UP));
            settlement.setTotalRefundAmount(new BigDecimal(data[5].toString()).setScale(2, BigDecimal.ROUND_UP));
            settlement.setTotalPaiedAmount(new BigDecimal(data[6].toString()).setScale(2, BigDecimal.ROUND_UP));
            settlements.add(settlement);
        }
        return settlements;
    }

    private String buildNewCommerceReport(String name, String channelName, Date startTime, Date endTime, Long channelId, Long commerceId) {
        StringBuffer sqlStr = new StringBuffer("SELECT b.commerce_id, b.commerce_name, a.channel_name, \n" +
                "(SUM(CASE a.pay_status WHEN 'PaySucceeded' THEN 1 ELSE 0 END) + SUM(CASE a.pay_status WHEN 'RefundSucceeded' THEN 1 ELSE 0 END)) totalOrder, \n" +
                "(SUM(CASE a.pay_status WHEN 'PaySucceeded' THEN a.total_amount ELSE 0 END) + SUM(CASE a.pay_status WHEN 'RefundSucceeded' THEN a.total_amount ELSE 0 END))/100 totalAmount,  \n" +
                "(SUM(CASE a.pay_status WHEN 'RefundSucceeded' THEN a.total_amount ELSE 0 END))/100 returnAmount, \n" +
                "(SUM(CASE a.pay_status WHEN 'PaySucceeded' THEN a.total_amount ELSE 0 END))/100 paiedAmount \n" +
                "FROM n_order a, n_order_product b WHERE a.id=b.order_id \n");

        if (StringUtils.isNotBlank(name)) {
            sqlStr.append(" and b.commerce_name like '%"+ name +"%'");
        }

        if (StringUtils.isNotBlank(channelName)) {
            sqlStr.append(" and a.channel_name like '%"+ channelName +"%'");
        }

        if (null != channelId){
            sqlStr.append(" and a.channel_id='" + channelId + "' ");
        }
        if (null != commerceId){
            sqlStr.append(" and b.commerce_id='" + commerceId + "' ");
        }

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        if (null != startTime && !("").equals(startTime)) {
            sqlStr.append(" and a.create_time>='"+sdf.format(startTime) + "'");
            if (null != endTime && !("").equals(endTime)) {
                sqlStr.append(" and a.create_time<='" + sdf.format(endTime) + "'");
            }
        } else if (null != endTime && !("").equals(endTime)){
            sqlStr.append(" and a.create_time<='" + sdf.format(endTime) + "'");
        }
        sqlStr.append(" GROUP BY b.commerce_id ");
        sqlStr.append(" order by b.commerce_name desc");
        return sqlStr.toString();
    }

    /**
     * 获取商品报表信息(统计销售数量)
     * @param productName
     * @param commerceName
     * @param startTime
     * @param endTime
     * @param pageNo
     * @param pageSize
     * @return
     */
    public Pagination getProductReport(String productName, String commerceName, Date startTime, Date endTime, int pageNo, int pageSize, Long channelId, Long commerceId) {
        String reportSql = buildProductReportSql(productName, commerceName, startTime, endTime, channelId, commerceId);
        if (null == reportSql) {
            return new Pagination();
        }

        SqlFinder sqlFinder =  SqlFinder.create(reportSql);
        Pagination pagination = findBySql(sqlFinder, pageNo, pageSize);

        Pagination reportPage = new Pagination(pagination.getPageNo(), pagination.getPageSize(), pagination.getTotalCount());
        List list = pagination.getList();
        List<ProductReport> settlements = new ArrayList<>();
        for (Object object: list) {
            Object[] data = (Object[]) object;
            ProductReport productReport = new ProductReport();
            productReport.setCommerceName(data[0].toString());
            productReport.setProductName((String) data[1]);
            productReport.setTotalOrder(Integer.parseInt(data[2].toString()));
            productReport.setaShotToPay(Integer.parseInt(data[3].toString()));
            productReport.setFlashPay(Integer.parseInt(data[4].toString()));
            productReport.setInsertCard(Integer.parseInt(data[5].toString()));
            productReport.setQrCode(Integer.parseInt(data[6].toString()));
            settlements.add(productReport);
        }
        reportPage.setList(settlements);

        return reportPage;
    }

    public List<ProductReport> getProductReport(String productName, String commerceName, Date startTime, Date endTime, Long channelId, Long commerceId) {
        String reportSql = buildProductReportSql(productName, commerceName, startTime, endTime, channelId, commerceId);
        List<ProductReport> productReports = new ArrayList<>();
        if (null == reportSql) {
            return productReports;
        }

        Query query = this.getSession().createSQLQuery(reportSql);
        Integer size = 1000;
        try {
            size = Integer.parseInt(ProjectXml.getValue("export_excel_max_row_size"));
        } catch (Exception e) {
            log.error("", e);
        }
        query.setMaxResults(size);
        List<ProductReport> list = query.list();
        for (Object object: list) {
            Object[] data = (Object[]) object;
            ProductReport productReport = new ProductReport();
            productReport.setCommerceName(data[0].toString());
            productReport.setProductName((String) data[1]);
            productReport.setTotalOrder(Integer.parseInt(data[2].toString()));
            productReport.setaShotToPay(Integer.parseInt(data[3].toString()));
            productReport.setFlashPay(Integer.parseInt(data[4].toString()));
            productReport.setInsertCard(Integer.parseInt(data[5].toString()));
            productReport.setQrCode(Integer.parseInt(data[6].toString()));
            productReports.add(productReport);
        }
        return productReports;
    }

    private String buildProductReportSql(String productName, String commerceName, Date startTime, Date endTime, Long channelId, Long commerceId) {
        StringBuffer sqlStr = new StringBuffer("SELECT b.commerce_name, b.product_name, COUNT(a.id) totalOrder, \n" +
                "SUM(CASE a.pay_method WHEN 'AShotToPay' THEN 1 ELSE 0 END) 一拍支付, \n" +
                "SUM(CASE a.pay_method WHEN 'FlashPay' THEN 1 ELSE 0 END) 闪付, \n" +
                "SUM(CASE a.pay_method WHEN 'InsertCard' THEN 1 ELSE 0 END) 插卡支付, \n" +
                "SUM(CASE a.pay_method WHEN 'QrCode' THEN 1 ELSE 0 END) 二维码支付 \n" +
                "FROM n_order a, n_order_product b WHERE a.id=b.order_id AND a.pay_status IN ('PaySucceeded', 'RefundSucceeded') \n");
        if (StringUtils.isNotBlank(commerceName)) {
            sqlStr.append(" and b.commerce_name like '%"+ commerceName +"%'");
        }

        if (StringUtils.isNotBlank(productName)) {
            sqlStr.append(" and b.product_name like '%"+ productName +"%'");
        }

        if (null != channelId){
            sqlStr.append(" and a.channel_id='" + channelId + "' ");
        }

        if (null != commerceId){
            sqlStr.append(" and b.commerce_id='" + commerceId + "' ");
        }

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        if (null != startTime && !("").equals(startTime)) {
            sqlStr.append(" and a.create_time>='" + sdf.format(startTime) + "'");
            if (null != endTime && !("").equals(endTime)) {
                sqlStr.append(" and a.create_time<='" + sdf.format(endTime) + "'");
            }
        } else if (null != endTime && !("").equals(endTime)){
            sqlStr.append(" and a.create_time<='" + sdf.format(endTime) + "'");
        }
        sqlStr.append(" GROUP BY b.product_id order by b.commerce_name desc");
        return sqlStr.toString();
    }

    /**
     * 获取商品报表数据（统计销售金额）
     * @param productName
     * @param commerceName
     * @param startTime
     * @param endTime
     * @param pageNo
     * @param pageSize
     * @return
     */
    public Pagination getProductReportByRMB(String productName, String commerceName, Date startTime, Date endTime, int pageNo, int pageSize, Long channelId, Long commerceId) {
        String reportSql = buildProductReportByRMBSql(productName, commerceName, startTime, endTime, channelId, commerceId);
        if (null == reportSql) {
            return new Pagination();
        }

        SqlFinder sqlFinder =  SqlFinder.create(reportSql);
        Pagination pagination = findBySql(sqlFinder, pageNo, pageSize);

        Pagination reportPage = new Pagination(pagination.getPageNo(), pagination.getPageSize(), pagination.getTotalCount());
        List list = pagination.getList();
        List<ProductReportEntity> settlements = new ArrayList<>();
        for (Object object: list) {
            Object[] data = (Object[]) object;
            ProductReportEntity productReportEntity = new ProductReportEntity();
            productReportEntity.setCommerceName(data[0].toString());
            productReportEntity.setProductName((String) data[1]);
            productReportEntity.setTotalAmount((new BigDecimal(data[2].toString())).setScale(2, BigDecimal.ROUND_UP));
            productReportEntity.setaShotToPay((new BigDecimal((data[3].toString())).setScale(2, BigDecimal.ROUND_UP)));
            productReportEntity.setFlashPay((new BigDecimal((data[4].toString())).setScale(2, BigDecimal.ROUND_UP)));
            productReportEntity.setInsertCard((new BigDecimal(data[5].toString())).setScale(2, BigDecimal.ROUND_UP));
            productReportEntity.setQrCode((new BigDecimal(data[6].toString())).setScale(2, BigDecimal.ROUND_UP));
            settlements.add(productReportEntity);
        }
        reportPage.setList(settlements);

        return reportPage;
    }

    public List<ProductReportEntity> getProductReportByRMB(String productName, String commerceName, Date startTime, Date endTime, Long channelId, Long commerceId) {
        String reportSql = buildProductReportByRMBSql(productName, commerceName, startTime, endTime, channelId, commerceId);
        List<ProductReportEntity> productReportEntities = new ArrayList<>();
        if (null == reportSql) {
            return productReportEntities;
        }

        Query query = this.getSession().createSQLQuery(reportSql);
        Integer size = 1000;
        try {
            size = Integer.parseInt(ProjectXml.getValue("export_excel_max_row_size"));
        } catch (Exception e) {
            log.error("", e);
        }
        query.setMaxResults(size);
        List<ProductReportEntity> list = query.list();
        for (Object object: list) {
            Object[] data = (Object[]) object;
            ProductReportEntity productReportEntity = new ProductReportEntity();
            productReportEntity.setCommerceName(data[0].toString());
            productReportEntity.setProductName((String) data[1]);
            productReportEntity.setTotalAmount((new BigDecimal(data[2].toString())).setScale(2, BigDecimal.ROUND_UP));
            productReportEntity.setaShotToPay((new BigDecimal((data[3].toString())).setScale(2, BigDecimal.ROUND_UP)));
            productReportEntity.setFlashPay((new BigDecimal((data[4].toString())).setScale(2, BigDecimal.ROUND_UP)));
            productReportEntity.setInsertCard((new BigDecimal(data[5].toString())).setScale(2, BigDecimal.ROUND_UP));
            productReportEntity.setQrCode((new BigDecimal(data[6].toString())).setScale(2, BigDecimal.ROUND_UP));
            productReportEntities.add(productReportEntity);
        }
        return productReportEntities;
    }

    private String buildProductReportByRMBSql(String productName, String commerceName, Date startTime, Date endTime, Long channelId, Long commerceId) {
        StringBuffer sqlStr = new StringBuffer("SELECT b.commerce_name, b.product_name, SUM(a.total_amount)/100 totalOrder, \n" +
                "SUM(CASE a.pay_method WHEN 'AShotToPay' THEN a.total_amount ELSE 0 END)/100 一拍支付, \n" +
                "SUM(CASE a.pay_method WHEN 'FlashPay' THEN a.total_amount ELSE 0 END)/100 闪付, \n" +
                "SUM(CASE a.pay_method WHEN 'InsertCard' THEN a.total_amount ELSE 0 END)/100 插卡支付, \n" +
                "SUM(CASE a.pay_method WHEN 'QrCode' THEN a.total_amount ELSE 0 END)/100 二维码支付 \n" +
                "FROM n_order a, n_order_product b WHERE a.id=b.order_id AND a.pay_status IN ('PaySucceeded', 'RefundSucceeded') \n");
        if (StringUtils.isNotBlank(commerceName)) {
            sqlStr.append(" and b.commerce_name like '%"+ commerceName +"%'");
        }
        if (null != channelId){
            sqlStr.append(" and a.channel_id='" + channelId + "' ");
        }
        if (null != commerceId){
            sqlStr.append(" and b.commerce_id='" + commerceId + "' ");
        }
        if (StringUtils.isNotBlank(productName)) {
            sqlStr.append(" and b.product_name like '%"+ productName +"%'");
        }

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        if (null != startTime && !("").equals(startTime)) {
            sqlStr.append(" and a.create_time>='" + sdf.format(startTime) + "'");
            if (null != endTime && !("").equals(endTime)) {
                sqlStr.append(" and a.create_time<='" + sdf.format(endTime) + "'");
            }
        } else if (null != endTime && !("").equals(endTime)){
            sqlStr.append(" and a.create_time<='" + sdf.format(endTime) + "'");
        }
        sqlStr.append(" GROUP BY b.product_id order by b.commerce_name desc");
        return sqlStr.toString();
    }

    /**
     * 获取售货机报表数据（统计销售数量）
     * @param name
     * @param startTime
     * @param endTime
     * @param pageNo
     * @param pageSize
     * @return
     */
    public Pagination getVendorReport(String name, Date startTime, Date endTime, Long channelId, Long commerceId, int pageNo, int pageSize) {
        String reportSql = buildVendorReportSql(name, startTime, endTime, channelId, commerceId);
        if (null == reportSql) {
            return new Pagination();
        }
        SqlFinder sqlFinder =  SqlFinder.create(reportSql);
        Pagination pagination = findBySql(sqlFinder, pageNo, pageSize);

        Pagination reportPage = new Pagination(pagination.getPageNo(), pagination.getPageSize(), pagination.getTotalCount());
        List list = pagination.getList();
        List<VendorReport> vendorReports = new ArrayList<>();
        for (Object object: list) {
            Object[] data = (Object[]) object;
            VendorReport vendorReport = new VendorReport();
            vendorReport.setTerminalId((data[0].toString()));
            vendorReport.setTotalOrder(Integer.parseInt(data[1].toString()));
            vendorReport.setaShotToPay(Integer.parseInt(data[2].toString()));
            vendorReport.setFlashPay(Integer.parseInt(data[3].toString()));
            vendorReport.setInsertCard(Integer.parseInt(data[4].toString()));
            vendorReport.setQrCode(Integer.parseInt(data[5].toString()));
            vendorReports.add(vendorReport);
        }
        reportPage.setList(vendorReports);

        return reportPage;
    }

    public List<VendorReport> getVendorReport(String name, Date startTime, Date endTime, Long channelId, Long commerceId) {
        String reportSql = buildVendorReportSql(name, startTime, endTime, channelId, commerceId);
        List<VendorReport> vendorReports = new ArrayList<>();
        if (null == reportSql) {
            return vendorReports;
        }

        Query query = this.getSession().createSQLQuery(reportSql);
        Integer size = 1000;
        try {
            size = Integer.parseInt(ProjectXml.getValue("export_excel_max_row_size"));
        } catch (Exception e) {
            log.error("", e);
        }
        query.setMaxResults(size);
        List<VendorReport> list = query.list();
        for (Object object: list) {
            Object[] data = (Object[]) object;
            VendorReport vendorReport = new VendorReport();
            vendorReport.setTerminalId((data[0].toString()));
            vendorReport.setTotalOrder(Integer.parseInt(data[1].toString()));
            vendorReport.setaShotToPay(Integer.parseInt(data[2].toString()));
            vendorReport.setFlashPay(Integer.parseInt(data[3].toString()));
            vendorReport.setInsertCard(Integer.parseInt(data[4].toString()));
            vendorReport.setQrCode(Integer.parseInt(data[5].toString()));
            vendorReports.add(vendorReport);
        }
        return vendorReports;
    }

    private String buildVendorReportSql(String name, Date startTime, Date endTime, Long channelId, Long commerceId) {
        StringBuffer sqlStr = new StringBuffer("SELECT a.terminal_id, COUNT(a.id) totalOrder, \n" +
                "SUM(CASE a.pay_method WHEN 'AShotToPay' THEN 1 ELSE 0 END) 一拍支付, \n" +
                "SUM(CASE a.pay_method WHEN 'FlashPay' THEN 1 ELSE 0 END) 闪付, \n" +
                "SUM(CASE a.pay_method WHEN 'InsertCard' THEN 1 ELSE 0 END) 插卡支付, \n" +
                "SUM(CASE a.pay_method WHEN 'QrCode' THEN 1 ELSE 0 END) 二维码支付 \n" +
                "FROM n_order a, n_order_product b where a.id=b.order_id and a.pay_status IN ('PaySucceeded', 'RefundSucceeded') \n") ;

        if (StringUtils.isNotBlank(name)) {
            sqlStr.append(" AND a.terminal_id like'%"+ name+"%'");
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        if (null != startTime && !("").equals(startTime)) {
            sqlStr.append(" AND a.create_time>='"+ sdf.format(startTime)+"'");
            if (null != endTime && !("").equals(endTime)) {
                sqlStr.append(" AND a.create_time<='" + sdf.format(endTime) + "'");
            }
        } else if (null != endTime && !("").equals(endTime)){
            sqlStr.append(" AND a.create_time<='"+ sdf.format(endTime)+"'");
        }
        if (null != channelId){
            sqlStr.append(" and a.channel_id='" + channelId + "' ");
        }
        if (null != commerceId){
            sqlStr.append(" and b.commerce_id='" + commerceId + "' ");
        }
        sqlStr.append(" GROUP BY a.terminal_id ORDER BY a.terminal_id DESC");
        return sqlStr.toString();
    }

    /**
     * 获取售货机报表数据（统计销售金额）
     * @param name
     * @param startTime
     * @param endTime
     * @param pageNo
     * @param pageSize
     * @return
     */
    public Pagination getVendorReportByRMB(String name, Date startTime, Date endTime, int pageNo, int pageSize) {
        String reportSql = buildVendorReportByRMBSql(name, startTime, endTime);
        if (null == reportSql) {
            return new Pagination();
        }

        SqlFinder sqlFinder =  SqlFinder.create(reportSql);
        Pagination pagination = findBySql(sqlFinder, pageNo, pageSize);

        Pagination reportPage = new Pagination(pagination.getPageNo(), pagination.getPageSize(), pagination.getTotalCount());
        List list = pagination.getList();
        List<VendorReportEntity> vendorReportEntities = new ArrayList<>();
        for (Object object: list) {
            Object[] data = (Object[]) object;
            VendorReportEntity vendorReportEntity = new VendorReportEntity();
            vendorReportEntity.setTerminalId((String) data[0]);
            vendorReportEntity.setTotalAmount((new BigDecimal(data[1].toString())).setScale(2, BigDecimal.ROUND_UP));
            vendorReportEntity.setaShotToPay((new BigDecimal(data[2].toString())).setScale(2, BigDecimal.ROUND_UP));
            vendorReportEntity.setFlashPay((new BigDecimal(data[3].toString())).setScale(2, BigDecimal.ROUND_UP));
            vendorReportEntity.setInsertCard((new BigDecimal(data[4].toString())).setScale(2, BigDecimal.ROUND_UP));
            vendorReportEntity.setQrCode((new BigDecimal(data[5].toString())).setScale(2, BigDecimal.ROUND_UP));
            vendorReportEntities.add(vendorReportEntity);
        }
        reportPage.setList(vendorReportEntities);

        return reportPage;
    }

    public List<VendorReportEntity> getVendorReportByRMB(String name, Date startTime, Date endTime) {
        String reportSql = buildVendorReportByRMBSql(name, startTime, endTime);
        List<VendorReportEntity> vendorReportEntities = new ArrayList<>();
        if (null == reportSql) {
            return vendorReportEntities;
        }

        Query query = this.getSession().createSQLQuery(reportSql);
        Integer size = 1000;
        try {
            size = Integer.parseInt(ProjectXml.getValue("export_excel_max_row_size"));
        } catch (Exception e) {
            log.error("", e);
        }
        query.setMaxResults(size);
        List<VendorReportEntity> list = query.list();
        for (Object object: list) {
            Object[] data = (Object[]) object;
            VendorReportEntity vendorReportEntity = new VendorReportEntity();
            vendorReportEntity.setTerminalId((String) data[0]);
            vendorReportEntity.setTotalAmount((new BigDecimal(data[1].toString())).setScale(2, BigDecimal.ROUND_UP));
            vendorReportEntity.setaShotToPay((new BigDecimal(data[2].toString())).setScale(2, BigDecimal.ROUND_UP));
            vendorReportEntity.setFlashPay((new BigDecimal(data[3].toString())).setScale(2, BigDecimal.ROUND_UP));
            vendorReportEntity.setInsertCard((new BigDecimal(data[4].toString())).setScale(2, BigDecimal.ROUND_UP));
            vendorReportEntity.setQrCode((new BigDecimal(data[5].toString())).setScale(2, BigDecimal.ROUND_UP));
            vendorReportEntities.add(vendorReportEntity);
        }
        return vendorReportEntities;
    }

    private String buildVendorReportByRMBSql(String name, Date startTime, Date endTime) {
        StringBuffer sqlStr = new StringBuffer("SELECT a.terminal_id, SUM(a.total_amount)/100 totalOrder, \n" +
                "SUM(CASE a.pay_method WHEN 'AShotToPay' THEN a.total_amount ELSE 0 END)/100 一拍支付, \n" +
                "SUM(CASE a.pay_method WHEN 'FlashPay' THEN a.total_amount ELSE 0 END)/100 闪付, \n" +
                "SUM(CASE a.pay_method WHEN 'InsertCard' THEN a.total_amount ELSE 0 END)/100 插卡支付, \n" +
                "SUM(CASE a.pay_method WHEN 'QrCode' THEN a.total_amount ELSE 0 END)/100 二维码支付 \n" +
                "FROM n_order a WHERE a.pay_status IN ('PaySucceeded', 'RefundSucceeded') ");
        if (StringUtils.isNotBlank(name)) {
            sqlStr.append(" AND a.terminal_id like'%"+ name+"%'");
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        if (null != startTime && !("").equals(startTime)) {
            sqlStr.append(" AND a.create_time>='"+ sdf.format(startTime)+"'");
            if (null != endTime && !("").equals(endTime)) {
                sqlStr.append(" AND a.create_time<='" + sdf.format(endTime) + "'");
            }
        } else if (null != endTime && !("").equals(endTime)){
            sqlStr.append(" AND a.create_time<='"+ sdf.format(endTime)+"'");
        }
        sqlStr.append(" GROUP BY a.terminal_id ORDER BY a.terminal_id DESC");
        return sqlStr.toString();
    }

    /**
     * 获取商户各支付方式报表数据
     * @param name
     * @param startTime
     * @param endTime
     * @param pageNo
     * @param pageSize
     * @return
     */
    public Pagination getCommerceReportByPayMethodAmount(String name, Date startTime, Date endTime, int pageNo, int pageSize) {
        String reportSql = buildCommerceReportByMethodAmountSql(name, startTime, endTime);
        if (null == reportSql) {
            return new Pagination();
        }

        SqlFinder sqlFinder =  SqlFinder.create(reportSql);
        Pagination pagination = findBySql(sqlFinder, pageNo, pageSize);

        Pagination reportPage = new Pagination(pagination.getPageNo(), pagination.getPageSize(), pagination.getTotalCount());
        List list = pagination.getList();
        List<ReportByAmountEntity> reportByAmountEntities = new ArrayList<>();
        for (Object object: list) {
            Object[] data = (Object[]) object;
            ReportByAmountEntity reportByAmountEntity = new ReportByAmountEntity();
            reportByAmountEntity.setId((String) data[0]);
            reportByAmountEntity.setName((String) data[1]);
            reportByAmountEntity.setTotalAmount(Double.parseDouble(data[2].toString()));
            reportByAmountEntity.setScanPayAmount(Double.parseDouble(data[3].toString()));
            reportByAmountEntity.setQrPayAmount(Double.parseDouble(data[4].toString()));
            reportByAmountEntity.setUnionPayAmount(Double.parseDouble(data[5].toString()));
            reportByAmountEntity.setQuickPayAmount(Double.parseDouble(data[6].toString()));
            reportByAmountEntities.add(reportByAmountEntity);
        }
        reportPage.setList(reportByAmountEntities);

        return reportPage;
    }

    public List<ReportByAmountEntity> getCommerceReportByPayMethodAmount(String name, Date startTime, Date endTime) {
        String reportSql = buildCommerceReportByMethodAmountSql(name, startTime, endTime);
        List<ReportByAmountEntity> reportByAmountEntities = new ArrayList<>();
        if (null == reportSql) {
            return reportByAmountEntities;
        }

        Query query = this.getSession().createSQLQuery(reportSql);
        Integer size = 1000;
        try {
            size = Integer.parseInt(ProjectXml.getValue("export_excel_max_row_size"));
        } catch (Exception e) {
            log.error("", e);
        }
        query.setMaxResults(size);

        List<ReportByAmountEntity> list = query.list();
        for (Object object: list) {
            Object[] data = (Object[]) object;
            ReportByAmountEntity reportByAmountEntity = new ReportByAmountEntity();
            reportByAmountEntity.setId((String) data[0]);
            reportByAmountEntity.setName((String) data[1]);
            reportByAmountEntity.setTotalAmount(Double.parseDouble(data[2].toString()));
            reportByAmountEntity.setScanPayAmount(Double.parseDouble(data[3].toString()));
            reportByAmountEntity.setQrPayAmount(Double.parseDouble(data[4].toString()));
            reportByAmountEntity.setUnionPayAmount(Double.parseDouble(data[5].toString()));
            reportByAmountEntity.setQuickPayAmount(Double.parseDouble(data[6].toString()));
            reportByAmountEntities.add(reportByAmountEntity);
        }
        return reportByAmountEntities;
    }

    private String buildCommerceReportByMethodAmountSql(String name, Date startTime, Date endTime) {
        StringBuffer sqlStr = new StringBuffer("select b.commerceId, b.commerceName, sum(a.product_price) totalAmount, " +
                "(SUM(CASE c.name WHEN '一拍支付' THEN a.product_price ELSE 0 END)) scanPayAmount, " +
                "SUM(CASE c.name WHEN '小额支付' THEN a.product_price ELSE 0 END) qrPayAmount, " +
                "SUM(CASE c.name WHEN '银联支付' THEN a.product_price ELSE 0 END) unionPayAmount, " +
                "SUM(CASE c.name WHEN '闪付' THEN a.product_price ELSE 0 END) quickPayAmount " +
                "from jc_shop_order a, jc_shop_product b, jc_shop_payment c " +
                "where a.product_id=b.product_id AND a.payment_id=c.payment_id ");
        sqlStr.append("and a.payment_status in (2, 3) ");
//        sqlStr.append("and a.status=4 ");

        if (null != name && !("").equals(name)) {
            sqlStr.append(" and b.commerceName like '%"+ name+"%'");
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        if (null != startTime && !("").equals(startTime)) {
            sqlStr.append(" and a.create_time>='"+sdf.format(startTime)+"'");
            if (null != endTime && !("").equals(endTime)) {
                sqlStr.append(" and a.create_time<='" + sdf.format(endTime) +"'");
            }
        } else if (null != endTime && !("").equals(endTime)){
            sqlStr.append(" and a.create_time<='"+ sdf.format(endTime) +"'");
        }
        sqlStr.append(" group by b.commerceId order by b.commerceName desc");
        return sqlStr.toString();
    }

    /**
     * 获取商户四种支付方式支付的商品数量
     * @param name
     * @param startTime
     * @param endTime
     * @param pageNo
     * @param pageSize
     * @return
     */
    public Pagination getCommerceReportByPayMethod(String name, Date startTime, Date endTime, int pageNo, int pageSize) {
        String reportSql = buildCommerceReportByMethodSql(name, startTime, endTime);
        if (null == reportSql) {
            return new Pagination();
        }

        SqlFinder sqlFinder =  SqlFinder.create(reportSql);
        Pagination pagination = findBySql(sqlFinder, pageNo, pageSize);

        Pagination reportPage = new Pagination(pagination.getPageNo(), pagination.getPageSize(), pagination.getTotalCount());
        List list = pagination.getList();
        List<ReportEntity> reportByAmountEntities = new ArrayList<>();
        for (Object object: list) {
            Object[] data = (Object[]) object;
            ReportEntity reportEntity = new ReportEntity();
            reportEntity.setId((String) data[0]);
            reportEntity.setName((String) data[1]);
            reportEntity.setTotalAmount(Integer.parseInt(data[2].toString()));
            reportEntity.setScanPayAmount(Integer.parseInt(data[3].toString()));
            reportEntity.setQrPayAmount(Integer.parseInt(data[4].toString()));
            reportEntity.setUnionPayAmount(Integer.parseInt(data[5].toString()));
            reportEntity.setQuickPayAmount(Integer.parseInt(data[6].toString()));
            reportByAmountEntities.add(reportEntity);
        }
        reportPage.setList(reportByAmountEntities);

        return reportPage;
    }

    public List<ReportEntity> getCommerceReportByPayMethod(String name, Date startTime, Date endTime) {
        String reportSql = buildCommerceReportByMethodSql(name, startTime, endTime);
        List<ReportEntity> reportEntities = new ArrayList<>();
        if (null == reportSql) {
            return reportEntities;
        }

        Query query = this.getSession().createSQLQuery(reportSql);
        Integer size = 1000;
        try {
            size = Integer.parseInt(ProjectXml.getValue("export_excel_max_row_size"));
        } catch (Exception e) {
            log.error("", e);
        }
        query.setMaxResults(size);
        List<ReportByAmountEntity> list = query.list();
        for (Object object: list) {
            Object[] data = (Object[]) object;
            ReportEntity reportEntity = new ReportEntity();
            reportEntity.setId((String) data[0]);
            reportEntity.setName((String) data[1]);
            reportEntity.setTotalAmount(Integer.parseInt(data[2].toString()));
            reportEntity.setScanPayAmount(Integer.parseInt(data[3].toString()));
            reportEntity.setQrPayAmount(Integer.parseInt(data[4].toString()));
            reportEntity.setUnionPayAmount(Integer.parseInt(data[5].toString()));
            reportEntity.setQuickPayAmount(Integer.parseInt(data[6].toString()));
            reportEntities.add(reportEntity);
        }
        return reportEntities;
    }

    private String buildCommerceReportByMethodSql(String name, Date startTime, Date endTime) {
        StringBuffer sqlStr = new StringBuffer("select b.commerceId, b.commerceName, sum(c.count) totalAmount, " +
                "SUM(CASE d.name WHEN '一拍支付' THEN c.COUNT ELSE 0 END) scanPayAmount, " +
                "SUM(CASE d.name WHEN '小额支付' THEN c.COUNT ELSE 0 END) qrPayAmount, " +
                "SUM(CASE d.name WHEN '银联支付' THEN c.COUNT ELSE 0 END) unionPayAmount, " +
                "SUM(CASE d.name WHEN '闪付' THEN c.COUNT ELSE 0 END) quickPayAmount " +
                "from jc_shop_order a, jc_shop_product b, jc_shop_order_item c, jc_shop_payment d " +
                "WHERE a.product_id=b.product_id AND a.order_id=c.order_id AND a.payment_id=d.payment_id ");
        sqlStr.append("and a.payment_status in (2, 3) ");
//        sqlStr.append("and a.status=4");

        if (null != name && !("").equals(name)) {
            sqlStr.append(" and b.commerceName like '%"+ name+"%'");
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        if (null != startTime && !("").equals(startTime)) {
            sqlStr.append(" and a.create_time>='"+ sdf.format(startTime) +"'");
            if (null != endTime && !("").equals(endTime)) {
                sqlStr.append(" and a.create_time<='" + sdf.format(endTime) +"'");
            }
        } else if (null != endTime && !("").equals(endTime)){
            sqlStr.append(" and a.create_time<='"+ sdf.format(endTime) +"'");
        }
        sqlStr.append(" group by b.commerceId order by b.commerceName desc");
        return sqlStr.toString();
    }

    @Override
    public Order findByCode(String code) {
        Query query = this.getSession().createQuery("from Order order where order.code=:code");
        query.setParameter("code", code);
        return (Order)query.uniqueResult();
    }

    public Order findByTerminalNoAndSerialNo(String terminalNo,String serialNo) {
        StringBuffer sb = new StringBuffer("from Order order where 1=1 ");
        if (!StringUtils.isBlank(terminalNo)) {
            sb.append(" and order.terminalId='" + terminalNo + "'");
        }
        if (!StringUtils.isBlank(serialNo)) {
            sb.append(" and order.serialNo='" + serialNo + "'");
        }
        Query query = this.getSession().createQuery(sb.toString());
        return (Order)query.uniqueResult();
    }


    public List<Order> getlistByCommerceAndmember(String commerceId, Long memberId) {
        Finder f = Finder
                .create("from Order bean where 1=1 ");
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

    public List<Order> getOrderListByIdAndPhone(String orderId,String commerceName,int start,int size){
        Finder f = Finder.create("from Order bean where 1=1 ");
        if (!StringUtils.isBlank(orderId)) {
            f.append("and bean.code like '%" + orderId + "%' ");
        }

        if (!StringUtils.isBlank(commerceName)) {
            f.append("and bean.product.commerceName like '%" + commerceName + "%' ");
        }
       if(start>0){
            f.setFirstResult(start);
        }else{
            f.setFirstResult(0);//default value
        }
        if(size>0){
            f.setMaxResults(size);
        }else {
            f.setMaxResults(50);//default value
        }

        return find(f);
    }


    public boolean isConsumeForVoucher(String code){
        StringBuffer sql = new StringBuffer("from OrderVoucher vou where vou.code ='"+code+"' and vou.status = 'Used' ");
        Query query = this.getSession().createQuery(sql.toString());
        return query.list().size()>0?true:false;
    }

    @Override
    public Integer getOrderCount(Long productId, Long mobile,String cookieId, Date newStart) {
        int count = 0;
        if(null != mobile || null != cookieId) {
            StringBuffer sql = new StringBuffer("select op.orderNumber from OrderProduct op where op.product.id ='" + productId + "' ");
            Query query1 = this.getSession().createQuery(sql.toString());
            List<String> orderN = query1.list();
            if (query1.list().size() > 0) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                StringBuffer f = new StringBuffer("select count(*)  from OrderEntity bean where 1=1 ");
                f.append(" and bean.paymentStatus = '" + PaymentStatusEnum.valueOf("PaySucceeded") + "'");
                f.append("and bean.code  in (:orderList) ");
                if (mobile != null) {
                    f.append("and bean.memberUserEntity.phone  = '" + mobile + "' ");
                }
                if (cookieId != null) {
                    f.append("and bean.deviceName  = '" + cookieId + "' ");
                }
                if (newStart != null) {
                    f.append("and bean.createTime  >='" + sdf.format(newStart) + "' ");
                }
                Query query = getSession().createQuery(f.toString());
                query.setParameterList("orderList", orderN);
                count = ((Long) query.iterate().next()).intValue();
            }
        }
        return count;
    }

    /**
     * get merchant's product details
     * @param commerceId
     * @param commerceName
     * @param channelName
     * @param startTime
     * @param endTime
     * @param pageNo
     * @param pageSize
     * @return
     */
    @Override
    public Pagination getCommerceReportDetails(Long commerceId, String commerceName, String channelName, Date startTime, Date endTime, int pageNo, int pageSize, Long channelId) {
        String sql = buildCommerceReportDetailsSql(commerceName, channelName, startTime, endTime, commerceId, channelId);
        SqlFinder sqlFinder =  SqlFinder.create(sql);
        Pagination pagination = findBySql(sqlFinder, pageNo, pageSize);

        Pagination reportPage = new Pagination(pagination.getPageNo(), pagination.getPageSize(), pagination.getTotalCount());
        List list = pagination.getList();
        List<ProductReportDetail> commerceReportDetails = new ArrayList<>();
        for (Object object: list) {
            Object[] data = (Object[]) object;
            ProductReportDetail commerceReportDetail= new ProductReportDetail();
            commerceReportDetail.setCommerceId(Integer.parseInt(data[0].toString()));
            commerceReportDetail.setCommerceName((String) data[1]);
            commerceReportDetail.setProductId(Integer.parseInt(data[2].toString()));
            commerceReportDetail.setProductName(data[3].toString());
            commerceReportDetail.setPrice((new BigDecimal(data[4].toString())).setScale(2, BigDecimal.ROUND_UP));
            commerceReportDetail.setSell(Integer.parseInt(data[5].toString()));
            commerceReportDetail.setRefund(Integer.parseInt(data[6].toString()));
            commerceReportDetail.setOrder(Integer.parseInt(data[7].toString()));
            commerceReportDetail.setUsed(Integer.parseInt(data[8].toString()));
            commerceReportDetail.setUsedAmount((new BigDecimal(data[9].toString())).setScale(2, BigDecimal.ROUND_UP));
            commerceReportDetail.setReceivedAmount((new BigDecimal(data[10].toString())).setScale(2, BigDecimal.ROUND_UP));
            commerceReportDetail.setRefundAmount((new BigDecimal(data[11].toString())).setScale(2, BigDecimal.ROUND_UP));
            commerceReportDetail.setRealReceivedAmount((new BigDecimal(data[12].toString())).setScale(2, BigDecimal.ROUND_UP));
            commerceReportDetails.add(commerceReportDetail);
        }
        reportPage.setList(commerceReportDetails);

        return reportPage;
    }

    @Override
    public List<ProductReportDetail> getCommerceReportDetails(String commerceName, String channelName, Date startTime,
                                                              Date endTime, Long channelId, Long commerceId) {
        String sql = buildCommerceReportDetailsSql(commerceName, channelName, startTime, endTime, commerceId, channelId);

        Query query = this.getSession().createSQLQuery(sql);
        Integer size = 1000;
        try {
            size = Integer.parseInt(ProjectXml.getValue("export_excel_max_row_size"));
        } catch (Exception e) {
            log.error("", e);
        }
        query.setMaxResults(size);
        List<ProductReportDetail> commerceReportDetails = new ArrayList<>();
        for (Object object: query.list()) {
            Object[] data = (Object[]) object;
            ProductReportDetail commerceReportDetail= new ProductReportDetail();
            commerceReportDetail.setCommerceId(Integer.parseInt(data[0].toString()));
            commerceReportDetail.setCommerceName((String) data[1]);
            commerceReportDetail.setProductId(Integer.parseInt(data[2].toString()));
            commerceReportDetail.setProductName(data[3].toString());
            commerceReportDetail.setPrice((new BigDecimal(data[4].toString())).setScale(2, BigDecimal.ROUND_UP));
            commerceReportDetail.setSell(Integer.parseInt(data[5].toString()));
            commerceReportDetail.setRefund(Integer.parseInt(data[6].toString()));
            commerceReportDetail.setOrder(Integer.parseInt(data[7].toString()));
            commerceReportDetail.setUsed(Integer.parseInt(data[8].toString()));
            commerceReportDetail.setUsedAmount((new BigDecimal(data[9].toString())).setScale(2, BigDecimal.ROUND_UP));
            commerceReportDetail.setReceivedAmount((new BigDecimal(data[10].toString())).setScale(2, BigDecimal.ROUND_UP));
            commerceReportDetail.setRefundAmount((new BigDecimal(data[11].toString())).setScale(2, BigDecimal.ROUND_UP));
            commerceReportDetail.setRealReceivedAmount((new BigDecimal(data[12].toString())).setScale(2, BigDecimal.ROUND_UP));
            commerceReportDetails.add(commerceReportDetail);
        }

        return commerceReportDetails;
    }

    private String buildCommerceReportDetailsSql(String commerceName, String channelName, Date startTime, Date endTime, Long commerceId, Long channelId) {
        StringBuffer sql = new StringBuffer();
        sql.append("SELECT base.commerceId commerceId, base.commerceName commerceName, base.productId productId, base.productName productName, base.price/100 price, \n" +
                "base.sell sell, base.refund refund, base.totalOrder totalOrder, if(ex.used is null, 0, ex.used) used, \n" +
                "if(ex.usedAmount is null, 0, ex.usedAmount) useAmount, base.receivedAmount receivedAmount, \n" +
                "base.refundAmount refundAmount, base.realReceivedAmount FROM \n" +
                "(SELECT b.commerce_id commerceId, b.commerce_name commerceName, b.product_id productId, b.product_name productName, b.product_price price, \n" +
                "(SUM(CASE a.pay_status WHEN 'PaySucceeded' THEN 1 else 0 END) + SUM(CASE a.pay_status WHEN 'RefundSucceeded' THEN 1 else 0 END)) sell,\n" +
                "(SUM(CASE a.pay_status WHEN 'RefundSucceeded' THEN 1 else 0 END)) refund,\n" +
                "(SUM(CASE a.pay_status WHEN 'PaySucceeded' THEN 1 else 0 END) + SUM(CASE a.pay_status WHEN 'RefundSucceeded' THEN 1 else 0 END)) totalOrder, \n" +
                "(SUM(CASE a.pay_status WHEN 'PaySucceeded' THEN (a.total_amount) else 0 END) + SUM(CASE a.pay_status WHEN 'RefundSucceeded' THEN (a.total_amount) else 0 END))/100 receivedAmount,\n" +
                "(SUM(CASE a.pay_status WHEN 'RefundSucceeded' THEN (a.total_amount) else 0 END))/100 refundAmount,\n" +
                "(SUM(CASE a.pay_status WHEN 'PaySucceeded' THEN (a.total_amount) else 0 END))/100 realReceivedAmount \n" +
                "FROM n_order a, n_order_product b where a.id=b.order_id AND a.pay_status in ('PaySucceeded', 'RefundSucceeded') \n");
        if (null != startTime && !("").equals(startTime)){
            sql.append("and a.create_time>='" + startTime + "' ");
        }
        if (null != endTime && !("").equals(endTime)){
            sql.append("and a.create_time<='" + endTime + "' ");
        }
        if (StringUtils.isNotBlank(channelName)){
            sql.append("and a.channel_name like '%" + channelName + "%' ");
        }
        if (null != channelId){
            sql.append("and a.channel_id='" + channelId + "' ");
        }

        sql.append(" GROUP BY b.commerce_id, b.product_id, b.product_price \n");
        sql.append("Having 1=1 ");
        if (null != commerceId){
            sql.append("AND commerceId='" + commerceId + "' " );
        }
        if (StringUtils.isNotBlank(commerceName)){
            sql.append("AND commerceName like '%" + commerceName + "%' " );
        }
        sql.append(") base LEFT JOIN ");
        sql.append("(SELECT b.commerce_id commerceId, b.commerce_name commerceName, b.product_id productId, b.product_name productName, \n" +
                "b.product_price price, SUM(CASE c.status WHEN 1 THEN 1 ELSE 0 END) used, (SUM(CASE c.status WHEN 1 THEN (a.total_amount) ELSE 0 END))/100 usedAmount\n" +
                "FROM n_order a, n_order_product b, t_n_voucher c WHERE a.id=b.order_id AND a.order_id=c.order_number AND a.pay_status in ('PaySucceeded', 'RefundSucceeded') \n");
        if (null != startTime && !("").equals(startTime)){
            sql.append("and c.use_time>='" + startTime + "' ");
        }
        if (null != endTime && !("").equals(endTime)){
            sql.append("and c.use_time<='" + endTime + "' ");
        }
        if (StringUtils.isNotBlank(channelName)){
            sql.append("and a.channel_name like '%" + channelName + "%' ");
        }
        if (null != channelId){
            sql.append("and a.channel_id='" + channelId + "' ");
        }
        sql.append(" GROUP BY b.commerce_id, b.product_id, b.product_price \n");
        sql.append("Having 1=1 ");
        if (null != commerceId){
            sql.append("AND commerceId='" + commerceId + "' " );
        }
        if (StringUtils.isNotBlank(commerceName)){
            sql.append("AND commerceName like '%" + commerceName + "%' " );
        }
        sql.append(") ex ON base.commerceId=ex.commerceId AND base.productId=ex.productId AND base.price=ex.price \n");
        sql.append("UNION ");
        sql.append("SELECT ex2.commerceId commerceId, ex2.commerceName commerceName, ex2.productId productId, ex2.productName productName, ex2.price/100 price,\n" +
                "if(base2.sell is null, 0, base2.sell) sell, if(base2.refund is null, 0, base2.refund) refund, if(base2.totalOrder is null, 0, base2.totalOrder) totalOrder, \n" +
                "if(ex2.used is null, 0, ex2.used) used, if(ex2.usedAmount is null, 0, ex2.usedAmount) useAmount, if(base2.receivedAmount is null, 0, base2.receivedAmount) receivedAmount, \n" +
                "if(base2.refundAmount is null, 0, base2.refundAmount) refundAmount, if(base2.realReceivedAmount is null, 0, base2.realReceivedAmount) \n" +
                "FROM \n" +
                "(SELECT b.commerce_id commerceId, b.commerce_name commerceName, b.product_id productId, b.product_name productName, b.product_price price, \n" +
                "(SUM(CASE a.pay_status WHEN 'PaySucceeded' THEN 1 else 0 END) + SUM(CASE a.pay_status WHEN 'RefundSucceeded' THEN 1 else 0 END)) sell,\n" +
                "(SUM(CASE a.pay_status WHEN 'RefundSucceeded' THEN 1 else 0 END)) refund,\n" +
                "(SUM(CASE a.pay_status WHEN 'PaySucceeded' THEN 1 else 0 END) + SUM(CASE a.pay_status WHEN 'RefundSucceeded' THEN 1 else 0 END)) totalOrder, \n" +
                "(SUM(CASE a.pay_status WHEN 'PaySucceeded' THEN (a.total_amount) else 0 END) + " +
                "SUM(CASE a.pay_status WHEN 'RefundSucceeded' THEN (a.total_amount) else 0 END))/100 receivedAmount,\n" +
                "(SUM(CASE a.pay_status WHEN 'RefundSucceeded' THEN (a.total_amount) else 0 END))/100 refundAmount,\n" +
                "(SUM(CASE a.pay_status WHEN 'PaySucceeded' THEN (a.total_amount) else 0 END))/100 realReceivedAmount \n" +
                "FROM n_order a, n_order_product b where a.id=b.order_id AND a.pay_status in ('PaySucceeded', 'RefundSucceeded') \n");
        if (null != startTime && !("").equals(startTime)){
            sql.append("and a.create_time>='" + startTime + "' ");
        }
        if (null != endTime && !("").equals(endTime)){
            sql.append("and a.create_time<='" + endTime + "' ");
        }
        if (StringUtils.isNotBlank(channelName)){
            sql.append("and a.channel_name like '%" + channelName + "%' ");
        }
        if (null != channelId){
            sql.append("and a.channel_id='" + channelId + "' ");
        }
        sql.append(" GROUP BY b.commerce_id, b.product_id, b.product_price \n");
        sql.append("Having 1=1 ");
        if (null != commerceId){
            sql.append("AND commerceId='" + commerceId + "' " );
        }
        if (StringUtils.isNotBlank(commerceName)){
            sql.append("AND commerceName like '%" + commerceName + "%' " );
        }
        sql.append(") base2 RIGHT JOIN ");
        sql.append("(SELECT b.commerce_id commerceId, b.commerce_name commerceName, b.product_id productId, b.product_name productName, \n" +
                "b.product_price price, SUM(CASE c.status WHEN 1 THEN 1 ELSE 0 END) used, (SUM(CASE c.status WHEN 1 THEN (a.total_amount) ELSE 0 END))/100 usedAmount \n" +
                "FROM n_order a, n_order_product b, t_n_voucher c WHERE a.id=b.order_id AND a.order_id=c.order_number AND a.pay_status in ('PaySucceeded', 'RefundSucceeded') \n");
        if (null != startTime && !("").equals(startTime)){
            sql.append("and c.use_time>='" + startTime + "' ");
        }
        if (null != endTime && !("").equals(endTime)){
            sql.append("and c.use_time<='" + endTime + "' ");
        }
        if (StringUtils.isNotBlank(channelName)){
            sql.append("and a.channel_name like '%" + channelName + "%' ");
        }
        if (null != channelId){
            sql.append("and a.channel_id='" + channelId + "' ");
        }
        sql.append(" GROUP BY b.commerce_id, b.product_id, b.product_price \n");
        sql.append("Having 1=1 ");
        if (null != commerceId){
            sql.append("AND commerceId='" + commerceId + "' " );
        }
        if (StringUtils.isNotBlank(commerceName)){
            sql.append("AND commerceName like '%" + commerceName + "%' " );
        }
        sql.append(") ex2 ON base2.commerceId=ex2.commerceId AND base2.productId=ex2.productId AND base2.price=ex2.price ");
        return sql.toString();
    }

    @Override
    public Pagination getAccountReport(String account, Date startTime, Date endTime, int pageNo, int pageSize) {
        StringBuffer sql = new StringBuffer();
        sql.append("SELECT a.account_number, DATE_FORMAT(a.pay_time,'%Y-%m-%d') day, sum(a.amount)/100 \n" +
                "FROM n_order_pay_refund a where a.pay_status='PaySucceeded' \n" +
                "group by a.account_number, day having 1=1 \n");
        if (StringUtils.isNotBlank(account)){
            sql.append(" AND a.account_number like '%" + account + "%' ");
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        if (null != startTime && !("").equals(startTime)){
            sql.append(" AND day >= '" + sdf.format(startTime) + "'");
        }
        if (null != endTime && !("").equals(endTime)){
            sql.append(" AND day <= '" + sdf.format(endTime) + "'");
        }
        sql.append("order by day desc");

        SqlFinder sqlFinder =  SqlFinder.create(sql.toString());
        Pagination pagination = findBySql(sqlFinder, pageNo, pageSize);

        Pagination reportPage = new Pagination(pagination.getPageNo(), pagination.getPageSize(), pagination.getTotalCount());
        List list = pagination.getList();
        List<AccountReport> accountReports = new ArrayList<>();
        for (Object object: list) {
            Object[] data = (Object[]) object;
            AccountReport accountReport = new AccountReport();
            accountReport.setAccount((String) data[0]);
            accountReport.setDay((String) data[1]);
            accountReport.setAmount((new BigDecimal(data[2].toString())).setScale(2, BigDecimal.ROUND_UP));
            accountReports.add(accountReport);
        }
        reportPage.setList(accountReports);

        return reportPage;
    }

    @Override
    protected Class<Order> getEntityClass() {
        return Order.class;
    }

    @Resource
    private SessionUtil sessionUtil;

    /**
     * 未确认
     */
    public static final  Integer CHECKING = 1;
    /**
     * 已确认
     */
    public static final Integer CHECKED = 2;

    @Resource
    private SessionProvider session;

}