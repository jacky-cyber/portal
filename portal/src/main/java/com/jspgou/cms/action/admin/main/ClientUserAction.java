package com.jspgou.cms.action.admin.main;

import com.ifunpay.portal.entity.BankPayInfo;
import com.ifunpay.portal.entity.Channel;
import com.ifunpay.portal.entity.Commerce;
import com.ifunpay.portal.service.MemberUserService;
import com.ifunpay.portal.service.commerce.ChannelService;
import com.ifunpay.portal.service.commerce.CommerceService;
import com.jspgou.cms.dao.SequenceDao;
import com.jspgou.cms.entity.ShopAdmin;
import com.jspgou.cms.manager.LogisticsMng;
import com.jspgou.cms.manager.ShopAdminMng;
import com.jspgou.common.page.Pagination;
import com.jspgou.common.web.CookieUtils;
import com.jspgou.common.web.ResponseUtils;
import com.jspgou.common.web.session.SessionProvider;
import com.jspgou.core.entity.Role;
import com.jspgou.core.entity.Website;
import com.jspgou.core.manager.AdminMng;
import com.jspgou.core.manager.RoleMng;
import com.jspgou.core.manager.UserMng;
import com.jspgou.core.web.SiteUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
public class ClientUserAction {

    private static Logger logger = Logger.getLogger(ClientUserAction.class);

    @Resource
    private SessionProvider session;

    @Resource
    private SequenceDao sequenceDao;

    @RequestMapping("/client-user/v_list.do")
    public String clientUserList(String id, String phone, String registerIp, Integer origin, Date startTime, Date endTime, HttpServletRequest request,Integer pageNo, ModelMap model){

        String commerceId = null;

        logger.info("channel id ==" + id);

        Pagination pagination = memberUserService.getPageForClientUser(id, commerceId, phone, registerIp, origin, startTime, endTime, SiteUtils.getWebId(request), cpn(pageNo), CookieUtils.getPageSize(request));

        model.addAttribute("startTime", startTime);
        model.addAttribute("endTime", endTime);
        model.addAttribute("phone", phone);
        model.addAttribute("registerIp", registerIp);
        model.addAttribute("origin", origin);
        model.addAttribute(pagination);

        return "commerce/client-user-list";
    }

    @Autowired
    private MemberUserService memberUserService;
}
