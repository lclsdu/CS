package com.nfc.reader;

import android.app.Activity;
import android.content.Intent;
import android.graphics.Typeface;
import android.os.Bundle;
import android.text.method.LinkMovementMethod;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import android.widget.ViewSwitcher;

import com.nfc.reader.ui.AboutPage;
import com.nfc.reader.ui.MainPage;
import com.nfc.reader.ui.NfcPage;
import com.nfc.reader.ui.Toolbar;

public class MainActivity extends Activity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);
		//初始化页面控件
		initViews();
		//实例化nfc管理类
		nfc = new NfcManager(this);
		//进行nfc事件监听
		onNewIntent(getIntent());
	}
	/**
	 * back 键后的回调
	 * 如果在about页   重新加载初始页面  否则退出
	 */
	@Override
	public void onBackPressed() {
		if (isCurrentPage(SPEC.PAGE.ABOUT))
			loadDefaultPage();
		else if (safeExit)
			super.onBackPressed();
	}
	/**
	 * Change the intent returned by getIntent. 
	 * This holds a reference to the given intent; it does not copy it. 
	 * Often used in conjunction with onNewIntent. 
	 */
	@Override
	public void setIntent(Intent intent) {
		if (NfcPage.isSendByMe(intent))
			loadNfcPage(intent);
		else if (AboutPage.isSendByMe(intent))
			loadAboutPage();
		else
			super.setIntent(intent);
	}

	@Override
	protected void onPause() {
		super.onPause();
		nfc.onPause();
	}

	@Override
	protected void onResume() {
		super.onResume();
		nfc.onResume();
	}

	@Override
	public void onWindowFocusChanged(boolean hasFocus) {
		if (hasFocus) {
			if (nfc.updateStatus())
				loadDefaultPage();

			// 有些ROM将关闭系统状态下拉面板的BACK事件发给最顶层窗口
			// 这里加入一个延迟避免意外退出
			board.postDelayed(new Runnable() {
				public void run() {
					safeExit = true;
				}
			}, 800);
		} else {
			safeExit = false;
		}
	}
	/**
	 * 跳转到其它activy后的回调
	 */
	@Override
	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		loadDefaultPage();
	}
	/**
	 * 监听nfc事件
	 */
	@Override
	protected void onNewIntent(Intent intent) {
		if (!nfc.readCard(intent, new NfcPage(this)))
			loadDefaultPage();
	}

	public void onSwitch2DefaultPage(View view) {
		if (!isCurrentPage(SPEC.PAGE.DEFAULT))
			loadDefaultPage();
	}

	public void onSwitch2AboutPage(View view) {
		if (!isCurrentPage(SPEC.PAGE.ABOUT))
			loadAboutPage();
	}

	public void onCopyPageContent(View view) {
		toolbar.copyPageContent(getFrontPage());
	}

	public void onSharePageContent(View view) {
		toolbar.sharePageContent(getFrontPage());
	}

	private void loadDefaultPage() {
		toolbar.show(null);

		TextView ta = getBackPage();

		resetTextArea(ta, SPEC.PAGE.DEFAULT, Gravity.CENTER);
		ta.setText(MainPage.getContent(this));

		board.showNext();
	}

	private void loadAboutPage() {
		toolbar.show(R.id.btnBack);

		TextView ta = getBackPage();

		resetTextArea(ta, SPEC.PAGE.ABOUT, Gravity.LEFT);
		ta.setText(AboutPage.getContent(this));

		board.showNext();
	}

	private void loadNfcPage(Intent intent) {
		final CharSequence info = NfcPage.getContent(this, intent);

		TextView ta = getBackPage();

		if (NfcPage.isNormalInfo(intent)) {
			toolbar.show(R.id.btnCopy, R.id.btnShare, R.id.btnReset);
			resetTextArea(ta, SPEC.PAGE.INFO, Gravity.LEFT);
		} else {
			toolbar.show(R.id.btnBack);
			resetTextArea(ta, SPEC.PAGE.INFO, Gravity.CENTER);
		}

		ta.setText(info);

		board.showNext();
	}
	/**
	 * 判断前一页是否是当前页
	 * @param which
	 * @return
	 */
	private boolean isCurrentPage(SPEC.PAGE which) {
		Object obj = getFrontPage().getTag();

		if (obj == null)
			return which.equals(SPEC.PAGE.DEFAULT);

		return which.equals(obj);
	}

	private void resetTextArea(TextView textArea, SPEC.PAGE type, int gravity) {

		((View) textArea.getParent()).scrollTo(0, 0);

		textArea.setTag(type);
		textArea.setGravity(gravity);
	}

	private TextView getFrontPage() {
		return (TextView) ((ViewGroup) board.getCurrentView()).getChildAt(0);
	}

	private TextView getBackPage() {
		return (TextView) ((ViewGroup) board.getNextView()).getChildAt(0);
	}

	private void initViews() {
		board = (ViewSwitcher) findViewById(R.id.switcher);

		Typeface tf = ThisApplication.getFontResource(R.string.font_oem1);
		TextView tv = (TextView) findViewById(R.id.txtAppName);
		tv.setTypeface(tf);

		tf = ThisApplication.getFontResource(R.string.font_oem2);

		tv = getFrontPage();
		tv.setMovementMethod(LinkMovementMethod.getInstance());
		tv.setTypeface(tf);

		tv = getBackPage();
		tv.setMovementMethod(LinkMovementMethod.getInstance());
		tv.setTypeface(tf);

		toolbar = new Toolbar((ViewGroup) findViewById(R.id.toolbar));
	}

	private ViewSwitcher board;
	private Toolbar toolbar;
	private NfcManager nfc;
	private boolean safeExit;
}
