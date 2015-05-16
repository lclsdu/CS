package com.grabparking.function;

import android.content.Context;
import android.util.Log;

import com.baidu.location.BDLocation;
import com.baidu.location.BDLocationListener;
import com.baidu.location.LocationClient;
import com.baidu.location.LocationClientOption;
import com.baidu.location.LocationClientOption.LocationMode;
import com.grabparking.application.GPApplication;
import com.grabparking.application.MyLocationListener;

public class GPManager implements IGPManager{
	private static String LOG=GPManager.class.getName();
	private GPApplication context=null;
	private String Appid="01";//android手机客户端
	private BDLocation locations=null;
	public BDLocationListener myListener = new MyLocationListener();
	public GPManager(GPApplication context,String AppId){
			this.context=context;
			this.Appid=AppId;
	}
	@Override
	public String checkUpdate() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean feedback(String feed) {
		// TODO Auto-generated method stub
		return false;
	}
}
