package com.jspgou.common.util;

import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.FileInputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by zhengjiang on 2015-06-11.
 */
public class ExcelReader {
    Workbook wb = null;
    List<String[]> dataList = new ArrayList<String[]>(100);
    public ExcelReader(String path){
        try {
            InputStream inp = new FileInputStream(path);
            wb = WorkbookFactory.create(inp);
        } catch (Exception e) {
            logger.error("", e);
        }
    }

    public ExcelReader(MultipartFile file){
        try {
            InputStream inp = file.getInputStream();
            wb = WorkbookFactory.create(inp);
        } catch (Exception e) {
            logger.error("", e);
        }
    }

    /**
     * 取Excel所有数据，包含header
     * @return  List<String[]>
     */
    public List<String[]> getAllData(int sheetIndex){
        int columnNum = 0;
        Sheet sheet = wb.getSheetAt(sheetIndex);
        if(sheet.getRow(0)!=null){
            columnNum = sheet.getRow(0).getLastCellNum()-sheet.getRow(0).getFirstCellNum();
        }
        if(columnNum>0){
            for(Row row:sheet){
                String[] singleRow = new String[columnNum];
                int n = 0;
                for(int i=0;i<columnNum;i++){
                    Cell cell = row.getCell(i, Row.CREATE_NULL_AS_BLANK);
                    switch(cell.getCellType()){
                        case Cell.CELL_TYPE_BLANK:
                            singleRow[n] = "";
                            break;
                        case Cell.CELL_TYPE_BOOLEAN:
                            singleRow[n] = Boolean.toString(cell.getBooleanCellValue());
                            break;
                        //数值
                        case Cell.CELL_TYPE_NUMERIC:
                            if(DateUtil.isCellDateFormatted(cell)){
                                singleRow[n] = String.valueOf(cell.getDateCellValue());
                            }else{
                                cell.setCellType(Cell.CELL_TYPE_STRING);
                                String temp = cell.getStringCellValue();
                                //判断是否包含小数点，如果不含小数点，则以字符串读取，如果含小数点，则转换为Double类型的字符串
                                if(temp.indexOf(".")>-1){
                                    singleRow[n] = String.valueOf(new Double(temp)).trim();
                                }else{
                                    singleRow[n] = temp.trim();
                                }
                            }
                            break;
                        case Cell.CELL_TYPE_STRING:
                            singleRow[n] = cell.getStringCellValue().trim();
                            break;
                        case Cell.CELL_TYPE_ERROR:
                            singleRow[n] = "";
                            break;
                        case Cell.CELL_TYPE_FORMULA:
                            cell.setCellType(Cell.CELL_TYPE_STRING);
                            singleRow[n] = cell.getStringCellValue();
                            if(singleRow[n]!=null){
                                singleRow[n] = singleRow[n].replaceAll("#N/A","").trim();
                            }
                            break;
                        default:
                            singleRow[n] = "";
                            break;
                    }
                    n++;
                }
                if("".equals(singleRow[0])){continue;}//如果第一行为空，跳过
                dataList.add(singleRow);
            }
        }
        return dataList;
    }
    /**
     * 返回Excel最大行index值，实际行数要加1
     * @return
     */
    public int getRowNum(int sheetIndex){
        Sheet sheet = wb.getSheetAt(sheetIndex);
        return sheet.getLastRowNum();
    }

    /**
     * 返回数据的列数
     * @return
     */
    public int getColumnNum(int sheetIndex){
        Sheet sheet = wb.getSheetAt(sheetIndex);
        Row row = sheet.getRow(0);
        if(row!=null&&row.getLastCellNum()>0){
            return row.getLastCellNum();
        }
        return 0;
    }

    /**
     * 获取某一行数据
     * @param rowIndex 计数从0开始，rowIndex为0代表header行
     * @return
     */
    public String[] getRowData(int sheetIndex,int rowIndex){
        String[] dataArray = null;
        if(rowIndex>this.getColumnNum(sheetIndex)){
            return dataArray;
        }else{
            dataArray = new String[this.getColumnNum(sheetIndex)];
            return this.dataList.get(rowIndex);
        }

    }

    /**
     * 获取某一列数据
     * @param colIndex
     * @return
     */
    public String[] getColumnData(int sheetIndex,int colIndex){
        String[] dataArray = null;
        if(colIndex>this.getColumnNum(sheetIndex)){
            return dataArray;
        }else{
            if(this.dataList!=null&&this.dataList.size()>0){
                dataArray = new String[this.getRowNum(sheetIndex)+1];
                int index = 0;
                for(String[] rowData:dataList){
                    if(rowData!=null){
                        dataArray[index] = rowData[colIndex];
                        index++;
                    }
                }
            }
        }
        return dataArray;
    }

    public static void main(String[] args){
        ExcelReader excelReader = new ExcelReader("C:\\Users\\zhengjiang\\Downloads\\operatorDemo.xlsx");
        List<String[]> arr = excelReader.getAllData(0);
        for (int i=1; i<arr.size(); i++){
            for (int j=0; j<arr.get(i).length; j++){
                System.out.println(arr.get(i)[j]);
            }
        }
    }

    private static final Logger logger = Logger.getLogger(ExcelReader.class);
}
