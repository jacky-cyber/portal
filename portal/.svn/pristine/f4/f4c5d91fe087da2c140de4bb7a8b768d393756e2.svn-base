package com.jspgou.cms.dao.impl;

import com.jspgou.cms.dao.SequenceDao;
import com.jspgou.cms.entity.SequenceEntity;
import com.jspgou.common.hibernate3.HibernateBaseDao;
import org.springframework.stereotype.Repository;

/**
 * Created by Conglong Xie on 2015/2/10.
 */
@Repository
public class SequenceDaoImpl extends HibernateBaseDao<SequenceEntity,String> implements SequenceDao {


    /**
     * generate order code
     * @return
     */
    public String getSequenceOrderId(){
        String seqOrder = getIdFromDb("order_id");
        int len = 10;
        StringBuffer sb = new StringBuffer();
        for(int i=0;i<len-seqOrder.length();i++){
            sb.append("0");
        }
        sb.append(seqOrder);

        return sb.toString();
    }

    /**
     * generate new order refund id
     */
    public String getOrderRefundEntityId(){
        String seqOrder =  getIdFromDb("n_order_refund_id");
        int len = 10;
        StringBuffer sb = new StringBuffer();
        for(int i=0;i<len-seqOrder.length();i++){
            sb.append("0");
        }
        sb.append(seqOrder);

        return sb.toString();
    }


    /**
     * generate new voucher id
     */
    public String getVoucherId(){
        String seqOrder =  getIdFromDb("n_voucher_id");
        int len = 10;
        StringBuffer sb = new StringBuffer();
        for(int i=0;i<len-seqOrder.length();i++){
            sb.append("0");
        }
        sb.append(seqOrder);

        return sb.toString();
    }

    /**
     * generate new channel id
     */
    public String getChannelId(){
        String seqOrder =  getIdFromDb("channel_id");
        int len = 10;
        StringBuffer sb = new StringBuffer("");
        for(int i=0;i<len-seqOrder.length();i++){
            sb.append("0");
        }
        sb.append(seqOrder);

        return sb.toString();
    }

    /**
     * generate new commerce id
     */
    public String getCommerceId(){
        String seqOrder =  getIdFromDb("commerce_id");
        int len = 11;
        StringBuffer sb = new StringBuffer("");
        for(int i=0;i<len-seqOrder.length();i++){
            sb.append("0");
        }
        sb.append(seqOrder);

        return sb.toString();
    }

    @Override
    protected Class<SequenceEntity> getEntityClass() {
        return SequenceEntity.class;
    }

    private String getIdFromDb(String seqName){

        String result = (String)this.getSession().createSQLQuery("SELECT currval('"+seqName+"')").uniqueResult();

        return result;
    }

}
