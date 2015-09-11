package com.jspgou.core.manager;

import com.jspgou.common.page.Pagination;
import com.jspgou.core.entity.Log;

import java.util.Date;

/**
* This class should preserve.
* @preserve
*/
public interface LogMng {

	public Pagination getPageOfOperateLog(int pageNo,int pageSize, Date startTime, Date endTime, String userId, String moduleId, String relateId);

	public Pagination getPage(int pageNo, int pageSize);

	public Log findById(Long id);

	public Log save(Log bean);
	
	public void save(String versions,String updatelog);

	public Log update(Log bean);

	public Log deleteById(Long id);
	
	public Log[] deleteByIds(Long[] ids);
}