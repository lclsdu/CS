package com.grabparking.utils;

/**
 * 防止连续点击
 * @author Administrator
 *
 */
public class ContinuationClickUtils {
	private static long lastClickTime;

	public static boolean isFastDoubleClick() {
		long time = System.currentTimeMillis();
		long timeD = time - lastClickTime;
		lastClickTime = time;
		if (0 < timeD && timeD < 800) {
			return true;
		}
		return false;
	}
	
	public static void initLastClickTime(){
		lastClickTime = 0;
	}
}
