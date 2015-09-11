package com.jspgou.core.utils;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import java.io.OutputStream;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

/**
 * Created by zhengjiang on 2015/3/10.
 */
public class ExcelUtils<T> {
    private static Logger log = Logger.getLogger(ExcelUtils.class);
    /**
     * 导入Excel表格
     * @param attribute 中的元素是一个长度为2的数组，其中arr [0]是Excel列名称  arr[1]表示的是对象的属性名称
     * @param objs 导出的对象集合
     * @param os 输出流
     */
    public void toExcelAjax(List<String[]> attribute,List<T> objs,OutputStream os){
        if(objs == null ){
            return;
        }
        if(objs.isEmpty()){
            return;
        }
        try {
            HSSFWorkbook hssfworkbook = new HSSFWorkbook();
            HSSFSheet hssfsheet = hssfworkbook.createSheet(getimageId());
            int j = 0;
            //设置表头
            HSSFRow hssfrow = hssfsheet.createRow(j);
            j++;

            int i = 0;

            for (String[] arr : attribute) {
                hssfrow.createCell(i).setCellValue(arr[0]);
                i++;
            }

            //设置表中内容
            HSSFRow row = null;
            for (T obj : objs) {
                row = hssfsheet.createRow(j);
                i = 0;
                for (String[] arr : attribute) {
                    String fileName = arr[1];
                    Object value = getField(obj, fileName);
                    if(value != null){
                        row.createCell(i).setCellValue(value.toString());
                    }else {
                        row.createCell(i).setCellValue("");
                    }
                    i++;
                }
                j++;
            }

            for (int n=0; n<attribute.size(); n++) {
                hssfsheet.setColumnWidth(n, 5000);
            }


            hssfworkbook.write(os);
            os.close();
        } catch (Exception e) {
            log.error(e);
        }
    }

    public Object getField(Object target, String fieldName) throws Exception {
        return getField1(target, findField(target.getClass(), fieldName));
    }

    public Object getField1(Object target, Field field) {
        try {
            boolean accessible = field.isAccessible();
            field.setAccessible(true);
            Object result = field.get(target);
            field.setAccessible(accessible);
            return result;
        } catch (Exception e) {
            throw new IllegalStateException("获取对象的属性[" + field.getName()
                    + "]值失败", e);
        }
    }

    public String getimageId(){
        Date data=new Date();
        String timestr=data.toString();
        timestr=timestr.substring(4);
        String str=new String(" CST ");
        timestr=timestr.replaceAll(str," ");
        timestr=timestr.replaceAll(" PDT "," ");
        timestr=timestr.replaceAll(" ","");//去掉所有的空格
        timestr=timestr.replaceAll(":","");//去掉所有的":"
        return timestr;
    }


    public Field findField(Class<?> targetClass, String fieldName) throws Exception {
        if (targetClass == null) {
            throw new Exception(fieldName);
        }
        if (null == fieldName ||  0 == fieldName.length()) {
            throw new Exception(fieldName);
        }
        for (Field field : getAllDeclaredField(targetClass)) {
            if (fieldName.equals(field.getName())) {
                return field;
            }
        }
        return null;
    }

    public List<Field> getAllDeclaredField(Class<?> targetClass,
                                                  String... excludeFieldNames) {
        List<Field> fields = new ArrayList<Field>();
        for (Field field : targetClass.getDeclaredFields()) {
            if (contains(excludeFieldNames, field.getName())) {
                continue;
            }
            fields.add(field);
        }
        Class<?> parentClass = targetClass.getSuperclass();
        if (parentClass != Object.class) {
            fields.addAll(getAllDeclaredField(parentClass, excludeFieldNames));
        }
        return fields;
    }

    public <T> Boolean contains(T[] elements, T elementToFind) {
        List<T> elementsList = Arrays.asList(elements);
        return elementsList.contains(elementToFind);
    }
}
