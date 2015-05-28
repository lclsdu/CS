package com.grabparking.activity;

import com.baidu.location.BDLocation;
import com.baidu.location.BDLocationListener;
import com.baidu.location.LocationClient;
import com.baidu.location.LocationClientOption;
import com.baidu.location.LocationClientOption.LocationMode;
import com.baidu.mapapi.map.BaiduMap;
import com.baidu.mapapi.map.BitmapDescriptor;
import com.baidu.mapapi.map.BitmapDescriptorFactory;
import com.baidu.mapapi.map.MapStatus;
import com.baidu.mapapi.map.MapStatusUpdateFactory;
import com.baidu.mapapi.map.MapView;
import com.baidu.mapapi.map.MyLocationConfiguration;
import com.baidu.mapapi.map.MyLocationData;

import android.location.LocationManager;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.Bundle;
import android.provider.Settings;
import android.annotation.SuppressLint;
import android.app.Activity;
import android.app.AlertDialog;
import android.content.ComponentName;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.util.Log;
import android.view.KeyEvent;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.Window;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;
import android.support.v4.app.NavUtils;

@SuppressLint({ "NewApi", "NewApi" })
public class MainActivity extends BaseActivity {
	MapView mMapView = null;
	private BaiduMap mBaiduMap = null;
	private TextView view=null;
	public LocationClient mLocationClient = null;
	public BDLocation  dblocation=null;
	private BitmapDescriptor  mCurrentMarker=null;
	//附近車位
	private Button nearparking=null;
	//发布车位
	private Button sellparking=null;
	//用户信息
	private ImageView userBtn=null;
	//分享测试
	private ImageView shareBtn=null;
	public BDLocationListener myListener = new MyLocationListener();
	@Override
	public void onCreate(Bundle savedInstanceState) {
		 setTheme(R.style.CustomTheme);  
		super.onCreate(savedInstanceState);
		//requestWindowFeature(Window.FEATURE_NO_TITLE);
		setContentView(R.layout.activity_main);
		//getWindow().setFeatureInt(Window.FEATURE_CUSTOM_TITLE, R.layout.home_title);
		initWidget();
		openGPSSettings();// 提示用户打开gps
		// 在使用SDK各组件之前初始化context信息，传入ApplicationContext
		// 注意该方法要再setContentView方法之前实现
		// 获取地图控件引用
		mMapView = (MapView) findViewById(R.id.bmapView);
		mMapView.showZoomControls(false);
		mBaiduMap = mMapView.getMap();  
		//普通地图  
		mBaiduMap.setMapType(BaiduMap.MAP_TYPE_NORMAL);  
		//卫星地图  
		//mBaiduMap.setMapType(BaiduMap.MAP_TYPE_SATELLITE);
		//开启交通图   
		//mBaiduMap.setTrafficEnabled(true);
		//开启热力图  
		//mBaiduMap.setBaiduHeatMapEnabled(true);
		//设置缩放级别
		mBaiduMap.setMapStatus(MapStatusUpdateFactory.newMapStatus(new MapStatus.Builder().zoom(17).build()));//设置缩放级别
		mBaiduMap.getLocationData();
		mBaiduMap.setMyLocationEnabled(true);  
		// 开启定位图层  
		//mBaiduMap.setMyLocationEnabled(true);  
		// 当不需要定位图层时关闭定位图层  
		//mBaiduMap.setMyLocationEnabled(false);
		
		
	    
		 mLocationClient = new LocationClient(getApplicationContext());     //声明LocationClient类
		 LocationClientOption option = new LocationClientOption();
		 option.setLocationMode(LocationMode.Hight_Accuracy);//设置定位模式
		 option.setCoorType("bd09ll");//返回的定位结果是百度经纬度,默认值gcj02
		 option.setScanSpan(5000);//设置发起定位请求的间隔时间为5000ms
		 option.setIsNeedAddress(true);//返回的定位结果包含地址信息
		 option.setNeedDeviceDirect(true);//返回的定位结果包含手机机头的方向
		 mLocationClient.setLocOption(option);
		 mLocationClient.registerLocationListener( myListener );    //注册监听函数
		 mLocationClient.start();
		// mLocationClient.stop();
//		 if (mLocationClient != null && mLocationClient.isStarted())
//			    mLocationClient.requestLocation();//离线定位
//			else 
//				Log.d("LocSDK5", "locClient is null or not started");
		 
		 
		
//		//位置提醒相关代码
//		 BDNotifyListener  mNotifyer = new NotifyLister();
//		 mNotifyer.SetNotifyLocation(dblocation.getLongitude(),dblocation.getLatitude(),3000,"gps");//4个参数代表要位置提醒的点的坐标，具体含义依次为：纬度，经度，距离范围，坐标系类型(gcj02,gps,bd09,bd09ll)
//		 mLocationClient.registerNotify(mNotifyer);
//		 //注册位置提醒监听事件后，可以通过SetNotifyLocation 来修改位置提醒设置，修改后立刻生效。
//		 //取消位置提醒
//		 mLocationClient.removeNotifyEvent(mNotifyer);
		 
		 
	
	}
	public class MyLocationListener implements BDLocationListener {
		
		@Override
		public void onReceiveLocation(BDLocation location) {
			if (location == null)
		            return ;
			StringBuffer sb = new StringBuffer(256);
			sb.append("time : ");
			sb.append(location.getTime());
			sb.append("\nerror code : ");
			sb.append(location.getLocType());
			sb.append("\nlatitude : ");
			sb.append(location.getLatitude());
			sb.append("\nlontitude : ");
			sb.append(location.getLongitude());
			sb.append("\nradius : ");
			sb.append(location.getRadius());
			if (location.getLocType() == BDLocation.TypeGpsLocation){
				sb.append("\nspeed : ");
				sb.append(location.getSpeed());
				sb.append("\nsatellite : ");
				sb.append(location.getSatelliteNumber());
			} else if (location.getLocType() == BDLocation.TypeNetWorkLocation){
				sb.append("\naddr : ");
				sb.append(location.getAddrStr());
			} 
			
//			 mBaiduMap.setMyLocationEnabled(true);  
//			//定义Maker坐标点  
//			LatLng point = new LatLng(location.getLatitude(), location.getLongitude());  
//			//构建Marker图标  
//			BitmapDescriptor bitmap = BitmapDescriptorFactory  
//			    .fromResource(R.drawable.ding);  
//			//构建MarkerOption，用于在地图上添加Marker  
//			OverlayOptions option = new MarkerOptions()  
//			    .position(point)  
//			    .icon(bitmap);  
//			//在地图上添加Marker，并显示  
//			mBaiduMap.addOverlay(option);
			//滚动显示当前地理位置
			view.setText(location.getAddrStr());
			 // 构造定位数据  
			 MyLocationData locData = new MyLocationData.Builder()  
			     .accuracy(location.getRadius())  
			     // 此处设置开发者获取到的方向信息，顺时针0-360  
			     .direction(0).latitude(location.getLatitude())  
			     .longitude(location.getLongitude()).build();  
			 // 设置定位数据  
			 mBaiduMap.setMyLocationData(locData);  
			 // 设置定位图层的配置（定位模式，是否允许方向信息，用户自定义定位图标）  
			 mCurrentMarker = BitmapDescriptorFactory  
			     .fromResource(R.drawable.ding);  
			 MyLocationConfiguration config = new MyLocationConfiguration(MyLocationConfiguration.LocationMode.COMPASS, true, mCurrentMarker);  
			 mBaiduMap.setMyLocationConfigeration(config);
			 // 当不需要定位图层时关闭定位图层  
			//mBaiduMap.setMyLocationEnabled(false);
			 mBaiduMap.hideInfoWindow();
		}
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
		  // 注册定位事件，定位后将地图移动到定位点
		mBaiduMap.setMyLocationEnabled(true);  
		 mLocationClient.stop();
		 mMapView.onResume();
	}

	@Override
	protected void onPause() {
		super.onPause();
		// 在activity执行onPause时执行mMapView. onPause ()，实现地图生命周期管理
		mMapView.onPause();
	}


	private void openGPSSettings() {
		LocationManager alm = (LocationManager) this
				.getSystemService(Context.LOCATION_SERVICE);
		if (alm.isProviderEnabled(android.location.LocationManager.GPS_PROVIDER)) {
			//Toast.makeText(this, "GPS模块正常", Toast.LENGTH_SHORT).show();
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
						android.os.Process.killProcess(android.os.Process.myPid());
						System.exit(0);
					}
				})
				.setNegativeButton("取消", new DialogInterface.OnClickListener() {
					@Override
					public void onClick(DialogInterface dialog, int which) {
						dialog.cancel();
					}
				}).setCancelable(false).show();
	}
     
    public void logMsg(String str) {
         //   textView.setText(str);
    	Toast.makeText(getApplicationContext(), str, 1);
    }

	@Override
	public void initWidget() {
		nearparking=(Button)findViewById(R.id.nearing_parking);
		nearparking.setOnClickListener(listener);
		sellparking=(Button)findViewById(R.id.public_parking);
		sellparking.setOnClickListener(listener);
		view=(TextView)findViewById(R.id.tv_name);
		userBtn=(ImageView)findViewById(R.id.iv_login);
		userBtn.setOnClickListener(listener);
		shareBtn=(ImageView)findViewById(R.id.iv_air);
		userBtn.setOnClickListener(listenershare);
	}
	
	OnClickListener listener=new OnClickListener() {
		@Override
		public void onClick(View v) {
			Log.i("V", ""+v.getId());
			mBaiduMap.setMyLocationEnabled(false);
			mLocationClient.stop();
			Intent intent = new Intent(MainActivity.this,RegisterActivity.class);
			startActivity(intent);
			
		}
	};
	OnClickListener listenershare=new OnClickListener() {
		
		@Override
		public void onClick(View v) {
			Intent intent=new Intent(Intent.ACTION_SEND); 
			ComponentName comp = new ComponentName("com.tencent.mm",
                      "com.tencent.mm.ui.tools.ShareImgUI");
		    	intent.setType("text/plain"); 
			  intent.setType("image/*");  
		      intent.setComponent(comp);
			intent.putExtra(Intent.EXTRA_SUBJECT, "分享"); 
			intent.putExtra(Intent.EXTRA_TEXT, "哈哈、测试");  
			intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK); 
			startActivity(Intent.createChooser(intent, getTitle()));
		}
	};
	@Override
	public void widgetClick(View v) {
	
	}


}
