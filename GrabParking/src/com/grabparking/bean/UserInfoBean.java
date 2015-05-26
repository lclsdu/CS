package com.grabparking.bean;

import org.json.JSONException;
import org.json.JSONObject;

public class UserInfoBean {
	private String _201101; //用户号
	private String _201102; //真实姓名
	private String _201103; //用户状态:0-预开户,1-正常状态,8-待销户状态,9-销户状态
	private String _201104; //手机号
	private String _201105; //邮箱
	private String _201106; //个性登录名
	private String _201107; //实名级别: 3 非实名 2 弱实名  1 强实名,4实名审核中
	private String _201108; //注册状态;0: 未注册 1：已注册
	private String _201109; //sessionid
	private String _201110; //ssoId，用来报活
	private String _201111; //身份证号
	private String _201112; //加密串，返回给客户端请客户端储存起来，以后每次调用后台的时候都需要将此串放到cookie中传递给后台。
	private String _201113; //是否开通电子现金账户 0 未开通，1开通
	private String _201114; //卡片应用序列号
	private String _201115; //开户时间,格式：yyyymmddhh24miss
	private String _201116; //电子现金账户状态,状态:1-正常,2-锁定,3-挂失,8-待销户,9-销户
	//3.1
	private String _201117; //是否支持开通信用支付 0不支持，1支持(3.1是否有支付密码)
	private String _201118; //密保
	private String _201119; //安全等级
	
	private String _201120;//101，    102，  101，102 201120
	
	private String _201121;//email
	
	public String get_201121() {
		return _201121;
	}
	public void set_201121(String _201121) {
		this._201121 = _201121;
	}

	private String _301101;//登陆等级
	private String _301102;//密保问题
	private String _301103;//密保邮件
	private String _301104;//实名状态
	private String _301105;//支付密码
	private String _301106 = "";//安全级
	private String _301107 = ""; //密保答案安全级
	
	public String get_301107() {
		return _301107;
	}
	public void set_301107(String _301107) {
		this._301107 = _301107;
	}
	public String get_301106() {
		return _301106;
	}
	public void set_301106(String _301106) {
		this._301106 = _301106;
	}
	public String get_201120() {
		return _201120;
	}
	public void set_201120(String _201120) {
		this._201120 = _201120;
	}
	public String get_301101() {
		return _301101;
	}
	public void set_301101(String _301101) {
		this._301101 = _301101;
	}
	public String get_301102() {
		return _301102;
	}
	public void set_301102(String _301102) {
		this._301102 = _301102;
	}
	public String get_301103() {
		return _301103;
	}
	public void set_301103(String _301103) {
		this._301103 = _301103;
	}
	public String get_301104() {
		return _301104;
	}
	public void set_301104(String _301104) {
		this._301104 = _301104;
	}
	public String get_301105() {
		return _301105;
	}
	public void set_301105(String _301105) {
		this._301105 = _301105;
	}
	public String get_201118() {
		return _201118;
	}
	public void set_201118(String _201118) {
		this._201118 = _201118;
	}
	public String get_201119() {
		return _201119;
	}
	public void set_201119(String _201119) {
		this._201119 = _201119;
	}

	
	
	public String get_201101() {
		return _201101;
	}
	public void set_201101(String _201101) {
		this._201101 = _201101;
	}
	public String get_201102() {
		return _201102;
	}
	public void set_201102(String _201102) {
		this._201102 = _201102;
	}
	public String get_201103() {
		return _201103;
	}
	public void set_201103(String _201103) {
		this._201103 = _201103;
	}
	public String get_201104() {
		return _201104;
	}
	public void set_201104(String _201104) {
		this._201104 = _201104;
	}
	public String get_201105() {
		return _201105;
	}
	public void set_201105(String _201105) {
		this._201105 = _201105;
	}
	public String get_201106() {
		return _201106;
	}
	public void set_201106(String _201106) {
		this._201106 = _201106;
	}
	public String get_201107() {
		return _201107;
	}
	public void set_201107(String _201107) {
		this._201107 = _201107;
	}
	public String get_201108() {
		return _201108;
	}
	public void set_201108(String _201108) {
		this._201108 = _201108;
	}
	public String get_201109() {
		return _201109;
	}
	public void set_201109(String _201109) {
		this._201109 = _201109;
	}
	public String get_201110() {
		return _201110;
	}
	public void set_201110(String _201110) {
		this._201110 = _201110;
	}
	public String get_201111() {
		return _201111;
	}
	public void set_201111(String _201111) {
		this._201111 = _201111;
	}
	public String get_201112() {
		return _201112;
	}
	public void set_201112(String _201112) {
		this._201112 = _201112;
	}
	public String get_201113() {
		return _201113;
	}
	public void set_201113(String _201113) {
		this._201113 = _201113;
	}
	public String get_201114() {
		return _201114;
	}
	public void set_201114(String _201114) {
		this._201114 = _201114;
	}
	public String get_201115() {
		return _201115;
	}
	public void set_201115(String _201115) {
		this._201115 = _201115;
	}
	public String get_201116() {
		return _201116;
	}
	public void set_201116(String _201116) {
		this._201116 = _201116;
	}
	public String get_201117() {
		return _201117;
	}
	public void set_201117(String _201117) {
		this._201117 = _201117;
	}
	
	/**
	 * 将用户信息转换为json格式的字符串，方便在本地存储
	 * @return
	 */
	public String toJson(){
		JSONObject json = new JSONObject();
		try {
			json.put("_201101", _201101);
			json.put("_201102", _201102);
			json.put("_201103", _201103);
			json.put("_201104", _201104);
			json.put("_201105", _201105);
			json.put("_201106", _201106);
			json.put("_201107", _201107);
			json.put("_201108", _201108);
			json.put("_201109", _201109);
			json.put("_201110", _201110);
			json.put("_201111", _201111);
			json.put("_201112", _201112);
			json.put("_201113", _201113);
			json.put("_201114", _201114);
			json.put("_201115", _201115);
			json.put("_201116", _201116);
			json.put("_201117", _201117);
			json.put("_201118", _201118);
			json.put("_201119", _201119);
			json.put("_201120", _201120);
			json.put("_201121", _201121);
			json.put("_301101", _301101);
			json.put("_301102", _301102);
			json.put("_301103", _301103);
			json.put("_301104", _301104);
			json.put("_301105", _301105);
			json.put("_301106", _301106);
			json.put("_301107", _301107);
		} catch (JSONException e) {
			e.printStackTrace();
		}
		return json.toString();
	}
}
