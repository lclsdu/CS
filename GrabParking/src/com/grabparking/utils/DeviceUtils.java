package com.grabparking.utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.telephony.TelephonyManager;

/**
 * 辅助读取设备相关参数
 * @author Administrator
 *
 */
public class DeviceUtils {
	/**
	 * 获取当前程序的版本号
	 * 
	 * @param context
	 * @return
	 * @throws Exception
	 */
	public static String getVersionName(Context context) {
		String version = "3.1.0";//注意这个地方，为了保险起见，最好是写上当前的版本号		

			try{
				// 获取packagemanager的实例
				PackageManager packageManager = context.getPackageManager();
				// getPackageName()是你当前类的包名，0代表是获取版本信息
				PackageInfo packInfo = packageManager.getPackageInfo(context.getPackageName(), 0);
				version = packInfo.versionName;
			} catch (Exception e) {
				e.printStackTrace();
			}
	
		return version;
	}

	/**
	 * 获取设备id
	 * 
	 * @param context
	 * @return
	 */
	public static String getDeviceId(Context context) {
		String imei = "";
		try {
			imei = ((TelephonyManager) context.getSystemService(Context.TELEPHONY_SERVICE)).getDeviceId();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return imei;
	}

	/**
	 * 获取机型
	 * 
	 * @return
	 */
	public static String getModel() {
		return android.os.Build.MODEL;
	}

	
	/**
	 * 从MySharedPreferences里面 获取渠道号
	 * @param context
	 * @return
	 */
	public static String getSourceID(Context context) {
		MySharedPreferences sharedPrefs = new MySharedPreferences(context);
		String sourceID = "";
		if(sharedPrefs.getSourceID().equals("")){
			sourceID = getSourcidFromAsset(context);
			sharedPrefs.setSourceID(sourceID);
		}
		
		MyLog.e("zz", sharedPrefs.getSourceID());
		return sharedPrefs.getSourceID();
	}

	public static final String fileName = "sourid.txt";

	/**
	 * 从文件里面获取渠道号
	 * @param context
	 * @return
	 */
	public static String getSourcidFromAsset(Context context) {
		BufferedReader reader = null;
		String sourceid = "";
		try {
			reader = new BufferedReader(new InputStreamReader(context.getResources().getAssets().open(fileName)));
			sourceid = reader.readLine().trim();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return sourceid;
	}
}
