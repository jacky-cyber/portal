package com.ifunpay.portal.entity;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.search.annotations.DocumentId;

import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.MappedSuperclass;

@MappedSuperclass
 public abstract class UuidEntity {
    @Id
    @GeneratedValue(
            generator = "system-uuid"
    )
    @GenericGenerator(
            name = "system-uuid",
            strategy = "org.hibernate.id.UUIDGenerator"
    )
    @DocumentId
    protected String id;

    public UuidEntity() {
    }

    public String getId() {
        return this.id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public int hashCode() {
        boolean prime = true;
        byte result = 1;
        int result1 = 31 * result + (this.id == null?0:this.id.hashCode());
        return result1;
    }

    public boolean equals(Object obj) {
        if(this == obj) {
            return true;
        } else if(obj == null) {
            return false;
        } else {
            UuidEntity other = (UuidEntity)obj;
            if(this.id == null) {
                if(other.getId() != null) {
                    return false;
                }
            } else if(!this.id.equals(other.getId())) {
                return false;
            }

            return true;
        }
    }
}
