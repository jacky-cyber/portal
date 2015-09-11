package com.ifunpay.portal.entity;

import com.sun.org.apache.bcel.internal.generic.RET;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * Created by Administrator on 2015/4/20.
 */

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.FIELD)
public @interface LogDescCN {
    public String chineseName();

    /**
     * 枚举值，继承了IEnum
     *
     * @return
     */
    public Class<?> val() default Object.class;

}
