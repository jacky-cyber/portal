package com.ifunpay.portal.service;

import com.ifunpay.portal.ProjectXml;
import org.springframework.stereotype.Component;

import javax.annotation.PreDestroy;
import java.util.concurrent.Executor;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * Created by Administrator on 2014/12/24.
 */
@Component
public class ThreadPoolService implements Executor {

    private ExecutorService executorService;

    public ThreadPoolService(){
        int size;
        try {
            size = new Integer(ProjectXml.getValue("executor-service-pool-size"));
        }catch (RuntimeException e){
            size = 1;
        }
        executorService = Executors.newFixedThreadPool(size);
    }

    public void execute(Runnable runnable){
        executorService.execute(runnable);
    }

    @PreDestroy
    public void destroy(){
        executorService.shutdown();
    }

}
