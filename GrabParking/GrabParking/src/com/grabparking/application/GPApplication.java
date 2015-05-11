package com.grabparking.application;


import com.baidu.location.BDLocation;
import com.baidu.mapapi.SDKInitializer;
import com.grabparking.function.GPManager;
import com.grabparking.function.GParkingApplication;
/**
 * 适配百度地图的application
 * @author lcl
 *
 */
public class GPApplication extends GParkingApplication {
	public static String PRO_URL="http://qiangchewei001:8889/qiangcheweiphone";
	public static GPManager gpManager=null;
	private String Appid="01";//android手机客户端
	@Override
	public void onCreate() {
		super.onCreate();
		// 在使用 SDK 各组间之前初始化 context 信息，传入 ApplicationContext
		SDKInitializer.initialize(this);
	}
	/**
	 * signlen  GpManager
	 * @return
	 */
	public GPManager getGPManager(){
		if(gpManager==null){
			gpManager=new GPManager(this,Appid);
		}
		return gpManager;
	}
	
}