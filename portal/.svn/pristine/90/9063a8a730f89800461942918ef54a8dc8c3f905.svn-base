package com.ifunpay.portal.entity.log;

import com.ifunpay.portal.enums.Module;
import com.ifunpay.portal.enums.RelativeType;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by yu on 15-6-16.
 */
@Entity
@Table(name = "operation_log")
public class OperationLogEntity {

    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    private int id;

    @Column(name = "user_id")
    private String userId;

    @Column(name = "operate_time")
    private Date operateTime;

    @Enumerated(EnumType.STRING)
    @Column(name = "module_name")
    private Module moduleName;

    @Enumerated(EnumType.STRING)
    @Column(name = "relative_type")
    private RelativeType relativeType;

    @Column(name = "relative_id")
    private String relateId;

    @Column(name = "operation_name")
    private String operationName;

    @Column(name = "module_id")
    private String moduleId;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public Date getOperateTime() {
        return operateTime;
    }

    public void setOperateTime(Date operateTime) {
        this.operateTime = operateTime;
    }

    public Module getModuleName() {
        return moduleName;
    }

    public void setModuleName(Module moduleName) {
        this.moduleName = moduleName;
    }

    public RelativeType getRelativeType() {
        return relativeType;
    }

    public void setRelativeType(RelativeType relativeType) {
        this.relativeType = relativeType;
    }

    public String getRelateId() {
        return relateId;
    }

    public void setRelateId(String relateId) {
        this.relateId = relateId;
    }

    public String getOperationName() {
        return operationName;
    }

    public void setOperationName(String operationName) {
        this.operationName = operationName;
    }

    public String getModuleId() {
        return moduleId;
    }

    public void setModuleId(String moduleId) {
        this.moduleId = moduleId;
    }
}
