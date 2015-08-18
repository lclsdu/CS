package com.nfc.reader.bean;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

import android.util.Log;

public class CityCode {
	final static String TAG=CityCode.class.getSimpleName();
	final static Map<String,String> cityCode=new HashMap<String,String>();
	static{
		File file=new File("./citycode/city-zip.txt");
		if(file.exists()){
		//加载citycode文件夹下 地市代码
		InputStreamReader in = null;
		try {
			in = new InputStreamReader(new FileInputStream(file),"UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		BufferedReader reader=new BufferedReader(in);
		String lineTxt="";
		 try {
			while((lineTxt = reader.readLine()) != null){
				 String[] str=lineTxt.split("\\s");
			     cityCode.put(str[0], str[1]);
			     Log.d(TAG, str[0]+":"+str[1]);
			 }
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		}
	}
	public static String getCityCode(String code){
		return cityCode.get(code);
	}
}
