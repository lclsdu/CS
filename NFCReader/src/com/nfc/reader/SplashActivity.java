package com.nfc.reader;

import java.util.ArrayList;
import java.util.List;
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.v4.view.ViewPager;
import android.support.v4.view.ViewPager.OnPageChangeListener;
import android.view.LayoutInflater;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.ImageView;

public class SplashActivity extends Activity  {
	/** Called when the activity is first created. */

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN,
				WindowManager.LayoutParams.FLAG_FULLSCREEN);
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		setContentView(R.layout.main);
		boolean first=MyApplication.getInstance().getMySharePerferences().isFirstEnter(getApplicationContext(), SplashActivity.class.getName());
		if (first) {
			mHandler.sendEmptyMessageDelayed(SWITCH_GUIDACTIVITY,2000);
		} else {
			mHandler.sendEmptyMessageDelayed(SWITCH_MAINACTIVITY,2000);
		}
	}
	
	//*************************************************
    // Handler:跳转至不同页面
    //*************************************************
    private final static int SWITCH_MAINACTIVITY = 1000;
    private final static int SWITCH_GUIDACTIVITY = 1001;
    public Handler mHandler = new Handler(){
        public void handleMessage(Message msg) {
            switch(msg.what){
            case SWITCH_MAINACTIVITY:
                Intent mIntent = new Intent();
                mIntent.setClass(SplashActivity.this, MainActivity.class);
                SplashActivity.this.startActivity(mIntent);
                SplashActivity.this.finish();
                break;
            case SWITCH_GUIDACTIVITY:
                mIntent = new Intent();
                mIntent.setClass(SplashActivity.this, GuideActivity.class);
                SplashActivity.this.startActivity(mIntent);
                SplashActivity.this.finish();
                break;
            }
            super.handleMessage(msg);
        }
    };
}