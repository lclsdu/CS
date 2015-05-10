package com.grabparking.activity;

import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.app.Activity;
import android.content.Intent;
import android.view.Menu;
import android.view.MenuItem;
import android.view.Window;
import android.widget.TextView;
import android.widget.Toast;
import android.support.v4.app.NavUtils;

/**
 * grabparking project 启动页面
 * 
 * @author lcl
 * 
 */
public class LauncherActivity extends Activity {
	private static String TAG = LauncherActivity.class.getName();
	private final static int MSG_200 = 200;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		setContentView(R.layout.activity_launcher);
		Intent intent = getIntent();
		Bundle bundle = intent.getExtras();
		if (bundle != null) {
			String name = bundle.getString("name");
			String birthday = bundle.getString("birthday");
			if (name != null && birthday != null) {
				Toast.makeText(getApplicationContext(),
						"name:" + name + "    birthday:" + birthday,
						Toast.LENGTH_SHORT).show();
				// TextView t = (TextView)findViewById(R.id.);
				// t.setText("name:" + name + "    birthday:" + birthday);
			}
		}

		mHandler.sendEmptyMessageDelayed(MSG_200, 3000);

	}

	Handler mHandler = new Handler() {
		@Override
		public void handleMessage(Message msg) {
			switch (msg.what) {
			case MSG_200:
				Intent intent = new Intent(LauncherActivity.this,
						MainActivity.class);
				startActivity(intent);
				finish();
				break;

			default:
				break;
			}
		}
	};

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		getMenuInflater().inflate(R.menu.activity_launcher, menu);
		return true;
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

}
