package com.grabparking.utils;


import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 正则表达式归集
 * @author Administrator
 *
 */
public class RegExpValidatorUtils {
	/**
	 * 验证邮箱
	 * 
	 * @param 待验证的字符串
	 * @return 如果是符合的字符串,返回 <b>true </b>,否则为 <b>false </b>
	 */
	public static boolean isEmail(String str) {
		String regex = "^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$";
		return match(regex, str);
	}

	/**
	 * 验证IP地址
	 * 
	 * @param 待验证的字符串
	 * @return 如果是符合格式的字符串,返回 <b>true </b>,否则为 <b>false </b>
	 */
	public static boolean isIP(String str) {
		String num = "(25[0-5]|2[0-4]\\d|[0-1]\\d{2}|[1-9]?\\d)";
		String regex = "^" + num + "\\." + num + "\\." + num + "\\." + num + "$";
		return match(regex, str);
	}

	/**
	 * 验证网址Url
	 * 
	 * @param 待验证的字符串
	 * @return 如果是符合格式的字符串,返回 <b>true </b>,否则为 <b>false </b>
	 */
	public static boolean IsUrl(String str) {
		String regex = "http(s)?://([\\w-]+\\.)+[\\w-]+(/[\\w- ./?%&=]*)?";
		return match(regex, str);
	}

	/**
	 * 验证输入邮政编号
	 * 
	 * @param 待验证的字符串
	 * @return 如果是符合格式的字符串,返回 <b>true </b>,否则为 <b>false </b>
	 */
	public static boolean IsPostalcode(String str) {
		String regex = "^\\d{6}$";
		return match(regex, str);
	}

	/**
	 * 验证输入手机号码
	 * 
	 * @param 待验证的字符串
	 * @return 如果是符合格式的字符串,返回 <b>true </b>,否则为 <b>false </b>
	 */
	public static boolean IsMobile(String str) {
		String regex = "^[1]+[3,4,5,6,7,8]+\\d{9}$";
		return match(regex, str);
	}

	/**
	 * 验证电话号码
	 * 
	 * @param 待验证的字符串
	 * @return 如果是符合格式的字符串,返回 <b>true </b>,否则为 <b>false </b>
	 */
	public static boolean IsTelephone(String str) {
		String regex = "^(\\d{3,4}-)?\\d{6,8}$";
		return match(regex, str);
	}
	
	/**
	 * 验证输入身份证号
	 * 
	 * @param 待验证的字符串
	 * @return 如果是符合格式的字符串,返回 <b>true </b>,否则为 <b>false </b>
	 */
	public static boolean IsIDcard(String str) {
		String regex = "(^\\d{18}$)|(^\\d{15}$)";
		return match(regex, str);
	}

	public static boolean IDCardValidate(String IDStr)  {   
        String errorInfo = "";// 记录错误信息   
        String[] ValCodeArr = { "1", "0", "x", "9", "8", "7", "6", "5", "4", "3", "2" };   
        String[] Wi = { "7", "9", "10", "5", "8", "4", "2", "1", "6", "3", "7","9", "10", "5", "8", "4", "2" };   
        String Ai = "";   
        // ================ 号码的长度 15位或18位 ================   
        if (IDStr.length() != 15 && IDStr.length() != 18) {   
            errorInfo = "身份证号码长度应该为15位或18位。";   
        	return false;
        }   
  
        // ================ 数字 除最后一位都为数字 ================   
        if (IDStr.length() == 18) {   
            Ai = IDStr.substring(0, 17);   
        } else if (IDStr.length() == 15) {   
            Ai = IDStr.substring(0, 6) + "19" + IDStr.substring(6, 15);   
        }   
        if (IsNumber(Ai) == false) {   
            errorInfo = "身份证15位号码都应为数字 ; 18位号码除最后一位外，都应为数字。";   
           // return errorInfo;   
        	return false;
        }   
        return true;
	}
	
	/**
	 * 检查真实姓名
	 * @param realName
	 * @return
	 */
	public static String getCheckRealName(String realName) {
		String errorInfo = "";
		if(realName.length() < 2 || realName.length() > 50 ){
			errorInfo = "1";//请输入正确的真实姓名
		}else{
			Pattern pattern = Pattern.compile("[\u4e00-\u9fa5]");
			Matcher matcher = pattern.matcher(realName);
			if (matcher.find()) {
				// "有汉字  ";
			}
			pattern = Pattern.compile("[a-zA-Z]");
			matcher = pattern.matcher(realName);
			if (matcher.find()) {
			    // "有字母  ";
			}
			pattern = Pattern.compile("[0-9]");
			matcher = pattern.matcher(realName);
			if (matcher.find()) {
				errorInfo = "2";//真实姓名不能包含数字
			}else{
				 // "有标点符号  ";
				pattern = Pattern.compile("\\p{Punct}");
				matcher = pattern.matcher(realName);
				if (matcher.find()) {
					errorInfo = "3";//真实姓名不能包含标点符号
				}
			}
		}
		return errorInfo;
	}
	
	/**
	 * 验证输入两位小数
	 * 
	 * @param 待验证的字符串
	 * @return 如果是符合格式的字符串,返回 <b>true </b>,否则为 <b>false </b>
	 */
	public static boolean IsDecimal2(String str) {
		String regex = "^[0-9]+(.[0-9]{2})?$";
		return match(regex, str);
	}

	/**
	 * 验证是否为整数
	 * 
	 * @param 待验证的字符串
	 * @return 如果是符合格式的字符串,返回 <b>true </b>,否则为 <b>false </b>
	 */
	public static boolean IsNumber(String str) {
		String regex = "^[0-9]*$";
		return match(regex, str);
	}
	
	/**
	 * 验证是否为数字（可带小数点）
	 * @param str
	 * @return
	 */
	public static boolean IsDecimal(String str) {
		if ( "0.0".equals(str) || "0".equals(str)) {
			return false;
		}
        String regex = "\\d+(\\.\\d+)?";
        return match(regex, str);
   }
	

	/**
	 * 验证非零的正整数
	 * 
	 * @param 待验证的字符串
	 * @return 如果是符合格式的字符串,返回 <b>true </b>,否则为 <b>false </b>
	 */
	public static boolean IsIntNumber(String str) {
		String regex = "^\\+?[1-9][0-9]*$";
		return match(regex, str);
	}

	/**
	 * 验证大写字母
	 * 
	 * @param 待验证的字符串
	 * @return 如果是符合格式的字符串,返回 <b>true </b>,否则为 <b>false </b>
	 */
	public static boolean IsUpChar(String str) {
		String regex = "^[A-Z]+$";
		return match(regex, str);
	}

	/**
	 * 验证小写字母
	 * 
	 * @param 待验证的字符串
	 * @return 如果是符合格式的字符串,返回 <b>true </b>,否则为 <b>false </b>
	 */
	public static boolean IsLowChar(String str) {
		String regex = "^[a-z]+$";
		return match(regex, str);
	}

	/**
	 * 验证验证输入字母
	 * 
	 * @param 待验证的字符串
	 * @return 如果是符合格式的字符串,返回 <b>true </b>,否则为 <b>false </b>
	 */
	public static boolean IsLetter(String str) {
		String regex = "^[A-Za-z]+$";
		return match(regex, str);
	}

	/**
	 * 验证验证输入汉字
	 * 
	 * @param 待验证的字符串
	 * @return 如果是符合格式的字符串,返回 <b>true </b>,否则为 <b>false </b>
	 */
	public static boolean IsChinese(String str) {
		String regex = "^[\u4e00-\u9fa5],{0,}$";
		return match(regex, str);
	}

	/**
	 * 验证输入密码条件(字符与数据同时出现)
	 * 
	 * @param 待验证的字符串
	 * @return 如果是符合格式的字符串,返回 <b>true </b>,否则为 <b>false </b>
	 */
	public static int IsPassword(String str) {
		int result = 0;
		boolean boo1 = find("[A-Za-z]+?", str);
		if(boo1){
			result+=1;
		}
		boolean boo2 = find("[0-9]+?", str);
		if(boo2){
			result+=1;
		}
		boolean boo3 = find("[`~!@#$%^]+?", str);
		if(boo3){
			result+=1;
		}
		return result;
	}

	/**
	 * 用于判断首字母是否是符号
	 * @param str
	 * @return
	 */
	public static boolean IsSymbol(String str){
		return find("[`~!@#$%^]+?", str);
	}
	
	/**
	 * 验证密码强度
	 * @param str
	 * @param minLength 密码最小位数的限制，6支付密码，8登陆密码，位数不够都是弱
	 * @return 0 未输入或者初始化，1弱，2中，3强
	 */
	public static int passLevel(String str, int minLength) {
		if(str==null || str.equals("")){
			return 0;
		}
		if(str.length()<minLength){
			return 1;
		}
		
		boolean boo1 = find("[A-Z]+?", str);
		boolean boo2 = find("[a-z]+?", str);
		boolean boo3 = find("[0-9]+?", str);
		boolean boo4 = find("[`~!@#$%^]+?", str);
		
		int result = 0;
		if(boo1||boo2){
			result+=1;
		}
		if(boo3){
			result+=1;
		}
		if(boo4){
			result+=1;
		}
		if(result<=1){
			return 1;
		}
		
		if((boo1&&boo2&&boo3&&boo4) 
			|| (boo1&&boo2&&boo3) 
			|| (boo1&&boo3&&boo4) 
			|| (boo2&&boo3&&boo4)){
			return 3;
		}
		
		return 2;
	}
	
	/**
	 * 获取根据正则表达式分隔后的手机号码
	 * @param s
	 * @return
	 */
	public static String getRuleText(String s){
		String[] found = null;
		Pattern p = Pattern.compile("(.{3}|.{0,3})(.{4}|.{0,4})(.{4}|.{0,4})");
		if(p!=null){
			Matcher m = p.matcher(s);
	    	if (m.matches()) {
	    		int len = m.groupCount();
	    		found = new String[len];
	    		for (int i = 1; i <= len; i++) {
	    			found[i - 1] = m.group(i);
	    		}
	    	}
		}
		if(found!=null && found.length>0){
			String result = "";
    		for(int i=0;i<found.length;i++){
    			if(!found[i].equals("")){
    				result+=found[i]+" ";
    			}
        	}
    		s=result.trim();
		}
		return s;
	}
	
	/**
	 * @param regex
	 *            正则表达式字符串
	 * @param str
	 *            要匹配的字符串
	 * @return 如果str 符合 regex的正则表达式格式,返回true, 否则返回 false;
	 */
	private static boolean match(String regex, String str) {
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(str);
		return matcher.matches();
	}
	
	/**
	 * 查询字符串里是否包含正则规定的支付
	 * @param regex
	 * @param str
	 * @return
	 */
	private static boolean find(String regex, String str) {
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(str);
		return matcher.find();
	}
	
	public static void main(String[] args) throws Exception {
		String str = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ`~!@#$%^";
		System.out.println(find("[A-Za-z]+?", str));
		System.out.println(find("[0-9]+?", str));
		System.out.println(find("[`~!@#$%^]+?", str));
		System.out.println(IsPassword(str));
		System.out.println(IsSymbol(str.substring(0,1)));
	}

}
