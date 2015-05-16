package com.grabparking.application;

import android.app.Service;
import android.os.Vibrator;

import com.baidu.location.BDLocation;
import com.baidu.location.BDNotifyListener;

//BDNotifyListner实现
public class NotifyLister extends BDNotifyListener{
       public void onNotify(BDLocation mlocation, float distance){
 	  // mVibrator01.vibrate(1000);//振动提醒已到设定位置附近
       }
    }
