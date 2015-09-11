package com.ifunpay.portal.service.commerce;

import com.ifunpay.portal.dao.NewOrderVoucherDao;
import com.ifunpay.portal.entity.OrderVoucher;
import com.ifunpay.portal.service.log.OperationLogService;
import com.jspgou.cms.action.admin.main.UnLoadAdminAct;
import com.jspgou.common.web.session.SessionProvider;
import com.jspgou.core.entity.Admin;
import com.jspgou.core.entity.User;
import com.jspgou.core.manager.AdminMng;
import com.jspgou.core.manager.UserMng;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2015/8/14.
 */
@Service
@Log4j
public class NewOrderVoucherService {
    @Resource
    private OperationLogService operationLogService;

    @Resource
    private NewOrderVoucherDao newOrderVoucherDao;

    @Resource
    private SessionProvider session;

    @Resource
    private UserMng userMng;

    @Resource
    private AdminMng adminMng;

    @Transactional
    public boolean validateVoucher(HttpServletRequest request,String voucherCode){
        //From client
        String username = (String)session.getAttribute(request, "username");
        log.info("username=" + username);
        User user = null;
        if(username!=null){
            user = userMng.getByUsername(username);
            operationLogService.consumeVoucher(username+"",voucherCode,voucherCode);
        }else {
            //From back-end
            long adminId = (long)session.getAttribute(request,"_admin_id_key");
            log.info("adminId = " + adminId);
            Admin admin = adminMng.findById(adminId);
            if(admin!=null){
                operationLogService.consumeVoucher(admin.getUsername(), voucherCode, voucherCode);
                user = admin.getUser();
            }
        }

        return newOrderVoucherDao.validateVoucherCodeForOrder(user, voucherCode);
    }

    public OrderVoucher getNoUsedVoucherByVoucherCode(String voucherCode){
        return newOrderVoucherDao.findByVoucherCode(voucherCode);
    }
}
