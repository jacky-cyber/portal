package com.ifunpay.portal.controller;

import com.ifunpay.portal.ProjectXml;
import com.ifunpay.portal.dao.NewOrderVoucherDao;
import com.ifunpay.portal.entity.Commerce;
import com.ifunpay.portal.entity.OrderVoucher;
import com.ifunpay.portal.service.commerce.CommerceService;
import com.ifunpay.portal.service.commerce.NewOrderVoucherService;
import com.ifunpay.portal.service.order.OrderProductService;
import com.jspgou.cms.entity.Order;
import com.jspgou.cms.entity.Product;
import com.jspgou.cms.manager.OrderMng;
import com.jspgou.cms.manager.ProductMng;
import com.jspgou.common.security.encoder.PwdEncoder;
import com.jspgou.common.web.session.SessionProvider;
import com.jspgou.core.entity.User;
import com.jspgou.core.manager.UserMng;
import com.jspgou.core.utils.PortToDHB;
import com.jspgou.core.web.Constants;
import net.sf.json.JSONObject;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

/**
 * Created by David on 2015/3/24.
 */
@Controller
@RequestMapping("/merchant")
public class MerchantController {
    private Logger log = Logger.getLogger(MerchantController.class);


    /**
     * 主页面
     * @param model
     * @return
     */
    @Deprecated
    @RequestMapping("index.do")
    public String list(Model model,HttpServletRequest request){
        User user =( User) session.getAttribute(request, Constants.DHB_COMMERCE);
        if(null==user){
            model.addAttribute("isLogin", "no");
        }else{
            model.addAttribute("isLogin", "yes");
//            model.addAttribute("commerce", commerce.getUsername());
        }
        return "merchant/newindex";
    }


    @RequestMapping("login.html")
    public String login(Model model){
        return "merchant/login";
    }


    /**
     * 用户登录
     * @param model
     * @param merchant_user_id
     * @param login_pwd
     * @param request
     * @return
     */
    @RequestMapping(value = "merchantLogin",method = RequestMethod.POST)
    @ResponseBody
    public JSONObject merchantLogin(Model model,String merchant_user_id,String login_pwd,HttpServletRequest request,HttpServletResponse response){
        log.info(" 商户用户["+merchant_user_id+"]开始登录......");
        JSONObject json = new JSONObject();
        String url = "";
        User commerce = null;
        User user = userMng.getByUsername(merchant_user_id);
        if (pwdEncoder.isPasswordValid(user.getPassword(), login_pwd)){
            commerce = user;
        }
//        HashMap<String,Object> commerce = merchantLogin(2,merchant_user_id,login_pwd);


        try {
            if(null!=commerce){
                url = "mvc/merchant/index.do";
                session.setAttribute(request,response,Constants.DHB_COMMERCE,commerce);
                session.setAttribute(request,response,"username",merchant_user_id);
                json.accumulate("success", "success");

            }else{
                url = "mvc/merchant/login.html";
                json.accumulate("success", "false");
                json.accumulate("errorMsg", "用户名或密码错误");
            }
            json.accumulate("url", url);
            log.info(" 商户用户["+merchant_user_id+"]登录成功......json："+json.toString());
        } catch (Exception e) {
            url = "merchant/login";
            json.accumulate("success", "false");
            json.accumulate("errorMsg", "用户名或密码错误");
            json.accumulate("url", url);
            model.addAttribute("json", json);
            return json;
        }
        return json;
    }


    /**
     * 商户注销登录
     * @param request
     * @return
     */
    @RequestMapping("logoutmerchant")
    public ModelAndView logoutMerchant(HttpServletRequest request,HttpServletResponse response){
        session.logout(request,response);
        return new ModelAndView("redirect:/mvc/merchant/index.do");
    }


    /**
     * 获取商户信息
     * @param model
     * @return
     */
    @Deprecated
    @RequestMapping("merchantInfo")
    public String getMerchantInfo(Model model,HttpServletRequest request){
        //判断用户是否已经登录
        User user = (User) session.getAttribute(request,Constants.DHB_COMMERCE);
        if(null==user){
            return "merchant/login";
        }else {
           Commerce commerce1= commerceService.getCommerceByCommerceId(user.getCommerceId());
            model.addAttribute("commerce", commerce1);
            return "merchant/merchantInfo";
        }
    }


    /**
     * 凭证验证 页面
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("yz")
    public String validate(Model model,HttpServletRequest request){
        //判断用户是否已经登录
        User user = (User) session.getAttribute(request,Constants.DHB_COMMERCE);
        if(null==user){
            return "merchant/login";
        }else {
            return "merchant/yz";
        }
    }


    /**
     *
     * purpose:跳转到手动输入凭证码页面 <br>
     * step: <br>
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("yz_input.html")
    public String yz_input(Model model,HttpServletRequest request){
        //判断用户是否已经登录
        User user = (User) session.getAttribute(request,Constants.DHB_COMMERCE);
        if(null==user){
            return "merchant/login";
        }else {
            return "/merchant/yz_input";
        }
    }


    /**
     * 查询凭证码
     * @param mav
     * @param request
     * @return
     */
    @RequestMapping("yz_result_new")
    public ModelAndView queryVoucherInfoForNewVoucher(String voucher_value, ModelAndView mav,HttpServletRequest request){
        //判断用户是否已经登录
        User user = (User) session.getAttribute(request,Constants.DHB_COMMERCE);
        if(null==user){
            mav.setViewName("merchant/login");
        }else {
            OrderVoucher orderVoucher = newOrderVoucherDao.findByVoucherCodeForAllStatus(voucher_value);
            if (orderVoucher == null) {
                log.info(" 此商户下,凭证号【" + voucher_value + "】不存在...... ");
                mav.addObject("errorMsg", "此商户下,凭证号【" + voucher_value + "】不存在. ");
                mav.setViewName("merchant/yz_snick");
                return mav;
            } else {
                //Order order = orderMng.getEntityByCode(orderVoucher.getCode());
                mav.addObject("voucherInfo", orderVoucher);
                Date start = orderVoucher.getStartTime();
                Date end = orderVoucher.getEndTime();
                if(start!=null&&end!=null){
                    Date now = new Date();
                    if(now.after(end)||now.before(start)){
                        log.info("expired");
                        mav.addObject("expire","0");//过期了
                    }else {
                        log.info("not expired");
                        mav.addObject("expire","1");//未过期
                    }
                }else {
                    mav.addObject("expire","1");//未过期
                }
                //mav.addObject("order", order);
                mav.setViewName("merchant/yz_result_new");
            }
        }
        return mav;
    }


    /**
     *
     * purpose: 验证凭证 <br>
     * step: <br>
     * @return
     */
    @RequestMapping("validateVoucherNew")
    public void validateResultForNewVoucher(String voucher_value ,HttpServletResponse response,HttpServletRequest request){
        boolean status = newOrderVoucherService.validateVoucher(request,voucher_value);
        HashMap<String ,String> map = new HashMap<>();
        if(status){
            map.put("errorMsg","success");
        }else {
            map.put("errorMsg","验证失败");
        }
        JSONObject json = JSONObject.fromObject(map);
        response.setContentType("text/html; charset=utf-8");
        try {
            response.getWriter().write(json.toString());
        } catch (IOException e) {
            log.info(e);
        }
    }


    /**
     * 新订单列表信息 第一页
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("newOrderlist")
    public String getNewOrderlist(Model model,HttpServletRequest request,String orderId ,String expressFlag){
        //判断用户是否已经登录
        User  user = (User) session.getAttribute(request,Constants.DHB_COMMERCE);
        if(null==user){
            return "merchant/login";
        }else {
            //测试
            String commerceId = user.getCommerceId();
            log.info("commerce id is " + commerceId);
            log.info("orderId ="+orderId);
            int pageNo = 1;
            List<Order> orderEntities = new ArrayList<>();
            if (StringUtils.isNotBlank(orderId)) {
                Order order = orderMng.getEntityByCode(orderId);
                orderEntities.add(order);
            } else {
                orderEntities = orderMng.getlistByCommerceAndmember(commerceId, null);
            }
            model.addAttribute("pageNo", pageNo);//当前页
            model.addAttribute("orders", orderEntities);
            model.addAttribute("pageCount", 1);
            if (orderEntities == null) {
                model.addAttribute("orderListSize", 0);
            } else {
                model.addAttribute("orderListSize", orderEntities.size());
            }
            model.addAttribute("orderId", orderId);
            model.addAttribute("expressFlag", expressFlag);
            return "merchant/neworderlist";
        }
    }


    /**
     * 新订单详细信息
     * @param model
     * @param id
     * @return
     */
    @RequestMapping("neworderinfo")
    public String getNewOrderInfoById(Model model,String id,HttpServletRequest request){
        User  user = (User) session.getAttribute(request,Constants.DHB_COMMERCE);
        if(null==user){
            return "merchant/login";
        }else {
            Order order = orderMng.findById(Long.valueOf(id));
            Commerce commerce = commerceService.getCommerceByCommerceId(user.getCommerceId());
            model.addAttribute("commerce",commerce);
            model.addAttribute("order", order);
            return "merchant/neworderinfo";
        }
    }

    /**
     * 新订单下
     * 显示商品列表信息
     * @param request
     * @return
     */
    @RequestMapping("productlistForNewOrder")
    public ModelAndView getAllProductsForNewOrder(ModelAndView mav,HttpServletRequest request,Long id){
        User  user = (User) session.getAttribute(request,Constants.DHB_COMMERCE);
        if(null==user){
            mav.setViewName("merchant/login");
        }else {
            String commerceId = user.getCommerceId();
            List<Product> list = new ArrayList<>();
            log.info("product id ="+id);
            if (null != id) {
                Product product = productMng.findById(id);
                int saleTotal = orderProductService.CountTotalSaleOut(id);
                log.info("sale total =" + saleTotal);
                product.setSaleCount(saleTotal);
               // product.setStockCount(product.getStockCount()-product.getSaleCount());
                list.add(product);
            } else {
                list = productMng.getListByCommerceId(commerceId);
                for(int i = 0;i<list.size();i++){
                    int saleTotal = orderProductService.CountTotalSaleOut(list.get(i).getId());
                    log.info("sale total =" + saleTotal);
                    list.get(i).setSaleCount(saleTotal);
                    //list.get(i).setStockCount(list.get(i).getStockCount()-list.get(i).getSaleCount());
                }
            }
            mav.addObject("products", list);
            mav.addObject("productListSize", list.size());
            mav.addObject("currPage", 1);
            mav.setViewName("merchant/newproductlist");
        }
        return mav;
    }


    /**
     * 活动商品信息详情
     * @param model
     * @param id
     * @return
     */
    @RequestMapping("productinfo")
    public String getProductInfo(Model model, Long id,HttpServletRequest request){
        User  user = (User) session.getAttribute(request,Constants.DHB_COMMERCE);
        if(null==user){
            return "merchant/login";
        }else {
            Product product = productMng.findById(id);
            model.addAttribute("productInfo", product);
            return "merchant/productinfo";
        }
    }


    /**
     * 修改密码页面
     * @param model
     * @return
     */
    @RequestMapping("pass_change")
    public String changPassword(Model model,HttpServletRequest request){
        User  user = (User) session.getAttribute(request,Constants.DHB_COMMERCE);
        if(null==user){
            return "merchant/login";
        }else {
            return "merchant/pass_change";
        }
    }


    /**
     * 修改密码逻辑
     * @param model
     * @param request
     * @param old_pwd
     * @param new_pwd
     * @return
     */
    @RequestMapping("result")
    public String modifyPassword(Model model,HttpServletRequest request,HttpServletResponse response ,String old_pwd,String new_pwd){
        User user1 = null;
        User  user = (User) session.getAttribute(request,Constants.DHB_COMMERCE);
        if(null==user){
            return "merchant/login";
        }else {
            log.info(" 用户[" + user.getUsername() + "]修改密码......");
            if (pwdEncoder.isPasswordValid(user.getPassword(), old_pwd)){
                 user1=userMng.updateUserPwd(user.getId(),new_pwd);
            }


            if(null!=user1){
                model.addAttribute("result", "修改成功");
                session.logout(request,response);
            }else {
                model.addAttribute("result", "修改失败");
            }
            return "merchant/result";
        }
    }


    @Autowired
    private OrderMng orderMng;
    @Autowired
    private NewOrderVoucherDao newOrderVoucherDao;
    @Autowired
    private ProductMng productMng;

    private SessionProvider session;
    @Autowired
    public void setSessionProvider(SessionProvider session) {
        this.session = session;
    }
    @Autowired
    private UserMng userMng;
    @Autowired
    private PwdEncoder pwdEncoder;
    @Autowired
    private CommerceService commerceService;

    @Resource
    private NewOrderVoucherService newOrderVoucherService;
    @Resource
    private OrderProductService orderProductService;
}
