package com.grabparking.function;
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
	/**
	 * 
	 */
}
