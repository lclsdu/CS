package com.grabparking.activity;

import com.baidu.location.LocationClient;
import com.baidu.location.LocationClientOption;
import com.baidu.location.LocationClientOption.LocationMode;
import com.baidu.mapapi.map.BaiduMap;
import com.baidu.mapapi.map.MapStatus;
import com.baidu.mapapi.map.MapStatusUpdateFactory;
import com.baidu.mapapi.map.MapView;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.Window;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.TextView;

public class RegisterActivity extends BaseActivity{
	public ImageButton buttonBack=null;
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		requestWindowFeature(Window.FEATURE_CUSTOM_TITLE);
		setContentView(R.layout.activity_register);
		getWindow().setFeatureInt(Window.FEATURE_CUSTOM_TITLE, R.layout.public_title);
		initWidget();
	}
	
	OnClickListener backListener=new OnClickListener() {		
		@Override
		public void onClick(View v) {
			// TODO Auto-generated method stub
			Intent intent = new Intent();
			intent.setClass(RegisterActivity.this, MainActivity.class);
			startActivityForResult(intent, 0);
		}
	};
	@Override
	public void initWidget() {
		// TODO Auto-generated method stub
		buttonBack=(ImageButton)findViewById(R.id.imageBtn_left);
		buttonBack.setOnClickListener(backListener);
	}

	@Override
	public void widgetClick(View v) {
		// TODO Auto-generated method stub
		
	}

}
