package com.ifunpay.portal.util;

import com.ifunpay.portal.ProjectXml;
import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.io.File;
import java.io.IOException;

/**
 * Created by David on 2015/5/12.
 */
@Component
@Lazy(false)
public class CopyFile  {
  private Logger logger = Logger.getLogger(CopyFile.class);
//    implements InitializingBean,ServletContextAware
    // Directory source
    static String fileSource = (ProjectXml.getValue("file_path")+"/WEB-INF/t/gou/tpl").replace("//","/");
    // Directory  go to
     String rootPath=getClass().getResource("/").getFile().toString();
    @PostConstruct
    public void init() throws IOException {

//        StringBuffer fileToPath = new StringBuffer();
//        String[] path = rootPath.split("\\/");
//        for (int i = 1; i < path.length-1; i++) {
//           fileToPath.append(path[i]).append("/");
//        }
//        fileToPath.append("t/gou");
//        if(new File(fileSource).exists()){
//            FileUtils.copyDirectoryToDirectory(new File(fileSource), new File(fileToPath.toString()));
//        }
        StringBuffer fileToPath = new StringBuffer();
        String[] pa = rootPath.split("\\/");
        for (int i = 1; i < pa.length-1; i++) {
            fileToPath.append(pa[i]).append("/");
        }
        fileToPath.append("t/gou/tpl");
        String path=fileSource;
        File file=new File(path);
        if(file.exists()){


        File[] tempList = file.listFiles();
        for (int i = 0; i < tempList.length; i++) {
            if (tempList[i].isFile()) {
                String paths = tempList[i].getPath();
                String[] mis = paths.replaceAll("\\\\","/").split(fileSource);
                File tofile = new File(fileToPath.toString()+mis[1]);
                if(!tofile.exists()){
                        FileUtils.copyFile(tempList[i], tofile);
                        logger.info("文     件："+tempList[i]);
                }
            }
            if (tempList[i].isDirectory()) {
                File file1=new File(path+"/"+tempList[i].getName());
                File[] tempList1 = file1.listFiles();
                for (int j = 0; j < tempList1.length; j++) {
                    if (tempList1[j].isFile()) {
                        String paths2 = tempList1[j].getPath();
                        String[] mis2 = paths2.replaceAll("\\\\","/").split(fileSource);
                        File tofile2 = new File(fileToPath.toString()+mis2[1]);
                        if(!tofile2.exists()){
                                FileUtils.copyFile(tempList1[j],tofile2);
                        }
                        logger.info("文     件："+tempList1[j]);
                    }
                }

            }
        }
    }
    }



}
