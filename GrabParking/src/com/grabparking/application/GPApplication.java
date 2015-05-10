package com.grabparking.application;


import com.baidu.mapapi.SDKInitializer;
import com.grabparking.function.GParkingApplication;
/**
 * 适配百度地图的application
 * @author lcl
 *
 */
public class GPApplication extends GParkingApplication {
//	public LocationClient mLocationClient;
//	public GeofenceClient mGeofenceClient;
//	public MyLocationListener mMyLocationListener;
	@Override
	public void onCreate() {
		super.onCreate();
		// 在使用 SDK 各组间之前初始化 context 信息，传入 ApplicationContext
		SDKInitializer.initialize(this);
	}

}