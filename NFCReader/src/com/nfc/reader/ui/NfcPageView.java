package com.nfc.reader.ui;

import java.util.Collection;

import android.app.Activity;
import android.app.Dialog;
import android.content.Intent;

import com.nfc.reader.R;
import com.nfc.reader.MyApplication;
import com.nfc.reader.SpecConf.EVENT;
import com.nfc.reader.bean.CardApplications;
import com.nfc.reader.bean.Card;
import com.nfc.reader.rd.ReaderListener;

public final class NfcPageView implements ReaderListener {
	private static final String TAG = "READCARD_ACTION";//读卡动作
	private static final String RET = "READCARD_RESULT";//读卡结果  html对象
	private static final String DATA = "READCARD_DATA";//原始卡数据对象
	private static final String STA = "READCARD_STATUS";//读卡成功状态

	private final Activity activity;

	public NfcPageView(Activity activity) {
		this.activity = activity;
	}

	public static boolean isSendByMe(Intent intent) {
		return intent != null && TAG.equals(intent.getAction());
	}

	public static boolean isNormalInfo(Intent intent) {
		return intent != null && intent.hasExtra(STA);
	}

	public static CharSequence getContent(Activity activity, Intent intent) {

		String info = intent.getStringExtra(RET);
		if (info == null || info.length() == 0)
			return null;

		return new SpanFormatter(AboutPageView.getActionHandler(activity))
				.toSpanned(info);
	}
	//返回Application 集
	public static Collection<CardApplications> getDATAContent(Activity activity, Intent intent) {

		Card card = (Card)intent.getSerializableExtra(DATA);
		if (card == null)
			return null;

		return card.getApplications();
	}

	@Override
	public void onReadEvent(EVENT event, Object... objs) {
		if (event == EVENT.IDLE) {
			showProgressBar();
		}else if(event==EVENT.READING){
			showProgressBar();
		} 
		else if (event == EVENT.FINISHED) {
			hideProgressBar();

			final Card card;
			if (objs != null && objs.length > 0)
				card = (Card) objs[0];
			else
				card = null;
			//读取成功后设置activity的Intent
			activity.setIntent(buildResult(card));
		}
	}
	/**
	 * 构建最终结果集
	 * @param card
	 * @return
	 */
	private Intent buildResult(Card card) {
		//Read action Intent
		final Intent ret = new Intent(TAG);

		if (card != null && !card.hasReadingException()) {
			if (card.isUnknownCard()) {
				ret.putExtra(RET, MyApplication
						.getStringResource(R.string.info_nfc_unknown));
			} else {
				//成功读取卡信息结果
				ret.putExtra(RET, card.toHtml());
				ret.putExtra(DATA, card);
				ret.putExtra(STA, 1);
			}
		} else {
			ret.putExtra(RET,
					MyApplication.getStringResource(R.string.info_nfc_error));
		}

		return ret;
	}

	private void showProgressBar() {
		Dialog d = progressBar;
		if (d == null) {
			d = new Dialog(activity, R.style.progressBar);
			d.setCancelable(false);
			d.setContentView(R.layout.progress);
			progressBar = d;
		}

		if (!d.isShowing())
			d.show();
	}

	private void hideProgressBar() {
		final Dialog d = progressBar;
		if (d != null && d.isShowing())
			d.cancel();
	}

	private Dialog progressBar;
}
