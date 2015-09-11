package com.jspgou.cms.entity;

import com.jspgou.cms.entity.base.BaseStore;

/**
 * Created by zhengjiang on 2015-07-09.
 */
public class Store extends BaseStore {
    private static final long serialVersionUID = 1L;

    public Store(){
        super();
    }

    public Store(Long id){
        super(id);
    }

    public Store(Long id,
                 String storeName,
                 Long commerceId,
                 String commerceName,
                 Integer storeStatus,
                 String mobile){
        super(id, storeName, commerceId, commerceName, storeStatus, mobile);
    }
}
