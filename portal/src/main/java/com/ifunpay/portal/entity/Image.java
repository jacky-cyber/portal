package com.ifunpay.portal.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

/**
 * Created by David on 2015/5/5.
 */
@Entity
@Table(name = "jc_shop_image")
public class Image  {
    /**
     * 主键、图片的路径
     */
    @Id
    @Column(name = "id")
    private String id;



    @Column(name = "CreateTime")
    private java.util.Date CreateTime;

    @Column(name = "md5")
    private java.lang.String md5;

    @Column(name = "imageName")
    private java.lang.String imageName;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }



    public Date getCreateTime() {
        return CreateTime;
    }

    public void setCreateTime(Date createTime) {
        CreateTime = createTime;
    }

    public String getMd5() {
        return md5;
    }

    public void setMd5(String md5) {
        this.md5 = md5;
    }

    public String getImageName() {
        return imageName;
    }

    public void setImageName(String imageName) {
        this.imageName = imageName;
    }

    @Override
    public String toString() {
        return "Image{" +
                "id='" + id + '\'' +
                ", CreateTime=" + CreateTime +
                ", md5='" + md5 + '\'' +
                ", imageName='" + imageName + '\'' +
                '}';
    }
}
