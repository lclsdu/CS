package com.grabparking.activity;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import org.apache.http.util.LangUtils;

import com.android.volley.AuthFailureError;
import com.android.volley.Request;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.grabparking.application.GPApplication;
import com.grabparking.function.DownloadProgressListener;
import com.grabparking.utils.AndroidTools;
import com.grabparking.utils.Constants;
import com.grabparking.utils.DeviceUtils;
import com.grabparking.utils.FileDownloader;
import com.grabparking.utils.MySharedPreferences;

import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;
import android.os.Handler;
import android.os.Message;
import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.Window;
import android.widget.ProgressBar;
import android.widget.TextView;
import android.widget.Toast;
import android.support.v4.app.NavUtils;

/**
 * grabparking project 启动页面
 * 
 * @author lcl
 * 
 */
public class LauncherActivity extends BaseActivity {
	private static String TAG = LauncherActivity.class.getName();
	private final static int MSG_200 = 200;
	private ProgressBar progressBar;
	private String appVersion = "1.3.0";
	private View layout;
	private MySharedPreferences perf = null;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		// requestWindowFeature(Window.FEATURE_NO_TITLE);
		setContentView(R.layout.activity_launcher);
		initWidget();
		// 检查是否首次使用
		if (!perf.getFirstEnter()) {
			Toast.makeText(getApplicationContext(), "首次安装使用", Toast.LENGTH_LONG).show();
		} else {
			perf.setFirstEnter(true);
			Toast.makeText(getApplicationContext(), "非首次安装使用",
					Toast.LENGTH_LONG).show();
		}
		/**
		 * 在此进行网络检查，检查版本更新
		 */
		if (!AndroidTools.isNetworkConnected(getApplicationContext())) {
			Toast.makeText(getApplicationContext(), "网络连接不可用",
					Toast.LENGTH_LONG).show();	
			// 直接跳转  无版本更新
			handler.sendEmptyMessageDelayed(-1, 1000);
		}else{
			GPApplication.getInstance().addToRequestQueue(getLoginCheck());
		}

		
	}

	Handler handler = new Handler() {
		@Override
		public void handleMessage(Message msg) {
			switch (msg.what) {
			case 1:
				progressBar.setProgress(msg.getData().getInt("size"));
				float num = (float) progressBar.getProgress()
						/ (float) progressBar.getMax();
				int result = (int) (num * 100);
				// resultView.setText(result + "%");

				if (progressBar.getProgress() == progressBar.getMax()) {
					Toast.makeText(LauncherActivity.this, "下载成功", 1).show();
					installApp(new File(
							Environment.getExternalStorageDirectory()
									+ "/GrabParking-0.2.apk"));
				}

				break;
			case -1:
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

	private void installApp(File appFile) {
		// 创建URI
		Uri uri = Uri.fromFile(appFile);
		// 创建Intent意图
		Intent intent = new Intent(Intent.ACTION_VIEW);
		// 设置Uri和类型
		intent.setDataAndType(uri, "application/vnd.android.package-archive");
		// 执行意图进行安装
		startActivity(intent);

	}

	/**
	 * 主线程(UI线程) 对于显示控件的界面更新只是由UI线程负责，如果是在非UI线程更新控件的属性值，更新后的显示界面不会反映到屏幕上
	 * 
	 * @param path
	 * @param savedir
	 */
	private void download(final String path, final File savedir) {
		new Thread(new Runnable() {
			@Override
			public void run() {
				FileDownloader loader = new FileDownloader(
						LauncherActivity.this, path, savedir, 5);
				progressBar.setMax(loader.getFileSize());// 设置进度条的最大刻度为文件的长度

				try {
					loader.download(new DownloadProgressListener() {
						@Override
						public void onDownloadSize(int size) {// 实时获知文件已经下载的数据长度
							Message msg = new Message();
							msg.what = 1;
							msg.getData().putInt("size", size);
							handler.sendMessage(msg);// 发送消息
						}
					});
				} catch (Exception e) {
					handler.obtainMessage(-1).sendToTarget();
				}
			}
		}).start();
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

	@Override
	public void initWidget() {
		// TODO Auto-generated method stub
		perf = new MySharedPreferences(getApplicationContext());
	}

	@Override
	public void widgetClick(View v) {
		// TODO Auto-generated method stub

	}

	public void showAlertDialog() {

		CustomDialog.Builder builder = new CustomDialog.Builder(LauncherActivity.this);
		builder.setMessage("版本更新");
		builder.setMessage("修复上一版本已知bug");
		builder.setTitle("提示");
		builder.setPositiveButton("确定", new DialogInterface.OnClickListener() {
			public void onClick(DialogInterface dialog, int which) {
				dialog.dismiss();
				layout = GPApplication.inflater.inflate(
						R.layout.progress_layout, null);
				AlertDialog.Builder builder = new AlertDialog.Builder(
						LauncherActivity.this);
				builder.setView(layout);
				builder.setTitle("更新进度");
				builder.create().show();
				// setContentView(layout);
				progressBar = (ProgressBar) layout
						.findViewById(R.id.progressBar1);
				// setContentView(layout);
				// 设置你的操作事项
				download(GPApplication.downloadApp,
						Environment.getExternalStorageDirectory());

			}
		});

		builder.setNegativeButton("取消",
				new android.content.DialogInterface.OnClickListener() {
					public void onClick(DialogInterface dialog, int which) {
						dialog.dismiss();
						handler.sendEmptyMessageDelayed(-1, 500);
					}
				});

		builder.create().show();
		
	}
	/**
	 * 启动app时的检查
	 * @return
	 */
	public  StringRequest getLoginCheck(){
		StringRequest  request = new StringRequest(  
		          Request.Method.POST,  
		          "http://"+Constants.map.get("serverIp")+":"+Constants.map.get("serverPort")+
		          Constants.map.get("loginCheckURL"),  
		          new Response.Listener<String>() {  
		            @Override  
		            public void onResponse(String s) {  
		            	if(s.equals("hello world")){
		            	showAlertDialog();
		            
		            	}else{
		    			// 直接跳转  无版本更新
		    			handler.sendEmptyMessageDelayed(-1, 500);
		            	}
		            	Log.d("网络返回成功", s);
		            }  
		          },  
		          new Response.ErrorListener() { 

					@Override
					public void onErrorResponse(VolleyError error) {
						// TODO Auto-generated method stub
						
					}  
		          }  
		      )
		 {  
		        @Override  
		        public Map<String, String> getHeaders() throws AuthFailureError {  //设置头信息  
		          Map<String, String> map = new HashMap<String, String>();  
		          map.put("Content-Type", "application/x-www-form-urldecoded");  
		          map.put("client_version", DeviceUtils.getVersionName(getApplicationContext()));  
		          map.put("phone_type",DeviceUtils.getModel());  
		          map.put("phone_os", "android");  
		          return map;  
		        }  
		        @Override  
		        protected Map<String, String> getParams() throws AuthFailureError {  //设置参数  
		          Map<String, String> map = new HashMap<String, String>();  
		          map.put("client_version", DeviceUtils.getVersionName(getApplicationContext()));  
		          map.put("phone_type",DeviceUtils.getModel());  
		          map.put("phone_os", "android");  
		          return map;  
		        }  
		      };
		return request;
	}
}
