/**    
 * 文件名：AutoIdEntity.java    
 *    
 * 版本信息：    
 * 日期：2014年10月15日    
 * Copyright 足下 Corporation 2014     
 * 版权所有    
 *    
 */
package com.ifunpay.portal.entity;

import org.hibernate.search.annotations.DocumentId;

import javax.persistence.*;
import java.io.Serializable;

/**    
 *     
 * 项目名称：dhb.core    
 * 类名称：AutoIdEntity    
 * 类描述：    
 * 创建人：Xie Cong long (xiecl@ifunpay.com)    
 * 创建时间：2014年10月15日 下午5:27:03    
 * 修改人：Xie Cong long   
 * 修改时间：2014年10月15日 下午5:27:03    
 * 修改备注：    
 * @version     
 *     
 */
@MappedSuperclass
public abstract class AutoIdEntity implements Serializable{
	@Id
	@Basic(optional=false)
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@DocumentId
	protected long id;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + (int) (id ^ (id >>> 32));
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		AutoIdEntity other = (AutoIdEntity) obj;
		if (id != other.id)
			return false;
		return true;
	}
	
}
