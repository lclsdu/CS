package com.grabparking.utils;



import java.util.ArrayList;
import java.util.Arrays;
import java.io.*;

import android.content.Context;

/**
 * 读取指定的文本文件
 * @author Administrator
 *
 */
public class TextFile extends ArrayList<String> {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

    public TextFile(Context context, String fileName, String splitter) {
        super(Arrays.asList(read(context, fileName).split(splitter)));
    }

    public TextFile(Context context, String fileName) {
        this(context, fileName, "\n");
    }

    public static String read(Context context, String fileName) {
        StringBuilder sb = new StringBuilder();

        try {
            InputStreamReader isr = new InputStreamReader(context.getAssets().open(fileName), "UTF-8");  
            BufferedReader in = new BufferedReader(isr);
            String s;
            try {
                while ((s = in.readLine()) != null) {
                    sb.append(s);
                    sb.append("\n");
                }
            } finally {
                in.close();
            }
        } catch (IOException e) {
            System.out.println("读取文件"+fileName+"异常,原因:"+e);
        }
        return sb.toString();
    }

    public ArrayList<String> getAlreadyReader() {
        return this;
    }

}
