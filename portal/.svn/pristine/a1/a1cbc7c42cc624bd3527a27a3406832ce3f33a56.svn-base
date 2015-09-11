package com.jspgou.cms.action.admin.main;

import com.ifunpay.portal.entity.BankPayInfo;
import com.ifunpay.portal.entity.Channel;
import com.ifunpay.portal.entity.Commerce;
import com.ifunpay.portal.entity.lottery.CommerceModel;
import com.ifunpay.portal.model.BankAppEnum;
import com.ifunpay.portal.service.commerce.ChannelService;
import com.ifunpay.portal.service.commerce.CommerceService;
import com.ifunpay.portal.service.log.OperationLogService;
import com.ifunpay.portal.util.SessionUtil;
import com.jspgou.cms.dao.SequenceDao;
import com.jspgou.cms.entity.Logistics;
import com.jspgou.cms.entity.ShopAdmin;
import com.jspgou.cms.entity.Store;
import com.jspgou.cms.manager.BankPayInfoMng;
import com.jspgou.cms.manager.LogisticsMng;
import com.jspgou.cms.manager.ShopAdminMng;
import com.jspgou.cms.manager.StoreMng;
import com.jspgou.common.page.Pagination;
import com.jspgou.common.web.CookieUtils;
import com.jspgou.common.web.ResponseUtils;
import com.jspgou.common.web.session.SessionProvider;
import com.jspgou.core.entity.Admin;
import com.jspgou.core.entity.Role;
import com.jspgou.core.entity.Website;
import com.jspgou.core.manager.AdminMng;
import com.jspgou.core.manager.RoleMng;
import com.jspgou.core.manager.UserMng;
import com.jspgou.core.utils.ExcelUtils;
import com.jspgou.core.web.SiteUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.apache.tools.ant.taskdefs.condition.Http;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import static com.jspgou.common.page.SimplePage.cpn;

/**
 *
 * Created by Conglong Xie on 2015/4/21.
 */
@Controller
public class CommerceAct {

    private static Logger logger = Logger.getLogger(CommerceAct.class);

    @Resource
    private SessionProvider session;

    @Resource
    private SequenceDao sequenceDao;

    @Resource
    private CommerceService commerceService;


    @Resource
    private ChannelService channelService;

    @Resource
    private OperationLogService operationLogService;


    /**
     * get commerce pagination
     * @param channelName
     * @param commerceName
     * @param pageNo
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/commerce/v_list.do")
    public String commercePagination(String channelName, String commerceName, Long id, Date startTime, Date endTime, Integer pageNo, HttpServletRequest request, ModelMap model) {
        Long commerceId = sessionUtil.getCommerceId(request);

        logger.debug("commerce id =" + commerceId);
        Long channelId = sessionUtil.getChannelId(request);
        logger.debug("channelId id ="+channelId);

        if (null == commerceId){
            commerceId = id;
        }

        model.addAttribute("id", id);
        model.addAttribute("startTime", startTime);
        model.addAttribute("endTime", endTime);
        model.addAttribute("commerceName", commerceName);
        model.addAttribute("channelName", channelName);
        Pagination pagination = commerceService.getCommercePaging(channelId, commerceId, channelName,commerceName, startTime, endTime, cpn(pageNo), CookieUtils.getPageSize(request));
        model.addAttribute("pagination", pagination);

        return "commerce/commerce-list";
    }


    @RequestMapping("/commerce/commerce_user_list.do")
    public String commerceUserList(String id,String channelId,HttpServletRequest request,Integer pageNo, ModelMap model){


        model.addAttribute("commerceId", id);
        model.addAttribute("channelId", channelId);
        logger.info("commerceId ==" + id);
        logger.info("channelId ==" + channelId);

        Pagination pagination = shopAdminMng.getPageForChannel(channelId, id, SiteUtils.getWebId(request), cpn(pageNo), CookieUtils.getPageSize(request));
        model.addAttribute(pagination);

        return "commerce/commerce-user-list";
    }



    @RequestMapping("/commerce/v_add_commerce_user.do")
    public String addForCommerce(String channelId, String commerceId,ModelMap model,HttpServletRequest request) {
       // List<Role> roleList = roleMng.getList();
        List<Role> roleList = new ArrayList<Role>();
        roleList.add(roleMng.findById(4));//商户Role
        model.addAttribute("roleList", roleList);

        Integer[] roleIds= {4};

        model.addAttribute("roleIds", roleIds);

        logger.debug("commerceId =="+commerceId);

        model.addAttribute("commerceId",commerceId);
        model.addAttribute("channelId",channelId);

        java.util.List<Channel> channelList = channelService.getChannelExceptNull();
        Channel chan = new Channel();
        chan.setId(Long.parseLong("-1"));
        chan.setChannelName("请选择");
        channelList.add(0,chan);


        java.util.List<Commerce> commerceList = commerceService.getAllCommerces();
        Commerce com = new Commerce();
        com.setId(new Long(0));
        com.setName("请选择");
        commerceList.add(0,com);

        model.addAttribute("channelList", channelList);
        model.addAttribute("commerceList", commerceList);

        java.util.ArrayList<HashMap<String,Object>> storeFrontList = new ArrayList<HashMap<String,Object>>();
        java.util.HashMap<String,Object> storeFrontObject = new HashMap<String,Object>();
        storeFrontObject.put("id"," ");
        storeFrontObject.put("name","无");
        storeFrontList.add(storeFrontObject);

        /*java.util.HashMap<String,Object> storeFrontObject1 = new HashMap<String,Object>();
        storeFrontObject1.put("id","store1");
        storeFrontObject1.put("name","店面1");
        storeFrontList.add(storeFrontObject1);*/

        List<Store> list = storeMng.getAllStore();

        model.addAttribute("storeFrontList", list);
        return "commerce/commerce_user_add";
    }


    @ResponseBody
    @RequestMapping("/commerce/o_save_commerce_user.do")
    public String save(ShopAdmin bean, String username, String password,Boolean viewonlyAdmin,String storeFront,
                       String email, Boolean disabled,Integer[] roleIds,String channelId,String commerceId,
                       HttpServletRequest request, ModelMap model) {

    try {
        Website web = SiteUtils.getWeb(request);
        String channelName = null;
        String commerceName = null;

        if (!"".equals(commerceId)) {
            logger.debug("commerceId = " + commerceId);
            Commerce commerceIndex = commerceService.getCommerceById(Long.parseLong(commerceId));
            if (commerceIndex != null) {
                logger.info("set value to commerce name");
                commerceName = commerceIndex.getName();
            }


        }
        logger.info("channel id ==" + channelId);
        if (!"".equals(channelId)) {

            Channel channelIndex = channelService.getChannelByChannelId(Long.parseLong(channelId));

            logger.info("channel == null?" + (channelIndex == null));

            if (channelIndex != null) {
                logger.info("set value to channel name");
                channelName = channelIndex.getChannelName();
            }

        }
        bean = shopAdminMng.register(username, password, viewonlyAdmin, email, request.getRemoteAddr(), disabled, web.getId(), bean, channelId, channelName, commerceId, commerceName,storeFront);
        adminMng.addRole(bean.getAdmin(), roleIds);
        logger.info("save ShopAdmin id={}" + bean.getId());

        long adminId = (long)session.getAttribute(request,"_admin_id_key");
        logger.info("adminId = " + adminId);
        Admin admin = adminMng.findById(adminId);
        operationLogService.addUserForCommerce(admin.getUsername(), bean.getId() + "", channelId);


        return "success";
    }catch (Exception e){
        logger.info(e);
        return "fail";
    }

       // return "redirect:commerce_user_list.do?id="+commerceId+"&channelId="+channelId;
    }

    @RequestMapping("/commerce/o_edit_commerce_user.do")
    public String editCommerceUser(String channelId,String commerceId,long id,HttpServletRequest request,HttpServletResponse response, ModelMap model){
        java.util.List<Channel> channelList = channelService.getAllChannel();
        Channel chan = new Channel();
        chan.setId(Long.parseLong("-1"));
        chan.setChannelName("请选择");
        channelList.add(0,chan);


        java.util.List<Commerce> commerceList = commerceService.getAllCommerces();
        Commerce com = new Commerce();
        com.setId(new Long(0));
        com.setName("请选择");
        commerceList.add(0,com);

        model.addAttribute("channelList", channelList);
        model.addAttribute("commerceList", commerceList);

        logger.info("id =="+id+",commerceId id =="+commerceId);
       // List<Role> roleList = roleMng.getList();
        List<Role> roleList = new ArrayList<Role>();
        roleList.add(roleMng.findById(4));//商户Role

        model.addAttribute("admin", shopAdminMng.findById(id));
        model.addAttribute("commerceId",commerceId);
        model.addAttribute("channelId",channelId);
       // model.addAttribute("roleIds", shopAdminMng.findById(id).getAdmin().getRoleIds());
        model.addAttribute("roleList", roleList);
        Integer[] roleIds= {4};
        model.addAttribute("roleIds",roleIds);

        java.util.ArrayList<HashMap<String,Object>> storeFrontList = new ArrayList<HashMap<String,Object>>();
        java.util.HashMap<String,Object> storeFrontObject = new HashMap<String,Object>();
        storeFrontObject.put("id"," ");
        storeFrontObject.put("name","无");
        storeFrontList.add(storeFrontObject);

        /*java.util.HashMap<String,Object> storeFrontObject1 = new HashMap<String,Object>();
        storeFrontObject1.put("id","store1");
        storeFrontObject1.put("name","店面1");
        storeFrontList.add(storeFrontObject1);*/

        List<Store> list = storeMng.getAllStore();
        model.addAttribute("storeFrontList", list);

        return "commerce/commerce_user_edit";
    }


    @ResponseBody
    @RequestMapping("/commerce/o_update_commerce_user.do")
    public String update(ShopAdmin bean, String password, Boolean viewonlyAdmin,String email,String storeFront, HttpServletResponse response,
                         Boolean disabled, Integer[] roleIds, Integer pageNo,String channelId,String commerceId,
                         HttpServletRequest request, ModelMap model) {

        try {
            long adminId = (long)session.getAttribute(request,"_admin_id_key");
            logger.info("adminId = " + adminId);
            Admin admin = adminMng.findById(adminId);
            operationLogService.editUserForCommerce(admin.getUsername(), bean.getId() + "", channelId);

            String channelName = "";
            String commerceName = "";
            if (!"".equals(commerceId)) {
                logger.debug("commerceId = " + commerceId);
                Commerce commerceIndex = commerceService.getCommerceById(Long.parseLong(commerceId));
                if (commerceIndex != null) {
                    logger.info("set value to commerce name");
                    commerceName = commerceIndex.getName();
                }


            }
            logger.info("channel id ==" + channelId);
            if (!"".equals(channelId)) {

                Channel channelIndex = channelService.getChannelByChannelId(Long.parseLong(channelId));

                logger.info("channel == null?" + (channelIndex == null));

                if (channelIndex != null) {
                    logger.info("set value to channel name");
                    channelName = channelIndex.getChannelName();
                }

            }
            bean = shopAdminMng.update(bean, password, disabled, email, viewonlyAdmin, channelId, channelName, commerceId, commerceName,storeFront);
            adminMng.updateRole(bean.getAdmin(), roleIds);
            logger.info("update ShopAdmin id={}." + bean.getId());
            return "success";
        }catch (Exception e){
           return "fail";
        }
        //return  commerceUserList(commerceId,channelId, request, pageNo, response, model);
    }


    @RequestMapping("/commerce/o_delete_commerce_user.do")
    public String delete(Long[] ids, Integer pageNo,String commerceId,String channelId,HttpServletResponse response,
                         HttpServletRequest request, ModelMap model) {

        String idCombinations = "";
        for (int i=0;i<ids.length;i++){
            if(i== ids.length-1){
                idCombinations +=ids[i]+" ";
            }else {
                idCombinations +=ids[i]+",";
            }
        }

        long adminId = (long)session.getAttribute(request,"_admin_id_key");
        logger.info("adminId = " + adminId);
        Admin admin = adminMng.findById(adminId);
        operationLogService.delUserForCommerce(admin.getUsername(), idCombinations, channelId);

        ShopAdmin[] beans = shopAdminMng.deleteByIds(ids);
        for (ShopAdmin bean : beans) {
            logger.info("delete ShopAdmin id={}"+ bean.getId());
        }
        return commerceUserList(commerceId, channelId, request, pageNo, model);
    }



    @RequestMapping("/commerce/v_add.do")
    public String addCommerce(HttpServletRequest request, ModelMap model){
        List<Channel> channelList = new ArrayList<>();
        Long channelId = sessionUtil.getChannelId(request);
        if (null != channelId){
            channelList.add(channelService.getChannelByChannelId(channelId));
        } else {
            channelList = channelService.getChannelExceptNull();
        }

        model.addAttribute("channelList", channelList);
        java.util.List<BankPayInfo> bankPayInfoList = channelService.getAllBankPayInfo();
        model.addAttribute("bankPayInfoList", bankPayInfoList);


        java.util.List<Logistics> logisticsList = logisticsMng.getAllList();
        model.addAttribute("logisticsList",logisticsList);

        return "commerce/add-commerce";
    }

    @RequestMapping("/commerce/v_edit.do")
    public String editCommerce(String id,HttpServletRequest request, ModelMap model){
        List<Channel> channelList = new ArrayList<>();
        Long channelId = sessionUtil.getChannelId(request);
        if (null != channelId){
            channelList.add(channelService.getChannelByChannelId(channelId));
        } else {
            channelList = channelService.getChannelExceptNull();
        }
        model.addAttribute("channelList",channelList);

        java.util.List<BankPayInfo> bankPayInfoList = channelService.getAllBankPayInfo();
        model.addAttribute("bankPayInfoList",bankPayInfoList);


        java.util.List<Logistics> logisticsList = logisticsMng.getAllList();
        model.addAttribute("logisticsList",logisticsList);

        Commerce commerce = commerceService.getCommerceById(Long.parseLong(id));
        model.addAttribute("commerce",commerce);

        return "commerce/edit-commerce";
    }


    /*@ResponseBody*/
    @RequestMapping("/commerce/o_save.do")
    public String savedCommerce(Commerce bean , HttpServletRequest request,HttpServletResponse response, ModelMap model){

        logger.info("city ="+bean.getCity());

        Commerce commerce = commerceService.getCommerceById(bean.getId());

        if(commerce == null){
            commerce = new Commerce();
            commerce.setCommerceId(sequenceDao.getCommerceId());
        }

//        logger.info("channel id = "+bean.getChanIdRela().getId());
        Channel channel = channelService.getChannelByChannelId(bean.getChanIdRela().getId());

        logger.info(channel == null);
        if(channel!=null){
            logger.info("set channel");
            commerce.setChanIdRela(channel);
        }
        commerce.setCreateDate(new Date());
        commerce.setChecked("1");//未审核
        commerce.setDelStatus("0");//正常
        commerce.setStatus(bean.getStatus());
        commerce.setName(bean.getName());
        commerce.setMobilePhone(bean.getMobilePhone());
        commerce.setEmail(bean.getEmail());
        commerce.setCode(bean.getCode());
//        commerce.setSynStatus("2");

        commerce.setCollaborateEndTime(bean.getCollaborateEndTime());
        commerce.setCollaborateStartTime(bean.getCollaborateEndTime());

        commerce.setAccount(bean.getAccount());
        commerce.setRoundDay(bean.getRoundDay());
        commerce.setRate(bean.getRate());
        commerce.setDescription(bean.getDescription());

        commerce.setPro(bean.getPro());
        commerce.setCity(bean.getCity());
        commerce.setDetailed(bean.getDetailed());

        commerce.setLinkMan(bean.getLinkMan());
        commerce.setDescription(bean.getDescription());
        /*commerce.setExpress(bean.getExpress());

        logger.info("express ==" + bean.getExpress());*/



        commerceService.saveCommerceEntity(commerce);


        long adminId = (long)session.getAttribute(request,"_admin_id_key");
        logger.info("adminId = " + adminId);
        Admin admin = adminMng.findById(adminId);
        operationLogService.addCommerce(admin.getUsername(), commerce.getCommerceId(), commerce.getCommerceId());


        return "redirect:v_list.do";
    }



/*    @ResponseBody*/
    @RequestMapping("/commerce/o_update_saved_commerce.do")
    public String updateCommerce(Commerce bean , HttpServletRequest request,HttpServletResponse response, ModelMap model){

        try {
            logger.info("city =" + bean.getCity());

            Commerce commerce = commerceService.getCommerceById(bean.getId());

            long adminId = (long)session.getAttribute(request,"_admin_id_key");
            logger.info("adminId = " + adminId);
            Admin admin = adminMng.findById(adminId);
            operationLogService.editCommerce(admin.getUsername(), commerce.getCommerceId(), commerce.getCommerceId());

            if (commerce == null) {
                commerce = new Commerce();
                commerce.setCommerceId(sequenceDao.getCommerceId());
            }

            logger.info("channel id = " + bean.getChanIdRela().getId());
            Channel channel = channelService.getChannelByChannelId(bean.getChanIdRela().getId());

            logger.info(channel == null);
            if (channel != null) {
                logger.info("set channel");
                commerce.setChanIdRela(channel);
            }
            commerce.setCreateDate(new Date());
            commerce.setChecked("1");//未审核
            commerce.setDelStatus("0");//正常
            commerce.setStatus(bean.getStatus());
            commerce.setName(bean.getName());
            commerce.setMobilePhone(bean.getMobilePhone());
            commerce.setEmail(bean.getEmail());
            commerce.setCode(bean.getCode());
//            commerce.setSynStatus("2");

            commerce.setCollaborateEndTime(bean.getCollaborateEndTime());
            commerce.setCollaborateStartTime(bean.getCollaborateEndTime());

            commerce.setAccount(bean.getAccount());
            commerce.setRoundDay(bean.getRoundDay());
            commerce.setRate(bean.getRate());
            commerce.setDescription(bean.getDescription());

            commerce.setPro(bean.getPro());
            commerce.setCity(bean.getCity());
            commerce.setDetailed(bean.getDetailed());

            commerce.setLinkMan(bean.getLinkMan());
            commerce.setDescription(bean.getDescription());
            /*commerce.setExpress(bean.getExpress());

            logger.info("express ==" + bean.getExpress());*/

            commerceService.updateCommerceEntity(commerce);
         //   return "success";
        }catch (Exception e){
            logger.error("",e);
       //     return "fail";
        }

        return "redirect:v_list.do";
    }


    @RequestMapping("/commerce/v_check_commerce_name.do")
    public String checkUsername(String id,String name, HttpServletRequest request,
                                HttpServletResponse response) {
        logger.info("id ="+id);
        Commerce commerceOriginal = null;
        if(id!=null){
            commerceOriginal = commerceService.getCommerceById(Long.parseLong(id));
        }
        Commerce commerce = commerceService.getCommerceByNameService(name);

        if (StringUtils.isBlank(name) || ( commerceOriginal ==null&& commerce!=null) ||(commerceOriginal !=null &&(!commerceOriginal.getName().equals(name))&& commerce!=null)){
            ResponseUtils.renderJson(response, "false");
        } else {
            ResponseUtils.renderJson(response, "true");
        }
        return null;
    }

    @RequestMapping("/commerce/o_delete.do")
    public String deleteCommerces(Long[] ids, Integer pageNo,
                                  HttpServletRequest request, ModelMap model) {
        logger.info("ids =="+ids[0]);
        Commerce[] beans = commerceService.deleteByIds(ids);
        for (Commerce bean : beans) {
            logger.info("delete commerce, id={} = "+bean.getId());
        }
        return commercePagination(null, null, null, null, null, pageNo, request, model);
    }

    @RequestMapping("/commerce/moveDataSteps.do")
    public String moveDataSteps(){
        return "commerce/moveDataSteps";
    }

    @RequestMapping(value = "commerceToXls.do")
    public void channelToElx(String channelName, String commerceName, Long id, Date startTime, Date endTime, HttpServletRequest request, HttpServletResponse response){

        Long channelId = sessionUtil.getChannelId(request);
        Long commerceId = sessionUtil.getCommerceId(request);
        if (null == commerceId){
            commerceId = id;
        }
        List<CommerceModel> commerces = commerceService.getCommerceToExcel(channelName, commerceName, channelId, commerceId, startTime, endTime);
        try {
            OutputStream outputStream = response.getOutputStream();
            response.setHeader("Content-disposition", "attachment; filename="+new String("商户".getBytes("GB2312"),"8859_1")+".xls");
            //定义输出类型为excel
            response.setContentType("application/msexcel");

            ExcelUtils<CommerceModel> excelUtils = new ExcelUtils<CommerceModel>();
            List<String[]> list = new ArrayList<String[]>();
            String[] a1 = {"商户ID", "id"};
            list.add(a1);
            String[] a2 = {"商户编号", "commerceId"};
            list.add(a2);
            String[] a3 = {"商户名称", "commerceName"};
            list.add(a3);
            String[] a4 = {"手机号码", "mobile"};
            list.add(a4);
            String[] a5 = {"所属渠道", "channelName"};
            list.add(a5);
            String[] a6 = {"创建时间", "createDate"};
            list.add(a6);
            excelUtils.toExcelAjax(list, commerces, outputStream);
        } catch (Exception e) {
            logger.error("导出商户失败！", e);
        }
    }

    @RequestMapping(value = "/commerce/downloadDemo.do")
    public void downloadDemo(HttpServletResponse response) {
        try {
            OutputStream outputStream = response.getOutputStream();

            response.setHeader("Content-disposition", "attachment; filename=" + new String("commerceDemo".getBytes("GB2312"), "8859_1") + ".xlsx");
            response.setContentType("application/msexcel");

            String rootPath = getClass().getResource("/").getFile().toString();
            String[] pa = rootPath.split("\\/");
            StringBuffer fileToPath = new StringBuffer("/");
            for (int i = 1; i < pa.length-1; i++) {
                fileToPath.append(pa[i]).append("/");
            }
            fileToPath.append("download/commerceDemo.xlsx");
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

    @RequestMapping(value = "/commerce/importCommerce.do")
    public String importCommerce(Model model, HttpServletRequest request){
        List<Channel> channelList = new ArrayList<>();
        Long channelId = sessionUtil.getChannelId(request);
        Long commerceId = sessionUtil.getCommerceId(request);
        if (null != channelId){
            channelList.add(channelService.getChannelByChannelId(channelId));
        } else if (null == commerceId){
            channelList = channelService.getAllChannel();
        }
        model.addAttribute("channelList", channelList);
        java.util.List<Logistics> logisticsList = logisticsMng.getAllList();
        model.addAttribute("logisticsList",logisticsList);

        return "commerce/import-commerce";
    }

    @RequestMapping(value = "/commerce/import_save.do")
    public String saveCommerces(@RequestParam(value = "file", required = false) MultipartFile file, Commerce bean,HttpServletRequest request){
        try {
            commerceService.saveCommerceFromFile(file, bean,request);
        } catch (Exception e){
            logger.error("", e);
        }
        return "redirect:v_list.do";
    }

    @RequestMapping(value = "/commerce/operatorDemo.do")
    public void operatorDemo(HttpServletResponse response){
        try {
            OutputStream outputStream = response.getOutputStream();

            response.setHeader("Content-disposition", "attachment; filename=" + new String("operatorDemo".getBytes("GB2312"), "8859_1") + ".xlsx");
            response.setContentType("application/msexcel");

            String rootPath = getClass().getResource("/").getFile().toString();
            String[] pa = rootPath.split("\\/");
            StringBuffer fileToPath = new StringBuffer();
            for (int i = 1; i < pa.length-1; i++) {
                fileToPath.append(pa[i]).append("/");
            }
            fileToPath.append("download/operatorDemo.xlsx");
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

    @RequestMapping(value = "/commerce/importOperator.do")
    public String importOperator(Model model, HttpServletRequest request){
        List<Role> roleList = new ArrayList<Role>();
        roleList.add(roleMng.findById(4));//商户Role
        model.addAttribute("roleList", roleList);

        Integer[] roleIds= {4};

        model.addAttribute("roleIds", roleIds);

        Long channelId = sessionUtil.getChannelId(request);
        Long commerceId = sessionUtil.getCommerceId(request);
        java.util.List<Commerce> commerceList = commerceService.getCommerces(channelId, commerceId);
        model.addAttribute("commerceList", commerceList);

        java.util.ArrayList<HashMap<String,Object>> storeFrontList = new ArrayList<HashMap<String,Object>>();
        java.util.HashMap<String,Object> storeFrontObject = new HashMap<String,Object>();
        storeFrontObject.put("id"," ");
        storeFrontObject.put("name","无");
        storeFrontList.add(storeFrontObject);

        List<Store> list = storeMng.getStore(channelId, commerceId);
        model.addAttribute("storeFrontList", list);
        return "commerce/import-operator";
    }

    @RequestMapping(value = "/commerce/o-save-operator.do")
    public String saveOperator(@RequestParam(value = "file", required = false) MultipartFile file, Boolean viewOnlyAdmin, String storeFront,
                               Boolean disabled, Integer[] roleIds, String commerceId, HttpServletRequest request, ModelMap model){
        Long channelId = null;
        try {
            Website web = SiteUtils.getWeb(request);
            String ip = request.getRemoteAddr();
            channelId = commerceService.saveOperators(file, viewOnlyAdmin, storeFront, disabled, roleIds, commerceId, ip, web);
        } catch (Exception e){
            logger.error("", e);
        }
//        return "redirect:v_list.do";
        return commerceUserList(commerceId, String.valueOf(channelId), request, 1, model);
    }

    @RequestMapping(value = "/commerce/pay_account_set.do")
    public String setPayAccount(Long id, ModelMap model){
        List apps = new ArrayList<>();
        for (BankAppEnum appEnum: BankAppEnum.values()) {
            apps.add(appEnum.name());
        }
        Commerce commerce = commerceService.getCommerceById(id);
        BankPayInfo bankPayInfo = null;
        if (StringUtils.isNotBlank(commerce.getPayAccountId())){
            bankPayInfo = bankPayInfoMng.getBankPayInfoById(commerce.getPayAccountId());
        }
        bankPayInfo = (null == bankPayInfo)? new BankPayInfo() : bankPayInfo;

        Integer payAccountStatus = 1;
        if (null != commerce.getPayAccountStatus()){
            payAccountStatus = commerce.getPayAccountStatus();
        }
        model.addAttribute("apps", apps);
        model.addAttribute("bankPayInfo", bankPayInfo);
        model.addAttribute("commerceId", id);
        model.addAttribute("payAccountStatus", payAccountStatus);
        return "commerce/pay-account-set";
    }

    @RequestMapping(value = "/commerce/o_pay_account_set.do")
    public String savePayAccount(BankPayInfo bankPayInfo, Long commerceId, Integer payAccountStatus){
        commerceService.setPayAccount(commerceId, bankPayInfo, payAccountStatus);
        return "redirect:v_list.do";
    }

    @RequestMapping(value = "/commerce/v_bank_pay_name.do")
    public void checkName(String name, Long commerceId, HttpServletResponse response){
        Commerce commerce = commerceService.getCommerceById(commerceId);
        String id = commerce.getPayAccountId();
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

    @RequestMapping(value = "/commerce/delete_pay_account.do")
    public String deletePayAccount(Long commerceId){
        commerceService.deletePayAccount(commerceId);
        return "redirect:v_list.do";
    }

    @Resource
    private SessionUtil sessionUtil;

    @Autowired
    private LogisticsMng logisticsMng;

    @Autowired
    private UserMng userMng;

    @Autowired
    private AdminMng adminMng;

    @Autowired
    private ShopAdminMng shopAdminMng;

    @Autowired
    private RoleMng roleMng;

    @Autowired
    private StoreMng storeMng;

    @Autowired
    private BankPayInfoMng bankPayInfoMng;
}
