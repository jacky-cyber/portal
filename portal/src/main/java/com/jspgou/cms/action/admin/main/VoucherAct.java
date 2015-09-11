package com.jspgou.cms.action.admin.main;

import com.ifunpay.portal.dao.NewOrderVoucherDao;
import com.ifunpay.portal.dao.OrderPayRefundDao;
import com.ifunpay.portal.entity.OrderPayRefundEntity;
import com.ifunpay.portal.entity.OrderVoucher;
import com.ifunpay.portal.entity.OrderVoucherExport;
import com.ifunpay.portal.enums.VoucherStatus;
import com.ifunpay.portal.service.commerce.NewOrderVoucherService;
import com.ifunpay.portal.service.log.OperationLogService;
import com.jspgou.cms.dao.SequenceDao;
import com.jspgou.cms.entity.*;
import com.jspgou.cms.manager.*;
import com.jspgou.cms.web.threadvariable.AdminThread;
import com.jspgou.cms.web.threadvariable.MemberThread;
import com.jspgou.common.page.Pagination;
import com.jspgou.common.web.CookieUtils;
import com.jspgou.common.web.RequestUtils;
import com.jspgou.common.web.ResponseUtils;
import com.jspgou.common.web.session.SessionProvider;
import com.jspgou.core.entity.Admin;
import com.jspgou.core.entity.Website;
import com.jspgou.core.manager.AdminMng;
import com.jspgou.core.utils.ExcelUtils;
import com.jspgou.core.web.SiteUtils;
import com.jspgou.core.web.WebErrors;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang.StringUtils;
import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.*;

import static com.jspgou.common.page.SimplePage.cpn;

/**
* This class should preserve.
* @preserve
*/
@Controller
public class VoucherAct {


	private static final Logger log = LoggerFactory.getLogger(VoucherAct.class);

    public static final String ALL = "all";
	public static final String PENDING = "pending";
	public static final String PROSESSING = "processing";
	public static final String DELIVERED = "delivered";
	public static final String COMPLETE = "complete";
	public static final String[] TYPES = { ALL, PENDING, PROSESSING, DELIVERED, COMPLETE };

    //凭证管理
    @RequestMapping("/voucher/v_list.do")
    public String generateVoucher(String recepPhone,String productName,String commerceName,String code,String status, Integer pageNo, HttpServletRequest request,String voucherCode, ModelMap model) throws JSONException {
        Website web = SiteUtils.getWeb(request);
        String userName = RequestUtils.getQueryParam(request, "userName");
        userName = StringUtils.trim(userName);

        String commerceId = (String)session.getAttribute(request,"commerceId");
        log.info("commerce id ="+commerceId);
        Long comId = null;
        if(StringUtils.isNotBlank(commerceId)){
            comId = Long.parseLong(commerceId);
        }
        String channelId = (String)session.getAttribute(request,"channelId");
        log.info("channelId id ="+channelId);
        Long chanId = null;
        if(StringUtils.isNotBlank(channelId)){
            chanId = Long.parseLong(channelId);
        }

        Pagination pagination = manager.getPageForVoucher(chanId,comId,recepPhone,productName,commerceName,voucherCode,status,code,cpn(pageNo), CookieUtils.getPageSize(request));
        model.addAttribute("pagination", pagination);

        List<Shipping> shippingList = shippingMng.getList(web.getId(), true);
        List<Payment> paymentList = paymentMng.getList(web.getId(), true);
        model.addAttribute("statusList", VoucherStatus.values());
        model.addAttribute("paymentList", paymentList);
        model.addAttribute("shippingList", shippingList);
        model.addAttribute("userName", userName);
        model.addAttribute("status", status);
        model.addAttribute("code", code);
        model.addAttribute("voucherCode",voucherCode);
        model.addAttribute("commerceName",commerceName);
        model.addAttribute("productName",productName);
        model.addAttribute("recepPhone",recepPhone);

        return "order/voucher";
    }

    //凭证管理
    @RequestMapping("voucherReportToXls.do")
    public void exportVoucher(String recepPhone,String productName,String commerceName,String code,String status,String voucherCode,HttpServletResponse response) throws JSONException {

        List<OrderVoucher> orderVoucherList = newOrderVoucherDao.getAllOrderVoucher(recepPhone,productName,commerceName,voucherCode,status,code);
        List<OrderVoucherExport> orderVoucherExports = new ArrayList<>();
        for (OrderVoucher orderVoucher: orderVoucherList){
            OrderVoucherExport orderVoucherExport = new OrderVoucherExport(orderVoucher.getVoucherCode(),orderVoucher.getRecepPhone(),orderVoucher.getCode(),
                    orderVoucher.getCost(),orderVoucher.getProductName(),orderVoucher.getOperator(),orderVoucher.getCommerceName(),
                    orderVoucher.getStoreName(),orderVoucher.getStatus().getDisplayName());
            orderVoucherExports.add(orderVoucherExport);
        }
        try {
            OutputStream outputStream = response.getOutputStream();
            response.setHeader("Content-disposition", "attachment; filename="+new String("凭证报表".getBytes("GB2312"),"8859_1")+".xls");
            //定义输出类型为excel
            response.setContentType("application/msexcel");

            ExcelUtils<OrderVoucherExport> excelUtils = new ExcelUtils<OrderVoucherExport>();
            List<String[]> list = new ArrayList<String[]>();
            String[] a1 = {"订单号", "code"};
            list.add(a1);
            String[] a10 = {"凭证号", "voucherCode"};
            list.add(a10);
            String[] a2 = {"手机号", "recepPhone"};
            list.add(a2);
            String[] a6 = {"商品名称", "productName"};
            list.add(a6);
            String[] a61 = {"商户名称", "commerceName"};
            list.add(a61);
            String[] a3 = {"消费店面", "storeName"};
            list.add(a3);
            String[] a4 = {"操作员", "operator"};
            list.add(a4);
            String[] a5 = {"金额(分)", "cost"};
            list.add(a5);
            String[] a7 = {"使用状态", "status"};
            list.add(a7);
            excelUtils.toExcelAjax(list, orderVoucherExports, outputStream);
        } catch (Exception e) {
            log.error("导出报表失败！");
        }
    }

    //消费凭证
    @RequestMapping("/voucher/validate-voucher-code.do")
    @ResponseBody
    public String validateVoucherCode(String voucherCode, HttpServletRequest request){
        //add log for consume voucher
        log.info("voucherCode ="+voucherCode);
        OrderVoucher orderVoucher = newOrderVoucherService.getNoUsedVoucherByVoucherCode(voucherCode);
        Date start = orderVoucher.getStartTime();
        Date end = orderVoucher.getEndTime();
        String expire ="1";
        if(start!=null&&end!=null){
            Date now = new Date();
            if(now.after(end)||now.before(start)){
                log.info("expired");
                return "0";//过期了
            }
        }
        log.info("expire = "+expire);
        if("1".equals(expire)) {
            //未过期
            boolean result = newOrderVoucherService.validateVoucher(request, voucherCode);
            log.info("validate result is :" + result);
            expire ="2";//消费完成
        }

        //return "redirect:v_list.do";
        return  expire;
    }


    @Resource
    private AdminMng adminMng;

    @Resource
    private OperationLogService operationLogService;

	@Autowired
	private ShippingMng shippingMng;
	@Autowired
	private PaymentMng paymentMng;
	@Autowired
	private OrderMng manager;
	@Autowired
	private OrderReturnMng orderReturnMng;
    @Autowired
	private ShopMemberMng shopMemberMng;
 	@Autowired
	private ShopScoreMng shopScoreMng;
	@Autowired
	private ProductMng productMng;
	@Autowired
	private ProductFashionMng productFashionMng;
	@Autowired
	private OrderItemMng orderItemMng;
	@Autowired
	private GatheringMng gatheringMng;

    @Autowired
    private SequenceDao sequenceDao;

    @Autowired
    private OrderPayRefundDao orderPayRefundDao;

    @Autowired
    private NewOrderVoucherDao newOrderVoucherDao;

    @Resource
    private SessionProvider session;

    @Resource
    private NewOrderVoucherService newOrderVoucherService;
}