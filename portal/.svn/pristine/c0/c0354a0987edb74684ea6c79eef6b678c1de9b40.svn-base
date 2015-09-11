package com.ifunpay.portal.entity;

/**
 * Created by Administrator on 2015/4/20.
 */

/*import javax.validation.constraints.NotNull;*/
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

/**
 * 地区。
 */
@Entity
@Table(name = "T_PUB_AREA")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE, region="longTimeCache")
public class Area {
    @Id
    @Column(name = "id")
    private String id;
/*    @NotNull*/
    @Column(name = "AREA_NAME")
    private String areaName;
    // @Column(name = "PARENT_AREA_ID")
    // private String parentAreaId;
    /** 上级地区 */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "PARENT_AREA_ID")
    // @Log(text = "上级地区", property = "areaName")
    private Area parent;

    /** 下级地区 */
    @OneToMany(mappedBy = "parent", fetch = FetchType.LAZY, cascade = {
            CascadeType.REFRESH, CascadeType.REMOVE }, orphanRemoval = true)
    private List<Area> childs = new ArrayList<Area>();

   /* @NotNull*/
    @Column(name = "AREA_LEVEL")
    private String areaLevel;
  /*  @NotNull*/
    private String status;
    @Column(name = "AREA_REGION")
    private String areaRegion;
    @Column(name = "IS_INTERNAL")
    private String isInternal;

    // public String getAreaId() {
    // return areaId;
    // }
    //
    // public void setAreaId(String areaId) {
    // this.areaId = areaId;
    // }

    public String getAreaName() {
        return areaName;
    }

    public void setAreaName(String areaName) {
        this.areaName = areaName;
    }

    public Area getParent() {
        return parent;
    }

    public void setParent(Area parent) {
        this.parent = parent;
    }

    public List<Area> getChilds() {
        return childs;
    }

    public void setChilds(List<Area> childs) {
        this.childs = childs;
    }

    public String getAreaLevel() {
        return areaLevel;
    }

    public void setAreaLevel(String areaLevel) {
        this.areaLevel = areaLevel;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getAreaRegion() {
        return areaRegion;
    }

    public void setAreaRegion(String areaRegion) {
        this.areaRegion = areaRegion;
    }

    public String getIsInternal() {
        return isInternal;
    }

    public void setIsInternal(String isInternal) {
        this.isInternal = isInternal;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

}