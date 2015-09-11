package com.ifunpay.portal.model.notification;

import javax.annotation.Resource;
import java.util.List;
import java.util.function.Consumer;

/**
 * Created by Yu on 2015/3/31.
 */
public class NotificationCenter {

    @Resource
    private List<NotificationSupplier<?>> notificationSupplierList;

    public <T> void bindService(String serviceName, Consumer<T> consumer){

    }
}
