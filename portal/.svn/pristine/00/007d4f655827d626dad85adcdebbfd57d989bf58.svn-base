package com.jspgou.cms.dao.impl;

import com.ifunpay.portal.entity.Image;
import com.jspgou.cms.dao.ImageDao;
import com.jspgou.common.hibernate3.HibernateBaseDao;
import org.springframework.stereotype.Repository;

import java.util.Date;

/**
 * Created by David on 2015/5/5.
 */
@Repository
public class ImageDaoImpl extends HibernateBaseDao<Image, Integer> implements ImageDao{
    @Override
    protected Class<Image> getEntityClass() {
        return Image.class;
    }


    public void save(String fileName, String relPath, String md5) {
        Image image = new Image();
        image.setId(relPath);
        image.setCreateTime(new Date());
        image.setMd5(md5);
        image.setImageName(fileName);
        getSession().save(image);
    }

    @Override
    public Image getEntityById(String imgPathCover) {
        return  (Image)getSession().get(Image.class,imgPathCover);
    }
}
