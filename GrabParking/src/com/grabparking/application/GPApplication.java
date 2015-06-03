package com.grabparking.application;


import java.io.File;

import org.apache.http.HttpVersion;
import org.apache.http.client.HttpClient;
import org.apache.http.conn.ClientConnectionManager;
import org.apache.http.conn.scheme.PlainSocketFactory;
import org.apache.http.conn.scheme.Scheme;
import org.apache.http.conn.scheme.SchemeRegistry;
import org.apache.http.conn.ssl.SSLSocketFactory;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.conn.tsccm.ThreadSafeClientConnManager;
import org.apache.http.params.BasicHttpParams;
import org.apache.http.params.HttpParams;
import org.apache.http.params.HttpProtocolParams;
import org.apache.http.protocol.HTTP;

import android.app.Application;
import android.content.Context;
import android.content.SharedPreferences;
import android.util.Log;
import android.view.LayoutInflater;

import com.baidu.mapapi.SDKInitializer;
import com.grabparking.function.GPManager;
import com.grabparking.utils.CrashHandler;
import com.grabparking.utils.MySharedPreferences;
/**
 * 适配百度地图的application
 * @author lcl
 *
 */
public class GPApplication extends Application {
	private static String TAG=GPApplication.class.getName();
	public static String PRO_URL="http://qiangchewei001:8889/qiangcheweiphone";
	public static String downloadApp="http://192.168.1.104:81/app/GrabParking-0.2.apk";
	public static  GPManager gpManager=null;
	private String Appid="01";//android手机客户端
	 public  HttpClient httpClient=null;
	 public static  MySharedPreferences perf=null;
	 //1、对于一个没有被载入或者想要动态载入的界面，都需要使用LayoutInflater.inflate()来载入；
	// 2、对于一个已经载入的界面，就可以使用Activiyt.findViewById()方法来获得其中的界面元素。
	public  static LayoutInflater inflater=null;
	 /**
	  * is login
	  */
	 private boolean islogin=false;
	@Override
	public void onCreate() {
		super.onCreate();
		// 在使用 SDK 各组间之前初始化 context 信息，传入 ApplicationContext
		SDKInitializer.initialize(getApplicationContext());
		 //初始化httpclient
	     httpClient = createHttpClient();
	     //加载页面对象
	     inflater=(LayoutInflater)getApplicationContext().getSystemService(Context.LAYOUT_INFLATER_SERVICE);
	     getGPManager();
	    // getMySharePerferences();
	     /**
		 * 初始化异常cash的接管类
		 */
		CrashHandler crashHandler = CrashHandler.getInstance();  
		crashHandler.init(getApplicationContext()); 
	}
	/**
	 * signlen  GpManager
	 * @return
	 */
	public  GPManager getGPManager(){
		if(gpManager==null){
			gpManager=new GPManager(this,Appid);
		}
		return gpManager;
	}
	/**
	 * shareperfacne
	 */
//	public MySharedPreferences getMySharePerferences(){
//		if(perf==null){
//			  perf=new MySharedPreferences(this);	
//		}
//		return perf;
//	}
	 
	    @Override
	    public void onLowMemory() {
	        super.onLowMemory();
	        shutdownHttpClient();
	    }
	 
	    @Override
	    public void onTerminate() {
	        super.onTerminate();
	        shutdownHttpClient();
	    }
	 
	    // 创建HttpClient对象
	    private HttpClient createHttpClient() {
	        Log.i(TAG, "Create HttpClient...");
	 
	        HttpParams params = new BasicHttpParams();
	        HttpProtocolParams.setVersion(params, HttpVersion.HTTP_1_1);
	        HttpProtocolParams.setContentCharset(params,
	                HTTP.DEFAULT_CONTENT_CHARSET);
	        HttpProtocolParams.setUseExpectContinue(params, true);
	 
	        SchemeRegistry schReg = new SchemeRegistry();
	        schReg.register(new Scheme("http", PlainSocketFactory
	                .getSocketFactory(), 80));
	        schReg.register(new Scheme("https",
	                SSLSocketFactory.getSocketFactory(), 443));
	 
	        ClientConnectionManager conMgr = new ThreadSafeClientConnManager(
	                params, schReg);
	 
	        return new DefaultHttpClient(conMgr, params);
	    }
	 
	    // 关闭HttpClent
	    private void shutdownHttpClient() {
	        if (httpClient != null && httpClient.getConnectionManager() != null) {
	            httpClient.getConnectionManager().shutdown();
	        }
	    }
	 
	    public HttpClient getHttpClient() {
	        return httpClient;
	    }
		public boolean isIslogin() {
			return islogin;
		}
		public void setIslogin(boolean islogin) {
			this.islogin = islogin;
		}
	    
}