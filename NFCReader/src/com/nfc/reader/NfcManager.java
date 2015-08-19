package com.nfc.reader;

import static android.nfc.NfcAdapter.EXTRA_TAG;
import static android.os.Build.VERSION_CODES.GINGERBREAD_MR1;
import static android.os.Build.VERSION_CODES.ICE_CREAM_SANDWICH;
import android.annotation.SuppressLint;
import android.app.Activity;
import android.app.PendingIntent;
import android.content.Intent;
import android.content.IntentFilter;
import android.nfc.NdefMessage;
import android.nfc.NdefRecord;
import android.nfc.NfcAdapter;
import android.nfc.Tag;
import android.nfc.tech.IsoDep;
import android.nfc.tech.NfcF;

import com.nfc.reader.rd.ReaderListener;
import com.nfc.reader.rd.ReaderManager;

public final class NfcManager {

	private final Activity activity;//上下文
	//设备nfc适配器
	private NfcAdapter nfcAdapter;
	private PendingIntent pendingIntent;
	//tech 
	private static String[][] TECHLISTS;
	private static IntentFilter[] TAGFILTERS;
	private int status;

	static {
		try {
			//支持ISODep   NFCF 类型的TECH TAG 列表
			TECHLISTS = new String[][] { { IsoDep.class.getName() },
					{ NfcF.class.getName() }, };
			//TECH Intent filter
			TAGFILTERS = new IntentFilter[] { new IntentFilter(
					NfcAdapter.ACTION_TECH_DISCOVERED, "*/*") };
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public NfcManager(Activity activity) {
		this.activity = activity;
		nfcAdapter = NfcAdapter.getDefaultAdapter(activity);
		pendingIntent = PendingIntent.getActivity(activity, 0, new Intent(
				activity, activity.getClass()).addFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP), 0);
		//设置beam 可用
		setupBeam(true);
		//adpater 状态 -1 1 0
		status = getStatus();
	}

	public void onPause() {
		setupOldFashionBeam(false);

		if (nfcAdapter != null)
			nfcAdapter.disableForegroundDispatch(activity);
	}

	public void onResume() {
		setupOldFashionBeam(true);

		if (nfcAdapter != null)
			nfcAdapter.enableForegroundDispatch(activity, pendingIntent,
					TAGFILTERS, TECHLISTS);
	}

	public boolean updateStatus() {

		int sta = getStatus();
		if (sta != status) {
			status = sta;
			return true;
		}

		return false;
	}
	/**
	 * 读取卡片内容的主方法
	 * @param intent
	 * @param listener 读取成功的回调接口   NfcPage中实现  并对NFC读出的内容进行组织
	 * @return
	 */
	public boolean readCard(Intent intent, ReaderListener listener) {
		final Tag tag = (Tag) intent.getParcelableExtra(EXTRA_TAG);//强制获取NDEF、TECH、TAG的action内容
		if (tag != null) {
			ReaderManager.readCard(tag, listener);
			return true;
		}
		return false;
	}
	/**
	 * nfc adapter的状态 
	 * adapter==null 时返回-1
	 * adapter可用时    返回1
	 * adapter不可用    返回0
	 * @return
	 */
	private int getStatus() {
		return (nfcAdapter == null) ? -1 : nfcAdapter.isEnabled() ? 1 : 0;
	}
	/**
	 * android beam功能
	 * @param enable
	 */
	@SuppressLint("NewApi")
	private void setupBeam(boolean enable) {

		final int api = android.os.Build.VERSION.SDK_INT;
		if (nfcAdapter != null && api >= ICE_CREAM_SANDWICH) {
			if (enable)
				nfcAdapter.setNdefPushMessage(createNdefMessage(), activity);
		}
	}
	/**
	 * 设置旧版本的nfc beam
	 * @param enable
	 */
	@SuppressWarnings("deprecation")
	private void setupOldFashionBeam(boolean enable) {

		final int api = android.os.Build.VERSION.SDK_INT;
		if (nfcAdapter != null && api >= GINGERBREAD_MR1
				&& api < ICE_CREAM_SANDWICH) {

			if (enable)
				nfcAdapter.enableForegroundNdefPush(activity,
						createNdefMessage());
			else
				nfcAdapter.disableForegroundNdefPush(activity);
		}
	}

	NdefMessage createNdefMessage() {

		String uri = "3play.google.com/store/apps/details?id=com.nfc.reader";
		byte[] data = uri.getBytes();

		// about this '3'.. see NdefRecord.createUri which need api level 14
		data[0] = 3;

		NdefRecord record = new NdefRecord(NdefRecord.TNF_WELL_KNOWN,
				NdefRecord.RTD_URI, null, data);

		return new NdefMessage(new NdefRecord[] { record });
	}
}
