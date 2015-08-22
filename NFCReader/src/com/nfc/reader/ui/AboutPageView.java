package com.nfc.reader.ui;

import android.app.Activity;
import android.content.Intent;

import com.nfc.reader.R;
import com.nfc.reader.MyApplication;

public final class AboutPageView {
	private static final String TAG = "ABOUTPAGE_ACTION";

	public static CharSequence getContent(Activity activity) {

		String tip = MyApplication
				.getStringResource(R.string.info_main_about);
		tip = tip.replace("<app />", MyApplication.name());
		tip = tip.replace("<version />", MyApplication.version());

		return new SpanFormatter(null).toSpanned(tip);
	}

	public static boolean isSendByMe(Intent intent) {
		return intent != null && TAG.equals(intent.getAction());
	}

	static SpanFormatter.ActionHandler getActionHandler(Activity activity) {
		return new Handler(activity);
	}

	private static final class Handler implements SpanFormatter.ActionHandler {
		private final Activity activity;

		Handler(Activity activity) {
			this.activity = activity;
		}

		@Override
		public void handleAction(CharSequence name) {
			activity.setIntent(new Intent(TAG));
		}
	}

	private AboutPageView() {
	}
}
