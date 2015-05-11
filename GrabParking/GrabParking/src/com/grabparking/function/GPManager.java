package com.grabparking.function;

import android.content.Context;
import android.util.Log;

import com.baidu.location.BDLocation;
import com.baidu.location.BDLocationListener;
import com.baidu.location.LocationClient;
import com.baidu.location.LocationClientOption;
import com.baidu.location.LocationClientOption.LocationMode;
import com.grabparking.application.GPApplication;

public class GPManager implements IGPManager{
	private GPApplication context=null;
	private String Appid="01";//android手机客户端
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

	@Override
	public BDLocation getLocation(Context context,LocationClient mLocationClient,BDLocationListener myListener) {
		 mLocationClient = new LocationClient(context);     //声明LocationClient类
		 LocationClientOption option = new LocationClientOption();
		 option.setLocationMode(LocationMode.Hight_Accuracy);//设置定位模式
		 option.setCoorType("bd09ll");//返回的定位结果是百度经纬度,默认值gcj02
		 option.setScanSpan(5000);//设置发起定位请求的间隔时间为5000ms
		 option.setIsNeedAddress(true);//返回的定位结果包含地址信息
		 option.setNeedDeviceDirect(true);//返回的定位结果包含手机机头的方向
		 mLocationClient.setLocOption(option);
		 mLocationClient.registerLocationListener( myListener );    //注册监听函数
		 mLocationClient.start();
		 if (mLocationClient != null && mLocationClient.isStarted())
			    mLocationClient.requestLocation();
			else 
				Log.d("LocSDK5", "locClient is null or not started");
		 
		 
		return mLocationClient.getLastKnownLocation();
	}
	
}
