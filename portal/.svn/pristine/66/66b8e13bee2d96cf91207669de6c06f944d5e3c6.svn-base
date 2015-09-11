package com.ifunpay.portal;


import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


/**
 *
 * <p>Description:解析xml </p>
 * @date 2014年6月10日
 * @author Aaron
 * @version 1.0
 * <p>Company:Mopon</p>
 * <p>Copyright:Copyright(c)2013</p>
 */
public final class ProjectXml {

    private static Logger logger = LoggerFactory.getLogger(ProjectXml.class);

    public static final String BASE_PATH_UPLOAD = "base_path_upload";

    /**
     * 缓存容器
     */
    public static Map<String,Object> cacheContext = new HashMap<String,Object>();

    static {
        SAXReader saxReader = new SAXReader();
        saxReader.setEncoding("UTF-8");
        Document document = null;
        InputStream is = null;
        try {
            is = Thread.currentThread().getContextClassLoader().getResourceAsStream("/project.xml");//兼容weblogic
            if(null == is){
                logger.error(" 配置文件project.xml 没有正常加载 InputStream="+is);
            }
            document = saxReader.read(is);
            Element root = document.getRootElement();
            Iterator it = root.element("project").elementIterator();
            while (it.hasNext()) {
                Element filed = (Element) it.next();
                cacheContext.put(filed.getName(), filed.getData());
            }
        } catch (Exception e) {
            logger.error("项目启动配置文件缓存加载异常...",e);
        }finally{
            try {
                if(null !=is) is.close();
            } catch (IOException e) {}
        }

    }

    private final static String bodyReg = new StringBuilder("<").append("project")
            .append(">(.*?)</").append("project").append(">").toString() ;
    private final static Pattern bodyPattern = Pattern.compile(bodyReg, Pattern.DOTALL);
    //取标签
    private final static String reg = new StringBuilder("<(.*?)>(.*?)</.*?>").toString() ;
    private final static Pattern pattern = Pattern.compile(reg, Pattern.DOTALL);

    /**
     *
     * 方法用途: 获得xml.body部分的内容<br>
     * 实现步骤: <br>
     * @param str
     * @return
     */
    private static String getProjectContent (String str) {
        Matcher bodyMatcher = bodyPattern.matcher(str);
        if (bodyMatcher.find()) {
            return bodyMatcher.group(1);
        }
        return null;
    }
    /**
     *
     * 功能：解析xml
     *
     * @param str xml文件
     * @return
     */
    public static Map<String,String> getContentFromXML(String str){
        SAXReader saxReader = new SAXReader();
        Map<String,String> map = new HashMap<String, String>();
        try {
            saxReader.setEncoding("gb2312");
            Document document = saxReader.read(new ByteArrayInputStream(str.getBytes()));

            // 获取根元素
            Element root = document.getRootElement();

            Iterator it = root.element("head").elementIterator();
            while (it.hasNext()) {
                Element filed = (Element) it.next();
                map.put(filed.attributeValue("name"), (filed.getData()+"").trim());
            }
            it = root.element("body").elementIterator();
            while (it.hasNext()) {
                Element filed = (Element) it.next();
                map.put(filed.attributeValue("name"), (filed.getData()+"").trim());
            }
        } catch (Exception e) {
            logger.info(" ParseXml.getContentFromXML 解析 xml 错误:",e);
        }

        return map;

    }

    /**
     *
     * 功能：解析xml
     * 1. 文件格式 <header><msgId>0000210</msgId></header>
     * @param str xml文件
     * @return
     */
    public static Map<String,String> getContentFromXMLForTag(String str){

        SAXReader saxReader = new SAXReader();
        Map<String,String> map = new HashMap<String, String>();
        try {
            saxReader.setEncoding("gb2312");
            Document document = saxReader.read(new ByteArrayInputStream(str.getBytes()));

            // 获取根元素
            Element root = document.getRootElement();

            Iterator it = root.element("header").elementIterator();
            while (it.hasNext()) {
                Element filed = (Element) it.next();
                map.put(filed.getName(), (filed.getData()+"").trim());
            }
            it = root.element("body").elementIterator();
            while (it.hasNext()) {
                Element filed = (Element) it.next();
                map.put(filed.getName(), (filed.getData()+"").trim());
            }
        } catch (Exception e) {
            logger.info(" ParseXml.getContentFromXMLForTag 解析 xml 错误:",e);
        }

        return map;

    }
    /**
     *
     * 功能：解析xml 为：苏州中行查询协议接口定制
     * 1. 文件格式 <header><msgId>0000210</msgId></header>
     * @param str xml文件
     * @return
     */
    public static Map<String,String> getContentFromXMLForAgrmtQuery(String str){

        SAXReader saxReader = new SAXReader();
        Map<String,String> map = new HashMap<String, String>();
        try {
            saxReader.setEncoding("gb2312");
            Document document = saxReader.read(new ByteArrayInputStream(str.getBytes()));

            // 获取根元素
            Element root = document.getRootElement();

            Iterator it = root.element("header").elementIterator();
            while (it.hasNext()) {
                Element filed = (Element) it.next();
                map.put(filed.getName(), (filed.getData()+"").trim());
            }

            it = root.element("body").elementIterator();
            while (it.hasNext()) {
                Element filed = (Element) it.next();
                if("AgreementInfo".equals(filed.getName())){
                    it = filed.elementIterator();
                    while (it.hasNext()) {
                        Element filed2 = (Element) it.next();
                        map.put(filed2.getName(), (filed2.getData()+"").trim());
                    }
                }
            }
        } catch (Exception e) {
            logger.info(" ParseXml.getContentFromXMLForAgrmtQuery 解析 xml 错误:",e);
        }

        return map;

    }

    public  static  String getValue(String propertyName) {
        String propertyVal = cacheContext.get(propertyName) == null ? null : cacheContext.get(propertyName).toString();
        if(propertyVal == null){
            logger.warn("no property for [" + propertyName + "]");
        }
        return propertyVal;
    }

    public static void main(String[] args) throws DocumentException {
//		System.out.println(getValue("voucher_webservice_url"));
        String path = "";
        SAXReader saxReader = new SAXReader();
        saxReader.setEncoding("gb2312");
//		Document document = saxReader.read(new File(path));
        Document document = saxReader.read(ProjectXml.class.getResourceAsStream("project.xml"));
    }
}
