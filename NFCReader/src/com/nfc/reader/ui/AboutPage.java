package com.nfc.reader.ui;

import android.app.Activity;
import android.content.Intent;

import com.nfc.reader.R;
import com.nfc.reader.ThisApplication;

public final class AboutPage {
	private static final String TAG = "ABOUTPAGE_ACTION";

	public static CharSequence getContent(Activity activity) {

		String tip = ThisApplication
				.getStringResource(R.string.info_main_about);
		tip = tip.replace("<app />", ThisApplication.name());
		tip = tip.replace("<version />", ThisApplication.version());

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

	private AboutPage() {
	}
}
