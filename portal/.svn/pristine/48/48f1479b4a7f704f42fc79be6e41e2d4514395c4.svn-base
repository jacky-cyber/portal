package com.jspgou.common.util;

import com.jspgou.cms.entity.BaseProductReport;
import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.util.CellRangeAddress;

import javax.swing.*;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


/**
 * 利用开源组件POI3.0.2动态导出EXCEL文档
 * Created by zj on 15-6-8.
 */
public class ExcelExport<T> {

    public void exportExcel(String title, Map<String, Collection<String[]>> headers, Collection<T> dataSet, OutputStream out, Integer... args) {
        exportExcel(title, headers, dataSet, out, "yyyy-MM-dd", args);
    }

    /**
     * 这是一个通用的方法，利用了JAVA的反射机制，可以将放置在JAVA集合中并且符号一定条件的数据以EXCEL 的形式输出到指定IO设备上
     *
     * @param title   表格标题名
     * @param headers 表格属性列名数组
     * @param dataSet 需要显示的数据集合,集合中一定要放置符合javabean风格的类的对象。此方法支持的
     *                javabean属性的数据类型有基本数据类型及String,Date,byte[](图片数据)
     * @param out     与输出设备关联的流对象，可以将EXCEL文档导出到本地文件或者网络中
     * @param pattern 如果有时间数据，设定输出格式。默认为"yyy-MM-dd"
     */
    public void exportExcel(String title, Map<String, Collection<String[]>> headers, Collection<T> dataSet, OutputStream out, String pattern, Integer... args) {
        // 声明一个工作薄
        HSSFWorkbook workbook = new HSSFWorkbook();
        workbook = buildWorkbook(workbook, title, headers.get(title), dataSet, pattern, args);

        try {
            workbook.write(out);
        } catch (IOException e) {
            logger.error("IOException", e);
        } finally {
            try {
                out.close();
            } catch (IOException e) {
                logger.error("IOException", e);
            }
        }
    }

    /**
     *
     * @param titles
     * @param headers
     * @param dataSets
     * @param out
     * @param pattern
     */
    public void exportExcel(Set<String> titles, Map<String, Collection<String[]>> headers, Map<String, Collection<T>> dataSets, OutputStream out, String pattern, Integer... args){
        HSSFWorkbook workbook = new HSSFWorkbook();
        Iterator it = titles.iterator();
        while (it.hasNext()){
            String title = it.next().toString();
            workbook = buildWorkbook(workbook, title, headers.get(title), dataSets.get(title), pattern, args);
        }

        try {
            workbook.write(out);
        } catch (IOException e) {
            logger.error("IOException", e);
        } finally {
            try {
                out.close();
            } catch (IOException e) {
                logger.error("IOException", e);
            }
        }
    }

    /**
     *
     * @param titles
     * @param headers
     * @param dataSets
     * @param out
     */
    public void exportExcel(Set<String> titles, Map<String, Collection<String[]>> headers, Map<String, Collection<T>> dataSets, OutputStream out, Integer... args){
        exportExcel(titles, headers, dataSets, out, "yyyy-MM-dd", args);
    }

    /**
     *
     * @param workbook
     * @param title
     * @param headers
     * @param dataSet
     * @param pattern
     * @return
     */
    public HSSFWorkbook buildWorkbook(HSSFWorkbook workbook, String title, Collection<String[]> headers, Collection<T> dataSet, String pattern, Integer... args){
        // 生成一个表格
        HSSFSheet sheet = workbook.createSheet(title);
        // 设置表格默认列宽度为15个字节
        sheet.setDefaultColumnWidth((short) 15);
        // 生成一个样式
        HSSFCellStyle style = workbook.createCellStyle();
        // 设置这些样式
        style.setFillForegroundColor(HSSFColor.SKY_BLUE.index);
        style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
        style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        style.setBorderRight(HSSFCellStyle.BORDER_THIN);
        style.setBorderTop(HSSFCellStyle.BORDER_THIN);
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        // 生成一个字体
        HSSFFont font = workbook.createFont();
        font.setColor(HSSFColor.VIOLET.index);
        font.setFontHeightInPoints((short) 12);
        font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
        // 把字体应用到当前的样式
        style.setFont(font);
        // 生成并设置另一个样式
        HSSFCellStyle style2 = workbook.createCellStyle();
        style2.setFillForegroundColor(HSSFColor.LIGHT_YELLOW.index);
        style2.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
        style2.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        style2.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        style2.setBorderRight(HSSFCellStyle.BORDER_THIN);
        style2.setBorderTop(HSSFCellStyle.BORDER_THIN);
        style2.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        style2.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        // 生成另一个字体
        HSSFFont font2 = workbook.createFont();
        font2.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);
        // 把字体应用到当前的样式
        style2.setFont(font2);

        // 声明一个画图的顶级管理器
        HSSFPatriarch patriarch = sheet.createDrawingPatriarch();

        // 产生表格标题行
        HSSFRow row = sheet.createRow(0);
        if (0==args.length){
            sheet.addMergedRegion(new CellRangeAddress(0, 0, 1, 5));
            sheet.addMergedRegion(new CellRangeAddress(0, 0, 7, 10));
        } else {
            for (int i=0; i<args.length; i=i+4){
                sheet.addMergedRegion(new CellRangeAddress(args[i], args[i+1], args[i+2], args[i+3]));
            }
        }
        Iterator headerIt = headers.iterator();
        int rowId = 0;
        while (headerIt.hasNext()){
            rowId++;
            String[] header = (String[]) headerIt.next();
            for (short i = 0; i<header.length; i++) {
                HSSFCell cell = row.createCell(i);
                cell.setCellStyle(style);
                HSSFRichTextString text = new HSSFRichTextString(header[i]);
                cell.setCellValue(text);
            }
            row = sheet.createRow(rowId);
        }

        // 遍历集合数据，产生数据行
        Iterator<T> it = dataSet.iterator();
        int index = 1;
        while (it.hasNext()) {
            index++;
            row = sheet.createRow(index);
            T t = (T) it.next();
            // 利用反射，根据javabean属性的先后顺序，动态调用getXxx()方法得到属性值
            Field[] fields = t.getClass().getDeclaredFields();
            for (short i = 0; i < fields.length; i++) {
                HSSFCell cell = row.createCell(i);
                cell.setCellStyle(style2);
                Field field = fields[i];
                String fieldName = field.getName();
                String getMethodName = "get" + fieldName.substring(0, 1).toUpperCase() + fieldName.substring(1);
                try {
                    Class tCls = t.getClass();
                    Method getMethod = tCls.getMethod(getMethodName, new Class[]{});
                    Object value = getMethod.invoke(t, new Object[]{});
                    // 判断值的类型后进行强制类型转换
                    String textValue = null;
                    if (value instanceof Boolean) {
                        boolean bValue = (Boolean) value;
                        textValue = "男";
                        if (!bValue) {
                            textValue = "女";
                        }
                    } else if (value instanceof Date) {
                        Date date = (Date) value;
                        SimpleDateFormat sdf = new SimpleDateFormat(pattern);
                        textValue = sdf.format(date);
                    } else if (value instanceof byte[]) {
                        // 有图片时，设置行高为60px;
                        row.setHeightInPoints(60);
                        // 设置图片所在列宽度为80px,注意这里单位的一个换算
                        sheet.setColumnWidth(i, (short) (35.7 * 80));
                        // sheet.autoSizeColumn(i);
                        byte[] bsValue = (byte[]) value;
                        HSSFClientAnchor anchor = new HSSFClientAnchor(0, 0, 1023, 255, (short) 6, index, (short) 6, index);
                        anchor.setAnchorType(2);
                        patriarch.createPicture(anchor, workbook.addPicture(bsValue, HSSFWorkbook.PICTURE_TYPE_JPEG));
                    } else {
                        // 其它数据类型都当作字符串简单处理
                        try {
                            textValue = value.toString();
                        } catch (Exception e){
                            textValue = null;
                        }
                    }
                    // 如果不是图片数据，就利用正则表达式判断textValue是否全部由数字组成
                    if (textValue != null) {
                        Pattern p = Pattern.compile("^//d+(//.//d+)?$");
                        Matcher matcher = p.matcher(textValue);
                        if (matcher.matches()) {
                            // 是数字当作double处理
                            cell.setCellValue(Double.parseDouble(textValue));
                        } else {
                            HSSFRichTextString richString = new HSSFRichTextString(textValue);
                            HSSFFont font3 = workbook.createFont();
                            font3.setColor(HSSFColor.BLUE.index);
                            richString.applyFont(font3);
                            cell.setCellValue(richString);
                        }
                    }
                } catch (SecurityException e) {
                    logger.error("Security Exception", e);
                } catch (NoSuchMethodException e) {
                    logger.error("No Such Method Exception", e);
                } catch (IllegalArgumentException e) {
                    logger.error("Illegal Argument Exception", e);
                } catch (IllegalAccessException e) {
                    logger.error("Illegal Access Exception", e);
                } catch (InvocationTargetException e) {
                    logger.error("Invocation Target Exception", e);
                }
            }
        }
        return workbook;
    }

    public static void main(String[] args){
        ExcelExport<BaseProductReport> ex = new ExcelExport<BaseProductReport>();
        Set<String> titles = new HashSet<String>();
        titles.add("test1");
        titles.add("test2");

        Map<String, Collection<String[]>> headers = new HashMap<>();

        String[] header = { "商品名称", "单价(元)", "销售的数量", "退款订单数量", "订单数量", "已消费数量", "消费总额", "付款总额", "退款总额", "应收款" };
        Iterator it = titles.iterator();
        while (it.hasNext()){
            String title = it.next().toString();
            List<String[]> headerList = new ArrayList<String[]>();
            String[] header1 = {"商户", title, null, null, null, "结算时间段", "2015-2016", null, null, null};
            headerList.add(header1);
            headerList.add(header);
            headers.put(title, headerList);
        }

        List<BaseProductReport> dataSet = new ArrayList<BaseProductReport>();
        dataSet.add(new BaseProductReport("拿铁咖啡", new BigDecimal("9.00"), 12, 12, 3, 9, new BigDecimal("9.00"), new BigDecimal("9.00"), new BigDecimal("9.00"), new BigDecimal("9.00")));

        // 测试图书
        List<BaseProductReport> dataSet2 = new ArrayList<BaseProductReport>();
        dataSet2.add(new BaseProductReport("拿铁", new BigDecimal("0.00"), 12, 12, 3, 9, new BigDecimal("19.00"), new BigDecimal("92.00"), new BigDecimal("39.00"), new BigDecimal("49.00")));

        Map<String, Collection<BaseProductReport>> dataSets = new HashMap<>();
        dataSets.put("test1", dataSet);
        dataSets.put("test2", dataSet2);

        try{
            OutputStream out = new FileOutputStream("/home/zj/a.xls");
            ex.exportExcel(titles, headers, dataSets, out);
            out.close();
            JOptionPane.showMessageDialog(null, "导出成功!");
            System.out.println("excel导出成功！");
        } catch (FileNotFoundException e)
        {
            e.printStackTrace();
        }
        catch (IOException e)
        {
            e.printStackTrace();
        }
    }

    private static final Logger logger = Logger.getLogger(ExcelExport.class);
}

