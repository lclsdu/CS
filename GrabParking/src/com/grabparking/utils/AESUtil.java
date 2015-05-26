package com.grabparking.utils;

import java.security.Key;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.spec.AlgorithmParameterSpec;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import android.content.Context;
import android.os.Build;
import android.text.TextUtils;

public class AESUtil {

	public static String encrypt(Context context, String src) {
		if(TextUtils.isEmpty(src)){
			return "";
		}
		
		try {
			Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
			//cipher.init(Cipher.ENCRYPT_MODE, makeKey(userName, context.getPackageName()), makeIv(userName));
			cipher.init(Cipher.ENCRYPT_MODE, makeKey(Build.USER, Build.DEVICE), makeIv(Build.USER));
			return Base64.encodeBytes(cipher.doFinal(src.getBytes()));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	public static String decrypt(Context context, String src) {
		if(TextUtils.isEmpty(src)){
			return "";
		}
		
		String decrypted = "";
		try {
			Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
			//cipher.init(Cipher.DECRYPT_MODE, makeKey(userName, context.getPackageName()), makeIv(userName));
			cipher.init(Cipher.DECRYPT_MODE, makeKey(Build.USER, Build.DEVICE), makeIv(Build.USER));
			decrypted = new String(cipher.doFinal(Base64.decode(src)));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return decrypted;
	}

	static AlgorithmParameterSpec makeIv(String userName) {
		try {
			byte[] iv = new byte[16];
			sha1(userName).getBytes(0, 16, iv, 0);
			return new IvParameterSpec(iv);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	static Key makeKey(String userName, String appid) {
		byte[] key = new byte[32];
		try {
			String userName_appid_sha1 = sha1(userName + appid);
			String appid_userName_sha1 = sha1(appid + userName);
			userName_appid_sha1.getBytes(0, 16, key, 0);
			appid_userName_sha1.getBytes(appid_userName_sha1.length() - 16, appid_userName_sha1.length(), key, 16);
			return new SecretKeySpec(key, "AES");
		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;
	}

	/**
	 * sha1
	 * 
	 * @param data
	 * @return
	 * @throws NoSuchAlgorithmException
	 */
	public static String sha1(String data) throws NoSuchAlgorithmException {
		MessageDigest md = MessageDigest.getInstance("SHA1");
		md.update(data.getBytes());
		StringBuffer buf = new StringBuffer();
		byte[] bits = md.digest();
		for (int i = 0; i < bits.length; i++) {
			int a = bits[i];
			if (a < 0)
				a += 256;
			if (a < 16)
				buf.append("0");
			buf.append(Integer.toHexString(a));
		}
		return buf.toString();
	}
}
