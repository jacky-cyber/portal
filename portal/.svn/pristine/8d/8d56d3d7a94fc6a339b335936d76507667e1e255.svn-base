package com.ifunpay.portal.service.lottery;


import com.ifunpay.portal.dao.BaseDao;
import com.ifunpay.portal.entity.lottery.LotteryTicketItemEntity;
import com.ifunpay.portal.entity.lottery.LotteryTicketOrderEntity;
import com.ifunpay.util.common.DateUtil;
import com.ifunpay.util.common.StringUtil;
import com.ifunpay.util.network.HttpStatusClient;
import org.apache.log4j.Logger;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.hibernate.Session;
import org.springframework.stereotype.Service;
import org.xml.sax.InputSource;

import javax.annotation.Resource;
import java.io.IOException;
import java.io.StringReader;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 瀚银彩票服务
 * Created by Yu on 2014/12/27.
 */
@Service
public class HyLotteryTicketService {

    private Logger logger = Logger.getLogger(HyLotteryTicketService.class);

    @Resource
    private HanYinConfigService hanYinConfigService;

    @Resource
    private BaseDao baseDao;

    /**
     * @param orderId
     * @param count     彩票数量
     * @param orderDate
     * @param mobile
     * @return
     */
    public LotteryTicketOrderEntity accept(String orderId, int count, Date orderDate, String mobile) {
        return accept(orderId, count, orderDate, mobile, "");
    }


    /**
     * @param orderId
     * @param count     彩票数量
     * @param orderDate
     * @param mobile
     * @param message   备注消息，可选
     * @return
     */
    public LotteryTicketOrderEntity accept(String orderId, int count, Date orderDate, String mobile, String message) {

        HttpStatusClient httpStatusClient = new HttpStatusClient();
        LotteryTicketOrderEntity orderEntity = new LotteryTicketOrderEntity(
                orderId, count, orderDate, mobile, message, hanYinConfigService.getProviderName()
        );

        String merId = hanYinConfigService.getLotteryMerId();
        String activityCode = hanYinConfigService.getLotteryTicketActivityCode();
        String mdseCode = hanYinConfigService.getLotteryTicketMdseCode();
        String departmentId = hanYinConfigService.getLotteryTicketDepartmentId();
        String dateStr = DateUtil.format(orderDate, "yyyyMMddHHmmss");
        Integer price = hanYinConfigService.getLotteryTicketPrice();
        String amount = "" + (price * count);
        httpStatusClient.addParam("merId", merId);
        httpStatusClient.addParam("activityCode", activityCode);
        httpStatusClient.addParam("num", count + "");
        httpStatusClient.addParam("orderId", orderId);
        httpStatusClient.addParam("settleDate", dateStr);
        httpStatusClient.addParam("mobile", mobile);
        httpStatusClient.addParam("mdseCode", mdseCode);
        httpStatusClient.addParam("amount", amount);
        httpStatusClient.addParam("reserveInfo", message);
        httpStatusClient.addParam("departmentId", departmentId);

        String key = hanYinConfigService.getKey();
        String forMd5 = merId + activityCode + count + orderId + dateStr + mobile + mdseCode + amount + key;
        try {
            String md5 = StringUtil.getMd5Hex(forMd5.getBytes(hanYinConfigService.getEncoding())).toUpperCase();
            httpStatusClient.addParam("sign", md5);

            String url = hanYinConfigService.getBaseUrl() + hanYinConfigService.getLotteryTicketAction();
            String responseContent = httpStatusClient.doPost(url);
            logger.debug("responseContent----->" + responseContent);
            if ("502".equals(responseContent)) {
                logger.error("bad gateway");
                return null;
            } else if ("504".equals(responseContent)) {
                logger.error("gateway timeout");
                return null;
            }

            readXMLInfo(responseContent, orderEntity, true);
            baseDao.save(orderEntity);
            return orderEntity;
        } catch (UnsupportedEncodingException e) {
            String errorMessage = "I think it never here";
            logger.info("ERROR, " + errorMessage, e);
            throw new RuntimeException(message, e);
        } catch (RuntimeException | IOException e) {
            logger.error("ERROR", e);
            return null;
        }
    }

    public void check(LotteryTicketOrderEntity entity){
        String orderId = entity.getId();
        HttpStatusClient client1 = new HttpStatusClient();
        String settleDate = DateUtil.format(entity.getOrderDate(), "yyyyMMddHHmmss");
        String merId = hanYinConfigService.getLotteryMerId();
        String sign = StringUtil.getMd5Hex((merId + orderId + settleDate + hanYinConfigService.getKey()).getBytes()).toUpperCase();
        client1.addParam("merId", merId);
        client1.addParam("activityCode", hanYinConfigService.getLotteryTicketActivityCode() + "");
        client1.addParam("orderId", orderId);
        client1.addParam("settleDate", settleDate);
        client1.addParam("bisType", hanYinConfigService.getLotteryTicketBisType());
        client1.addParam("sign", sign);
        String url = hanYinConfigService.getBaseUrl() + hanYinConfigService.getLotteryTicketCheckAction();
        try {
            String response = client1.doPost(url);
            logger.debug("response content: " + response);
            readXMLInfo(response, entity, false);
        } catch (IOException e) {
            logger.error("", e);
        }
    }

    /**
     * @param orderId   订单id
     * @param orderDate 订单日期
     *                  phone   手机号
     *                  sellPrice   结算价格
     *                  status: 0： 成功； 1: 失败； 2：进行中； -1：没有该订单
     */
    public LotteryTicketOrderEntity check(String orderId, Date orderDate, Session session) {
        LotteryTicketOrderEntity entity = (LotteryTicketOrderEntity) session.get(LotteryTicketOrderEntity.class, orderId);

        if (entity != null && entity.getState() == 0) {
            logger.warn("order is success, do not check state from Server");
            return entity;
        }

        if (entity == null) {
            logger.warn("order is not exist in db. try to connect server");
            entity = new LotteryTicketOrderEntity();
            entity.setId(orderId);
            entity.setOrderDate(orderDate);
            entity.setProvider( hanYinConfigService.getProviderName());
        }
        check(entity);
        return entity;
    }

    /**
     * 发货后解析xml信息
     *
     * @param xmlInfo
     * @param orderEntity
     * @param isAccept    true: 下单, false: 查询
     * @return
     */
    private void readXMLInfo(String xmlInfo, LotteryTicketOrderEntity orderEntity, boolean isAccept) {
        try {
            StringReader reader = new StringReader(xmlInfo);
            InputSource inputSource = new InputSource(reader);
            SAXReader saxReader = new SAXReader();
            Document document = saxReader.read(inputSource);
            Element root = document.getRootElement();
            String rCode = root.element("retCode").getText();

            // 校验状态
            if ("1".equals(rCode)) {
                try {
                    String orgSign = root.elementText("sign");
                    String merchantId = root.elementText("merchId");
                    String activityCode = root.elementText("activityCode");
                    String orderId = root.elementText("orderId");
                    String settleDate = root.elementText("settleDate");
                    String hyOrderId = root.elementText("hyOrderId");
                    String payAmount = root.elementText("payAmount");
                    String status = root.elementText("status");
                    String phone = root.elementText("mobile");
                    String sellPrice = root.elementText("sellPrice");
                    String key = hanYinConfigService.getKey();

                    String forMd5;
                    int ticketCount;
                    if (isAccept) {
                        forMd5 = merchantId + activityCode + orderId + settleDate + hyOrderId + payAmount + status + key;
                        ticketCount = Integer.valueOf(payAmount) / hanYinConfigService.getLotteryTicketPrice();
                    } else {
                        forMd5 = merchantId + orderId + settleDate + hyOrderId + status + phone + sellPrice + key;
                        ticketCount = Integer.valueOf(sellPrice) / hanYinConfigService.getLotteryTicketPrice();
                        orderEntity.setMobile(phone);
                    }

                    orderEntity.setTicketCount(ticketCount);
                    String sign = StringUtil.getMd5Hex((forMd5.getBytes(hanYinConfigService.getEncoding())));
                    logger.debug("MD5[" + forMd5 + "] -> " + sign);
                    if (sign.equalsIgnoreCase(orgSign)) {
                        List<LotteryTicketItemEntity> originalItemEntityList = new ArrayList<>();
                        List<LotteryTicketItemEntity> itemEntityList = new ArrayList<>();
                        Iterator iterator = root.element("voteNums").elementIterator();
                        while (iterator.hasNext()) {
                            Element element = (Element) iterator.next();
                            String voteNum = element.elementText("num");
                            String amount = element.elementText("amount");
                            int count = Integer.valueOf(amount) / hanYinConfigService.getLotteryTicketPrice();
                            LotteryTicketItemEntity itemEntity = new LotteryTicketItemEntity();
                            itemEntity.setTicketCount(count);
                            itemEntity.setCode(voteNum);
                            originalItemEntityList.add(itemEntity);
                        }
                        originalItemEntityList.stream().collect(Collectors.groupingBy(i -> i.getCode(), Collectors.summingInt(i -> i.getTicketCount()))).forEach(
                                (k, v) -> itemEntityList.add(new LotteryTicketItemEntity(StringUtil.uuid(), orderId, k, v))
                        );
                        orderEntity.setState(Integer.valueOf(status));
                        orderEntity.setItemEntityList(itemEntityList);

                    } else {
                        //签名不正确
                        logger.info("Response sign check failed. sign: " + sign + ", sign from response: " + orgSign);
                        orderEntity.setState(1);
                        orderEntity.setErrorMessage("签名错误");
                    }
                } catch (Exception e) {
                    logger.error("", e);
                }
            } else {
                String errorMessage = root.elementText("errMsg");
                orderEntity.setState(2);//解析错误，稍后再查
                orderEntity.setErrorMessage(errorMessage);
            }
        } catch (Exception e) {
            logger.error("解析XML错误,返回数据异常", e);
            orderEntity.setState(1);
            orderEntity.setErrorMessage(e.getMessage());
        }
        return;
    }


    public void setHanYinConfigService(HanYinConfigService hanYinConfigService) {
        this.hanYinConfigService = hanYinConfigService;
    }
}
