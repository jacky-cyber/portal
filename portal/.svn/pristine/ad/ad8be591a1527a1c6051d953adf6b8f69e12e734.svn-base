package com.ifunpay.portal.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Random;

public class Common {
	public static String voucherValueHandler(String voucherValue) {
		String str = voucherValue.substring(0, 4) + "**********" + voucherValue.substring(voucherValue.length()-4,voucherValue.length());
		return str;
	}
	
	/**
	 * 
	 * @param dateStr
	 * @return
	 */
	public static Date getDateFromStr(String dateStr){
		Date date=null;
		if(!dateStr.equals("")){
			DateFormat format = new SimpleDateFormat("yyyy-MM-dd"); 
			try {
				date=format.parse(dateStr);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}		
		return date;
	}

	/**
	 *
	 * @param max
	 * @return 1 to max
	 */
	public static int genRandom(int max){
		Random random = new Random();
		return random.nextInt(max) + 1;
	}
}