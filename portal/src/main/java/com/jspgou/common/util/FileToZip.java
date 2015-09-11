package com.jspgou.common.util;

import org.apache.log4j.Logger;

import java.io.*;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

/**
 * Created by zj on 15-7-31.
 */
public class FileToZip {
    Logger log = Logger.getLogger(FileToZip.class);

    /**
     * 将存放在sourceFilePath目录下的源文件,打包成fileName名称的ZIP文件,并存放到zipFilePath。
     * @param sourceFilePath 待压缩的文件路径
     * @param zipFilePath    压缩后存放路径
     * @param fileName       压缩后文件的名称
     * @return flag
     */
    public boolean fileToZip(String sourceFilePath, String zipFilePath,String fileName) {
        boolean flag = false;
        File sourceFile = new File(sourceFilePath);
        FileInputStream fis = null;
        BufferedInputStream bis = null;
        FileOutputStream fos = null;
        ZipOutputStream zos = null;

        if(sourceFile.exists() == false) {
            log.error("File " + sourceFilePath + " is not found ....");
        } else {

            try {
                File zipFile = new File(zipFilePath + "/" + fileName + ".zip");
                if(zipFile.exists()) { zipFile.delete(); }

                File[] sourceFiles = sourceFile.listFiles();
                if(null == sourceFiles || sourceFiles.length < 1) {
                    log.error("The directory is empty ...");
                    return false;
                }

                fos = new FileOutputStream(zipFile);
                zos = new ZipOutputStream(new BufferedOutputStream(fos));
                byte[] bufs = new byte[1024*10];
                for(int i=0;i<sourceFiles.length;i++) {
                    ZipEntry zipEntry = new ZipEntry(sourceFiles[i].getName());
                    zos.putNextEntry(zipEntry);
                    fis = new FileInputStream(sourceFiles[i]);
                    bis = new BufferedInputStream(fis,1024*10);
                    int read = 0;
                    while((read=bis.read(bufs, 0, 1024*10)) != -1) {
                        zos.write(bufs, 0, read);
                    }
                }
                flag = true;


            } catch (FileNotFoundException e) {
                log.error("file not found...", e);
            } catch (IOException e) {
                log.error("IO exception...", e);
            } finally {
                // 关闭流
                try {
                    if(null != bis) bis.close();
                    if(null != zos) zos.close();
                } catch (IOException e) {
                    log.error("", e);
                }
            }
        }
        return flag;
    }
}
