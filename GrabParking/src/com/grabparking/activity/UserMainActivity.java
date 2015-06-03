package com.grabparking.activity;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.ImageView;
import android.widget.RelativeLayout;
public class UserMainActivity extends BaseActivity{
	public RelativeLayout go_phone=null;
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.user_main_activity);
		initWidget();
	}
	@Override
	public void initWidget() {
		go_phone=(RelativeLayout)findViewById(R.id.layout_phone);
		go_phone.setOnClickListener(gotoPhone);
	}
	OnClickListener gotoPhone=new OnClickListener() {	
		@Override
		public void onClick(View v) {
			 //用intent启动拨打电话  
            Intent intent = new Intent(Intent.ACTION_CALL,Uri.parse("tel:"+"13146230614"));  
            startActivity(intent);  
		}
	};

	@Override
	public void widgetClick(View v) {
		// TODO Auto-generated method stub
		
	}

}
