package com.nf.reader.utils;
import org.json.JSONObject;
import android.content.Context;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;
import android.text.TextUtils;


public class MySharedPreferences {
	SharedPreferences prefs;
	Context ctx;

	private static final String KEY_GUIDE_ACTIVITY = "guide_activity";
	public MySharedPreferences(Context context){
		prefs = context.getSharedPreferences(Constants.SETTING_PREFERENCE_NAME, Context.MODE_WORLD_READABLE);
		ctx = context;
	}
	 //****************************************************************
    // 判断应用是否初次加载，读取SharedPreferences中的guide_activity字段
    //****************************************************************
	 public boolean isFirstEnter(Context context,String className){
	        if(context==null || className==null||"".equalsIgnoreCase(className))return false;
	        String mResultStr = prefs.getString(KEY_GUIDE_ACTIVITY, "");//取得所有类名 如 com.my.MainActivity
	        if(mResultStr.equalsIgnoreCase("false"))
	            return false;
	        else
	            return true;
	    }
	 public void setGuided( ){
		    Editor edit =prefs.edit();
			edit.putString(KEY_GUIDE_ACTIVITY, "false");
			edit.commit();
	    }
	//  NFC status
	public int getNFCStatus(){
		return prefs.getInt("NFC", 0);
	}
	public void setNFCStatus(int v){
		Editor edit = prefs.edit();
		edit.putInt("NFC",v);
		edit.commit();
	}
}
