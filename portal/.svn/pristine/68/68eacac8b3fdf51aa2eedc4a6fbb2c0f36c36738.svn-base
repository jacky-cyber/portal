package com.ifunpay.portal.controller.security;

import com.ifunpay.portal.dao.MemberUserDao;
import com.ifunpay.portal.entity.MemberUserEntity;
import com.ifunpay.util.common.MapUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.*;

/**
 * Created by yu on 4/3/15.
 */
@RestController
@RequestMapping("/security/user")
public class UserRestController {

    private Logger logger = LoggerFactory.getLogger(UserRestController.class);

    @Resource
    MemberUserDao memberUserDao;

    @RequestMapping("/fetch")
    public Object fetch(@RequestBody Map<String, Object> requestParam) {
        Map<String, Object> map = new HashMap<>();
        List<MemberUserEntity> list;
        long rowCount = 0;
        try {
            Optional<String> id = MapUtil.get(requestParam, "id");
            Optional<String> userName = MapUtil.get(requestParam, "username");
            Optional<String> phone = MapUtil.get(requestParam, "phone");
            int start = (Integer) requestParam.getOrDefault("start", 0);
            int size = (int) requestParam.getOrDefault("size", 50);
            list = memberUserDao.fetch(id, userName, phone, start, size);
            rowCount = memberUserDao.fetchCount(id, userName, phone);
        } catch (Exception e) {
            logger.error("", e);
            list = new ArrayList<>();
            map.put("errorMessage", e.toString());
        }
        map.put("size", list.size());
        map.put("users", list);
        map.put("totalCount", rowCount);
        return map;
    }
    @RequestMapping("/fetchCount")
    public Object fetchCount(@RequestBody Map<String, Object> requestParam){
        HashMap<String,Object> map = new HashMap<String,Object>();
        try {
            Integer  count = memberUserDao.findCount();//
            map.put("count",count);
        }catch (Exception e){
            logger.info("error",e);
            map.put("errorMessage","fetchCount false");
        }
        return map;
    }

    @RequestMapping("/create")
    public Object create(@RequestBody Map<String, Object> requestParam) {
        MemberUserEntity userEntity = new MemberUserEntity();
        Map<String, Object> map = new HashMap<>();
        map.put("ok", false);
        map.put("errorMessage", "this method not supported yet.");
        //TODO complete this method
        return map;
    }

    @RequestMapping("/update")
    public Object update(@RequestBody Map<String, Object> requestParam) {
        //TODO return resources
        Map<String, Object> map = new HashMap<>();
        map.put("ok", false);
        map.put("errorMessage", "this method not supported yet.");
        return map;
    }


    @RequestMapping("/delete")
    public Object delete(@RequestBody Map<String, Object> requestParam) {
        boolean ok = false;
        try {
            List<String>  ids= (List) requestParam.get("ids");
            String[] strings = new String[ids.size()];
            for(int i = 0;i<ids.size();i++){
                 strings[i] = ids.get(i).toString();
            }
            memberUserDao.delete(MemberUserEntity.class,strings);
            ok = true;
        } catch (Exception e) {
            logger.error("", e);
        }
        Map<String, Boolean> map = new HashMap<>();
        map.put("ok", ok);
        return map;
    }
}
