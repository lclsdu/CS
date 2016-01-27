package com.nfc.reader;

import java.util.ArrayList;

import android.os.Bundle;
import android.app.Activity;
import android.content.Intent;
import android.support.v4.view.ViewPager;
import android.support.v4.view.ViewPager.OnPageChangeListener;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.View;
import android.view.ViewGroup;
import android.view.Window;
import android.view.WindowManager;
import android.view.ViewGroup.LayoutParams;
import android.widget.Button;
import android.widget.ImageView;

public class GuideActivity extends Activity {
	private ViewPager viewPaper;
	//view page 分页显示的页面
	private ArrayList<View> pageViews;
	private ImageView view;
	//view pages  中的小圆点
	private ImageView[] dots;
	//包裹滑动图片的linerLayout
	private ViewGroup viewPics;
	//包裹滑动小圆点的viewGroup
	private ViewGroup viewPoints;
	//button
	private Button startBtn;
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    	getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN,
				WindowManager.LayoutParams.FLAG_FULLSCREEN);
		requestWindowFeature(Window.FEATURE_NO_TITLE);
        //将要分页显示的图片装入数组中、
        LayoutInflater inflater=getLayoutInflater();
        pageViews=new ArrayList<View>();
        pageViews.add(inflater.inflate(R.layout.guide1, null));
        pageViews.add(inflater.inflate(R.layout.guide2, null));
        pageViews.add(inflater.inflate(R.layout.guide3, null));
        pageViews.add(inflater.inflate(R.layout.guide4, null));
      //创建imageviews数组  小圆点，大小是要显示的图片的数量
        dots = new ImageView[pageViews.size()];
        //从指定的XML文件加载视图
        viewPics = (ViewGroup) inflater.inflate(R.layout.activity_guide, null);
      //实例化小圆点的linearLayout和viewpager
        viewPoints = (ViewGroup) viewPics.findViewById(R.id.viewGroup);
        viewPaper = (ViewPager) viewPics.findViewById(R.id.guidePages);
        //实例化小圆点的viewgroup
        for(int i=0;i<pageViews.size();i++){
        	view=new ImageView(GuideActivity.this);
        	//设置小圆点的参数
        	view.setLayoutParams(new LayoutParams(20,20));
        	view.setPadding(20, 0, 20, 0);
        	dots[i]=view;
        	if(i==0){
        		dots[i].setBackgroundResource(R.drawable.select_on);
        	}else{
        		dots[i].setBackgroundResource(R.drawable.select_off);
        	}
        	
        	viewPoints.addView(dots[i]);
        }
 
        setContentView(viewPics);
        //设置viewpager的适配器和监听事件
        viewPaper.setAdapter(new GuidePageAdapter(pageViews,GuideActivity.this,Button_OnClickListener));
        viewPaper.setOnPageChangeListener(new GuidePageChangeListener());  
    }

    public Button.OnClickListener  Button_OnClickListener = new Button.OnClickListener() {
        public void onClick(View v) {
            //设置已经引导
        	MyApplication.getInstance().getMySharePerferences().setGuided();
            //跳转
            Intent mIntent = new Intent();
            mIntent.setClass(GuideActivity.this, MainActivity.class);
            GuideActivity.this.startActivity(mIntent);
            GuideActivity.this.finish();
        }
    }; 

    
    class GuidePageChangeListener implements OnPageChangeListener{
        @Override
        public void onPageScrollStateChanged(int arg0) {
            // TODO Auto-generated method stub
             
        }
        @Override
        public void onPageScrolled(int arg0, float arg1, int arg2) {
            // TODO Auto-generated method stub
             
        }
        @Override
        public void onPageSelected(int position) {
            // TODO Auto-generated method stub
            for(int i=0;i<dots.length;i++){
            	dots[position].setBackgroundResource(R.drawable.select_on);
                //不是当前选中的page，其小圆点设置为未选中的状态
                if(position !=i){
                	dots[i].setBackgroundResource(R.drawable.select_off);
                }
            }
             
        }
    }
}
