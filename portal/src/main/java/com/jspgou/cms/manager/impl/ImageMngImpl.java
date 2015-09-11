package com.jspgou.cms.manager.impl;

import com.ifunpay.portal.entity.Image;
import com.jspgou.cms.dao.ImageDao;
import com.jspgou.cms.manager.ImageMng;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

/**
 * Created by David on 2015/5/5.
 */
@Service
@Transactional
public class ImageMngImpl implements ImageMng{
    @Resource
    ImageDao imageDao;
    @Override
    public void save(String fileName, String relPath, String md5) {
        imageDao.save(fileName,relPath,md5);
    }

    @Override
    public Image getEntityById(String imgPathCover) {
        return imageDao.getEntityById(imgPathCover);
    }

}
