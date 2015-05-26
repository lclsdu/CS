package com.grabparking.utils;

import java.io.File;

import android.content.Context;
import android.content.Intent;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.net.Uri;
import android.os.Environment;
import android.os.StatFs;
import android.telephony.SmsManager;
import android.view.View;
import android.view.inputmethod.InputMethodManager;

/**
 * android系统专用工具
 * @author Administrator
 *
 */
public class AndroidTools {
	private static final String TAG = AndroidTools.class.getSimpleName();
	
	public static int getResourceId(Context context, String strName) {
		return context.getResources().getIdentifier(strName, "string", context.getPackageName());
	}

    /**
     * 判断sdcard是否可用
     * @return
     */
    public static boolean sdCardIsExsit(){  
    	return Environment.getExternalStorageState().equals(Environment.MEDIA_MOUNTED);  
    }  
	
    /**
     * 获取SDCARD的可用空间
     * @return
     */
    public static long getSdCardAvailableSize(){
		if(Environment.getExternalStorageState().equals(Environment.MEDIA_MOUNTED)){
			File sdcardDir = Environment.getExternalStorageDirectory();  
           StatFs sf = new StatFs(sdcardDir.getPath());  
           long blockSize = sf.getBlockSize();  
           long blockCount = sf.getBlockCount();  
           long availCount = sf.getAvailableBlocks();  
           
           return availCount*blockSize;
		}
		
		return 0;
	}
    
    /**
     * 得到SDCARD的目录
     * @return
     */
    public static String getSDPath(){
        File sdDir = null;
        if(sdCardIsExsit()){                              
          sdDir = Environment.getExternalStorageDirectory();//获取跟目录
        }  
        return sdDir.toString();
    	//return "/sdcard/";
    } 
    
    /**
     * 检查网络是否可用
     * @param context
     * @return true 有可用的网络，false 没有可用的网络
     */
    public static boolean isNetworkConnected(Context context) {
    	ConnectivityManager cm = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);
    	
    	NetworkInfo network = cm.getActiveNetworkInfo();
    	if (network != null) {
    		return network.isAvailable();
    	}
    	return false;
    }
    
    /**
     * 专门检测wifi是否可用
     * @param context
     * @return
     */
    public static boolean isWifi(Context context) {
    	ConnectivityManager cm = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);
    	NetworkInfo mWifi = cm.getNetworkInfo(ConnectivityManager.TYPE_WIFI);

    	return mWifi.isConnected();
    }
    
    /**
	 * 隐藏键盘
	 */
    public static void keyBoxGone(Context ctx,View v){
		InputMethodManager imm = (InputMethodManager)ctx.getSystemService(Context.INPUT_METHOD_SERVICE);   
		if(imm.isActive()){   
			imm.hideSoftInputFromWindow(v.getApplicationWindowToken(), 0 ); 
		}
	}
    
    /**
	 * 弹出键盘
	 */
    public static void keyBoxShow(Context ctx,View v){
		InputMethodManager imm = (InputMethodManager)ctx.getSystemService(Context.INPUT_METHOD_SERVICE);   
		imm.showSoftInput(v, InputMethodManager.SHOW_FORCED);
	}
    
    /**
     * 呼叫
     * @param ctx
     * @param phone
     */
    public static void call(Context ctx, String phone){
		Intent intent = new Intent(Intent.ACTION_CALL, Uri.parse("tel:" + phone));
    	ctx.startActivity(intent);
    }
    
    /**
     * 发送短信
     * @param ctx
     * @param phone
     */
    public static void sendSms(Context ctx, String phone,String body){
    	Uri smsToUri = Uri.parse("smsto:"+Tools.convertObject(phone));  
		Intent intent = new Intent(Intent.ACTION_SENDTO, smsToUri);  
		if(body!=null && !body.equals("")){
			intent.putExtra("sms_body", body);  
		}
		ctx.startActivity(intent);
    }
    

    public static void sendSms2(String phone, String message){
        SmsManager sms = SmsManager.getDefault();
        sms.sendTextMessage(phone, null, message, null, null);
    }
    
    /** 
	 * 根据手机的分辨率从 dp 的单位 转成为 px(像素) 
	 */  
	public static int dip2px(Context context, float dpValue) {  
	    final float scale = context.getResources().getDisplayMetrics().density;  
	    return (int) (dpValue * scale + 0.5f);  
	}  
	  
	/** 
	 * 根据手机的分辨率从 px(像素) 的单位 转成为 dp 
	 */  
	public static int px2dip(Context context, float pxValue) {  
	    final float scale = context.getResources().getDisplayMetrics().density;  
	    return (int) (pxValue / scale + 0.5f);  
	}  
	
    /**
	 * sdcard目录
	 */
	public static final String SDCard_Dir = android.os.Environment.getExternalStorageDirectory().getAbsolutePath();
	public static final String Dir = SDCard_Dir+"/wopay/";
	public static final String FileDir = Dir+"file/";
	/**
	 * 下载目录，这个一定要创建，否则部分手机因为没有默认的download目录而导致下载失败
	 */
	public static final String DownloadDir = SDCard_Dir+"/download";
	
    /**
	 * 创建数据文件目录
	 */
    public static void mdAppRootDir(Context ctx){
    	MyLog.e(TAG, "Dir="+Dir);
    	MyLog.e(TAG, "FileDir"+FileDir);
    	MyLog.e(TAG, "DownloadDir="+DownloadDir);
    	
		File f = new File(Dir);
		if(!f.exists()){
			f.mkdir();
		}
		File f2 = new File(FileDir);
		if(!f2.exists()){
			f2.mkdir();
		}
		File f3 = new File(DownloadDir);
		if(!f3.exists()){
			f3.mkdir();
		}
		
    }
    
}
