package com.nfc.reader;

import java.util.Collection;

import android.app.Activity;
import android.content.Intent;
import android.graphics.Typeface;
import android.os.Bundle;
import android.text.method.LinkMovementMethod;
import android.util.Log;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import android.widget.ViewSwitcher;

import com.nfc.reader.bean.CardApplications;
import com.nfc.reader.bean.CityCode;
import com.nfc.reader.ui.AboutPageView;
import com.nfc.reader.ui.MainPageView;
import com.nfc.reader.ui.NfcPageView;

public class MainActivity extends Activity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);
		//初始化页面控件
		initViews();
		//实例化nfc管理类
		nfc = new NfcManager(this);
		//进行nfc事件监听   通过getIntent取回结果数据
		onNewIntent(getIntent()); 
	}
	/**
	 * back 键后的回调
	 * 如果在about页   重新加载初始页面  否则退出
	 */
	@Override
	public void onBackPressed() {
		if (isCurrentPage(SpecConf.PAGE.ABOUT))
			loadDefaultPage();
		else if (safeExit)
			super.onBackPressed();
	}
	/**
	 * Change the intent returned by getIntent. 
	 * This holds a reference to the given intent; it does not copy it. 
	 * Often used in conjunction with onNewIntent. 
	 * onNewIntent 事件后最终获取数据的回调方法
	 */
	@Override
	public void setIntent(Intent intent) {
		if (NfcPageView.isSendByMe(intent))
			loadNfcPage(intent);
//		else if (AboutPage.isSendByMe(intent)) 注释的这部分代码不可能走到的 读卡的操作触发不了about页面
//			loadAboutPage();
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
		if (!nfc.readCard(intent, new NfcPageView(this)))
			loadDefaultPage();
	}

	public void onSwitch2DefaultPage(View view) {
		if (!isCurrentPage(SpecConf.PAGE.DEFAULT))
			loadDefaultPage();
	}
	/**
	 * 跳转到关于页面
	 * @param view
	 */
	public void onSwitch2AboutPage(View view) {
		if (!isCurrentPage(SpecConf.PAGE.ABOUT))
			loadAboutPage();
	}

	private void loadDefaultPage() {

		TextView ta = getBackPage();

		resetTextArea(ta, SpecConf.PAGE.DEFAULT, Gravity.CENTER);
		ta.setText(MainPageView.getContent(this));

		board.showNext();
	}

	private void loadAboutPage() {

		TextView ta = getBackPage();

		resetTextArea(ta, SpecConf.PAGE.ABOUT, Gravity.LEFT);
		ta.setText(AboutPageView.getContent(this));

		board.showNext();
	}

	private void loadNfcPage(Intent intent) {
		final CharSequence info = NfcPageView.getContent(this, intent);
		//现获取要切换的下一个view
		TextView ta = getBackPage();
		
		if (NfcPageView.isNormalInfo(intent)) {
			//toolbar.show(R.id.btnCopy, R.id.btnShare, R.id.btnReset); 注释
			resetTextArea(ta, SpecConf.PAGE.INFO, Gravity.LEFT);
		} else {
			//toolbar.show(R.id.btnBack);
			resetTextArea(ta, SpecConf.PAGE.INFO, Gravity.CENTER);
		}

		ta.setText(info);
		System.out.println("cacaca:"+info);
		final Collection<CardApplications> apps =NfcPageView.getDATAContent(this, intent);
		if(apps.isEmpty()){
			MyApplication.showMessage(1, "app is null");
		}
		for(CardApplications app:apps){
			if(app!=null&&app.getProperty(SpecConf.PROP.BALANCE)!=null){
			System.out.println("***************data balance**********:"+app.getProperty(SpecConf.PROP.BALANCE).toString());
		}
		}
		//调用showNext进行上面获取页面的显示
		board.showNext();
	}
	/**
	 * 判断前一页是否是当前页
	 * @param which
	 * @return
	 */
	private boolean isCurrentPage(SpecConf.PAGE which) {
		Object obj = getFrontPage().getTag();

		if (obj == null)
			return which.equals(SpecConf.PAGE.DEFAULT);

		return which.equals(obj);
	}

	private void resetTextArea(TextView textArea, SpecConf.PAGE type, int gravity) {

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
		/**
		 * ViewSwitcher 代表了视图切换组件, 本身继承了FrameLayout ,可以将多个View叠在一起 ,
		 * 每次只显示一个组件.当程序控制从一个View切换到另个View时,ViewSwitcher 支持指定动画效果.
		 */
		board = (ViewSwitcher) findViewById(R.id.switcher);
		TextView tv = (TextView) findViewById(R.id.txtAppName);
		
		tv = getFrontPage();
		//使超链接<a href>起作用
		tv.setMovementMethod(LinkMovementMethod.getInstance());
		
		//设置后一页的字体和响应
		tv = getBackPage();
		//使超链接<a href>起作用
		tv.setMovementMethod(LinkMovementMethod.getInstance());

	}

	private ViewSwitcher board;
	private NfcManager nfc;
	private boolean safeExit;
}
