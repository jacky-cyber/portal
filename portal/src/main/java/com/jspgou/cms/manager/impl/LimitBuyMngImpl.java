package com.jspgou.cms.manager.impl;

import com.jspgou.cms.entity.Favorable;
import com.jspgou.cms.entity.ProductFavorable;
import com.jspgou.cms.manager.FavorableMng;
import com.jspgou.cms.manager.LimitBuyMng;
import com.jspgou.cms.manager.OrderMng;
import com.jspgou.cms.manager.ProductFavorableMng;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
 * Created by David on 2015/7/29.
 */
@Service
public class LimitBuyMngImpl implements LimitBuyMng {
    @Autowired
    private FavorableMng manager;
    @Autowired
    private ProductFavorableMng pfManager;
    @Autowired
    private OrderMng orderMng;
    public Boolean checkLimitOrNot(Long productId,Long needLogin,Long mobile,String cookieId){
        Boolean limit = false;
        List<ProductFavorable> pfList = pfManager.getListByProduct(productId,null);
        if(pfList.size()>0){//该商品有限购
//            ProductFavorable productFavorable= pfList.get(0);
            for (ProductFavorable productFavorable : pfList){
                limit = limit( productFavorable, productId, needLogin, mobile, cookieId);
                if(limit){
                    break;
                }
            }
        }
        return limit;
    };

    public Boolean limit(ProductFavorable productFavorable,Long productId,Long needLogin,Long mobile,String cookieId){
        Boolean limit = false;
        Favorable favorable = manager.findById(productFavorable.getFavorableId());
        if(favorable!=null){
            Date endTime=favorable.getEndTime();
            Date startTime=favorable.getStartTime();
            Date nowDate = new Date();
            if(nowDate.getTime()>startTime.getTime() &&nowDate.getTime()<endTime.getTime()){// 在活动时间内
                Integer manner = favorable.getManner();
                if(manner.intValue()==needLogin.intValue()){ //登录方式相同
                    Integer favorableType = favorable.getFavorableType();
                    switch (favorableType){  // 限购类型
                        case 1 :   break; //固定周期
                        case 2 :   break; //固定月
                        case 3 : limit = automatic(favorable,mobile,cookieId,productId);
                            break; // 自定义
                        case 4 :   break; //前N笔优惠
                        default:break;
                    }
                };
            }
        }
        return limit;
    }


    public Boolean automatic(Favorable favorable,Long mobile,String cookieId, Long productId){
        Boolean limit1= false;
        Integer automatic = favorable.getAutomatic();
        if(automatic>0){
            Date now = new Date();
            Date start = favorable.getStartTime();
            Long time = now.getTime() - start.getTime();
            long ms= 1000;
            long day= ms*60*60*24;
            long da = time/day;
            long distanceDate=da/automatic;
            Date newStart = new Date(start.getTime()+distanceDate*day);
            Integer favorableArea = favorable.getArea();
            switch (favorableArea){
                case 1 : limit1 = check(favorable,mobile,cookieId ,newStart);   break;
                case 2 : limit1 = check(favorable,productId,mobile,cookieId,newStart);   break;
                case 3 : break;
                case 4 : break;
                default:break;
            }

        }else if (0==automatic) {
            Integer favorableArea = favorable.getArea();
            switch (favorableArea){
                case 1 : limit1 = check(favorable,mobile,cookieId,favorable.getStartTime());   break;
                case 2 : limit1 = check(favorable,productId,mobile,cookieId,favorable.getStartTime());   break;
                case 3 : break;
                case 4 : break;
                default:break;
            }
        }
        return limit1;
    }
    public Boolean check(Favorable favorable ,Long mobile,String cookieId,Date newStart){
        Integer orderCount = 0;
        List<ProductFavorable> productFavorableList = pfManager.getListByProduct(null,favorable.getId());
        for (ProductFavorable productFavorable : productFavorableList){
            Integer  orderList = orderMng.getOrderCount(productFavorable.getProductId(), mobile,cookieId, newStart);
            orderCount +=orderList;
        }
       if(orderCount>=favorable.getOrderAmount()){
           return true;
       }else {
           return false;
       }
    }
    public Boolean check(Favorable favorable ,Long productId ,Long mobile,String cookieId ,Date newStart){
            Integer  orderList = orderMng.getOrderCount(productId, mobile,cookieId, newStart);
        if(orderList>=favorable.getOrderAmount()){
            return true;
        }else {
            return false;
        }
    }
}
