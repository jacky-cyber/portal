package com.ifunpay.test;

import org.hibernate.SessionFactory;
import org.hibernate.classic.Session;
import org.hibernate.transform.Transformers;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;

import java.util.List;
import java.util.Map;

/**
 * Created by David on 2015/5/18.
 */
public class TestMoveData {

    @Test
    public void move(){
        System.out.println("??????????????????????????????????????????????开始");
//        ApplicationContext contex = new ClassPathXmlApplicationContext("src/applicationContext.xml");
        ApplicationContext contex = new FileSystemXmlApplicationContext("classpath:applicationContext.xml");
        SessionFactory factory = (SessionFactory)contex.getBean("sessionFactory"); //sessionFactory 为你配置的SessionFactory been的id
        Session session = factory.openSession();
        String sql = "select * from t_product";
        List list = session.createSQLQuery(sql).setResultTransformer(
                Transformers.ALIAS_TO_ENTITY_MAP).list();
        Map map = (Map) list.get(0);

        System.out.println("name" + map.get("PRODUCT_NAME"));
        System.out.println("??????????????????????????????????????????????" + list);
    }
}
