package com.ifunpay.portal.service.system;

import com.ifunpay.util.web.filter.SecurityCheckFilter;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import java.util.Map;

/**
 * Created by yu on 15-5-28.
 */
@Service
@Lazy(false)
public class ApplicationStartService {


    @Resource
    Map<String, String> securityMap;

    @PostConstruct
    private void init(){
        SecurityCheckFilter.setSecurityCodeSupplier(securityMap::get);
    }
}
