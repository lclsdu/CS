package com.grabparking.utils;

import android.os.Environment;

public class SDHelper {
	
	/**
	 * 检查SD卡是否存在
	 * @return
	 */
	public static boolean checkSDCard(){
		boolean bRes = Environment.getExternalStorageState().equals(
				Environment.MEDIA_MOUNTED);
		return bRes;
	}

}
