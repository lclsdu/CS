package com.grabparking.function;

import android.content.Context;

import com.baidu.location.BDLocation;
import com.baidu.location.BDLocationListener;
import com.baidu.location.LocationClient;

/**
 * 抢车位基础业务接口
 * @author lcl
 *
 */
public interface IGPManager {
	/**
	* 检查更新
	 */
	public String checkUpdate();
	/**
	 * 意见反馈
	 */
	public boolean feedback(String feed);
}
