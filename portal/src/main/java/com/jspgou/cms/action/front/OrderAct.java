package com.jspgou.cms.action.front;

import static com.jspgou.cms.Constants.MEMBER_SYS;
import java.util.List;
import java.util.Set;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.jspgou.cms.entity.Cart;
import com.jspgou.cms.entity.Order;
import com.jspgou.cms.entity.OrderItem;
import com.jspgou.cms.entity.OrderReturn;
import com.jspgou.cms.entity.Payment;
import com.jspgou.cms.entity.PaymentPlugins;
import com.jspgou.cms.entity.Product;
import com.jspgou.cms.entity.ProductFashion;
import com.jspgou.cms.entity.Shipping;
import com.jspgou.cms.entity.ShopMember;
import com.jspgou.cms.entity.ShopScore;
import com.jspgou.cms.manager.OrderMng;
import com.jspgou.cms.manager.OrderReturnMng;
import com.jspgou.cms.manager.PaymentMng;
import com.jspgou.cms.manager.PaymentPluginsMng;
import com.jspgou.cms.manager.ProductFashionMng;
import com.jspgou.cms.manager.ProductMng;
import com.jspgou.cms.manager.ShippingMng;
import com.jspgou.cms.manager.ShopMemberMng;
import com.jspgou.cms.manager.ShopScoreMng;
import com.jspgou.cms.service.ShoppingSvc;
import com.jspgou.cms.web.ShopFrontHelper;
import com.jspgou.cms.web.SiteUtils;
import com.jspgou.cms.web.threadvariable.MemberThread;
import com.jspgou.common.page.Pagination;
import com.jspgou.common.security.annotation.Secured;
import com.jspgou.common.web.ResponseUtils;
import com.jspgou.common.web.springmvc.MessageResolver;
import com.jspgou.core.entity.Website;
import com.jspgou.core.web.WebErrors;
import com.jspgou.core.web.front.FrontHelper;
import com.jspgou.core.web.front.URLHelper;

/**
* This class should preserve.
* @preserve
*/
@Secured
@Controller
public class OrderAct {
	/**
	 * 我的订单
	 */
	private static final String MY_ORDER = "tpl.myOrder";
	private static final String MY_RETURN_ORDER = "tpl.myReturnOrder";
	private static final String MY_ORDER_VIEW = "tpl.myOrderView";
	private static final String SUCCESSFULLY_ORDER = "tpl.successfullyOrder";

	/**
	 * 订单列表
	 */
	@RequestMapping(value = "/order/myorder*.jspx")
	public String myOrder(Integer status,String code,String userName, Long paymentId,
			Long shippingId, String startTime,String endTime,Double startOrderTotal,
			Double endOrderTotal,HttpServletRequest request, ModelMap model) {
		Website web = SiteUtils.getWeb(request);
		ShopMember member = MemberThread.get();
		if(member==null){
			return "redirect:../login.jspx";
		}
		if(StringUtils.isBlank(userName)){
			userName = null;
		}
		if(StringUtils.isBlank(startTime)){
			startTime = null;
		}
		if(StringUtils.isBlank(endTime)){
			endTime = null;
		}
		List<Shipping> shippingList = shippingMng.getList(web.getId(), true);
		List<Payment> paymentList = paymentMng.getList(web.getId(), true);
		model.addAttribute("historyProductIds", getHistoryProductIds(request));
		model.addAttribute("paymentList", paymentList);
		model.addAttribute("shippingList", shippingList);
		model.addAttribute("status", status);
		model.addAttribute("code",code);
		model.addAttribute("userName", userName);
		model.addAttribute("startTime", startTime);
		model.addAttribute("endTime", endTime);
		model.addAttribute("paymentId", paymentId);
		model.addAttribute("shippingId", shippingId);
		model.addAttribute("startOrderTotal",startOrderTotal);
		model.addAttribute("endOrderTotal", endOrderTotal);
		Integer pageNo = URLHelper.getPageNo(request);
		ShopFrontHelper.setCommonData(request, model, web, 1);
		ShopFrontHelper.setDynamicPageData(request, model, web, "", "myorder",".jspx", pageNo);
		return web.getTplSys(MEMBER_SYS, MessageResolver.getMessage(request,MY_ORDER));
	}
	
	/**
	 * 查看订单详情
	 */
	@RequestMapping(value = "/order/myOrderView.jspx")
	public String myOrderView(Long orderId, HttpServletRequest request,
			ModelMap model) {
		Website web = SiteUtils.getWeb(request);
		ShopMember member = MemberThread.get();
		if(member==null){
			return "redirect:../login.jspx";
		}
		WebErrors errors = validateOrderView(orderId, member, request);
		if (errors.hasErrors()) {
			return FrontHelper.showError(errors, web, model, request);
		}
		Order order = manager.findById(orderId);
		model.addAttribute("order", order);
		ShopFrontHelper.setCommonData(request, model, web, 1);
		return web.getTplSys(MEMBER_SYS, MessageResolver.getMessage(request,MY_ORDER_VIEW));
	}

	/**
	 * 生成订单
	 */
	@RequestMapping(value = "/order/order_shipping.jspx", method = RequestMethod.POST)
	public String orderShipping(Long deliveryInfo,Long shippingMethodId,Long paymentMethodId,Long[] cartItemId,String comments,String memberCouponId,
			HttpServletRequest request,HttpServletResponse response, ModelMap model) {
		Website web = SiteUtils.getWeb(request);
		ShopMember member = MemberThread.get();
		if(member==null){
			return "redirect:../login.jspx";
		}
		Order order = null;
		Cart cart = shoppingSvc.getCart(member.getId());		
		if(cart!=null){
		   order = manager.createOrder(cart, cartItemId, shippingMethodId,deliveryInfo,paymentMethodId,comments,request.getRemoteAddr(), member, web.getId(),memberCouponId);
		}
		shoppingSvc.clearCookie(request, response);	
		List<PaymentPlugins> list = paymentPluginsMng.getList();
		model.addAttribute("list", list);
		model.addAttribute("order", order);
		ShopFrontHelper.setCommonData(request, model, web, 1);
		return web.getTplSys(MEMBER_SYS, MessageResolver.getMessage(request,SUCCESSFULLY_ORDER));
	}
	
	
	/**
	 * 删除订单
	 */
	@RequestMapping(value = "/order/deleteOrder.jspx")
	public void deleteOrder(Long orderId,HttpServletRequest request,
			HttpServletResponse response) throws JSONException {
		JSONObject json=new JSONObject();
		if(orderId!=null){
			Order order=manager.findById(orderId);
			order.getItems().clear();
			manager.deleteById(orderId);
		}
		json.put("success", true);
		ResponseUtils.renderJson(response, json.toString());
	}
	
	/**
	 * 取消订单
	 */
	@RequestMapping(value = "/order/abolishOrder.jspx")
	public void abolishOrder(Long orderId,HttpServletRequest request,
			HttpServletResponse response) throws JSONException {
		JSONObject json=new JSONObject();
		ShopMember member = MemberThread.get();
		if(orderId!=null){
			Order order=manager.findById(orderId);
			order.setStatus(3);
			Set<OrderItem> set = order.getItems();
			//处理库存
			for(OrderItem item:set){	
				Product product=item.getProduct();
				if(item.getProductFash()!=null){
					ProductFashion fashion=item.getProductFash();
					fashion.setStockCount(fashion.getStockCount()+item.getCount());
					product.setStockCount(product.getStockCount()+item.getCount());
					productFashionMng.update(fashion);
				}else{
					product.setStockCount(product.getStockCount()+item.getCount());
				}
				productMng.updateByUpdater(product);
			}
			//会员冻结的积分
			member.setFreezeScore(member.getFreezeScore()-order.getScore());
			shopMemberMng.update(member);
			List<ShopScore> list = shopScoreMng.getlist(order.getCode());
			for(ShopScore s:list){
				shopScoreMng.deleteById(s.getId());
			}
			manager.updateByUpdater(order);
		}	
		json.put("success", true);
		ResponseUtils.renderJson(response, json.toString());
	}
	
	
	/**
	 * 确认收货
	 */
	@RequestMapping(value = "/order/accomplishOrder.jspx")
	public void accomplishOrder(Long orderId,HttpServletRequest request,
			HttpServletResponse response) throws JSONException {
		JSONObject json=new JSONObject();
		ShopMember member = MemberThread.get();
		if(orderId!=null){
			Order order=manager.findById(orderId);
			order.setStatus(4);
			//会员冻结的积分
			member.setFreezeScore(member.getFreezeScore()-order.getScore());
			member.setScore(member.getScore()+order.getScore());
			shopMemberMng.update(member);
			List<ShopScore> list = shopScoreMng.getlist(order.getCode());
			for(ShopScore s:list){
				s.setStatus(true);
				shopScoreMng.update(s);
			}
			manager.updateliRun(orderId);
			manager.updateByUpdater(order);
		}
		json.put("success", true);
		ResponseUtils.renderJson(response, json.toString());
	}
	
	/**
	 * 再次支付订单
	 */
	@RequestMapping(value = "/order/order_payAgain.jspx")
	public String payOrderAgain(Long orderId,HttpServletRequest request,HttpServletResponse response, ModelMap model) {
		Website web = SiteUtils.getWeb(request);
		ShopMember member = MemberThread.get();
		if(member==null){
			return "redirect:../login.jspx";
		}
		WebErrors errors = validateOrderView(orderId, member, request);
		if (errors.hasErrors()) {
			return FrontHelper.showError(errors, web, model, request);
		}
		shoppingSvc.clearCookie(request, response);
		Order order=manager.findById(orderId);
		List<PaymentPlugins> list = paymentPluginsMng.getList();
		model.addAttribute("list", list);
		model.addAttribute("order", order);
		ShopFrontHelper.setCommonData(request, model, web, 1);
		return web.getTplSys(MEMBER_SYS, MessageResolver.getMessage(request,SUCCESSFULLY_ORDER));
	}
	
	/**
	 * 退换货订单列表
	 */
	@RequestMapping(value = "/order/myReturnOrder*.jspx")
	public String myReturnOrder(HttpServletRequest request, ModelMap model) {
		Website web = SiteUtils.getWeb(request);
		ShopMember member = MemberThread.get();
		if(member==null){
			return "redirect:../login.jspx";
		}
	   
		Integer pageNo = URLHelper.getPageNo(request);
		Pagination pagination = manager.getPageForOrderReturn(member.getId(), pageNo, 10);
		model.addAttribute("pagination", pagination);
		model.addAttribute("historyProductIds", getHistoryProductIds(request));
		ShopFrontHelper.setCommonData(request, model, web, 1);
		ShopFrontHelper.setDynamicPageData(request, model, web, "", "myReturnOrder",".jspx", pageNo);
		return web.getTplSys(MEMBER_SYS, MessageResolver.getMessage(request,MY_RETURN_ORDER));
	}
	
	
	/**
	 * 发货
	 */
	@RequestMapping(value = "/order/shipments.jspx")
	public String shipments(Long id,HttpServletRequest request, ModelMap model) {
		Website web = SiteUtils.getWeb(request);
		ShopMember member = MemberThread.get();
		if(member==null){
			return "redirect:../login.jspx";
		}
		WebErrors errors = validateOrderReturnView(id,member,request);
		if (errors.hasErrors()) {
			return FrontHelper.showError(errors, web, model, request);
		}
		OrderReturn entity = orderReturnMng.findById(id);
		entity.setStatus(4);
		orderReturnMng.update(entity);
		return myReturnOrder(request,model);
	}
	
	/**
	 *退货确认
	 */
	@RequestMapping(value = "/order/accomplish.jspx")
	public String accomplish(Long id, HttpServletRequest request, ModelMap model) {
		Website web = SiteUtils.getWeb(request);
		ShopMember member = MemberThread.get();
		if(member==null){
			return "redirect:../login.jspx";
		}
		WebErrors errors = validateOrderReturnView(id,member,request);
		if (errors.hasErrors()) {
			return FrontHelper.showError(errors, web, model, request);
		}
		OrderReturn entity = orderReturnMng.findById(id);
		entity.setStatus(7);
		Set<OrderItem> set = entity.getOrder().getItems();
		//处理库存
		for(OrderItem item:set){	
			Product product=item.getProduct();
			if(item.getProductFash()!=null){
				ProductFashion fashion=item.getProductFash();
				fashion.setStockCount(fashion.getStockCount()+item.getCount());
				product.setStockCount(product.getStockCount()+item.getCount());
				productFashionMng.update(fashion);
			}else{
				product.setStockCount(product.getStockCount()+item.getCount());
			}
			productMng.updateByUpdater(product);
		}
		//会员冻结的积分
		member.setFreezeScore(member.getFreezeScore()-entity.getOrder().getScore());
		shopMemberMng.update(member);
		List<ShopScore> list = shopScoreMng.getlist(entity.getOrder().getCode());
		for(ShopScore s:list){
			shopScoreMng.deleteById(s.getId());
		}
		orderReturnMng.update(entity);
		return myReturnOrder(request,model);
	}

	private WebErrors validateOrderView(Long orderId, ShopMember member,
			HttpServletRequest request) {
		WebErrors errors = WebErrors.create(request);
		if (errors.ifNull(orderId, "orderId")) {
			return errors;
		}
		Order order = manager.findById(orderId);
		if (errors.ifNotExist(order, Order.class, orderId)) {
			return errors;
		}
		if (!order.getMember().getId().equals(member.getId())) {
			errors.noPermission(Order.class, orderId);
			return errors;
		}
		return errors;
	}
	
	
	public String getHistoryProductIds(HttpServletRequest request){
		String str = null ;
		Cookie[] cookie = request.getCookies();
		int num = cookie.length;
		for (int i = 0; i < num; i++) {
			if (cookie[i].getName().equals("shop_record")) {
				str = cookie[i].getValue();
				break;
			}
		}
		return str;
	}
	
	private WebErrors validateOrderReturnView(Long orderReturnId, ShopMember member,
			HttpServletRequest request) {
		WebErrors errors = WebErrors.create(request);
		if (errors.ifNull(orderReturnId, "orderReturnId")) {
			return errors;
		}
		OrderReturn orderReturn = orderReturnMng.findById(orderReturnId);
		if (errors.ifNotExist(orderReturn,OrderReturn.class, orderReturnId)) {
			return errors;
		}
		if (!orderReturn.getOrder().getMember().getId().equals(member.getId())) {
			errors.noPermission(OrderReturn.class, orderReturnId);
			return errors;
		}
		return errors;
	}

	@Autowired
	private OrderMng manager;
	@Autowired
	private ShippingMng shippingMng;
	@Autowired
	private PaymentMng paymentMng;
	@Autowired
	private ShoppingSvc shoppingSvc;
	@Autowired
	private PaymentPluginsMng paymentPluginsMng;
	@Autowired
	private ProductMng productMng;
	@Autowired
	private ProductFashionMng productFashionMng;
	@Autowired
	private ShopMemberMng shopMemberMng;
	@Autowired
	private ShopScoreMng shopScoreMng;
	@Autowired
	private OrderReturnMng orderReturnMng;
}
