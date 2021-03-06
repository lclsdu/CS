package com.nfc.reader;

import java.util.List;

import android.content.Context;
import android.support.v4.view.PagerAdapter;
import android.support.v4.view.ViewPager;
import android.view.View;
import android.widget.Button;

public class GuidePageAdapter extends PagerAdapter{
	private List<View> views;
	private Context context;
	private Button.OnClickListener listener;
	public GuidePageAdapter(List<View> views,Context context,Button.OnClickListener l) {
			this.views=views;
			this.context=context;
			listener=l;
	}
	@Override
	public void destroyItem(View container, int position, Object object) {
		((ViewPager)container).removeView(views.get(position));
	}
	/**
	 * 实例化一个view
	 */
	@Override
	public Object instantiateItem(View container, int position) {
		((ViewPager)container).addView(views.get(position));
		if(position==3){
			 Button btn = (Button) container.findViewById(R.id.startMain);  
             btn.setOnClickListener(listener);  
		}
		return views.get(position);
	}
	@Override
	public int getCount() {
		return views.size();
	}

	@Override
	public boolean isViewFromObject(View arg0, Object arg1) {
		// TODO Auto-generated method stub
		return arg0==arg1;
	}

}
