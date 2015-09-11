package com.jspgou.cms.manager;

import com.ifunpay.portal.entity.Image;

/**
 * Created by David on 2015/5/5.
 */
public interface ImageMng {
    public void save(String fileName, String relPath, String md5);

    public Image getEntityById(String imgPathCover);
}
