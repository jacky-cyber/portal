package com.ifunpay.portal.controller;

import com.ifunpay.front.TerminalFrontRemoteControl;
import com.ifunpay.front.bean.response.BaseRestResponse;
import com.ifunpay.portal.ProjectXml;
import com.ifunpay.portal.entity.MemberAddr;
import com.ifunpay.portal.entity.MemberUserEntity;
import com.ifunpay.portal.entity.order.OrderEntity;
import com.ifunpay.portal.entity.order.OrderProduct;
import com.ifunpay.portal.service.MemberAddrService;
import com.ifunpay.portal.service.MemberUserService;
import com.ifunpay.portal.service.OrderVoucherService;
import com.ifunpay.portal.service.ThreadPoolService;
import com.ifunpay.portal.service.order.OrderEntityService;
import com.ifunpay.portal.service.order.OrderProductService;
import com.ifunpay.portal.util.UserSecurity;
import com.ifunpay.sms.SmsCenterResponse;
import com.ifunpay.sms.sdk.SmsClient;
import com.ifunpay.util.Constant;
import com.ifunpay.util.common.StringUtil;
import com.ifunpay.util.network.HttpStatusClient;
import com.ifunpay.util.web.cookie.CookieUtil;
import com.jspgou.cms.entity.Product;
import com.jspgou.cms.entity.ProductPicture;
import com.jspgou.cms.manager.LimitBuyMng;
import com.jspgou.cms.manager.ProductMng;
import com.jspgou.common.web.session.SessionProvider;
import com.jspgou.core.web.Constants;
import com.octo.captcha.service.CaptchaService;
import net.sf.json.JSONObject;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.*;

/**
 * Created by David on 2015/3/24.
 */
@Controller
@RequestMapping("/personCore")
public class PersonCoreController {
    private Logger log = Logger.getLogger(PersonCoreController.class);

    /**
     * 个人中心 登录 页面
     *
     * @param mav
     * @return
     */
    @Deprecated
    @RequestMapping("tologin.do")
    public ModelAndView toPD(ModelAndView mav) {
        mav.setViewName("personCore/login");
        return mav;
    }


    /**
     * 登录
     *
     * @param
     * @param request
     * @param response
     * @return
     */
    @Deprecated
    @RequestMapping("login.do")
    public void login(String mobileCode, String username, String password, HttpServletRequest request, HttpServletResponse response) {
        JSONObject json = new JSONObject();
        String url = null;
        MemberUserEntity memberUserEntity = memberUserService.getEntityByName(username);
        String success = "false";
        String errorMsg = null;


        if (null == memberUserEntity) {
            if (!"".equals(mobileCode)) {
                String code = (String) session.getAttribute(request, "verifiedCode");
                if (code.equals(mobileCode)) {
                    session.setAttribute(request, response, Constants.DHB_MEMBER, username);
                    MemberUserEntity entity = new MemberUserEntity();
                    entity.setName(username);
                    entity.setLastLogin(new Date());
                    entity.setRegisterDate(new Date());
                    entity.setLastLoginIp(request.getRemoteAddr());
                    entity.setPhone(username);
                    entity.setUserStatus(2);
                    memberUserService.save(entity);
                    url = "mvc/personCore/personInfoComplete.do";
                    success = "success";
                } else {
                    errorMsg = "验证码错误";
                }


            }else {
                errorMsg = "用户不存在";
            }
        } else {
//
            if (!"".equals(password)) {
                UserSecurity userSecurity = new UserSecurity();
                if (userSecurity.checkPassword(password, memberUserEntity.getPassword())) {
                    session.setAttribute(request, response, Constants.DHB_MEMBER, username);
                    memberUserEntity.setLastLogin(new Date());
                    memberUserEntity.setLastLoginIp(request.getRemoteAddr());
                    memberUserService.update(memberUserEntity);
                    url = "mvc/personCore/myAccount.do";
                    success = "success";
                } else {
                    errorMsg = "密码错误";
                }
            } else if (!"".equals(mobileCode)) {
                String code = (String) session.getAttribute(request, "verifiedCode");
                if (code.equals(mobileCode)) {
                    session.setAttribute(request, response, Constants.DHB_MEMBER, username);
                    memberUserEntity.setLastLogin(new Date());
                    memberUserEntity.setLastLoginIp(request.getRemoteAddr());
                    memberUserService.update(memberUserEntity);
                    if (null == memberUserEntity.getPassword()) {
                        url = "mvc/personCore/personInfoComplete.do";

                    } else {
                        url = "mvc/personCore/myAccount.do";
                    }
                    success = "success";
                } else {
                    errorMsg = "验证码错误";
                }
            }
        }

//            String   member = memberLogin(1,username,password);
        json.accumulate("url", url);
        json.accumulate("success", success);
        json.accumulate("errorMsg", errorMsg);
        response.setContentType("text/html; charset=utf-8");
        try {
            response.getWriter().write(json.toString());
        } catch (IOException e) {
            log.info("", e);
        }
        log.info("member '{}' login success." + username);
    }


    /**
     * purpose: 用户登录后 注销操作<br>
     * step: <br>
     *
     * @param mav
     * @param request
     * @return
     */
    @RequestMapping("loginOff.do")
    public ModelAndView loginOff(ModelAndView mav, HttpServletRequest request, HttpServletResponse response) {
        session.logout(request, response);
        mav.setViewName("personCore/login");
        return mav;
    }

    /**
     * 个人中心 页面
     *
     * @param mav
     * @param request
     */
    @RequestMapping("myAccount.do")
    public ModelAndView myAccount(ModelAndView mav, HttpServletRequest request) {
        //首次登陆后
        String member = (String) session.getAttribute(request, Constants.DHB_MEMBER);
        if (null == member) {
            mav.setViewName("personCore/login");
        } else {
            mav.addObject("member", member);
            mav.setViewName("personCore/myAccount");
        }
        return mav;
    }


    /**
     * 个人中心 页面
     *
     * @param mav
     * @param request
     */
    @RequestMapping("personInfoComplete.do")
    public ModelAndView personInfoComplete(ModelAndView mav, HttpServletRequest request) {
        //首次登陆后
        String member = (String) session.getAttribute(request, Constants.DHB_MEMBER);
        if (null == member) {
            mav.setViewName("personCore/login");
        } else {
            mav.addObject("member", member);
            mav.setViewName("personCore/personInfoComplete");
        }
        return mav;
    }

    /**
     * 个人中心 页面
     *
     * @param response
     * @param request
     */
    @RequestMapping("personInfoSave")
    public void personInfoSave(String login_pwd,
                               String confirm_pwd,
                               HttpServletRequest request, HttpServletResponse response) {

        String member = (String) session.getAttribute(request, Constants.DHB_MEMBER);
        MemberUserEntity memberUserEntity = memberUserService.getEntityByName(member);
        UserSecurity userSecurity = new UserSecurity();
        login_pwd = userSecurity.encryptPassword(login_pwd);
        memberUserEntity.setPassword(login_pwd);
        memberUserService.update(memberUserEntity);
        JSONObject json = new JSONObject();
        json.accumulate("url", "mvc/personCore/myAccount.do");
        json.accumulate("member", member);
        response.setContentType("text/html; charset=utf-8");
        try {
            response.getWriter().write(json.toString());
        } catch (IOException e) {
            log.info(e);
        }
    }

    /**
     * 收货地址
     *
     * @param mav
     * @param request
     * @return
     */
    @RequestMapping("changeinfo.do")
    public ModelAndView changeinfo(ModelAndView mav, HttpServletRequest request) {
        String member = (String) session.getAttribute(request, Constants.DHB_MEMBER);
        if (null == member) {
            mav.setViewName("personCore/login");
        } else {
            mav.addObject("member", member);
            MemberUserEntity memberUserEntity = memberUserService.getEntityByName(member);
            List<MemberAddr> memberAddrList = memberAddrService.getAddrByMember(memberUserEntity.getId().toString());
            MemberAddr memberAddr = new MemberAddr();
            String address = "无";
            if (memberAddrList.size() > 0) {
                memberAddr = memberAddrList.get(0);
                address = memberAddr.getName() + "," + memberAddr.getPhone() + "," + memberAddr.getProvince() + memberAddr.getCity() + memberAddr.getDetail();
            }
            mav.addObject("address", address);
            mav.setViewName("personCore/changeinfo");
        }
        return mav;
    }


    /**
     * 设置/修改密码
     *
     * @param mav
     * @param request
     * @return
     */
    @RequestMapping("settingPassword.do")
    public ModelAndView settingPwd(ModelAndView mav, HttpServletRequest request) {
        String member = (String) session.getAttribute(request, Constants.DHB_MEMBER);
        if (null == member) {
            mav.setViewName("personCore/login");
        } else {
            mav.addObject("member", member);
            MemberUserEntity memberUserEntity = memberUserService.getEntityByName(member);
            if(null!=memberUserEntity.getPassword() &&"".equals(memberUserEntity.getPassword()) ){
                mav.addObject("settingP", 0);
            }else {

                mav.addObject("settingP", 1);
            }

            mav.setViewName("personCore/settingPassword");
        }
        return mav;
    }

    /**
     * 保存设置/修改密码
     *
     * @param request
     * @return
     */
    @RequestMapping("savePwd.do")
    public void savePwd(String oldPwd,String pwd,Integer settingP, HttpServletRequest request,HttpServletResponse response) {
        JSONObject json = new JSONObject();
        String member = (String) session.getAttribute(request, Constants.DHB_MEMBER);
        UserSecurity userSecurity = new UserSecurity();
        String success = "false";
        if (null != member) {
            MemberUserEntity memberUserEntity = memberUserService.getEntityByName(member);
            if(settingP ==1){ // 0设置密码  1 修改密码
                try {
                    String oldP = userSecurity.encryptPassword(oldPwd);
                    String password = userSecurity.encryptPassword(pwd);
                    if(oldP.equals(memberUserEntity.getPassword())){
                        memberUserEntity.setPassword(password);
                        memberUserService.update(memberUserEntity);
                        success = "success";
                    }
                }catch(Exception e){
                    log.info("update  member pwd false", e);

                }
            }else {
                try {
                    String password = userSecurity.encryptPassword(pwd);
                    memberUserEntity.setPassword(password);
                    memberUserService.update(memberUserEntity);

                    success = "success";


                }catch (Exception e){
                    log.info("update  member pwd false",e);

                }
               }

            json.accumulate("success", success);

            response.setContentType("text/html; charset=utf-8");
            try {
                response.getWriter().write(json.toString());
            } catch (IOException e) {
                log.info("", e);
            }
        }
    }


    /**
     * 收货地址
     *
     * @param mav
     * @param request
     * @return
     */
    @RequestMapping("upchangeinfo")
    public ModelAndView upchangeinfo(String mobile, String real_name, String city, String pro, String detail, ModelAndView mav, HttpServletRequest request) {
        String member = (String) session.getAttribute(request, Constants.DHB_MEMBER);
        String type = "2";//调用 修改个人信息 的接口
        if (null == member) {
            mav.setViewName("personCore/login");
        } else {
            try {

                MemberUserEntity memberUserEntity = memberUserService.getEntityByName(member);
                List<MemberAddr> memberAddrList = memberAddrService.getAddrByMember(memberUserEntity.getUuid());

                MemberAddr memberAddr = new MemberAddr();
                if (memberAddrList.size() > 0) {
                    memberAddr = memberAddrList.get(0);
                }
                memberAddr.setMemberId(memberUserEntity.getId().toString());
                memberAddr.setPhone(mobile);
                memberAddr.setName(real_name);
                memberAddr.setCity(city);
                memberAddr.setProvince(pro);
                memberAddr.setDetail(detail);
                memberAddr.setCreateTime(new Date());
                if (memberAddrList.size() > 0) {
                    memberAddrService.update(memberAddr);
                } else {
                    memberAddrService.save(memberAddr);
                }

                mav.addObject("member", member);
                mav.addObject("address", real_name + "," + member + "," + pro + city + detail);

                mav.addObject("status", "1");
                mav.addObject("errorMsg", "修改成功");
                mav.setViewName("personCore/changeinfo");
            } catch (Exception e) {
                log.info("update address false", e);
                mav.addObject("errorMsg", "修改失败");
                mav.setViewName("personCore/changeinfo");
            }


        }
        return mav;
    }


    /**
     * 设置/修改密码
     *
     * @param request
     * @return
     */
    @RequestMapping("upPwd.html")
    public void upPwd(String pwd, HttpServletRequest request,HttpServletResponse response) {
        JSONObject json = new JSONObject();
        String success = "false";
        String errorMsg = "";
        String member = (String) session.getAttribute(request, Constants.DHB_MEMBER);
        if (null == member) {
            errorMsg = "用户不存在！";
        } else {
            try {
                    MemberUserEntity memberUserEntity = memberUserService.getEntityByName(member);
                    UserSecurity userSecurity = new UserSecurity();
                    String password = userSecurity.encryptPassword(pwd);
                    memberUserEntity.setPassword(password);
                    memberUserService.update(memberUserEntity);
                    errorMsg="保存密码成功";
                    success = "success";
                }catch(Exception e){
                    log.info("update  member pwd false", e);
                    errorMsg= "保存密码失败";
                }
            json.accumulate("success", success);
            json.accumulate("errorMsg", errorMsg);
            response.setContentType("text/html; charset=utf-8");
            try {
                response.getWriter().write(json.toString());
            } catch (IOException e) {
                log.info("", e);
            }

        }

    }

    /**
     * 查看我的订单列表
     */
    @RequestMapping("myOrders.do")
    public ModelAndView myOrders(ModelAndView mav, HttpServletRequest request) {
        String member = (String) session.getAttribute(request, Constants.DHB_MEMBER);
        if (null == member) {
            mav.setViewName("personCore/login");
        } else {
            Long memberId = Long.valueOf(member);
            String commerceId = null;
            List<OrderEntity> list = orderEntityService.getlistByCommerceAndmember(commerceId, memberId);
            mav.addObject("orderList", list);
            mav.addObject("orderListSize", list.size());
            mav.addObject("currPage", 1);
            mav.setViewName("personCore/myOrders");
        }
        return mav;
    }


    /**
     * purpose:订单列表 查询订单详情 <br>
     * step: <br>
     *
     * @param mav
     * @return
     */
    @RequestMapping("orderDetail.html")
    public ModelAndView orderDetail(Long order_id, ModelAndView mav, HttpServletRequest request) {
        String member = (String) session.getAttribute(request, Constants.DHB_MEMBER);
        if (null == member) {
            mav.setViewName("personCore/login");
        } else {
            try {
                OrderEntity orderDetail = orderEntityService.findOrderEntityById(order_id);
                int totalQuan = 0;//购买总金额
                int productQty = 0;//购买总数
                Object postInfo = null;
                mav.addObject("postInfo", postInfo);//邮寄地址信息
                mav.addObject("waitPostInfo", null);//待发货的邮寄信息
                String postHight = "130px";
                if (postInfo != null) {
                    postHight = "180px";
                }
                mav.addObject("postHight", postHight);
                mav.addObject("totalQuan", totalQuan);
                mav.addObject("orderDetail", orderDetail);
                List<OrderProduct> orderProductList = orderProductService.getOrderProductByOrderId(orderDetail.getCode());
                StringBuffer productName = new StringBuffer();
                for (OrderProduct orderProduct : orderProductList) {
                    productQty = productQty + orderProduct.getProductQty();
                    productName.append(orderProduct.getProductName());
                }
                mav.addObject("productName",productName.toString());
                mav.addObject("totals", productQty);
                mav.addObject("phone", orderDetail.getMemberUserEntity().getPhone());
                mav.setViewName("personCore/orderDetail");

            } catch (Exception e) {
                log.error("操作异常", e);
                mav.addObject("errorMsg", "操作失败,请重试");
                mav.setViewName("personCore/myOrders");
            }
        }
        return mav;
    }


    /**
     * purpose:跳转到注册页面br>
     * step: <br>
     *
     * @param mav
     * @return
     */
    @RequestMapping("toregister.do")
    public ModelAndView toRegister(ModelAndView mav) {
        mav.setViewName("personCore/register");
        return mav;
    }


    /**
     * 手机号的校验和发送验证码
     */
    @RequestMapping(value = "sendMobileCode", method = RequestMethod.POST)
    public void sendMobileCode(String mobile, String checkCode, HttpServletRequest request, HttpServletResponse response) {
        String id = session.getSessionId(request, response);
        String verifiedCode = null;
        Boolean validateCheckCode = false;
        HashMap<String, String> map = new HashMap<>();
        if(checkCode != null &&! "".equals(checkCode)) {
            try {
                validateCheckCode = captchaService.validateResponseForID(id, checkCode.toUpperCase());
            } catch (Exception e) {
                log.info("validateCheckCode false", e);
                map.put("success", "false");
                map.put("errorMsg", "发送失败，验证码过期，请刷新验证");
            }
            try {
                if (validateCheckCode) {
                    verifiedCode = sandMsg(mobile);
                    if (null != verifiedCode) {
                        session.setAttribute(request, response, "verifiedCode", verifiedCode);
                        map.put("success", "true");
                    } else {
                        map.put("success", "false");
                        map.put("errorMsg", "发送失败，请重新发送");
                    }
                }

            } catch (Exception e) {
                log.info("sendMsg false", e);
                map.put("success", "false");
                map.put("errorMsg", "发送失败，请重新发送");
            }
        } else {
            map.put("success", "false");
            map.put("errorMsg", "发送失败，请先输入验证码");
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
     * 用户注册
     */
    @RequestMapping("registering")
    public void register(String mobile, String mobileCode, String login_pwd, String confirm_pwd, HttpServletRequest request, HttpServletResponse response) {
        String code = (String) session.getAttribute(request, "verifiedCode");
        HashMap<String, String> map = new HashMap<String, String>();
        String url;
        if (mobileCode.equals(code)) {
            try {
                MemberUserEntity memberUserEntity = new MemberUserEntity();
                memberUserEntity.setName(mobile);
                memberUserEntity.setPassword(login_pwd);
                memberUserEntity.setPhone(mobile);
                memberUserEntity.setRegisterDate(new Date());
                memberUserEntity.setRegisterIp(request.getLocalAddr());
                memberUserEntity.setUserStatus(1);
                memberUserService.save(memberUserEntity);
                map.put("success", "true");
                url = "mvc/personCore/tologin.do";
                map.put("url", url);
            } catch (Exception e) {
                map.put("success", "false");
                map.put("errorMsg", "error");
                url = "mvc/personCore/toregister.do";
                map.put("url", url);
            }
        } else {
            map.put("success", "false");
            map.put("errorMsg", "验证码错误");
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
     * 注册页面
     *
     * @param model
     */
    @RequestMapping("register")
    public void register(Model model) {
    }


    /**
     * 找回密码页面
     */
    @RequestMapping("findPassword.html")
    public ModelAndView findPassword(ModelAndView mav) {
        mav.setViewName("/personCore/findPassword");
        return mav;
    }


    /**
     * 找回密码
     *
     * @param mobile
     * @param mobileCode
     * @param login_pwd
     * @param confirm_pwd
     * @param request
     * @param response
     */
    @RequestMapping("updatePwd")
    public void updatePwd(String mobile, String mobileCode, String login_pwd, String confirm_pwd, HttpServletRequest request, HttpServletResponse response) {
        String code = (String) session.getAttribute(request, "verifiedCode");
        HashMap<String, String> map = new HashMap<>();
        String url = null;
        String type = "1"; // 修改用户密码接口
        if (mobileCode.equals(code)) {
//            JSONObject data = doRegister(type,mobile,login_pwd);
            try {
                MemberUserEntity memberUserEntity = memberUserService.getEntityByName(mobile);
                UserSecurity userSecurity = new UserSecurity();
                String password = userSecurity.encryptPassword(login_pwd);
                memberUserEntity.setPassword(password);
                memberUserService.update(memberUserEntity);
                map.put("success", "true");
                url = "mvc/personCore/tologin.do";
                map.put("url", url);
            } catch (Exception e) {
                log.info("updatePassword false", e);
                map.put("success", "false");
                map.put("errorMsg", "修改密码失败");
                url = "mvc/personCore/toregister.do";
                map.put("url", url);
            }


        }
        JSONObject json = JSONObject.fromObject(map);
        response.setContentType("text/html; charset=utf-8");
        try {
            response.getWriter().write(json.toString());
        } catch (IOException e) {
            log.info(e);
        }
    }


    @RequestMapping("order/{apId}/{flag}/{terminalId}/{serialNo}/{step}")
    public ModelAndView orderConfirm(@PathVariable Long apId, @PathVariable String flag, @PathVariable String terminalId, @PathVariable String serialNo, @PathVariable String step, ModelAndView mav, HttpServletRequest request, HttpServletResponse response) {
        try {
        Product product = productMng.findById(apId);
        if (1 == product.getBuyStep() || "1".equals(step)) {
            if ("1".equals(flag)) {
                //推送扫码成功消息到指定的终端
                threadPoolService.execute(() -> {
                    log.info("start to scan via remote control,terminalId:" + terminalId + ",serialNo:" + serialNo);
                    BaseRestResponse response1 = null;
                    if ("1".equals(serialNo)) {
                         response1 = terminalFrontRemoteControl.scanned(terminalId, null);
                    } else {
                         response1 = terminalFrontRemoteControl.scanned(terminalId, serialNo);
                    }
                    log.info("terminalId:" + terminalId + ",serialNo:" + serialNo + "scanned response: " + response1);
                });
            }
            HttpSession session1 = request.getSession();
            session1.setAttribute("tId", terminalId);
            session1.setAttribute("flag", flag);
            session1.setAttribute("needLogin", product.getLoginOrNot());
            session1.setAttribute("serialNo", serialNo);
            mav.addObject("productCount", product.getStockCount());
            mav.addObject("productId", product.getId());
            mav.addObject("productName", product.getName());
            mav.addObject("productPrice", product.getScanningPrice());
            mav.addObject("prodType", product.getProductStamp());
            mav.addObject("needLogin", product.getLoginOrNot());
            mav.addObject("onSale", product.getOnSale());
            if (1 == product.getLoginOrNot()) {
                Optional<String> cookie = CookieUtil.getCookieValue(request, Constant.DEVICE_COOKIE_NAME);
                String cookieString = cookie.orElse(null);
                log.info("service name = " + cookieString);
                boolean limit=false;
                try {
                     limit = limitBuyMng.checkLimitOrNot(product.getId(), product.getLoginOrNot().longValue(), null, cookieString);

                }catch (Exception e){
                    log.info("限购异常",e);
                    mav.setViewName("error");
                }
                mav.addObject("buyLimit", limit);
            } else {
                mav.addObject("buyLimit", false);
            }
            mav.setViewName("personCore/orderConfirm");
        } else {
            List<ProductPicture> productPictures = product.getPictures();
            Integer defaultCount = 3;
            Integer count = 0;
            List<Map<String, String>> listPictures = new ArrayList<>();
            Map<String, String> mapPictures = new HashMap<>();
            if (productPictures.size() > 0) {
                count = Integer.min(defaultCount, productPictures.size());
                for (int i = 0; i < count; i++) {
                    mapPictures = new HashMap<>();
                    mapPictures.put("picture", ProjectXml.getValue("base_path_upload") + productPictures.get(i).getAppPicturePath());
                    listPictures.add(mapPictures);
                }
            } else {
                mapPictures.put("picture", "/images/no_image.jpg");
                listPictures.add(mapPictures);
                count = 1;
            }

            mav.addObject("pictureCount", count);
            mav.addObject("listPictures", listPictures);
            mav.addObject("product", product);
            mav.addObject("url", "mvc/personCore/order" + "/" + apId + "/" + flag + "/" + terminalId + "/" + serialNo + "/" + "1");
            mav.setViewName("personCore/twoStepOrderConfirm");
        }
        }catch (Exception e){
            log.info("go to buy product false ",e);
            mav.addObject("msg","系统繁忙，请稍后再试!");
            mav.setViewName("error");
        }

        return mav;
    }


    /**
     * 登录
     *
     * @param
     * @param request
     * @param response
     * @return
     */
    @Deprecated
    @RequestMapping("orderLogin.do")
    public void orderLogin(String mobileCode, String username, String password, Long productId, HttpServletRequest request, HttpServletResponse response) {
        JSONObject json = new JSONObject();
        MemberUserEntity memberUserEntity = memberUserService.getEntityByName(username);
        String success = null;
        if (null == memberUserEntity) {
            if (!"".equals(mobileCode)) {
                String code = (String) session.getAttribute(request, "verifiedCode");
                if(code == null){
                    success = "false";
                }else {
                    if (code.equals(mobileCode)) {
                        HttpSession session1 = request.getSession();
                        session1.setAttribute("member", username);
                        MemberUserEntity entity = new MemberUserEntity();
                        entity.setName(username);
                        entity.setLastLogin(new Date());
                        entity.setLastLoginIp(request.getRemoteAddr());
                        entity.setPhone(username);
                        entity.setUserStatus(2);
                        memberUserService.save(entity);
                        success = "success";
                    } else {
                        success = "false";
                    }
                }


            }else {
                success = "false";
            }
        } else {
            if (!"".equals(password)) {
                UserSecurity userSecurity = new UserSecurity();
                if (userSecurity.checkPassword(password, memberUserEntity.getPassword())) {
                    HttpSession session1 = request.getSession();
                    session1.setAttribute("member", username);
                    memberUserEntity.setLastLogin(new Date());
                    memberUserEntity.setLastLoginIp(request.getRemoteAddr());
                    memberUserService.update(memberUserEntity);

                    success = "success";
                } else {
                    success = "false";
                }
            } else if (!"".equals(mobileCode)) {
                String code = (String) session.getAttribute(request, "verifiedCode");
                if(code == null){
                    success = "false";
                }else {
                    if (code.equals(mobileCode)) {
                        HttpSession session1 = request.getSession();
                        session1.setAttribute("member", username);
                        memberUserEntity.setLastLogin(new Date());
                        memberUserEntity.setLastLoginIp(request.getRemoteAddr());
                        memberUserService.update(memberUserEntity);

                        success = "success";
                    } else {
                        success = "false";
                    }
                }
            }
        }
        boolean limit = limitBuyMng.checkLimitOrNot(productId, new Long(0), Long.valueOf(username), null);
        json.accumulate("buyLimit", limit);
        json.accumulate("success", success);

        response.setContentType("text/html; charset=utf-8");
        try {
            response.getWriter().write(json.toString());
        } catch (IOException e) {
            log.info(e);
        }
        log.info("member '{}' login success." + username);
    }


    public String sandMsg(String mobile) {

        String s = StringUtil.generatedRandomNumber(4);
//        String smsContent="【艾丰宝】温馨提示：本次操作验证码为："+s+"；验证码5分钟内有效，请不要告知他人。";
        String smsModel = orderVoucherService.getPubMould(ProjectXml.getValue("send_check_sms_model_key"));
        Map<String, String> smsValue = new HashMap<String, String>();
        smsValue.put("verifiedCode", s);
        String smsContent = null;
        try {
            smsContent = orderVoucherService.process(smsValue, smsModel);
        } catch (Exception e) {
            log.info("", e);
        }
        try {
            SmsCenterResponse smsCenterResponse = client.sendMessage(mobile, smsContent);
            return s;
        } catch (Exception e) {
            return null;
        }
    }


    @Autowired
    private ProductMng productMng;
    @Autowired
    private MemberUserService memberUserService;

    @Autowired
    private OrderEntityService orderEntityService;
    @Resource
    private MemberAddrService memberAddrService;

    @Autowired
    private SessionProvider session;


    public SessionProvider getSession() {
        return session;
    }

    public void setSession(SessionProvider session) {
        this.session = session;
    }

    @Autowired
    private SmsClient client;

    @Resource
    private ThreadPoolService threadPoolService;
    @Resource
    private TerminalFrontRemoteControl terminalFrontRemoteControl;

    @Resource
    private LimitBuyMng limitBuyMng;

    @Autowired
    private HttpStatusClient httpStatusClient;
    @Autowired
    private CaptchaService captchaService;

    @Autowired
    private OrderProductService orderProductService;

    @Resource
    private OrderVoucherService orderVoucherService;

}
