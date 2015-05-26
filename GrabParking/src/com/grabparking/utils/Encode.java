package com.grabparking.utils;

import java.security.MessageDigest;

public class Encode {

	private static final String KEY = "wopay10010!@#";

	/**
	 * md5加密
	 * 
	 * @param password
	 * @return
	 */
	public static String Md5(String password, boolean addKey) {
		String pwOri = password;
		if (addKey) {
			password += KEY;
		}
		String encodeStr = "";
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			md.update(password.getBytes("UTF-8"));
			byte b[] = md.digest();
			int i;
			StringBuffer buf = new StringBuffer("");
			for (int offset = 0; offset < b.length; offset++) {
				i = b[offset];
				if (i < 0)
					i += 256;
				if (i < 16)
					buf.append("0");
				buf.append(Integer.toHexString(i));
			}
			encodeStr = buf.toString();
			if (addKey) {
				encodeStr = pwOri + "|" + encodeStr;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return encodeStr;
	}

}
