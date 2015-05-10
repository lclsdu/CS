package com.grabparking.activity;

import com.baidu.location.LocationClient;
import com.baidu.mapapi.SDKInitializer;
import com.baidu.mapapi.map.BaiduMap;
import com.baidu.mapapi.map.BaiduMapOptions;
import com.baidu.mapapi.map.BitmapDescriptorFactory;
import com.baidu.mapapi.map.MapStatus;
import com.baidu.mapapi.map.MapStatusUpdateFactory;
import com.baidu.mapapi.map.MapView;
import com.baidu.mapapi.map.MyLocationConfiguration;
import com.baidu.mapapi.map.MyLocationData;
import com.baidu.mapapi.model.LatLng;

import android.location.LocationManager;
import android.os.Bundle;
import android.provider.Settings;
import android.annotation.SuppressLint;
import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.view.KeyEvent;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.Window;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;
import android.support.v4.app.NavUtils;

@SuppressLint({ "NewApi", "NewApi" })
public class MainActivity extends Activity {
	MapView mMapView = null;
	private BaiduMap mBaiduMap = null;
	private TextView view=null;
	//private LocationClient location=null;
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		requestWindowFeature(Window.FEATURE_CUSTOM_TITLE);
		setContentView(R.layout.activity_main);
		getWindow().setFeatureInt(Window.FEATURE_CUSTOM_TITLE, R.layout.home_title);
		openGPSSettings();// 提示用户打开gps
		view=(TextView)findViewById(R.id.Titletext);
		view.setText("抢车app");
		// 在使用SDK各组件之前初始化context信息，传入ApplicationContext
		// 注意该方法要再setContentView方法之前实现
		SDKInitializer.initialize(getApplicationContext());
		// 获取地图控件引用
		mMapView = (MapView) findViewById(R.id.bmapView);
		mBaiduMap = mMapView.getMap();  
		//普通地图  
		mBaiduMap.setMapType(BaiduMap.MAP_TYPE_NORMAL);  
		//卫星地图  
		mBaiduMap.setMapType(BaiduMap.MAP_TYPE_SATELLITE);
		//开启交通图   
		mBaiduMap.setTrafficEnabled(true);
		//开启热力图  
		mBaiduMap.setBaiduHeatMapEnabled(true);
		/**
		 * 
		 */
		mBaiduMap.setMapStatus(MapStatusUpdateFactory.newMapStatus(new MapStatus.Builder().zoom(15).build()));//设置缩放级别
		// 开启定位图层  
		mBaiduMap.setMyLocationEnabled(true);  
		
		// 构造定位数据  
//		MyLocationData locData = new MyLocationData.Builder()  
//		    .accuracy(location.getRadius())  
//		    // 此处设置开发者获取到的方向信息，顺时针0-360  
//		    .direction(100).latitude(location.getLatitude())  
//		    .longitude(location.getLongitude()).build();  
//		// 设置定位数据  
//		mBaiduMap.setMyLocationData(locData);  
//		// 设置定位图层的配置（定位模式，是否允许方向信息，用户自定义定位图标）  
//		mCurrentMarker = BitmapDescriptorFactory  
//		    .fromResource(R.drawable.icon_geo);  
//		MyLocationConfiguration config = new MyLocationConfiguration(mCurrentMode, true, mCurrentMarker);  
//		mBaiduMap.setMyLocationConfiguration();  
//		// 当不需要定位图层时关闭定位图层  
		mBaiduMap.setMyLocationEnabled(false);
	}

	@Override
	protected void onDestroy() {
		super.onDestroy();
		// 在activity执行onDestroy时执行mMapView.onDestroy()，实现地图生命周期管理
		mMapView.onDestroy();
	}

	@Override
	protected void onResume() {
		super.onResume();
		// 在activity执行onResume时执行mMapView. onResume ()，实现地图生命周期管理
		mMapView.onResume();
	}

	@Override
	protected void onPause() {
		super.onPause();
		// 在activity执行onPause时执行mMapView. onPause ()，实现地图生命周期管理
		mMapView.onPause();
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		getMenuInflater().inflate(R.menu.activity_main, menu);
		return true;
	}

	private void openGPSSettings() {
		LocationManager alm = (LocationManager) this
				.getSystemService(Context.LOCATION_SERVICE);
		if (alm.isProviderEnabled(android.location.LocationManager.GPS_PROVIDER)) {
			Toast.makeText(this, "GPS模块正常", Toast.LENGTH_SHORT).show();
			return;
		}

		Toast.makeText(this, "请开启GPS！", Toast.LENGTH_SHORT).show();
		Intent intent = new Intent(Settings.ACTION_SETTINGS);
		startActivityForResult(intent, 0); // 此为设置完成后返回到获取界面

	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		switch (item.getItemId()) {
		case android.R.id.home:
			NavUtils.navigateUpFromSameTask(this);
			return true;
		}
		return super.onOptionsItemSelected(item);
	}
	/**
	 * 标记定位地点
	 */
	public void marker(){
		
	}
	@Override
	public boolean onKeyDown(int keyCode, KeyEvent event) {
		if (keyCode == KeyEvent.KEYCODE_BACK && event.getRepeatCount() == 0) {
			// 按下的如果是BACK，同时没有重复
			askForOut();

			return true;
		}

		return super.onKeyDown(keyCode, event);
	}

	private void askForOut() {
		AlertDialog.Builder builder = new AlertDialog.Builder(this);

		builder.setTitle("确定退出").setMessage("确定退出？")
				.setPositiveButton("确定", new DialogInterface.OnClickListener() {
					@Override
					public void onClick(DialogInterface dialog, int which) {
						finish();
					}
				})
				.setNegativeButton("取消", new DialogInterface.OnClickListener() {
					@Override
					public void onClick(DialogInterface dialog, int which) {
						dialog.cancel();
					}
				}).setCancelable(false).show();
	}

}
