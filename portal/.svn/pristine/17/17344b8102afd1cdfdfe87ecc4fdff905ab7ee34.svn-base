package com.jspgou.cms.action.admin.main;

import com.ifunpay.portal.entity.BankPayInfo;
import com.ifunpay.portal.entity.Channel;
import com.ifunpay.portal.entity.Commerce;
import com.ifunpay.portal.service.commerce.CommerceService;
import com.ifunpay.portal.service.log.OperationLogService;
import com.ifunpay.portal.util.SessionUtil;
import com.jspgou.cms.entity.Store;
import com.jspgou.cms.entity.StoreModel;
import com.jspgou.cms.manager.StoreMng;
import com.jspgou.common.page.Pagination;
import com.jspgou.common.web.CookieUtils;
import com.jspgou.common.web.ResponseUtils;
import com.jspgou.common.web.session.SessionProvider;
import com.jspgou.core.entity.Admin;
import com.jspgou.core.manager.AdminMng;
import com.jspgou.core.utils.ExcelUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import static com.jspgou.common.page.SimplePage.cpn;

/**
 * Created by zhengjiang on 2015-07-09.
 */
@Controller
public class StoreAct {
    @RequestMapping(value = "/store/v_list.do")
    public String list(String storeName, Long id, Integer storeStatus, String commerceName,
                            Date startTime, Date endTime, Integer pageNo,
                            ModelMap modelMap, HttpServletRequest request){

        Long commerceId = sessionUtil.getCommerceId(request);
        Long channelId = sessionUtil.getChannelId(request);

        Pagination pagination = storeMng.getPage(storeName, id, storeStatus, commerceName, startTime, endTime, CookieUtils.getPageSize(request), cpn(pageNo), channelId, commerceId);
        modelMap.addAttribute("id", id);
        modelMap.addAttribute("pagination", pagination);
        modelMap.addAttribute("storeName", storeName);
        modelMap.addAttribute("storeStatus", storeStatus);
        modelMap.addAttribute("commerceName", commerceName);
        modelMap.addAttribute("startTime", startTime);
        modelMap.addAttribute("endTime", endTime);
        return "store/list";
    }

    @RequestMapping(value = "/store/v_add.do")
    public String add(ModelMap model, HttpServletRequest request){
        Long commerceId = sessionUtil.getCommerceId(request);
        Long channelId = sessionUtil.getChannelId(request);
        List<Commerce> commerces = commerceService.getCommerces(channelId, commerceId);
        model.addAttribute("commerces", commerces);
        return "store/add";
    }

    @RequestMapping(value = "/store/o_save.do")
    public String save(Store store,HttpServletRequest request){
        Commerce commerce = commerceService.getCommerceById(store.getCommerceId());
        store.setCommerceName(commerce.getName());
        store.setCreateDate(new Date());
        storeMng.save(store);
        long adminId = (long)session.getAttribute(request,"_admin_id_key");
        logger.info("adminId = " + adminId);
        Admin admin = adminMng.findById(adminId);
        operationLogService.addStore(admin.getUsername(), store.getId() + "", store.getId() + "");
        return "redirect:v_list.do";
    }

    @RequestMapping(value = "/store/v_check_store_name.do")
    public void checkStoreName(String storeName, Long id, HttpServletResponse response){
        Boolean flag = false;
        if (null == id){
            flag = storeMng.checkName(storeName);
        }else {
            Long[] ids = new Long[]{id};
            flag = storeMng.checkName(storeName, ids);
        }

        if (flag) {
            ResponseUtils.renderJson(response, "false");
        }else {
            ResponseUtils.renderJson(response, "true");
        }
    }

    @RequestMapping(value = "/store/v_edit.do")
    public String edit(Long id, ModelMap model,HttpServletRequest request){
        long adminId = (long)session.getAttribute(request,"_admin_id_key");
        logger.info("adminId = " + adminId);
        Admin admin = adminMng.findById(adminId);
        operationLogService.editStore(admin.getUsername(), id+"", id+"");

        List<Commerce> commerces = commerceService.getAllCommerces();
        model.addAttribute("commerces",commerces);
        Store store = storeMng.getStoreById(id);
        model.addAttribute("store", store);
        return "store/edit";
    }

    @RequestMapping(value = "/store/o_update_save.do")
    public String saveUpdate(Store store){
        Commerce commerce = commerceService.getCommerceById(store.getCommerceId());
        store.setCommerceName(commerce.getName());
        store.setCreateDate(new Date());
        store.setModifyDate(new Date());
        storeMng.update(store);
        return "redirect:v_list.do";
    }

    @RequestMapping(value = "storeToXls.do")
    public void exportStore(String commerceName, String storeName, Long id, String startTime, String endTime, HttpServletResponse response){
        List<StoreModel> stores = storeMng.getStoreToExcel(commerceName, storeName, id, startTime, endTime);
        try {
            OutputStream outputStream = response.getOutputStream();
            response.setHeader("Content-disposition", "attachment; filename="+new String("店面".getBytes("GB2312"),"8859_1")+".xls");
            //定义输出类型为excel
            response.setContentType("application/msexcel");

            ExcelUtils<StoreModel> excelUtils = new ExcelUtils<StoreModel>();
            List<String[]> list = new ArrayList<String[]>();
            String[] a1 = {"店面ID", "id"};
            list.add(a1);
            String[] a2 = {"店面名称", "storeName"};
            list.add(a2);
            String[] a3 = {"所属商户", "commerceName"};
            list.add(a3);
            String[] a4 = {"手机号码", "mobile"};
            list.add(a4);
            String[] a5 = {"创建时间", "date"};
            list.add(a5);
            String[] a6 = {"店面状态", "status"};
            list.add(a6);
            excelUtils.toExcelAjax(list, stores, outputStream);
        } catch (Exception e) {
            logger.error("导出店面失败！", e);
        }
    }

    @RequestMapping(value = "/store/downloadDemo.do")
    public void downloadDemo(HttpServletResponse response){
        try {
            OutputStream outputStream = response.getOutputStream();

            response.setHeader("Content-disposition", "attachment; filename=" + new String("storeDemo".getBytes("GB2312"), "8859_1") + ".xlsx");
            response.setContentType("application/msexcel");

            String rootPath = getClass().getResource("/").getFile().toString();
            String[] pa = rootPath.split("\\/");
            StringBuffer fileToPath = new StringBuffer();
            for (int i = 1; i < pa.length-1; i++) {
                fileToPath.append(pa[i]).append("/");
            }
            fileToPath.append("download/storeDemo.xlsx");
            File file = new File(fileToPath.toString());
            FileInputStream fis = new FileInputStream(file);
            BufferedInputStream buff = new BufferedInputStream(fis);
            byte[] b = new byte[1024];
            long k = 0;
            while (k < file.length()) {
                int j = buff.read(b, 0, 1024);
                k += j;
                outputStream.write(b, 0, j);
            }
            outputStream.close();
        } catch (IOException e) {
            logger.error("", e);
        }
    }

    @RequestMapping(value = "/store/importStore.do")
    public String importStore(Model model, HttpServletRequest request){
        Long channelId = sessionUtil.getChannelId(request);
        Long commerceId = sessionUtil.getCommerceId(request);
        java.util.List<Commerce> commerceList = commerceService.getCommerces(channelId, commerceId);
        model.addAttribute("commerceList", commerceList);
        return "store/import-store";
    }

    @RequestMapping(value = "/store/o-save-store.do")
    public String saveOperator(@RequestParam(value = "file", required = false) MultipartFile file, Store store,HttpServletRequest request){
        try {
            storeMng.saveStoreFromExcel(file, store,request);
        } catch (Exception e){
            logger.error("", e);
        }
        return "redirect:v_list.do";
    }

    @RequestMapping(value = "/store/o_delete.do")
    public String delete(Long[] ids, Integer pageNo,
                         HttpServletRequest request, ModelMap model){
        Store[] beans = storeMng.deleteByIds(ids);
        for (Store bean : beans) {
            logger.info("delete Payment, id= " + bean.getStoreName());
        }
        return list(null, null, null, null, null, null, pageNo, model, request);
    }

    private static final Logger logger = Logger.getLogger(StoreAct.class);

    @Autowired
    private StoreMng storeMng;
    @Resource
    private CommerceService commerceService;
    @Autowired
    private AdminMng adminMng;
    @Resource
    private SessionProvider session;

    @Resource
    private SessionUtil sessionUtil;

    @Resource
    private OperationLogService operationLogService;
}
