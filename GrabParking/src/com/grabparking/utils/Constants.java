package com.grabparking.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.Properties;
import java.util.Set;

/**
 * 该类主要存储系统变量
 * @author Administrator
 *
 */
public class Constants {
	public static final String SETTING_PREFERENCE_NAME = "SETTING_PREFERENCE";// 保存设置的share
	static HashMap<String,String> map=new HashMap<String,String>();;
	static{ 
		InputStream in=Constants.class.getResourceAsStream("/constnts.properties");
		 Properties pro=new Properties();
		 try {
			pro.load(in);
		} catch (IOException e) {
			e.printStackTrace();
		}
		if(pro.contains("downloadAppUrl")){
			map.put("downloadAppUrl", pro.getProperty("downloadAppUrl"));
		}
		
	}
	/**
	 * 单点登录的模块名
	 */
	public static final String PAY_SSO_MODULE_NAME = "paySSO";
	public static final String FUND_MODULE_NAME = "Fund";
	public static final String SHOP_MODULE_NAME = "WANGSHOP";
	
	public static final int VISIT_NET_FAIL = 100;
	
	public static final String HEARTBEAT_MODULE_NAME = "HEARTBEAT";
	
	public static final String GOBACK_LOGIN_URL = "upclient://login";
	public static final String BACK_MAIN = "Wopay://BackMain";
	public static String souyintai = "https://epay.10010.com/symini";
	public static String jianyisouyintai = "https://cellphonefront.unicompayment.com:55352/payment/";
	public static final String DATABASE_NAME = "wopay.db";
	public static final String FILEPATH = "wopay";
	
	public static final String NOTIFICATION_ACCOUNT = "100";
	public static final String NOTIFICATION_GOODS = "200";
	public static final String NOTIFICATION_SYSTEM = "300";
	public static final String NOTIFICATION_RECHARGE = "400";
	public static final String NOTIFICATION_MANDATORY_READING = "500";
	public static final String NOTIFICATION_MANDATORY_HEBING = "600";
	public static String tactic = "ALL";// 轮询策略
	public static Date cztime;// 充值时间

	public static final HashMap<String, String> getSecretQuestionMap(){
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("0","我妈妈的名字是?");
		map.put("1","我初恋的名字是?");
		map.put("2","我爸爸的名字是?");
		map.put("3","我的出生地在哪?");
		map.put("4","我妈妈的出生地在哪?");
		map.put("5","我丈夫的名字是?");
		map.put("6","我宝宝的名字是?");
		map.put("7","我毕业的院校是?");
		map.put("8","我的生日是?");
		map.put("9","我丈夫的生日是?");
		map.put("10","我妈妈的生日是?");
		map.put("11","我爸爸的生日是?");
		map.put("12","我宝宝的生日是?");
		map.put("13","我的证件号?");

		return map;
	}

}
