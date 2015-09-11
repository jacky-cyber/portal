package com.ifunpay.portal.util;

import com.ifunpay.portal.ProjectXml;
import com.ifunpay.portal.dao.ChannelDao;
import com.ifunpay.portal.entity.Channel;
import com.ifunpay.portal.entity.Commerce;
import com.ifunpay.portal.entity.Image;
import com.ifunpay.portal.entity.MemberUserEntity;
import com.ifunpay.portal.service.MemberUserService;
import com.ifunpay.portal.service.commerce.CommerceService;
import com.jspgou.cms.entity.Order;
import com.jspgou.cms.entity.Product;
import com.jspgou.cms.entity.ShopMember;
import com.jspgou.cms.manager.ImageMng;
import com.jspgou.cms.manager.OrderMng;
import com.jspgou.cms.manager.ProductMng;
import com.jspgou.cms.manager.ShopMemberMng;
import com.jspgou.core.entity.Member;
import com.jspgou.core.entity.User;
import com.jspgou.core.entity.Website;
import com.jspgou.core.manager.MemberMng;
import com.jspgou.core.manager.UserMng;
import com.jspgou.core.manager.WebsiteMng;
import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.hibernate.SessionFactory;
import org.hibernate.classic.Session;
import org.hibernate.transform.Transformers;
import org.hibernate.type.DoubleType;
import org.hibernate.type.IntegerType;
import org.hibernate.type.StringType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by David on 2015/5/18.
 */
@Component
@RequestMapping("/moveData")
public class MoveData   {
    private Logger logger = Logger.getLogger(MoveData.class);
    ApplicationContext contex = new FileSystemXmlApplicationContext("classpath:applicationContext.xml");
    SessionFactory factory = (SessionFactory)contex.getBean("sessionFactory"); //sessionFactory 为你配置的SessionFactory been的id
    private static HashMap<String,String> productId = new HashMap<>();
    @RequestMapping("moveProductData")
    @Transactional
    public String moveProductData(){
//        copyImageFile();
        Session session = factory.openSession();
        String message = null;
        try {
            String sql = "select a.*  from t_product a";
            List list = session.createSQLQuery(sql)
                .addScalar("id", StringType.INSTANCE)
                .addScalar("PRODUCT_NAME",StringType.INSTANCE)
                .addScalar("PRODUCT_ID", StringType.INSTANCE)
                .addScalar("CHANNEL_ID", StringType.INSTANCE)
                .addScalar("COMMERCE_ID", StringType.INSTANCE)
                .addScalar("MERCHANT_NAME", StringType.INSTANCE)
                .addScalar("PRICE", DoubleType.INSTANCE)
                .addScalar("COST", DoubleType.INSTANCE)
                .addScalar("CREATE_DATE", StringType.INSTANCE)
                .addScalar("PRODUCT_OUTLINE", StringType.INSTANCE)
                .addScalar("PRODUCT_FEATURE", StringType.INSTANCE)
                .addScalar("PRODUCT_TYPE_ID", StringType.INSTANCE)
                .addScalar("PRODUCT_SERIES", StringType.INSTANCE)
                .addScalar("PRODUCT_BRAND", StringType.INSTANCE)
                .addScalar("CREATOR_ID", StringType.INSTANCE)
                .addScalar("delStatus", StringType.INSTANCE)
                .addScalar("specification", StringType.INSTANCE)
                .addScalar("country", StringType.INSTANCE)
                .addScalar("package", StringType.INSTANCE)
                .setResultTransformer(
                        Transformers.ALIAS_TO_ENTITY_MAP).list();

            for(int i=0;i<list.size();i++){
                Map map = (Map) list.get(i);
                Product product = new Product();
                product.setName(String.valueOf(map.get("PRODUCT_NAME")));
                product.setCommerceId(String.valueOf(map.get("COMMERCE_ID")));
                SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//小写的mm表示的是分钟
                String data = String.valueOf(map.get("CREATE_DATE"));
                Date da =sdf.parse(data);
                product.setCreateTime(da);

                product.setChannelId(String.valueOf(map.get("CHANNEL_ID")));

                String sql3 = "select * from t_activity_product where PRODUCT_ID='"+String.valueOf(map.get("id"))+"'" ;

                List listProduct  =  session.createSQLQuery(sql3)
                        .addScalar("STATUS", StringType.INSTANCE)//状态
                        .addScalar("BASE_SALE", IntegerType.INSTANCE)//已销售商品数
                        .addScalar("INVENTORY", IntegerType.INSTANCE)//商品库存
                        .addScalar("scan_pay_price", DoubleType.INSTANCE)//扫码支付价格
                        .addScalar("flash_pay_price", DoubleType.INSTANCE)//闪付价格
                        .addScalar("qr_pay_price", DoubleType.INSTANCE)//二维码小额支付价格
                        .addScalar("union_pay_price", DoubleType.INSTANCE)//银联支付价格
                        .setResultTransformer(
                                Transformers.ALIAS_TO_ENTITY_MAP).list();
                if(0!=listProduct.size()){
                    Map actProduct  = (Map)listProduct.get(0);

                    if(null!=actProduct.get("flash_pay_price")){
                        product.setFlashPrice(new Double(String.valueOf(actProduct.get("flash_pay_price"))));
                    }else {
                        product.setFlashPrice(new Double(0));
                    }
                    if(null!=actProduct.get("union_pay_price")){
                        product.setScreenPrice(new Double(String.valueOf(actProduct.get("union_pay_price"))));
                    }else {
                        product.setScreenPrice(new Double(0));
                    }
                    product.setSaleCount(Integer.valueOf(String.valueOf(actProduct.get("BASE_SALE"))));
                    product.setChecked(true);
                    if("1".equals(actProduct.get("STATUS"))||"2".equals(actProduct.get("STATUS"))){
                        product.setOnSale(false);
                    }else if("3".equals(actProduct.get("STATUS"))){
                        product.setOnSale(true);
                    }
                    product.setStockCount(Integer.valueOf(String.valueOf(actProduct.get("INVENTORY"))));
                    if(null!=actProduct.get("qr_pay_price")){
                        product.setLittlePrice(new Double(String.valueOf(actProduct.get("qr_pay_price"))));
                    }else {
                        product.setLittlePrice(new Double(0));
                    }
                    if(null!=actProduct.get("scan_pay_price")){
                        product.setScanningPrice(new Double(String.valueOf(actProduct.get("scan_pay_price"))));
                    }else {
                        product.setScanningPrice(new Double(0));
                    }

                }else {
                    product.setFlashPrice(new Double(0));
                    product.setScreenPrice(new Double(0));
                    product.setSaleCount(0);
                    product.setChecked(true);
                    product.setOnSale(false);
                    product.setStockCount(0);
                    product.setLittlePrice(new Double(0));
                    product.setScanningPrice(new Double(0));
                }

                if(null!=map.get("COST")){
                    product.setCostPrice(new Double(String.valueOf(map.get("COST"))));
                }else {
                    product.setCostPrice(new Double(0));
                }


                product.setMarketPrice(new Double(String.valueOf(map.get("PRICE"))));
                product.setSalePrice(new Double(String.valueOf(map.get("PRICE"))));

                product.setText("");
                product.setText2("");
                String sql2 = "select * from t_gby_product_category where ID='"+String.valueOf(map.get("PRODUCT_TYPE_ID"))+"'" ;
                Map productType  = (Map) session.createSQLQuery(sql2)
                        .addScalar("product_type", StringType.INSTANCE)
                        .setResultTransformer(
                                Transformers.ALIAS_TO_ENTITY_MAP).list().get(0);
                product.setProductStamp(Integer.valueOf(String.valueOf(productType.get("product_type"))));//map.get("PRODUCT_TYPE_ID").toString())
                product.setExpireTime(new Date());
                product.setScore(0);
                product.setViewCount(Long.valueOf("0"));

                product.setNewProduct(false);
                product.setHotsale(false);
                product.setRecommend(false);
                product.setLackRemind(0);
                product.setSpecial(false);
                product.setShareContent("");
                product.setLiRun(new Double(0));
                String id = map.get("id").toString();

                String sql1 = "select * from t_product_img where PRODUCT_ID='"+id+"'" ;
                List imgList = session.createSQLQuery(sql1)
                        .addScalar("is_cover", StringType.INSTANCE)
                        .addScalar("IMG_PATH",StringType.INSTANCE)
                        .addScalar("md5",StringType.INSTANCE)
                        .addScalar("IMG_NAME",StringType.INSTANCE)
                        .setResultTransformer(
                                Transformers.ALIAS_TO_ENTITY_MAP).list();
                String imgPathCover = null;
                ArrayList<String> img = new ArrayList<>();
                if(imgList.size()>0){
                    if(imgList.size()>1){
                    for (int j = 0;j<imgList.size();j++){
                        Map map1  = (Map) imgList.get(j);
                        String isCover = String.valueOf(map1.get("is_cover"));
                        if("1".equals(isCover)){
//                            imgPathCover = String.valueOf(map1.get("IMG_PATH"));
                            imgPathCover = "/u/201505/"+String.valueOf(map1.get("IMG_NAME"));


                        }else {
                            img.add( "/u/201505/"+String.valueOf(map1.get("IMG_NAME")));
                            if(null==imgPathCover){
                                imgPathCover = "/u/201505/"+String.valueOf(map1.get("IMG_NAME"));
                            }
                        }
                        Image image = imageMng.getEntityById("/u/201505/"+String.valueOf(map1.get("IMG_NAME")));
                        if(null==image){
                            String imgNameCover = String.valueOf(map1.get("IMG_NAME"));
                            String imgMd5Cover = String.valueOf(map1.get("md5"));
                            String imgP = "/u/201505/"+String.valueOf(map1.get("IMG_NAME"));
                            imageMng.save(imgNameCover,imgP,imgMd5Cover);
                        }

                    }
                    }else {
                        Map map1 = (Map) imgList.get(0);
                        imgPathCover = "/u/201505/"+String.valueOf(map1.get("IMG_NAME"));
                        Image image = imageMng.getEntityById(imgPathCover);
                        if(null==image){
                            String imgNameCover = String.valueOf(map1.get("IMG_NAME"));
                            String imgMd5Cover = String.valueOf(map1.get("md5"));
                            String imgP = "/u/201505/"+String.valueOf(map1.get("IMG_NAME"));
                            imageMng.save(imgNameCover,imgP,imgMd5Cover);
                        }
                    }
                }else {
                    imgPathCover = "";
                }
                Product product1 = productMng.saveOldProduct(product, imgPathCover, img);
                productId.put(String.valueOf(map.get("id")),product1.getId().toString());
                System.out.println("name" + map.get("PRODUCT_NAME"));
            }
            message = "move data success!";
       }catch (Exception e){
            logger.info("copy false" , e);
            message = "move data false!";
       }finally {
           session.close();
       }
        return "<h1>" + message + "</h1>";
    }



   @RequestMapping("moveOrderData")
   @Transactional
   public String moveOrderData (HttpServletRequest request){
       Session session = factory.openSession();
       String message = null;
       try{

           String sql = "select n.*  from n_order n";
           List list = session.createSQLQuery(sql)
                   .addScalar("id", StringType.INSTANCE)
                   .addScalar("channel_id", StringType.INSTANCE)
                   .addScalar("member_user_id", StringType.INSTANCE)
                   .addScalar("amount", IntegerType.INSTANCE)
                   .addScalar("pay_method", StringType.INSTANCE)
                   .addScalar("payment_status", StringType.INSTANCE)
                   .addScalar("order_status", StringType.INSTANCE)
                   .addScalar("ship_status", StringType.INSTANCE)
                   .addScalar("created_date", StringType.INSTANCE)
                   .addScalar("payed_date", StringType.INSTANCE)
                   .addScalar("recipient_name", StringType.INSTANCE)
                   .addScalar("recipient_phone", StringType.INSTANCE)
                   .addScalar("province", StringType.INSTANCE)
                   .addScalar("city", StringType.INSTANCE)
                   .addScalar("district", StringType.INSTANCE)
                   .addScalar("invoice_title", StringType.INSTANCE)
                   .addScalar("user_message", StringType.INSTANCE)
                   .addScalar("post_type", StringType.INSTANCE)
                   .addScalar("commerce_id", StringType.INSTANCE)
                   .addScalar("order_type", StringType.INSTANCE)
                   .addScalar("rece_voucher_phone", StringType.INSTANCE)
                   .addScalar("terminal_number", StringType.INSTANCE)
                   .addScalar("serial_no", StringType.INSTANCE)
//                   .addScalar("feedback_message", StringType.INSTANCE)
                   .setResultTransformer(
                           Transformers.ALIAS_TO_ENTITY_MAP).list();
           for(int i =0 ; i<list.size();i++) {
               Order order = new Order();
               Map map = (Map) list.get(i);
               MemberUserEntity memberUserEntity = null;
               memberUserEntity = memberUserService.getEntityByUuid(String.valueOf(map.get("member_user_id")));
               String terminalId = String.valueOf(map.get("terminal_number"));
               String ordeId = String.valueOf(map.get("id"));
               String sql1 = "select * from n_order_product where order_id='"+ordeId+"'" ;
               List orderProductList = session.createSQLQuery(sql1)
                       .addScalar("product_id", StringType.INSTANCE)
                       .addScalar("volume",IntegerType.INSTANCE)
                       .addScalar("amount",IntegerType.INSTANCE)
                       .addScalar("price",IntegerType.INSTANCE)
                       .setResultTransformer(
                               Transformers.ALIAS_TO_ENTITY_MAP).list();
               Map orderProductMap = (Map) orderProductList.get(0);

                   String activityProduct= String.valueOf(orderProductMap.get("product_id"));


               String sql2 = "select * from t_activity_product where ID='"+activityProduct+"'" ;
               List productList = session.createSQLQuery(sql2)
                       .addScalar("PRODUCT_ID", StringType.INSTANCE)
                       .setResultTransformer(
                               Transformers.ALIAS_TO_ENTITY_MAP).list();
               Map productMap = (Map) productList.get(0);

               String product= String.valueOf(productMap.get("PRODUCT_ID"));


               Long  ItemId =new Long(0);
               if(null!=product){
                   try {
                       ItemId = Long.valueOf(productId.get(product));
                   }catch (Exception e){
                       ItemId = new Long(0);
                   }

               }
               Long [] cartItemId   = {ItemId};
//                   Long [] cartItemId   = {Long.valueOf(productId.get(String.valueOf(productMap.get("product_id"))))};
               //发货方式
               long shippingMethodId = 1;
               //收货信息
               long deliveryInfo =1;
               //支付方式
               long paymentMethodId =1;
               switch (String.valueOf(orderProductMap.get("pay_method"))){
                   case "ScanPay":
                       paymentMethodId = 4;
                       break;
                   case "Pos":
                       paymentMethodId = 6;
                       break;
                   case "FlashPay":
                       paymentMethodId = 5;
                       break;
                   case "QrCode":
                       paymentMethodId = 7;
                       break;
               }


               String address = String.valueOf(map.get("province"))+String.valueOf(map.get("city"))+String.valueOf(map.get("district"));
               if("nullnullnull".equals(address)){
                   address="";
               }
               order.setMemberUserEntity(memberUserEntity);
                   order.setTerminalId(terminalId);
               SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//小写的mm表示的是分钟
               String data = String.valueOf(map.get("created_date"));
               Date da =sdf.parse(data);
               order.setCreateTime(da);
               order.setComments("");
               order.setIp(request.getRemoteAddr());
               order.setTotal(Long.valueOf(String.valueOf(orderProductMap.get("amount"))));
               order.setProductPrice(Long.valueOf(String.valueOf(orderProductMap.get("price"))));
               order.setSerialNo(String.valueOf(map.get("serial_no")));
               order.setReceiveName(String.valueOf(map.get("recipient_name")));
               order.setReceivePhone(String.valueOf(map.get("recipient_phone")));
               order.setReceiveAddress(address);
               order.setScore(0);
               order.setWeight(new Double(0));
               switch (String.valueOf(map.get("order_status"))){
                   case "Finished":
                       order.setStatus(4);//已完成
                       break;
                   case "NEW":
                       order.setStatus(1);//未确认
                       break;
                   case "Canceled":
                       order.setStatus(3);//已取消
                       break;
                   case "Confirmed":
                       order.setStatus(2);//已确认
                       break;
                   default: order.setStatus(3);//未知

               }

               switch (String.valueOf(map.get("ship_status"))){
                   case "NotShip":
                       order.setShippingStatus(1);//未发货
                       break;
                   case "Shipped":
                       order.setShippingStatus(2);//已发货
                       break;
                   case "Received":
                       order.setShippingStatus(2);//已取消
                       break;
                   case "Rejected":
                       order.setShippingStatus(1);//已退款
                       break;
                   case "ReturnConfirming":
                       order.setShippingStatus(3);//已退款
                       break;
                   case "ReturnDecline":
                       order.setShippingStatus(3);//已退款
                       break;
                   case "Returning":
                       order.setShippingStatus(3);//已退款
                       break;
                   case "Returned":
                       order.setShippingStatus(3);//已退款
                       break;
                   default:order.setShippingStatus(2);//未知
               }
               switch (String.valueOf(map.get("payment_status"))){
                   case "NotPay":
                       order.setPaymentStatus(1);//未付款
                       break;
                   case "Paying":
                       order.setPaymentStatus(2);//付款中
                       break;
                   case "PayFailed":
                       order.setPaymentStatus(1);//付款失败
                       break;
                   case "PaySucceeded":
                       order.setPaymentStatus(2);//付款成功
                       break;
                   case "Refunding":
                       order.setPaymentStatus(3);//退款中
                       break;
                   case "RefundSucceeded":
                       order.setPaymentStatus(3);//已退款
                       break;
                   case "RefundFailed":
                       order.setPaymentStatus(3);//退款失败
                       break;
                   case "Unknown":
                       order.setPaymentStatus(3);//未知
                       break;
                   default:order.setPaymentStatus(1);//未知
               }
               order.setReceiveMobile("");
               order.setReceiveZip("");
               orderMng.moveOrder( order, cartItemId, shippingMethodId, paymentMethodId);
           }
           message = "move data success !";
       }catch (Exception e){
           logger.info("moveOrderData false",e);
           message = "move data false !";
       }finally {
           session.close();

       }

       return "<h1>" + message + "</h1>";

   }


    @RequestMapping("moveChannelData")
    @ResponseBody
    public String moveChannelData(){
        String message;
        try {
            List<Channel> channelList = channelDao.getAllChannel();
            List<MemberUserEntity> memberUserEntityList =memberUserService.getAllMemberUser();
            for(Channel channel:channelList){
                for(Channel chan:channelList){
                    if(channel.getParent()!=null&&channel.getParent().equals(chan.getUuid())){
                        channel.setChanParentId(chan);
                        channelDao.updateChannel(channel);
                    }
                }
                for(MemberUserEntity memberUserEntity : memberUserEntityList){
                    if(channel.getCreator()!=null&&channel.getCreator().equals(memberUserEntity.getUuid())){
                        channel.setOperator(memberUserEntity.getId());
                        channelDao.updateChannel(channel);
                    }
                }
            }
            message = "success";
        }catch (Exception e){
            logger.error("",e);
            message = "failed";
        }
        return "<h1>" + message + "</h1>";
    }


    @RequestMapping("moveCommerceData")
    @ResponseBody
    public String moveCommerceData(){
        String message ="";
        try {
            List<Channel> channelList = channelDao.getAllChannel();
            List<Commerce> commerceList = commerceService.getAllCommerces();
            for(Commerce commerce:commerceList){
                for(Channel chan:channelList){
                    if(commerce.getChannel()!=null&&commerce.getChannel().equals(chan.getUuid())){
                        commerce.setChanIdRela(chan);
                        commerceService.updateCommerceEntity(commerce);
                    }
                }
            }
            message = "success";
        }catch (Exception e){
            message = "fail";
            logger.error("",e);
        }

        return "<h1>" + message + "</h1>";
    }


    @RequestMapping("moveMemberUserData")
    @ResponseBody
    public String moveMemberUserData(){

        List<User> users = userMng.getAllUser();
        String message ="";
        if(users.size()>1){

       /* long startId = Long.parseLong(start);
        long endId = Long.parseLong(end);
        logger.info("from .."+startId+" to .."+endId);*/

        try {
            Website web = websiteMng.findById(new Long(1));
            for (int i = 1; i < users.size(); i++) {
                User user = users.get(i);
                logger.info("user name=" + user.getUsername());
                Member member = new Member();
                Timestamp createtime = new Timestamp(System.currentTimeMillis());
                member.setCreateTime(createtime);
                member.setUser(user);
                member.setWebsite(web);
                member.setDisabled(false);
                member.setActive(true);
                Member member1 = memberMng.save(member);

                ShopMember shopMember = new ShopMember();
                shopMember.setMember(member1);
                shopMember.setWebsite(web);
                shopMember.setFreezeScore(0);
                ShopMember shopMember1 = shopMemberMng.save(shopMember);

            }
            message = "success";
        }catch (Exception e){
            message = "fail";
            logger.error("",e);
        }
        }


        return "<h1>" + message + "</h1>";
    }

    public  void  copyImageFile (){
        try {
            String oldSource = ProjectXml.getValue("img_path")+"\\productImg";
            String newSource = ProjectXml.getValue("img_path")+"\\u\\201505";
            if(new File(newSource).exists()){
                FileUtils.copyDirectoryToDirectory(new File(oldSource), new File(newSource));
            }else {
                File file =new File(newSource);
                file.mkdirs();
                FileUtils.copyDirectoryToDirectory(new File(oldSource),new File(newSource));
            }


        }catch (Exception e){
            logger.info("copy the image false ",e);
        }
    }


    @Autowired
    private ChannelDao channelDao;

    @Autowired
    ProductMng productMng;
    @Autowired
    OrderMng orderMng;
    @Resource
    MemberUserService memberUserService;
    @Autowired
    ImageMng imageMng;
    @Autowired
    private CommerceService commerceService;

    @Autowired
    private UserMng userMng;

    @Autowired
    private WebsiteMng websiteMng;

    @Autowired
    private MemberMng memberMng;

    @Autowired
    private ShopMemberMng shopMemberMng;

}
