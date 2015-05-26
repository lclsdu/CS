package com.grabparking.utils;
import org.json.JSONObject;

import com.grabparking.bean.UserInfoBean;

import android.content.Context;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;
import android.text.TextUtils;


public class MySharedPreferences {
	SharedPreferences prefs;
	Context ctx;
	public MySharedPreferences(Context context){
		prefs = context.getSharedPreferences(Constants.SETTING_PREFERENCE_NAME, Context.MODE_PRIVATE);
		ctx = context;
	}
	
	/**
	 * 是否打开手势密码
	 * 默认为打开，在进入软件的时候需要输入手势密码,手机钱包默认关闭
	 * 如果不打开就算设置了手势密码，进入软件时也不使用手势密码
	 * @return 
	 */
	public Boolean getIsOpenGesture() {
//		if(RequestUrlBuild.IS_NFC)
//			return prefs.getBoolean("isOpenGesture", false);
//		else
			return prefs.getBoolean("isOpenGesture", true);
	}
	public void setIsOpenGesture(Boolean isOpenGesture) {
		Editor edit =prefs.edit();
//		if(RequestUrlBuild.IS_NFC)
//			edit.putBoolean("isOpenGesture", false);
//		else
			edit.putBoolean("isOpenGesture", isOpenGesture);
		edit.commit();
	}
	
	public boolean getSecurityEmail(){
		return prefs.getBoolean("securityEmail", false);
	}
	public void setSecurityEmail(boolean b){
		Editor edit =prefs.edit();
		edit.putBoolean("securityEmail", b);
		edit.commit();
	}
	
	/**
	 * 是否首次进入
	 * @return
	 */
	public Boolean getFirstEnter() {
		return prefs.getBoolean("isFirstEnter", true);
	}
	public void setFirstEnter(Boolean isFirstEnter) {
		Editor edit =prefs.edit();
		edit.putBoolean("isFirstEnter", isFirstEnter);
		edit.commit();
	}
	/**
	 * 是否首次登录
	 * @return
	 */
	public Boolean getFirstLogin() {
		return prefs.getBoolean("isFirstLogin", true);
	}
	public void setFirstLogin(Boolean isFirstLogin) {
		Editor edit =prefs.edit();
		edit.putBoolean("isFirstLogin", isFirstLogin);
		edit.commit();
	}
	/*public Boolean getPromotion() {
		return prefs.getBoolean("promotion", false);
	}
	public void setPromotion(Boolean b) {
		Editor edit =prefs.edit();
		edit.putBoolean("promotion", b);
		edit.commit();
	}
	*/
	/**
	 * 是否按了home键,包括home键和锁屏
	 * @return
	 */
	public Boolean getIsPressHome() {
		return prefs.getBoolean("isPressHome", false);
	}
	public void setIsPressHome(Boolean isPressHome) {
		Editor edit =prefs.edit();
		edit.putBoolean("isPressHome", isPressHome);
		edit.commit();
	}
	
	/**
	 * 是否登录
	 * @return true 登录,false 未登录
	 */
	public boolean getIsLogin() {
		String userNumber = getUserNumber();
		String sessionID = getSessionID();
		String ssoID = getSSOID();
		UserInfoBean bean = getUserInfo();
		boolean boo = false;
		if(!TextUtils.isEmpty(userNumber) && !TextUtils.isEmpty(sessionID) && !TextUtils.isEmpty(ssoID) && bean!=null){
			boo = true;
		}
		return boo;
	}
	
	
	/**
	 * 记录密码验证错误的次数，用于登录成功需要验证密码的情况
	 * @return
	 */
	public long getPassVerifyErrorCount() {
		if((System.currentTimeMillis()-getPassVerifyErrorTime())>(1000*60*30)){
			setPassVerifyErrorCount(0);
			setPassVerifyErrorTime(0);
		}
		return prefs.getLong("passVerifyErrorCount", 0);
	}
	public void setPassVerifyErrorCount(long passVerifyErrorCount) {
		Editor edit =prefs.edit();
		edit.putLong("passVerifyErrorCount", passVerifyErrorCount);
		edit.commit();
	}
	
	/**
	 * 记录密码验证错误的次数达到锁定值时的时间，用于登录成功需要验证密码的并且密码验证错误需要锁定的情况
	 * 一般情况是锁定30分钟(1000*60*30)
	 * @return
	 */
	public long getPassVerifyErrorTime() {
		return prefs.getLong("passVerifyErrorTime", 0);
	}
	public void setPassVerifyErrorTime(long passVerifyErrorTime) {
		Editor edit =prefs.edit();
		edit.putLong("passVerifyErrorTime", passVerifyErrorTime);
		edit.commit();
	}
	
	
	/**
	 * 本机手机号
	 * @return
	 */
	public String getLocalMobile() {
		String mobile = AESUtil.decrypt(ctx, prefs.getString("localMobile", ""));
		return mobile;
	}
	public void setLocalMobile(String localMobile) {
		Editor edit =prefs.edit();
		edit.putString("localMobile", AESUtil.encrypt(ctx, localMobile));
		edit.commit();
	}
	
	/**
	 * 设置退出系统
	 * 注意这里不能清空手机号
	 */
	public void setExitSys(){
		setPass("");
		setUserNumber("");
		setUserInfo(null);
		setSessionID("");
		setSSOID("");
		setLoginState(0);
		
	}
	
	/**
	 * 手机号（用户账号）
	 * @return
	 */
	public String getMobile() {
		String mobile = AESUtil.decrypt(ctx, prefs.getString("mobile", ""));
		return mobile;
	}
	public void setMobile(String mobile) {
		Editor edit =prefs.edit();
		edit.putString("mobile", AESUtil.encrypt(ctx, mobile));
		edit.commit();
	}
	
	/**
	 * 密码
	 * @return
	 */
	public String getPass() {
		String pass = AESUtil.decrypt(ctx, prefs.getString("pass", ""));
		return pass;
	}
	public void setPass(String pass) {
		Editor edit =prefs.edit();
		edit.putString("pass", AESUtil.encrypt(ctx, pass));
		edit.commit();
	}
	
	/**
	 * 用户号
	 * @return
	 */
	public String getUserNumber() {
		String userNumber = AESUtil.decrypt(ctx, prefs.getString("userNumber", ""));
		return userNumber;
	}
	public void setUserNumber(String userNumber) {
		Editor edit =prefs.edit();
		edit.putString("userNumber", AESUtil.encrypt(ctx, userNumber));
		edit.commit();
	}
	
	/**
	 * 用户信息
	 * @return
	 */
	public UserInfoBean getUserInfo() {
		UserInfoBean user = null;
		String userJson = prefs.getString("userInfo", "");
		if(TextUtils.isEmpty(userJson)){
			return user;
		}
		String userInfo = AESUtil.decrypt(ctx, userJson);
		try{
			user = new UserInfoBean();
			JSONObject json = new JSONObject(userInfo);
			user.set_201101(json.isNull("_201101")?"":json.getString("_201101"));
			user.set_201102(json.isNull("_201102")?"":json.getString("_201102"));
			user.set_201103(json.isNull("_201103")?"":json.getString("_201103"));
			user.set_201104(json.isNull("_201104")?"":json.getString("_201104"));
			user.set_201105(json.isNull("_201105")?"":json.getString("_201105"));
			user.set_201106(json.isNull("_201106")?"":json.getString("_201106"));
			user.set_201107(json.isNull("_201107")?"":json.getString("_201107"));
			user.set_201108(json.isNull("_201108")?"":json.getString("_201108"));
			user.set_201109(json.isNull("_201109")?"":json.getString("_201109"));
			user.set_201110(json.isNull("_201110")?"":json.getString("_201110"));
			user.set_201111(json.isNull("_201111")?"":json.getString("_201111"));
			user.set_201112(json.isNull("_201112")?"":json.getString("_201112"));
			user.set_201113(json.isNull("_201113")?"":json.getString("_201113"));
			user.set_201114(json.isNull("_201114")?"":json.getString("_201114"));
			user.set_201115(json.isNull("_201115")?"":json.getString("_201115"));
			user.set_201116(json.isNull("_201116")?"":json.getString("_201116"));
			//3.1
			user.set_201117(json.isNull("_201117")?"":json.getString("_201117"));
			user.set_201118(json.isNull("_201118")?"":json.getString("_201118"));
			user.set_201119(json.isNull("_201119")?"":json.getString("_201119"));
			user.set_201120(json.isNull("_201120")?"":json.getString("_201120"));
			user.set_201121(json.isNull("_201121")?"":json.getString("_201121"));
			
			user.set_301101(json.isNull("_301101")?"":json.getString("_301101"));
			user.set_301102(json.isNull("_301102")?"":json.getString("_301102"));
			user.set_301103(json.isNull("_301103")?"":json.getString("_301103"));
			user.set_301104(json.isNull("_301104")?"":json.getString("_301104"));
			user.set_301105(json.isNull("_301105")?"":json.getString("_301105"));
			user.set_301106(json.isNull("_301106")?"":json.getString("_301106"));
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return user;
	}
	public void setUserInfo(UserInfoBean userInfo) {
		Editor edit =prefs.edit();
		if(userInfo!=null){
			edit.putString("userInfo", AESUtil.encrypt(ctx, userInfo.toJson()));
		}else{
			edit.putString("userInfo", "");
		}
		
		edit.commit();
	}
	
	/**
	 * sessionid
	 * @return
	 */
	public String getSessionID() {
		return prefs.getString("sessionID", "");
	}
	public void setSessionID(String sessionID) {
		Editor edit =prefs.edit();
		edit.putString("sessionID", sessionID);
		edit.commit();
	}
	
	/**
	 * SSOID
	 * @return
	 */
	public String getSSOID() {
		return prefs.getString("SSOID", "");
	}
	public void setSSOID(String ssoid) {
		Editor edit =prefs.edit();
		edit.putString("SSOID", ssoid);
		edit.commit();
	}
	
	
	
	/**
	 * 渠道号
	 * @return
	 */
	public String getSourceID() {
		return prefs.getString("sourceID", "");
	}
	public void setSourceID(String sourceID) {
		Editor edit =prefs.edit();
		edit.putString("sourceID", sourceID);
		edit.commit();
	}
	
	
	
	/**
	 * 获取活动消息打开与否的开关值
	 * @return
	 */
	public Boolean getMsgActState() {
		return prefs.getBoolean("msgActState", true);
	}
	public void setMsgActState(Boolean state) {
		Editor edit =prefs.edit();
		edit.putBoolean("msgActState", state);
		edit.commit();
	}
	/**
	 * 获取活动消息打开与否的开关值
	 * @return
	 */
	public Boolean getMsgBillState() {
		return prefs.getBoolean("msgBillState", true);
	}
	public void setMsgBillState(Boolean state) {
		Editor edit =prefs.edit();
		edit.putBoolean("msgBillState", state);
		edit.commit();
	}
	
	/**
	 * 实名认证
	 */
	public static final String IS_APPROVE = "IS_APPROVE";
	public String getAppRove() {
		return prefs.getString(IS_APPROVE, "");
	}
	public void setAppRove(String savaPwd) {
		Editor edit =prefs.edit();
		edit.putString(IS_APPROVE, savaPwd);
		edit.commit();
	}
	
	
	/**
	 * 手动切换到的省份代码
	 * 默认为北京
	 */
	public static final String gpsCode = "gpsCode";
	public String getGpsCode() {
		return prefs.getString(gpsCode, "131");
	}
	public void setGpsCode(String code) {
		Editor edit =prefs.edit();
		edit.putString(gpsCode, code);
		edit.commit();
	}
	/**
	 * 手动切换位到的省份名称
	 * 默认为北京
	 */
	public static final String gpsName = "gpsName";
	public String getGpsName() {
		return prefs.getString(gpsName, "全国");
	}
	public void setGpsName(String name) {
		Editor edit =prefs.edit();
		edit.putString(gpsName, name);
		edit.commit();
	}
	
	/**
	 * gps定位到的纬度
	 */
	public static final String gpsLati = "gpsLati";
	public String getGpsLati() {
		return prefs.getString(gpsLati, "");
	}
	public void setGpsLati(String lati) {
		Editor edit =prefs.edit();
		edit.putString(gpsLati, lati);
		edit.commit();
	}
	/**
	 * gps定位到的经度
	 */
	public static final String gpsLng = "gpsLng";
	public String getGpsLng() {
		return prefs.getString(gpsLng, "");
	}
	public void setGpsLng(String lng) {
		Editor edit =prefs.edit();
		edit.putString(gpsLng, lng);
		edit.commit();
	}
	
	
	
	
	public static final String LOGIN_PHONE = "LOGIN_PHONE";
	public static final String LOGIN_IDNO = "LOGIN_IDNO";
	public static final String LOGIN_STATUS = "LOGIN_STATUS";
	public static final String CREDIT_STATUS = "CREDIT_STATUS";
	public static final String LOGIN_USERNO = "LOGIN_USERNO";
	
	public String getLoginPhone() {
		return AESUtil.decrypt(ctx,prefs.getString(LOGIN_PHONE, ""));
	}
	public void setLoginPhone(String phone) {
		Editor edit =prefs.edit();
		edit.putString(LOGIN_PHONE,  AESUtil.encrypt(ctx,phone));
		edit.commit();
	}
	
	
	public int getLoginState() {
		return prefs.getInt(LOGIN_STATUS, 0);
	}
	public void setLoginState(int state) {
		Editor edit =prefs.edit();
		edit.putInt(LOGIN_STATUS, state);
		edit.commit();
	}
	/**
	 * 信用支付签约状态
	 * @return
	 */
	
	public int getCreditState() {
		return prefs.getInt(CREDIT_STATUS, 0);
	}
	public void setCreditState(int state) {
		Editor edit =prefs.edit();
		edit.putInt(CREDIT_STATUS, state);
		edit.commit();
	}
	

	public void setCreditCustomerNo(String csNo){
		Editor edit = prefs.edit();
		edit.putString("credit_customer_no",csNo);
		edit.commit();
	}
	public String getCreditCustomerNo(){
		return prefs.getString("credit_customer_no", "");
	}
	
	//  NFC status
	public int getNFCStatus(){
		return prefs.getInt("NFC", 0);
	}
	public void setNFCStatus(int v){
		Editor edit = prefs.edit();
		edit.putInt("NFC",v);
		edit.commit();
	}
}
