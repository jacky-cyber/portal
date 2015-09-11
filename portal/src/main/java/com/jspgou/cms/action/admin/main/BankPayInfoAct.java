package com.jspgou.cms.action.admin.main;

import com.ifunpay.portal.entity.BankPayInfo;
import com.ifunpay.portal.model.BankAppEnum;
import com.ifunpay.portal.service.log.OperationLogService;
import com.jspgou.cms.manager.BankPayInfoMng;
import com.jspgou.common.page.Pagination;
import com.jspgou.common.web.CookieUtils;
import com.jspgou.common.web.ResponseUtils;
import com.jspgou.common.web.session.SessionProvider;
import com.jspgou.core.manager.AdminMng;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

import static com.jspgou.common.page.SimplePage.cpn;

/**
 * Created by zj on 15-7-17.
 */
@Controller
public class BankPayInfoAct {

    @RequestMapping("/bankPayInfo/v_list.do")
    public String list(String id, Integer pageNo, HttpServletRequest request, ModelMap model) {
        Pagination pagination = bankPayInfoMng.getBankPayInfo(id, cpn(pageNo), CookieUtils.getPageSize(request));
        model.addAttribute("pagination", pagination);
        return "bankPayInfo/list";
    }

    @RequestMapping(value = "/bankPayInfo/v_add.do")
    public String add(ModelMap model){
        List apps = new ArrayList<>();
        for (BankAppEnum appEnum: BankAppEnum.values()) {
            apps.add(appEnum.name());
        }
        model.addAttribute("apps", apps);
        model.addAttribute("bankPayInfo", new BankPayInfo());
        return "bankPayInfo/add";
    }

    /**
     * validate name
     * @param name
     * @param response
     */
    @RequestMapping(value = "/bankPayInfo/v_bank_pay_name.do")
    public void checkName(String name, String id, HttpServletResponse response){
        Boolean flag = false;
        if (StringUtils.isBlank(id)){
            flag = bankPayInfoMng.checkName(name);
        } else {
            String[] ids = new String[]{id};
            flag = bankPayInfoMng.checkName(name, ids);
        }

        if (flag) {
            ResponseUtils.renderJson(response, "false");
        }else {
            ResponseUtils.renderJson(response, "true");
        }
    }

    @RequestMapping(value = "/bankPayInfo/o_save.do")
    public String save(BankPayInfo bankPayInfo, HttpServletRequest request){
        String id = bankPayInfoMng.save(bankPayInfo);
        Long adminId = (Long) session.getAttribute(request,"_admin_id_key");
        operationLogService.addBankPayInfoAccount(adminMng.findById(adminId).getUsername(), id, id);
        return "redirect:v_list.do";
    }

    @RequestMapping(value = "/bankPayInfo/v_edit.do")
    public String add(String id, ModelMap model){
        List apps = new ArrayList<>();
        for (BankAppEnum appEnum: BankAppEnum.values()) {
            apps.add(appEnum.name());
        }
        model.addAttribute("apps", apps);
        model.addAttribute("bankPayInfo", bankPayInfoMng.getBankPayInfoById(id));
        return "bankPayInfo/edit";
    }

    @RequestMapping(value = "/bankPayInfo/o_update_save.do")
    public String update(BankPayInfo bankPayInfo, HttpServletRequest request){
        String id = bankPayInfo.getId();
        bankPayInfoMng.update(bankPayInfo);
        Long adminId = (Long) session.getAttribute(request,"_admin_id_key");
        operationLogService.modifyBankPayInfoAccount(adminMng.findById(adminId).getUsername(), id, id);
        return "redirect:v_list.do";
    }

    @RequestMapping(value = "/bankPayInfo/o_delete.do")
    public String delete(String[] ids, Integer pageNo,
                         HttpServletRequest request, ModelMap model){
        BankPayInfo[] beans = bankPayInfoMng.deleteByIds(ids);
        String id = "";
        for (int i=0; i<beans.length; i++){
            logger.info("delete Payment, id= " + beans[i].getName());
            id += (i<beans.length-1)? beans[i].getId() + "," : beans[i].getId();
        }
        Long adminId = (Long) session.getAttribute(request,"_admin_id_key");
        operationLogService.deleteBankPayInfoAccount(adminMng.findById(adminId).getUsername(), id, id);
        return list(null, pageNo, request, model);
    }

    private static final Logger logger = Logger.getLogger(BankPayInfoAct.class);

    @Autowired
    private BankPayInfoMng bankPayInfoMng;

    @Autowired
    private OperationLogService operationLogService;

    @Resource
    private SessionProvider session;
    @Autowired
    private AdminMng adminMng;
}
