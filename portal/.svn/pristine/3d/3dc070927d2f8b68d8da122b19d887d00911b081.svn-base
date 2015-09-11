package com.ifunpay.test;

import org.apache.commons.io.FileUtils;

import java.io.File;
import java.io.IOException;

/**
 * Created by David on 2015/5/12.
 */
public class TestCopyDirectory {


    public static void main(String[] args) {
        String fileSource = "X:/life/upload/WEB-INF/t/gou/tpl";
        String gotoFile = "E:/201505/portal1.0/target/portal-4.5-SNAPSHOT/WEB-INF/t/gou";
        try {
            FileUtils.copyDirectoryToDirectory(new File(fileSource), new File(gotoFile));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
