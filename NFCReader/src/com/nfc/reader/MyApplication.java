package com.nfc.reader;

import java.io.InputStream;
import java.lang.Thread.UncaughtExceptionHandler;
import android.app.Application;
import android.graphics.Typeface;
import android.graphics.drawable.Drawable;
import android.util.DisplayMetrics;
import android.widget.Toast;

public final class MyApplication extends Application implements UncaughtExceptionHandler {
	private static MyApplication instance;

	@Override
	public void uncaughtException(Thread thread, Throwable ex) {
		System.exit(0);
	}

	@Override
	public void onCreate() {
		super.onCreate();

		Thread.setDefaultUncaughtExceptionHandler(this);

		instance = this;
	}

	public static String name() {
		return getStringResource(R.string.app_name);
	}

	public static String version() {
		try {
			return instance.getPackageManager().getPackageInfo(instance.getPackageName(), 0).versionName;
		} catch (Exception e) {
			return "1.0";
		}
	}

	public static void showMessage(int fmt, CharSequence... msgs) {
		//使用本地系统对象格式化字符串
		String msg = String.format(getStringResource(fmt), msgs);
		Toast.makeText(instance, msg, Toast.LENGTH_LONG).show();
	}

	public static Typeface getFontResource(int pathId) {
		String path = getStringResource(pathId);
		return Typeface.createFromAsset(instance.getAssets(), path);
	}

	public static int getDimensionResourcePixelSize(int resId) {
		return instance.getResources().getDimensionPixelSize(resId);
	}

	public static int getColorResource(int resId) {
		return instance.getResources().getColor(resId);
	}

	public static String getStringResource(int resId) {
		return instance.getString(resId);
	}

	public static Drawable getDrawableResource(int resId) {
		return instance.getResources().getDrawable(resId);
	}

	public static DisplayMetrics getDisplayMetrics() {
		return instance.getResources().getDisplayMetrics();
	}
	
	public static byte[] loadRawResource(int resId) {
		InputStream is = null;
		try {
			is = instance.getResources().openRawResource(resId);

			int len = is.available();
			byte[] raw = new byte[(int) len];

			int offset = 0;
			while (offset < raw.length) {
				int n = is.read(raw, offset, raw.length - offset);
				if (n < 0)
					break;

				offset += n;
			}
			return raw;
		} catch (Throwable e) {
			return null;
		} finally {
			try {
				is.close();
			} catch (Throwable ee) {
			}
		}
	}
}
