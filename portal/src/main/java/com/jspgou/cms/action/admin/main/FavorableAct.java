package com.jspgou.cms.action.admin.main;

import com.ifunpay.portal.entity.Channel;
import com.ifunpay.portal.service.commerce.ChannelService;
import com.jspgou.cms.entity.Favorable;
import com.jspgou.cms.entity.Product;
import com.jspgou.cms.entity.ProductFavorable;
import com.jspgou.cms.manager.FavorableMng;
import com.jspgou.cms.manager.ProductFavorableMng;
import com.jspgou.cms.manager.ProductMng;
import com.jspgou.common.page.Pagination;
import com.jspgou.common.web.CookieUtils;
import com.jspgou.common.web.session.SessionProvider;
import com.jspgou.core.entity.Website;
import com.jspgou.core.web.SiteUtils;
import com.jspgou.core.web.WebErrors;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.*;

import static com.jspgou.common.page.SimplePage.cpn;
import static com.jspgou.core.web.Constants.CHANNELID;
import static com.jspgou.core.web.Constants.CHANNELNAME;

/**
 * Created by David on 2015/3/17.
 */
@Controller
public class FavorableAct {
    private static final Logger log = LoggerFactory.getLogger(FavorableAct.class);
    public static  ArrayList<HashMap<String,String>> channels=new ArrayList<HashMap<String,String>>();;

    @RequestMapping("/favorable/v_list.do")
    public String list(Integer pageNo, HttpServletRequest request, ModelMap model,
                       String channelName,String name,Integer area,Integer favorableType,Integer amountType ,Integer manner,
                       Date startTime,Date endTime,
                       String massage,String productName) {
        String channelId= (String)session.getAttribute(request,CHANNELID);


        Pagination pagination = manager.getPage(cpn(pageNo), CookieUtils.getPageSize(request),channelId,channelName, name, area, favorableType, amountType, manner, startTime, endTime,null,productName);
            model.addAttribute("channelName",channelName);
            if(null!=name){
                model.addAttribute("name",name);
            }
            if(null!=area){
                model.addAttribute("area",area);
            }
            if(null!=favorableType){
                model.addAttribute("favorableType",favorableType);
            }
            if(null!=amountType){
                model.addAttribute("amountType",amountType);
            }
            if(null!=manner){
                model.addAttribute("manner",manner);
            }
            SimpleDateFormat sFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            if(null!=startTime){
                model.addAttribute("startTime",sFormat.format(startTime));
            }
            if(null!=endTime){

                model.addAttribute("endTime",sFormat.format(endTime));
            }
            model.addAttribute("pagination",pagination);
            if(null!=massage) {
                model.addAttribute("message", massage);
            }
            model.addAttribute("productName",productName);
            return "favorable/list";
    }

    @RequestMapping("/favorable/v_add.do")
    public String add(HttpServletRequest request,ModelMap model) {
        String channelId = (String)session.getAttribute(request,CHANNELID);
        List<Map<String,String>> channelList = new ArrayList<>();
        Map<String,String> channelMap =new HashMap<>();
            if(channelId!=null){
                channelMap.put("id","");
                channelMap.put("channelName","请选择");
                channelList.add(channelMap);
                channelMap = new HashMap<>();
                channelMap.put("id",channelId);
                channelMap.put("channelName",(String)session.getAttribute(request,CHANNELNAME));
                channelList.add(channelMap);
                model.addAttribute("channelList", channelList);
            }else {
                model.addAttribute("channelList", channelService.getAllChannel());
            }
        return "favorable/add";
    }

    @RequestMapping("/favorable/v_edit.do")
    public String edit(Long id, HttpServletRequest request, ModelMap model) {
        Website web = SiteUtils.getWeb(request);
        WebErrors errors = validateEdit(id, request);
        if (errors.hasErrors()) {
            return errors.showErrorPage(model);
        }
        Favorable bean=manager.findById(id);
        model.addAttribute("favorable", bean);
        Integer nameType;
        if(0!=bean.getBeforeN()){
            nameType=1;
        }else if (!"".equals(bean.getWeeks())){
            nameType=2;
        }else {
            nameType=3;
        }
        model.addAttribute("nameType",nameType);
        return "favorable/edit";
    }

    @RequestMapping("/favorable/v_view.do")
    public String view(Long id, HttpServletRequest request, ModelMap model) {
        Website web = SiteUtils.getWeb(request);
        WebErrors errors = validateEdit(id, request);
        if (errors.hasErrors()) {
            return errors.showErrorPage(model);
        }
        Favorable bean=manager.findById(id);
        model.addAttribute("favorable", bean);
        Integer nameType;
        if(0!=bean.getBeforeN()){
            nameType=1;
        }else if (!"".equals(bean.getWeeks())){
            nameType=2;
        }else {
            nameType=3;
        }
        model.addAttribute("nameType",nameType);
        return "favorable/view";
    }
    @RequestMapping("/favorable/o_save.do")
    public String save(Favorable bean,HttpServletRequest request,ModelMap model) {
        WebErrors errors = validateSave(bean, request);
        if (errors.hasErrors()) {
            return errors.showErrorPage(model);
        }
        String channelName = (String)session.getAttribute(request,CHANNELNAME);
        if(null == channelName){
            List<Channel> channelList= channelService.getAllChannel();
            for (int i = 0;i<channelList.size();i++){
                if (bean.getChannelId().equals(String.valueOf(channelList.get(i).getId()))){
                    channelName = channelList.get(i).getChannelName();
                }
            }
        }
        bean.setChannelName(channelName);
        bean.setDele(0);
        bean = manager.save(bean);

        log.info("save Favorable id={}", bean.getId());
        return "redirect:v_list.do";
    }

    @RequestMapping("/favorable/o_update.do")
    public String update(Favorable bean,Integer nameType,HttpServletRequest request,ModelMap model,Integer pageNo ) {
        WebErrors errors = validateUpdate(bean.getId(), request);
        String massage = null;
//        List<ProductFavorable> list = pfManager.getListByProduct(null,bean.getId());
//        if (0==list.size()) {
            if (errors.hasErrors()) {
                return errors.showErrorPage(model);
            }
            bean.setDele(0);
            bean = manager.update(bean);
            log.info("update favorable id={}.", bean.getId());
//        }else {
//            log.info("update favorable false this has banding product", bean.getId());
//            massage = "修改失败，请先解除商品关联"; //alert favorable has banding product
//        }
        return list(pageNo, request, model,null,null,null,null,null,null,null,null,massage,null);
    }

    @RequestMapping("/favorable/o_delete.do")
    public String delete(Long[] ids, Integer pageNo, HttpServletRequest request,ModelMap model) {
        WebErrors errors = validateDelete(ids, request);
        if (errors.hasErrors()) {
            return errors.showErrorPage(model);
        }
        String massage =null;
        boolean doDelete = false;
        ArrayList<Long> deleteIds = new ArrayList<>();
        for (int i =0;i<ids.length;i++){
            List<ProductFavorable> list = pfManager.getListByProduct(null,ids[i]);
            if(0!=list.size()){
                log.info("delete false be this Favorable binding product ", ids[i]);
                massage = "删除失败，请先解除和商品的绑定"; //alert Favorable binding product
            }else {
                deleteIds.add(ids[i]);
            }
            if(null!=ids[i]){
                doDelete = true;
            }
        }
        if(doDelete){
            Favorable[] beans  = manager.deleteByIds(deleteIds);
            for (Favorable bean : beans) {
                log.info("delete Favorable id={}", bean.getId());
            }
        }
        return list(pageNo, request, model,null,null,null,null,null,null,null,null,massage,null);
    }

    @RequestMapping("/favorable/favorableProduct/v_list.do")
    public String bindProduct(Long favorableId,Integer pageNo,Long productId,String productName,String commerceName ,String banding,HttpServletRequest request ,ModelMap model  ) {
        Favorable favorable =manager.findById(favorableId);
        if(favorable!=null){
            List<ProductFavorable> pList= pfManager.getListByProduct(null, favorableId);
            Pagination pagination =pdManager.getPageForChannel(cpn(pageNo),CookieUtils.getPageSize(request),favorable.getChannelId(),productId,productName,commerceName);
            List<Product> list=(List<Product>)pagination.getList();
            List<Product> list1= new ArrayList<>();
           if(banding!=null) {
               if ("1" .equals( banding)) {
                   for (Product product : list) {
                       for (ProductFavorable productFavorable : pList) {
                           if (product.getId().longValue() == productFavorable.getProductId().longValue()) {
                               list1.add(product);
                           }
                       }
                   }
               } else if ("2".equals(banding)) {
                   for (Product product : list) {
                       boolean toAdd = true;
                       for (ProductFavorable productFavorable : pList) {
                           if (product.getId().longValue() == productFavorable.getProductId().longValue()) {
                               toAdd = false;
                           }
                       }
                       if (toAdd) {
                           list1.add(product);
                       }
                   }
               } else {
                   list1 = list;
               }
           }else {
               list1 = list;
           }

            List<Long> refuseBind = new ArrayList<>();
            List<Long> allBind = new ArrayList<>();
            List<Long> otherBind = new ArrayList<Long>();

            for (Product product :list1){
            List<ProductFavorable> pfList= pfManager.getListByProduct(product.getId(), favorableId);
                if(pfList.size()>0){
                refuseBind.add(product.getId());
                }
            }
            // 由一个商品只能属于一个限购策略   改为可以属于多个限购策略     --David 2015/08/19
//            for (Product product :list1){
//                List<ProductFavorable> pfList= pfManager.getListByProduct(product.getId(), null);
//                if(pfList.size()>0){
//                    allBind.add(product.getId());
//                }
//            }
//            for (Long l : allBind) {//遍历list1
//                if (!refuseBind.contains(l)) {//如果存在这个数
//                    otherBind.add(l);//放进一个list里面，这个list就是交集
//                }
//            }
            pagination.setList(list1);
            model.addAttribute("refuseBind",refuseBind);
            model.addAttribute("otherBind",otherBind);
            model.addAttribute("pageNo",pageNo);
            model.addAttribute("favorableId",favorableId);
            model.addAttribute("channelId",favorable.getChannelId());
            model.addAttribute("pagination",pagination);
            model.addAttribute("productName",productName);
            model.addAttribute("productId",productId);
            model.addAttribute("commerceName",commerceName);
            if(banding!=null&&!"".equals(banding)){
                model.addAttribute("banding",Integer.valueOf(banding));
            }

        }
        return "favorableProduct/list";
    }

    @RequestMapping("/favorable/favorableProduct/o_bind_save.do")
    public String bind(Long[] ids,Long favorableId,String channelId, Integer pageNo, HttpServletRequest request,ModelMap model) {
//        WebErrors errors = validateDelete(ids, request);
//        if (errors.hasErrors()) {
//            return errors.showErrorPage(model);
//        }
        String massage = null;

        for(int i = 0;i<ids.length;i++) {
                ProductFavorable bean = new ProductFavorable();
                bean.setFavorableId(Long.valueOf(favorableId));
                bean.setProductId(ids[i] );
                Product product = pdManager.findById(ids[i]);
                bean.setProductName(product.getName());
                bean = pfManager.save(bean);

        }

        return bindProduct( favorableId,  pageNo,  null,  null,null, null,  request,  model);
    }

    @RequestMapping("/favorable/favorableProduct/p_delete.do")
    public String favorableDelete(Long favorableId,Long productId,String channelId, Integer pageNo, HttpServletRequest request,ModelMap model) {

        List<ProductFavorable> list = pfManager.getListByProduct(productId,favorableId);
        ProductFavorable beans = pfManager.deleteById(list.get(0).getId());
            log.info("delete ProductFavorable id={}", beans.getId());
         return bindProduct(favorableId, pageNo, null,null,null, null, request, model);
    }

    @RequestMapping("/favorable/p_relieveProduct.do")
    public String relieveProduct(String id, Integer pageNo, HttpServletRequest request,ModelMap model) {
        String massage = null;
        if(id != null && !"".equals(id)) {
            List<ProductFavorable> list = pfManager.getListByProduct(null, Long.valueOf(id));
            for (ProductFavorable productFavorable : list) {
                ProductFavorable beans = pfManager.deleteById(productFavorable.getId());
                log.info("delete ProductFavorable id={}", beans.getId());
            }
        }
        return list(pageNo, request, model, null, null, null, null, null, null, null, null, massage,null);
    }
    private WebErrors validateSave(Favorable bean, HttpServletRequest request) {
        WebErrors errors = WebErrors.create(request);
        return errors;
    }
    private WebErrors validateEdit(Long id, HttpServletRequest request) {
        WebErrors errors = WebErrors.create(request);
        Website web = SiteUtils.getWeb(request);
        if (vldExist(id, web.getId(), errors)) {
            return errors;
        }
        return errors;
    }
    private boolean vldExist(Long id, Long webId, WebErrors errors) {
        if (errors.ifNull(id, "id")) {
            return true;
        }
        Favorable entity = manager.findById(id);
        if(errors.ifNotExist(entity, Favorable.class, id)) {
            return true;
        }
        return false;
    }
    private WebErrors validateUpdate(Long id, HttpServletRequest request) {
        WebErrors errors = WebErrors.create(request);
        Website web = SiteUtils.getWeb(request);
        if (vldExist(id, web.getId(), errors)) {
            return errors;
        }
        return errors;
    }
    private WebErrors validateDelete(Long[] ids, HttpServletRequest request) {
        WebErrors errors = WebErrors.create(request);
        Website web = SiteUtils.getWeb(request);
        errors.ifEmpty(ids, "ids");
        for (Long id : ids) {
            vldExist(id, web.getId(), errors);
        }
        return errors;
    }
    @Autowired
    private FavorableMng manager;
    @Autowired
    private ProductFavorableMng pfManager;

    @Autowired
    private SessionProvider session;

    public SessionProvider getSession() {
        return session;
    }

    public void setSession(SessionProvider session) {
        this.session = session;
    }

    @Autowired
    private ProductMng pdManager;


    @Autowired
    private ChannelService channelService;
}
