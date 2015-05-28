package com.grabparking.activity;

import com.grabparking.function.AppManager;
import com.grabparking.utils.MySharedPreferences;

import android.app.Activity;
import android.content.pm.ActivityInfo;
import android.os.Bundle;
import android.support.v4.app.FragmentActivity;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.Window;
import android.widget.LinearLayout;

public abstract class BaseActivity extends Activity implements OnClickListener{
		private static final String TAG = BaseActivity.class.getSimpleName();
		private static final int ACTIVITY_RESUME = 0;
	    private static final int ACTIVITY_STOP = 1;
	    private static final int ACTIVITY_PAUSE = 2;
	    private static final int ACTIVITY_DESTROY = 3;
	    public int activityState;
	 
	    // 是否允许全屏
	    private boolean mAllowFullScreen = true;
	 
	    public abstract void initWidget();
	 
	    public abstract void widgetClick(View v);
	 
	    public void setAllowFullScreen(boolean allowFullScreen) {
	        this.mAllowFullScreen = allowFullScreen;
	    }
	    public MySharedPreferences prefs;
	
	    private LinearLayout mainLayout;			//主布局
	    @Override
	    protected void onCreate(Bundle savedInstanceState) {
	    	super.onCreate(savedInstanceState);
	    	 Log.d(this.getClass().getSimpleName() , "---------onCreat ");
	         // 竖屏锁定
//	      setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT);
//	         if (mAllowFullScreen) {
//	             requestWindowFeature(Window.FEATURE_NO_TITLE); // 取消标题
//	         }
	         requestWindowFeature(Window.FEATURE_NO_TITLE);
	         AppManager.getAppManager().addActivity(this);
	         
	    }

	    @Override
		public void onClick(View v) {
	    	 widgetClick(v);	
	}
	    @Override
	    protected void onStart() {
	        super.onStart();
	        Log.i(this.getClass().getSimpleName(), "---------onStart ");
	    }
	 
	    @Override
	    protected void onResume() {
	        super.onResume();
	        activityState = ACTIVITY_RESUME;
	        Log.i(this.getClass().getSimpleName(), "---------onResume ");
	    }
	 
	    @Override
	    protected void onStop() {
	        super.onResume();
	        activityState = ACTIVITY_STOP;
	        Log.i(this.getClass().getSimpleName(), "---------onStop ");
	    }
	 
	    @Override
	    protected void onPause() {
	        super.onPause();
	        activityState = ACTIVITY_PAUSE;
	        Log.i(this.getClass().getSimpleName(), "---------onPause ");
	    }
	 
	    @Override
	    protected void onRestart() {
	        super.onRestart();
	        Log.i(this.getClass().getSimpleName(), "---------onRestart ");
	    }
	 
	    @Override
	    protected void onDestroy() {
	        super.onDestroy();
	        activityState = ACTIVITY_DESTROY;
	        Log.i(this.getClass().getSimpleName(), "---------onDestroy ");
	        AppManager.getAppManager().finishActivity(this);
	    }

}
