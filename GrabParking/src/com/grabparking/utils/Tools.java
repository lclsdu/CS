package com.grabparking.utils;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.text.DecimalFormat;
import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import android.text.TextUtils;


/**
 * 通用方法定义
 * @author Administrator
 *
 */
public class Tools {
	private static final String TAG = Tools.class.getSimpleName();
	
	/**
     * 将字符转换成int
     * @param strNumber
     * @return
     */
    public static int convertStringToInt(String strNumber) {
        int intNumber = 0;

        if (strNumber != null && !strNumber.equals("")) {
            try {
                intNumber = new Integer(strNumber).intValue();
            } catch (NumberFormatException e) {
            	MyLog.e(TAG,"NumberFormatException:>>" + e.toString() + "<<str>>" + strNumber);
            }
            return intNumber;
        } else {
            return 0;
        }
    }
    
    /**
     * 将字符转换成long
     * @param strNumber
     * @return
     */
    public static long convertStringToLong(String strNumber) {
        long lNumber = 0;

        if (strNumber != null && !strNumber.equals("")) {
            try {
                lNumber = Long.parseLong(strNumber);
            } catch (NumberFormatException e) {
                lNumber = 0;
                MyLog.e(TAG,"NumberFormatException:>>" + e.toString() + "<<str>>" + strNumber);
            }
            return lNumber;
        } else {
            return 0;
        }
    }
    
    /**
     * 将字符转换成double
     * @param strNumber
     * @return
     */
    public static double convertStringToDouble(String strNumber) {
        double dNumber = 0;

        if (strNumber != null && !strNumber.equals("")) {
            try {
                dNumber = Double.parseDouble(strNumber);
            } catch (NumberFormatException e) {
                dNumber = 0;
                MyLog.e(TAG,"NumberFormatException:>>" + e.toString() + "<<str>>" + strNumber);
                throw e;
            }
            return dNumber;
        } else {
            return 0;
        }
    }
    
    /**
     * 将object转换成为字符
     * @param o
     * @return
     */
    public static String convertObject(Object o) {
        String s = "";
        if (o == null) {
            return s;
        }else {
        	return o.toString();
        }
    }
    
    /**
	 * 输入流转成字符串
	 * 
	 * @param is
	 * @return
	 */
	public static String InputStreamToString(InputStream is) {
		if (is == null) {
			return null;
		}
		StringBuilder result = new StringBuilder();
		try {
			BufferedReader reader = new BufferedReader(new InputStreamReader(is,"UTF-8"));
			String line = null;
			while ((line = reader.readLine()) != null) {
				result.append(line + "\n");
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			try {
				is.close();
			} catch (IOException ex) {
				ex.printStackTrace();
			}
		}
		return result.toString();
	}

	/**
	 * 字符串转成输入流
	 * 
	 * @param str
	 * @return
	 */
	public static InputStream StringToInputStream(String str) {
		if (str == null) {
			return null;
		}
		ByteArrayInputStream result = null;
		try {
			result = new ByteArrayInputStream(str.getBytes());
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return result;
	}
	
    /**
     * 得到6位随机数
     * @return
     * @throws Exception
     */
    public static String getRandomID() {
        Random ran = new Random();
        int rtn = ran.nextInt(1000000);
        if (rtn < 10000) {
            rtn = rtn * 10;
        }
        return Integer.toString(rtn);
    }
    
    /**
     * 得到4位随机数
     * @return
     * @throws Exception
     */
    public static String get4RandomID() {
    	Random ran = new Random();
        int rtn = ran.nextInt(10000);
        if (rtn < 1000) {
            rtn = rtn * 10;
        }
        return Integer.toString(rtn);
    }
    
	/**
	 * 分转化为元
	 * 
	 * @param fen
	 * @return
	 */
	public static String getYuanByFen(String fen) {
		Double b = Double.parseDouble(fen) * 0.010;
		DecimalFormat df = new DecimalFormat("#0.00");
		return df.format(b);
	}

	/**
	 * 元转化为分
	 * 
	 * @param yuan
	 * @return
	 */
	public static String getFenByYuan(String yuan) {
		if(TextUtils.isEmpty(yuan)){
			yuan = "0";
		}
		BigDecimal b1 = new BigDecimal(yuan);   
		BigDecimal b2 = new BigDecimal(100); 
		String fen = b1.multiply(b2).toString();
		
		try{
			if(!fen.contains("E")){
				fen=fen.substring(0,fen.lastIndexOf("."));
			}
		}catch(Exception e){
			
		}
		return fen;
	}
	
	public static String encode(String value) throws Exception{     
        return URLEncoder.encode(value, "utf-8");     
    }  
	 
	
	
	
	/**
	 * 格式化数字，保留2位小数
	 * @param s
	 * @return
	 */
	public static String getDecimal2Bit(Double s){
		DecimalFormat df = new DecimalFormat("##.00");
		String amount = df.format(s);
		if(s<1){	//小于补充0
			amount = "0" + amount;
		}
		return amount;
	}
	
	/**
	 * 获取两位小数，如果传入为三位小数，截掉后只保留2为小数
	 * @param s
	 * @return
	 */
	public static int getOverDecimal2(String s){
		int over = 0;
		if(s!=null && !"".equals(s)){
			int position = s.indexOf(".");
			if(position!=-1){
				int decimalLength = s.length()-position;
				if(decimalLength>3){
					over = 1;
				}
			}
			int num = getCharNum(s,'.');
			if(num>1){
				over = 2;
			}
		}
		return over;
	}
	
	private static int getCharNum(String s,char c){
		char[] chars = s.toCharArray();
		int num = 0;
		for(int i = 0; i < chars.length; i++){
		    if(c == chars[i]){
		       num++;
		    }
		} 
		return num;
	}
	
	/**
	 * 按字节获得字符串长度
	 * 
	 * @param s字符串
	 * @return
	 */
	public static int getWordCount(String s) {
		s = s.replaceAll("[^\\x00-\\xff]", "**");
		int length = s.length();
		return length;
	}
	public static boolean isSpecialRight(String str) {
		Pattern pattern = Pattern.compile("^[A-Za-z0-9`~!@#$%^]+$");
		Matcher matcher = pattern.matcher(str);
		return matcher.matches();
	}
	/**
	 * 删除字符串中的空格
	 * 
	 * @param oriStr
	 * @return
	 */
	public static String deleteSpace(String oriStr) {
		String[] fragmentStr = oriStr.split(" ");
		if (fragmentStr.length > 1) {
			StringBuffer fullSb = new StringBuffer();
			for (int i = 0; i < fragmentStr.length; i++) {
				fullSb.append(fragmentStr[i]);
			}
			oriStr = fullSb.toString();
		}
		return oriStr;
	}
	
	public static boolean isRealNameWord(String str) {
		if (str==null || str.equals("")) {
			return true;
		}
		String regex = "^[A-Za-z\u4e00-\u9fa5]+$";
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(str);
		return matcher.matches();
	}
}
