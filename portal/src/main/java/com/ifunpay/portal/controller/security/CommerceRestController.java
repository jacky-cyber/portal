package com.ifunpay.portal.controller.security;

import com.ifunpay.portal.entity.Commerce;
import com.ifunpay.portal.entity.Merchant;
import com.ifunpay.portal.service.commerce.CommerceService;
import com.jspgou.common.page.Pagination;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

import static com.jspgou.common.page.SimplePage.checkSize;
import static com.jspgou.common.page.SimplePage.cpn;

/**
 * Created by zj on 15-4-27.
 */
@RestController
@RequestMapping(value = "/security/commerce")
public class CommerceRestController {
    @RequestMapping(value = "/commerce")
    public Object getCommerce(@RequestBody Map<String, Object> requestParam){
        Long channelId = null;
        Object obc = requestParam.get("channelId");
        if (null != obc && !("").equals(obc)){
            channelId = Long.parseLong(obc.toString());
        }
        Long merchantId = null;
        Object obm = requestParam.get("commerceId");
        if (null != obm && !("").equals(obm)){
            merchantId = Long.parseLong(obm.toString());
        }
        String channelName = (String) requestParam.get("channel_name");
        String name = (String) requestParam.get("name");
        Integer start = (Integer) requestParam.get("start");
        Integer size = (Integer) requestParam.get("size");
        Map<String, Object> map = new HashMap<>();
        Pagination pagination = commerceService.getCommercePaging(channelId, merchantId, channelName, name, null, null, cpn(start), checkSize(size));
        List<Commerce> list = (List<Commerce>) pagination.getList();
        List<Merchant> merchants = list.stream().map(m -> {
            return new Merchant(m.getId(), m.getName(), m.getChanId(), m.getChanIdRela().getChannelName(), m.getStatus(), m.getMobilePhone(),
                    m.getEmail(), m.getPro(), m.getCity(), m.getDetailed(), m.getCreateDate(), m.getCreator(), m.getModifyDate(), m.getModifier(),
                    m.getCode(), m.getDescription(), m.getDelStatus(), m.getCollaborateStartTime(), m.getCollaborateEndTime(), m.getChecked(),
                    m.getLinkMan(), m.getAccount(), m.getRoundDay(), m.getRate(), m.getPayAccountId(), m.getPayAccountStatus());
        }).collect(Collectors.toList());
        map.put("commerces", merchants);
        map.put("totalCount", pagination.getTotalCount());
        return map;
    }

    @Resource
    private CommerceService commerceService;
}
