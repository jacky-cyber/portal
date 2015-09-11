package com.ifunpay.portal.controller.security;

import com.ifunpay.portal.entity.Channel;
import com.ifunpay.portal.service.commerce.ChannelService;
import com.jspgou.common.page.Pagination;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.jspgou.common.page.SimplePage.checkSize;
import static com.jspgou.common.page.SimplePage.cpn;

/**
 * Created by zj on 15-4-27.
 */
@RestController
@RequestMapping(value = "/security/channel")
public class ChannelRestController {

    @RequestMapping(value = "/channel")
    public Object getChannel(@RequestBody Map<String, Object> requestParam) {
        String name = (String) requestParam.get("name");
        Long channelId = null;
        if(null!=requestParam.get("channel_id")&&!"".equals(requestParam.get("channel_id"))){
             channelId =  Long.valueOf(requestParam.get("channel_id").toString());
        }

        Integer start = (Integer) requestParam.get("start");
        Integer size = (Integer) requestParam.get("size");
        Map<String, Object> map = new HashMap<>();
        Pagination pagination = channelService.getPaginationForChannelService(channelId, name, null, null, cpn(start), checkSize(size));
        List<Channel> list = (List<Channel>)pagination.getList();
        for (Channel channel:list){
            channel.setChannelId(String.valueOf(channel.getId()));
        }
        map.put("channels", pagination.getList());
        map.put("totalCount", pagination.getTotalCount());
        return map;
    }

    @RequestMapping(value = "/allChannel")
    public Object getAllChannel() {
        Map<String, Object> map = new HashMap<>();
        List<Channel> channels = channelService.getAllChannel();
        for (Channel channel :channels){
            channel.setChannelId(String.valueOf(channel.getId()));
        }
        map.put("channels", channels);
        return map;
    }

    @Resource
    private ChannelService channelService;
}
