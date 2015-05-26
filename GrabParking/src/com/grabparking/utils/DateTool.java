package com.grabparking.utils;

import java.util.Date;
import java.util.Calendar;
import java.text.SimpleDateFormat;
import java.text.ParseException;

/**
 * 日期和时间处理
 * @author Administrator
 *
 */
public class DateTool {
	public static final String TAG = DateTool.class.getName();

	public DateTool() {

    }

    /**
     * 将字符串转换成为date
     * @param Patten
     * @param str
     * @return
     */
	public static Date strToDate(String Patten, String str) {
        Date date = null;
        try {
        	SimpleDateFormat format = null;
            format = new SimpleDateFormat(Patten);
            date = format.parse(str);
        } catch (ParseException e) {
            MyLog.e(TAG,"strToDate ParseException::>>" + e.toString());
        } catch (Exception e) {
            MyLog.e(TAG,"strToDate Exception::>>" + e.toString());
        }
        return date;
    }

    /**
     * 将时间转换成为字符串
     * @param Patten
     * @param date
     * @return
     */
    public static String dateToStr(String Patten, Date date) {
        String str = null;
        try {
        	SimpleDateFormat format = null;
            format = new SimpleDateFormat(Patten);
            str = format.format(date);
        } catch (Exception e) {
            MyLog.e(TAG,"dateToStr::>>" + e.toString());
        }
        return str;
    }

    /**
     * 得到当前时间，以年为单位,格式如[yyyy]
     * @return
     */
    public static String getCurrentYear() {
        Date now = new Date();
        SimpleDateFormat df = new SimpleDateFormat("yyyy");
        String strDate = df.format(now);
        return strDate;
    }

    /**
     * 得到当前时间，以月为单位,格式如[yyyy-MM]
     * @return
     */
    public static String getCurrentMonth() {
        Date now = new Date();
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM");
        String strDate = df.format(now);
        return strDate;
    }

    /**
     * 得到当前日期，以天为单位,格式如[yyyy-MM-dd]
     * @return
     */
    public static String getCurrentDay() {
    	Date now = new Date();
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        String strDate = df.format(now);
        return strDate;
    }

    /**
     * 得到当前日期，以天为单位,格式如[yyyyMMdd]
     * @return
     */
    public static String getCurrentDay2() {
    	Date now = new Date();
        SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
        String strDate = df.format(now);
        return strDate;
    }
    
    /**
     * 得到当前日期，以天为单位,格式如[MM-dd]
     * @return
     */
    public static String getCurrentDay3() {
    	Date now = new Date();
        SimpleDateFormat df = new SimpleDateFormat("MM-dd");
        String strDate = df.format(now);
        return strDate;
    }
    
    /**
     * 得到当前时间，以小时为单位,格式如[yyyy-MM-dd HH]
     * @return
     */
    public static String getCurrentHours() {
    	Date now = new Date();
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH");
        String strDate = df.format(now);
        MyLog.e(TAG,"strDate=" + strDate);
        return strDate;
    }

    /**
     * 得到当前时间，格式如[yyyy-MM-dd HH:mm:ss]
     * @return
     */
    public static String getCurAllTime() {
    	Date now = new Date();
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String strDate = df.format(now);
        MyLog.e(TAG,"strDate=" + strDate);
        return strDate;
    }

    /**
     * 得到当前时间，格式如[yyyyMMddHHmmss]
     * @return
     */
    public static String getCurAllTime2() {
    	Date now = new Date();
        SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
        String strDate = df.format(now);
        MyLog.e(TAG,"strDate=" + strDate);
        return strDate;
    }
    
    /**
     * 得到当前时间
     * @return
     */
    public static String getCurrentTime() {
    	Date now = new Date();
        SimpleDateFormat df = new SimpleDateFormat("HH:mm:ss");
        String strDate = df.format(now);
        return strDate;
    }

    /**
     * 当前日期加减天数，days为正表示加days天，为负表示减days天
     * @param days
     * @return
     * @throws Exception
     */
    public static String convertAddDay(int days){
        String str = getCurrentDay();
        return convertAddDay(str, days);
    }
    
    /**
     * 某个日期加减月份
     * @param date 指定的日期
     * @param month 月份，为正表示加，为负表示减
     * @return
     * @throws Exception
     */
    public static String convertAddMonth(String date,int month){
        Date dt = strToDate("yyyy-MM-dd", date);

        Calendar current = Calendar.getInstance();
        current.setTime(dt);
        current.add(Calendar.MONTH, month);
        Date dt1 = current.getTime();

        return dateToStr("yyyy-MM-dd", dt1);
    }
    public static String convertAddMonth2(String date,int month){
        Date dt = strToDate("yyyyMMdd", date);

        Calendar current = Calendar.getInstance();
        current.setTime(dt);
        current.add(Calendar.MONTH, month);
        Date dt1 = current.getTime();

        return dateToStr("yyyyMMdd", dt1);
    }
    
    /**
     * 指定日期加上指定天数
     * @param date
     * @param days
     * @return
     * @throws Exception
     */
    public static String convertAddDay(String date,int days){
        Date dt = strToDate("yyyy-MM-dd", date);

        Calendar current = Calendar.getInstance();
        current.setTime(dt);
        current.add(Calendar.DATE, days);
        Date dt1 = current.getTime();

        return dateToStr("yyyy-MM-dd", dt1);
    }
    
    /**
     * 当前时间加减小时，hours为正表示加hours小时，为负表示减hours小时
     * @param hours
     * @return
     * @throws Exception
     */
    public static String convertAddHours(int hours) throws Exception {
        String str = getCurrentHours();
        Date dt = strToDate("yyyy-MM-dd HH", str);

        Calendar current = Calendar.getInstance();
        current.setTime(dt);
        current.add(Calendar.HOUR, hours);
        Date dt1 = current.getTime();

        return dateToStr("yyyy-MM-dd HH", dt1);
    }

    /**
     * 返回以毫秒为单位的当前时间
     * @return
     * @throws Exception
     */
    public static long currentTimeMillis() throws Exception{
        return System.currentTimeMillis();
    }

    /**
	 * 计算两个时间之间的差值,单位:毫秒
	 * @param str1date 第一个时间
	 * @param strdate2 第二个时间
	 * @param Patten 是个格式化参数
	 * @return
	 * @throws Exception
	 */
	public static double dateSubtraction(String strdate1,String strdate2,String Patten) throws Exception{
		Date date1 = strToDate(Patten,strdate1);
		Date date2 = strToDate(Patten,strdate2);
		long diff =  date2.getTime()-date1.getTime(); 
		return diff;
	}
	
    /**
     * 将毫秒转化为时间格式
     * @param mill
     * @return
     */
    public static String convertMillDateToString(long mill){
    	Date date = new Date(mill);
    	SimpleDateFormat sfd = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	return sfd.format(date);
    }
    
    /**
     * 将秒数转换为可辨识的日期格式
     * @param second
     * @return
     */
    public static String[] convertDurationToString(long second){
    	String[] ds = new String[4];
    	
    	int d = (int) Math.floor(second/(60*60*24));
    	second = second%(60*60*24);
    	
    	int h = (int) Math.floor(second/(60*60));
    	second = second%(60*60);
    	
    	int m = (int) Math.floor(second/60);
    	second = second%60;
    	
    	ds[0] = d+"";
    	ds[1] = h+"";
    	ds[2] = m+"";
    	ds[3] = second+"";
    	
    	return ds;
    			
    }
}
