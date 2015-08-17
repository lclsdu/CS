package com.nfc.reader.ui;

import static android.provider.Settings.ACTION_SETTINGS;
import android.app.Activity;
import android.content.Intent;
import android.nfc.NfcAdapter;

import com.nfc.reader.R;
import com.nfc.reader.ThisApplication;

public final class MainPage {

	public static CharSequence getContent(Activity activity) {

		final NfcAdapter nfc = NfcAdapter.getDefaultAdapter(activity);
		final int resid;

		if (nfc == null)
			resid = R.string.info_nfc_notsupport;
		else if (!nfc.isEnabled())
			resid = R.string.info_nfc_disabled;
		else
			resid = R.string.info_nfc_nocard;

		String tip = ThisApplication.getStringResource(resid);

		return new SpanFormatter(new Handler(activity)).toSpanned(tip);
	}

	private static final class Handler implements SpanFormatter.ActionHandler {
		private final Activity activity;

		Handler(Activity activity) {
			this.activity = activity;
		}

		@Override
		public void handleAction(CharSequence name) {
			startNfcSettingsActivity();
		}

		private void startNfcSettingsActivity() {
			try {
				activity.startActivityForResult(new Intent("android.settings.NFC_SETTINGS"), 0);
			} catch (Exception e) {
				activity.startActivityForResult(new Intent(ACTION_SETTINGS), 0);
			}
		}
	}

	private MainPage() {
	}
}
