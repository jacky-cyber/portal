package com.ifunpay.test;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonValue;
import com.ifunpay.util.common.DateUtil;
import com.ifunpay.util.jackson.JsonUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.time.LocalDateTime;
import java.util.Date;

/**
 * Created by yu on 4/9/15.
 */
public class TestJsonUtil {

    static Logger logger = LoggerFactory.getLogger(TestJsonUtil.class);

    public static void main(String... args) {
        C1 c1 = new C1();
        logger.debug(JsonUtil.toJson(c1));
    }
}

class C1 {
    private Date date = new Date();
    private LocalDateTime localDateTime = LocalDateTime.now();

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    @JsonValue(false)
    public LocalDateTime getLocalDateTime() {
        return localDateTime;
    }

    public void setLocalDateTime(LocalDateTime localDateTime) {
        this.localDateTime = localDateTime;
    }
}
