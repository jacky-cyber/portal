package com.jspgou.cms.action.front;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.jspgou.common.web.RequestUtils;
import com.jspgou.core.entity.Website;
import com.jspgou.core.web.front.FrontHelper;
import com.jspgou.cms.Alipay;
import com.jspgou.cms.entity.Order;
import com.jspgou.cms.entity.PaymentPlugins;
import com.jspgou.cms.manager.OrderMng;
import com.jspgou.cms.manager.PaymentPluginsMng;
import com.jspgou.cms.web.FrontUtils;
import com.jspgou.cms.web.SiteUtils;

/**
* This class should preserve.
* @preserve
*/
@Controller
public class AlipayAct extends Alipay {

	//在线支付订单
	@RequestMapping(value="/pay.jspx",method=RequestMethod.POST)
	public String pay(Long orderId,String code,HttpServletRequest request,HttpServletResponse response, ModelMap model){
		Website web = SiteUtils.getWeb(request);
		if(orderId!=null&&manager.findById(orderId)!=null){
			Order order = manager.findById(orderId);
			PaymentPlugins paymentPlugins = paymentPluginsMng.findByCode(code);
			PrintWriter out = null;
			String aliURL = null;
			try {
				if(!StringUtils.isBlank(code)&&code.equals("alipayPartner")){
					aliURL = alipay(paymentPlugins,web, order, request, model);		
				}else if(!StringUtils.isBlank(code)&&code.equals("alipay")){
					aliURL = alipayapi(paymentPlugins,web, order, request, model);
				}
				response.setContentType("text/html;charset=UTF-8");
				out = response.getWriter();
				out.print(aliURL);
			} catch (IOException e) {
				e.printStackTrace();
			}finally{
				out.close();
			}
			return null;	
		}else {
			return FrontHelper.pageNotFound(web, model, request);
		}		
	}

	//支付宝返回参数
	@RequestMapping(value = "/aliReturn.jspx")
	public String aliReturn(HttpServletRequest request,HttpServletResponse response, ModelMap model) throws UnsupportedEncodingException {
		Map<String,String> params = new HashMap<String,String>();
		Map requestParams = request.getParameterMap();
		for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext();) {
			String name = (String) iter.next();
			String[] values = (String[]) requestParams.get(name);
			String valueStr = "";
			for (int i = 0; i < values.length; i++) {
				valueStr = (i == values.length - 1) ? valueStr + values[i]: valueStr + values[i] + ",";
			}
			params.put(name, valueStr);
		}
		//商户订单号
		String out_trade_no = new String(request.getParameter("out_trade_no").getBytes("ISO-8859-1"),"UTF-8");
		//支付宝交易号
		String trade_no = new String(request.getParameter("trade_no").getBytes("ISO-8859-1"),"UTF-8");
		//交易状态
		String trade_status = new String(request.getParameter("trade_status").getBytes("ISO-8859-1"),"UTF-8");
		PaymentPlugins paymentPlugins =paymentPluginsMng.findByCode("alipayPartner");
		Long orderId=Long.parseLong(out_trade_no);
		Order order=manager.findById(orderId);
		if(verify(params,paymentPlugins.getPartner(),paymentPlugins.getSellerKey())){
			if(trade_status.equals("WAIT_BUYER_PAY")){
				//该判断表示买家已在支付宝交易管理中产生了交易记录，但没有付款
				return  FrontUtils.showMessage(request, model,"付款失败！");
			}else if(trade_status.equals("WAIT_SELLER_SEND_GOODS")){
				//该判断表示买家已在支付宝交易管理中产生了交易记录且付款成功，但卖家没有发货
				order.setPaymentStatus(2);
				order.setTradeNo(trade_no);
				order.setPaymentCode("alipayPartner");
				manager.updateByUpdater(order);
				return  FrontUtils.showMessage(request, model,"付款成功，请等待发货！");
			}else if(trade_status.equals("WAIT_BUYER_CONFIRM_GOODS")){
				//该判断表示卖家已经发了货，但买家还没有做确认收货的操作
				return  FrontUtils.showMessage(request, model,"已发货，未确认收货！");
			}else if(trade_status.equals("TRADE_FINISHED")){
				//该判断表示买家已经确认收货，这笔交易完成
				return  FrontUtils.showMessage(request, model,"交易完成！");
			}else {
				return  FrontUtils.showMessage(request, model,"success！");
			}
		}
		return  FrontUtils.showMessage(request, model,"付款异常！");
	}
	
	private String alipay(PaymentPlugins paymentPlugins,Website web,Order order,
			HttpServletRequest request,ModelMap model){
		//支付类型
		String payment_type = "1"; //必填，不能修改
		//服务器异步通知页面路径
		String notify_url = "http://"+web.getDomain()+"/aliReturn.jspx";
		//页面跳转同步通知页面路径
		String return_url = "http://"+web.getDomain()+"/aliReturn.jspx";
		//卖家支付宝帐户
		String seller_email = paymentPlugins.getSellerEmail();//必填
		//商户订单号
		String out_trade_no = order.getId().toString();//商户网站订单系统中唯一订单号，必填
		//订单名称
		String subject = "("+order.getId()+")";//必填
		//付款金额
		String price = String.valueOf(order.getTotal());//必填
		//商品数量
		String quantity = "1";//必填，建议默认为1，不改变值，把一次交易看成是一次下订单而非购买一件商品
		//物流费用
		String logistics_fee = String.valueOf(order.getFreight());
		//物流类型
		String logistics_type = getLogisticsType(order);//必填，三个值可选：EXPRESS（快递）、POST（平邮）、EMS（EMS）
		//物流支付方式
		String logistics_payment = "BUYER_PAY";//必填，两个值可选：SELLER_PAY（卖家承担运费）、BUYER_PAY（买家承担运费）
		//订单描述
		String body = "("+order.getId()+")";
		//商品展示地址
		String show_url ="http://"+web.getDomain()+"/";
		//收货人姓名
		String receive_name = order.getReceiveName();
		//收货人地址
		String receive_address = order.getReceiveAddress();
		//收货人邮编
		String receive_zip = order.getReceiveZip();
		//收货人电话号码
		String receive_phone = order.getReceivePhone();
		//收货人手机号码
		String receive_mobile = order.getReceiveMobile();
		//把请求参数打包成数组
		Map<String, String> sParaTemp = new HashMap<String, String>();
		sParaTemp.put("service", "create_partner_trade_by_buyer");
        sParaTemp.put("partner", paymentPlugins.getPartner());
        sParaTemp.put("_input_charset", "utf-8");
		sParaTemp.put("payment_type", payment_type);
		sParaTemp.put("notify_url", notify_url);
		sParaTemp.put("return_url", return_url);
		sParaTemp.put("seller_email", seller_email);
		sParaTemp.put("out_trade_no", out_trade_no);
		sParaTemp.put("subject", subject);
		sParaTemp.put("price", price);
		sParaTemp.put("quantity", quantity);
		sParaTemp.put("logistics_fee", logistics_fee);
		sParaTemp.put("logistics_type", logistics_type);
		sParaTemp.put("logistics_payment", logistics_payment);
		sParaTemp.put("body", body);
		sParaTemp.put("show_url", show_url);
		sParaTemp.put("receive_name", receive_name);
		sParaTemp.put("receive_address", receive_address);
		sParaTemp.put("receive_zip", receive_zip);
		sParaTemp.put("receive_phone", receive_phone);
		sParaTemp.put("receive_mobile", receive_mobile);
		//建立请求
		String sHtmlText = buildRequest(sParaTemp,paymentPlugins.getSellerKey(),"get","确认");
		return sHtmlText;
	}

	//支付宝返回参数
	@RequestMapping(value = "/aliReturnUrl.jspx")
	public String aliReturndirect(HttpServletRequest request,HttpServletResponse response, ModelMap model) throws UnsupportedEncodingException {
		//获取支付宝POST过来反馈信息
		Map<String,String> params = new HashMap<String,String>();
		Map requestParams = request.getParameterMap();
		for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext();) {
			String name = (String) iter.next();
			String[] values = (String[]) requestParams.get(name);
			String valueStr = "";
			for (int i = 0; i < values.length; i++) {
				valueStr = (i == values.length - 1) ? valueStr + values[i]
						: valueStr + values[i] + ",";
			}
			//乱码解决，这段代码在出现乱码时使用。如果mysign和sign不相等也可以使用这段代码转化
			//valueStr = new String(valueStr.getBytes("ISO-8859-1"), "gbk");
			params.put(name, valueStr);
		}
		//商户订单号
		String out_trade_no = new String(request.getParameter("out_trade_no").getBytes("ISO-8859-1"),"UTF-8");
		//支付宝交易号
		String trade_no = new String(request.getParameter("trade_no").getBytes("ISO-8859-1"),"UTF-8");
		//交易状态
		String trade_status = new String(request.getParameter("trade_status").getBytes("ISO-8859-1"),"UTF-8");

		PaymentPlugins paymentPlugins =paymentPluginsMng.findByCode("alipay");
		Long orderId=Long.parseLong(out_trade_no);
		Order order=manager.findById(orderId);
		if(verify(params,paymentPlugins.getPartner(),paymentPlugins.getSellerKey())){//验证成功
			if(trade_status.equals("TRADE_FINISHED")){
				//判断该笔订单是否在商户网站中已经做过处理
				//如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
				//如果有做过处理，不执行商户的业务程序
				order.setPaymentStatus(2);
				manager.updateByUpdater(order);
				return  FrontUtils.showMessage(request, model,"付款成功，请等待发货！");
				//注意：
				//该种交易状态只在两种情况下出现
				//1、开通了普通即时到账，买家付款成功后。
				//2、开通了高级即时到账，从该笔交易成功时间算起，过了签约时的可退款时限（如：三个月以内可退款、一年以内可退款等）后。
			} else if (trade_status.equals("TRADE_SUCCESS")){
				//判断该笔订单是否在商户网站中已经做过处理
				//如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
				//如果有做过处理，不执行商户的业务程序
				order.setPaymentStatus(2);
				manager.updateByUpdater(order);
				return  FrontUtils.showMessage(request, model,"付款成功，请等待发货！");
				//注意：
				//该种交易状态只在一种情况下出现——开通了高级即时到账，买家付款成功后。
			}
		}else{//验证失败
			return  FrontUtils.showMessage(request, model,"验证失败！");
		}
		return  FrontUtils.showMessage(request, model,"付款异常！");
	}

	private String alipayapi(PaymentPlugins paymentPlugins,Website web,Order order,
			HttpServletRequest request,ModelMap model){
		//支付类型
		String payment_type = "1";//必填，不能修改
		//服务器异步通知页面路径
		String notify_url = "http://"+web.getDomain()+"/aliReturnUrl.jspx";
		//页面跳转同步通知页面路径
		String return_url = "http://"+web.getDomain()+"/aliReturnUrl.jspx";
		//卖家支付宝帐户
		String seller_email = paymentPlugins.getSellerEmail();//必填
		//商户订单号
		String out_trade_no = order.getId().toString();//商户网站订单系统中唯一订单号，必填
		//订单名称
		String subject = "("+order.getId()+")";//必填
		//付款金额
		String total_fee = String.valueOf(order.getTotal());//必填
		//订单描述
		String body = "("+order.getId()+")";
		//商品展示地址
		String show_url = "http://"+web.getDomain()+"/";
		//防钓鱼时间戳
		String anti_phishing_key = "";//若要使用请调用类文件submit中的query_timestamp函数
		//客户端的IP地址
		String exter_invoke_ip = RequestUtils.getIpAddr(request);//非局域网的外网IP地址，如：221.0.0.1
		Map<String, String> sParaTemp = new HashMap<String, String>();
		sParaTemp.put("service", "create_direct_pay_by_user");
        sParaTemp.put("partner", paymentPlugins.getPartner());
        sParaTemp.put("_input_charset", "utf-8");
		sParaTemp.put("payment_type", payment_type);
		sParaTemp.put("notify_url", notify_url);
		sParaTemp.put("return_url", return_url);
		sParaTemp.put("seller_email", seller_email);
		sParaTemp.put("out_trade_no", out_trade_no);
		sParaTemp.put("subject", subject);
		sParaTemp.put("total_fee", total_fee);
		sParaTemp.put("body", body);
		sParaTemp.put("show_url", show_url);
		sParaTemp.put("anti_phishing_key", anti_phishing_key);
		sParaTemp.put("exter_invoke_ip", exter_invoke_ip);
		//建立请求
		String sHtmlText = buildRequest(sParaTemp,paymentPlugins.getSellerKey(),"get","确认");	
		return sHtmlText;
	}
	
	public String getLogisticsType(Order order){
		String logistics_type;
		if(!StringUtils.isBlank(order.getShipping().getLogisticsType())){
			logistics_type = order.getShipping().getLogisticsType();
		}else{
			logistics_type = "EXPRESS";
		}
		return logistics_type;
		
	}
	
	@Autowired
	private OrderMng manager;
	@Autowired
	private PaymentPluginsMng paymentPluginsMng;
}
