package com.ifunpay.test;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by yu on 4/8/15.
 */
public class TestMap {

    static Logger logger = LoggerFactory.getLogger(TestMap.class);

    public static void main(String... args){
        Map<String, Object> map = new HashMap<>();
        map.put("s", Integer.valueOf(3));
        int a = (int) map.getOrDefault("s", 45);
        logger.debug("" + a);
    }
}
