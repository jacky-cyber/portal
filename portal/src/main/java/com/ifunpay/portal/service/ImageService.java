package com.ifunpay.portal.service;

import com.ifunpay.portal.ProjectXml;
import com.ifunpay.portal.dao.BaseDao;
import com.ifunpay.portal.entity.Image;
import com.ifunpay.util.common.StringUtil;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;
import java.util.function.Function;

/**
 * Created by yu on 15-5-13.
 */
@Component
public class ImageService {

    private Logger logger = Logger.getLogger(ImageService.class);

    @Resource
    private BaseDao baseDao;

    public Optional<Image> getImage(String relativeUrl) {
        if (relativeUrl == null || relativeUrl.equals(""))
            return Optional.empty();
        Optional<Image> optionalImage = baseDao.get(Image.class, relativeUrl);
        if (!optionalImage.isPresent()) {
            logger.warn(relativeUrl + " image not in the Database, try to load from file system.");
            try {
                Image dbImage;
                Path imageRealPath = Paths.get(getImageRealPrefixPath() + relativeUrl);
                byte[] bytes = Files.readAllBytes(imageRealPath);
                String md5 = StringUtil.getMd5Hex(bytes);
                int lastSlash = relativeUrl.lastIndexOf('/');
                String name = relativeUrl.substring(lastSlash + 1);
                logger.info("image load OK, save to DB");
                dbImage = new Image();
                dbImage.setId(relativeUrl);
                dbImage.setCreateTime(new Date());
                dbImage.setMd5(md5);
                dbImage.setImageName(name);
                baseDao.save(dbImage);
                optionalImage = Optional.of(dbImage);
            } catch (IOException e) {
                logger.error("load image file error: ", e);
            }
        }
        return optionalImage;
    }

    public Optional<ImageWrapper> getImageWrapper(String relativeUrl) {
        return getImage(relativeUrl).map(ImageWrapper::new);
    }

    public static String getImageRealPrefixPath() {
        return ProjectXml.getValue("img_path");
    }

    public static String getImageHttpPrefixUrl() {
        return ProjectXml.getValue("base_path_upload");
    }

    public static class ImageWrapper{

        public ImageWrapper(Image image) {
            this.url = getImageHttpPrefixUrl() + image.getId();
            this.name = image.getImageName();
            this.modified = image.getCreateTime();
            this.md5 = image.getMd5();
        }

        private String url;
        private String name;
        private Date modified;
        private String md5;

        public String getUrl() {
            return url;
        }

        public void setUrl(String url) {
            this.url = url;
        }

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public Date getModified() {
            return modified;
        }

        public void setModified(Date modified) {
            this.modified = modified;
        }

        public String getMd5() {
            return md5;
        }

        public void setMd5(String md5) {
            this.md5 = md5;
        }
    }

}
