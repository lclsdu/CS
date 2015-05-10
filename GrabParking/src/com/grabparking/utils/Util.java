/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.grabparking.utils;

import java.io.ByteArrayOutputStream;
import java.util.Calendar;
import java.util.Date;

public class Util {

	public static String asHex(byte buf[]) {
		StringBuffer strbuf = new StringBuffer(buf.length * 2);

		for (int i = 0; i < buf.length; i++) {
			if (((int) buf[i] & 0xff) < 0x10) {
				strbuf.append("0");
			}
			strbuf.append(Long.toString((int) buf[i] & 0xff, 16));
		}
		return strbuf.toString();
	}

	public static String asHex(byte buf[], int length) {
		StringBuffer strbuf = new StringBuffer(buf.length * 2);

		for (int i = 0; i < length; i++) {
			if (((int) buf[i] & 0xff) < 0x10) {
				strbuf.append("0");
			}
			strbuf.append(Long.toString((int) buf[i] & 0xff, 16));
		}
		return strbuf.toString();
	}

	/* BCD */
	public static byte[] toByteArray(String hex) {
		byte[] bts = new byte[hex.length() / 2];
		for (int i = 0; i < hex.length() / 2; i++) {
			bts[i] = (byte) Integer.parseInt(hex.substring(2 * i, 2 * i + 2),
					16);
		}
		return bts;
	}

	public static String toHexString(byte bytes[]) {
		StringBuffer retString = new StringBuffer();
		for (int i = 0; i < bytes.length; ++i) {
			retString.append(Integer.toHexString(0x0100 + (bytes[i] & 0x00FF))
					.substring(1));
		}
		return retString.toString();
	}

	public static String toHexString(byte bytes[], int off, int len) {
		StringBuffer retString = new StringBuffer();
		for (int i = 0; i < len; ++i) {
			retString.append(Integer.toHexString(
					0x0100 + (bytes[off + i] & 0x00FF)).substring(1));
		}
		return retString.toString();
	}

	public static byte[] intToByte(int i) {
		byte[] abyte0 = new byte[2];
		abyte0[1] = (byte) (0xff & i);
		abyte0[0] = (byte) ((0xff00 & i) >> 8);
		return abyte0;
	}

	public static int byteToInt(byte b1, byte b2) {
		int addr = b2 & 0xFF;
		addr |= ((b1 << 8) & 0xFF00);
		return addr;
	}

	public static int bytesToInt(byte[] bytes) {
		int addr = bytes[1] & 0xFF;
		addr |= ((bytes[0] << 8) & 0xFF00);
		return addr;
	}

	public static long arr2long(byte[] arr, int start) {
		int i = 0;
		int len = 8;
		int cnt = 0;
		byte[] tmp = new byte[len];
		for (i = start; i < (start + len); i++) {
			tmp[cnt] = arr[i];
			cnt++;
		}
		long accum = 0;
		i = 0;
		for (int shiftBy = 0; shiftBy < 32; shiftBy += 8) {
			accum |= ((long) (tmp[i] & 0xff)) << shiftBy;
			i++;
		}
		return accum;
	}

	public static byte[] parseLong(long x) {
		byte[] bb = new byte[8];
		bb[0] = (byte) (x >> 56);
		bb[1] = (byte) (x >> 48);
		bb[2] = (byte) (x >> 40);
		bb[3] = (byte) (x >> 32);
		bb[4] = (byte) (x >> 24);
		bb[5] = (byte) (x >> 16);
		bb[6] = (byte) (x >> 8);
		bb[7] = (byte) (x >> 0);
		return bb;
	}

	public static String currentDataString;

	public static byte[] getCurrentDataHexString() {
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		int y = cal.get(Calendar.YEAR);
		int m = cal.get(Calendar.MONTH) + 1;
		int d = cal.get(Calendar.DAY_OF_MONTH);
		int h = cal.get(Calendar.HOUR_OF_DAY);
		int M = cal.get(Calendar.MINUTE);
		int s = cal.get(Calendar.SECOND);
		StringBuffer sb = new StringBuffer();
		sb.append(y);
		if (m < 10)
			sb.append("0");
		sb.append(m);
		if (d < 10)
			sb.append("0");
		sb.append(d);
		if (h < 10)
			sb.append("0");
		sb.append(h);
		if (M < 10)
			sb.append("0");
		sb.append(M);
		if (s < 10)
			sb.append("0");
		sb.append(s);
		currentDataString = sb.toString();
		return toByteArray(currentDataString + "80");
	}

	public static String getCurrentDataYYYYMMDD() {
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		int y = cal.get(Calendar.YEAR);
		int m = cal.get(Calendar.MONTH) + 1;
		int d = cal.get(Calendar.DAY_OF_MONTH);
		
		StringBuffer sb = new StringBuffer();
		sb.append(y);
		if (m < 10)
			sb.append("0");
		sb.append(m);
		if (d < 10)
			sb.append("0");
		sb.append(d);
		
		return sb.toString();
	}
	
	public static String getCurrentTimehhmmss() {
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		int h = cal.get(Calendar.HOUR_OF_DAY);
		int M = cal.get(Calendar.MINUTE);
		int s = cal.get(Calendar.SECOND);
		StringBuffer sb = new StringBuffer();
		if (h < 10)
			sb.append("0");
		sb.append(h);
		if (M < 10)
			sb.append("0");
		sb.append(M);
		if (s < 10)
			sb.append("0");
		sb.append(s);
		return sb.toString();
	}
	public static String getCurrentDataYYYYMMDDhhmmss() {
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		int y = cal.get(Calendar.YEAR);
		int m = cal.get(Calendar.MONTH) + 1;
		int d = cal.get(Calendar.DAY_OF_MONTH);
		int h = cal.get(Calendar.HOUR_OF_DAY);
		int M = cal.get(Calendar.MINUTE);
		int s = cal.get(Calendar.SECOND);
		StringBuffer sb = new StringBuffer();
		sb.append(y);
		if (m < 10)
			sb.append("0");
		sb.append(m);
		if (d < 10)
			sb.append("0");
		sb.append(d);
		if (h < 10)
			sb.append("0");
		sb.append(h);
		if (M < 10)
			sb.append("0");
		sb.append(M);
		if (s < 10)
			sb.append("0");
		sb.append(s);
		return sb.toString();
	}

	// 12,1,2,3,4,5,6,7,8,9,10,11 days
	final static long[] monthDay = { 31, 31, 28, 31, 30, 31, 30, 31, 31, 30,
			31, 30 };

	public static String getOneMonthBeforeDataYYYYMMDDhhmmss() {
		Calendar cal = Calendar.getInstance();
		Date date = new Date();
		cal.setTime(date);
		int y = cal.get(Calendar.YEAR);
		int m = cal.get(Calendar.MONTH) + 1;
		long time = date.getTime();
		if ((m == 3) && ((y % 400 == 0) || (y % 4 == 0 && y % 100 != 0))) {
			time -= (29 * 24 * 3600000);
		} else {
			time -= (monthDay[m - 1] * 24 * 3600000);
		}
		System.out.println("time " + time);
		date = new Date(time);
		cal.setTime(date);
		y = cal.get(Calendar.YEAR);
		m = cal.get(Calendar.MONTH) + 1;
		int d = cal.get(Calendar.DAY_OF_MONTH);
		StringBuffer sb = new StringBuffer();
		sb.append(y);
		if (m < 10)
			sb.append("0");
		sb.append(m);
		if (d < 10)
			sb.append("0");
		sb.append(d);
		sb.append("000000");
		return sb.toString();
	}

	public static String bytesToBCD(byte[] b) {
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < b.length; i++) {
			sb.append((b[i] >> 4) & 0x0f);
			sb.append(b[i] & 0x0f);
		}
		return sb.toString();
	}

	/* BCD */
	public static byte[] str2cbcd(String s) {
		if (s.length() % 2 != 0) {
			s += "0";
		}
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		char[] cs = s.toCharArray();
		for (int i = 0; i < cs.length; i += 2) {
			int high = cs[i] - 48;
			int low = cs[i + 1] - 48;
			baos.write(high << 4 | low);
		}
		return baos.toByteArray();
	}

	public static String cbcd2string(byte[] b) {
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < b.length; i++) {
			int h = ((b[i] & 0xff) >> 4) + 48;
			sb.append((char) h);
			int l = (b[i] & 0x0f) + 48;
			sb.append((char) l);
		}
		return sb.toString();
	}

	public static String cbcd2string(byte[] b, int off, int len) {
		StringBuffer sb = new StringBuffer();
		for (int i = off; i < off + len; i++) {
			int h = ((b[i] & 0xff) >> 4) + 48;
			sb.append((char) h);
			int l = (b[i] & 0x0f) + 48;
			sb.append((char) l);
		}
		return sb.toString();
	}

	public static byte[] hex2Bytes(int hex, int size) {
		byte[] result = new byte[size];
		for (int i = 0; i < size; i++) {
			result[i] = (byte) ((((long) hex) >> (8 * (size - 1 - i))) & 0xFF);
		}
		return result;
	}

	public static byte[] int2Bytes(int dec, int size) {
		String s = String.valueOf(dec);
		int t = s.length();
		for (int i = 0; i < size - t; i++) {
			s = "0" + s;
		}
		System.out.println(s);
		return str2cbcd(s);
	}

	public static int byte2Hex(byte[] packetBytes) {
		int result = 0;
		if (packetBytes == null) {
			return result;
		}
		for (int i = 0; i < packetBytes.length; i++) {
			result += (packetBytes[i] & 0xff) << (i * 8);
		}
		return result;
	}

	public static byte[] double2BCD(double d) {
		byte[] byteReturn = null;
		int cycle = 0;
		boolean needSuffix = false;
		String s = Double.toString(d);
		int len = s.length();
		if (len % 2 == 0) {
			needSuffix = false;
			len = len / 2;
			cycle = len;
		} else {
			needSuffix = true;
			len = (len + 1) / 2;
			cycle = len - 1;
		}
		byteReturn = new byte[len];
		int int1 = 0, int2 = 0;

		for (int i = 0; i < cycle; i++) {
			String temp1 = s.substring(2 * i, 2 * i + 1);
			String temp2 = s.substring(2 * i + 1, 2 * i + 2);
			if (temp1.equals("-")) {
				int1 = 0xB;
			} else if (temp1.equals(".")) {
				int1 = 0xA;
			} else {
				int1 = Integer.parseInt(temp1);
			}
			int1 = int1 * 16;

			if (temp2.equals("-")) {
				int2 = 0xB;
			} else if (temp2.equals(".")) {
				int2 = 0xA;
			} else {
				int2 = Integer.parseInt(temp2);
			}
			byteReturn[i] = (byte) ((int1 + int2) & 0xFF);
		}
		// patch 0xF
		if (needSuffix) {
			int suffix = Integer
					.parseInt(s.substring(2 * len - 2, 2 * len - 1));
			byteReturn[len - 1] = (byte) (suffix * 16 + 0xF);
		}
		return byteReturn;
	}

	public static double byteBCD2Double(byte[] packetBytes) {
		if (packetBytes == null) {
			return 0;
		}
		int length = packetBytes.length;
		String stringValue = "";
		for (int i = 0; i < length; i++) {
			String temp = Integer.toHexString(packetBytes[i] & 0xFF);
			if (temp != null && temp.length() < 2) {
				temp = "0" + temp;
			}
			stringValue = stringValue + temp;
		}
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < stringValue.length(); i++) {
			char c = stringValue.toUpperCase().charAt(i);
			if (c == 'B') {
				c = '-';
				sb.append(c);
			} else if (c == 'A') {
				c = '.';
				sb.append(c);
			} else if (c != 'F') {
				sb.append(c);
			}
		}
		stringValue = sb.toString();
		return Double.valueOf(stringValue).doubleValue();
	}

	private static final byte[] highDigits;
	private static final byte[] lowDigits;

	// initialize lookup tables
	static {
		final byte[] digits = { '0', '1', '2', '3', '4', '5', '6', '7', '8',
				'9', 'A', 'B', 'C', 'D', 'E', 'F' };

		int i;
		byte[] high = new byte[256];
		byte[] low = new byte[256];

		for (i = 0; i < 256; i++) {
			high[i] = digits[i >>> 4];
			low[i] = digits[i & 0x0F];
		}

		highDigits = high;
		lowDigits = low;
	}

	public static String getHexdump(byte[] data, boolean ff) {
		StringBuffer out = new StringBuffer(data.length * 2);
		int byteValue;
		char c;
		for (int i = 0; i < data.length; i++) {
			byteValue = data[i] & 0xFF;
			c = (char) highDigits[byteValue];
			if (ff && c == 'F')
				break;
			out.append(c);
			c = (char) lowDigits[byteValue];
			if (ff && c == 'F')
				break;
			out.append(c);
		}
		return out.toString();
	}

	public static String getHexdump(byte[] data, int length, boolean ff) {
		StringBuffer out = new StringBuffer(data.length * 2);
		int byteValue;
		char c;
		for (int i = 0; i < length && i < data.length; i++) {
			byteValue = data[i] & 0xFF;
			c = (char) highDigits[byteValue];
			if (ff && c == 'F')
				break;
			out.append(c);
			c = (char) lowDigits[byteValue];
			if (ff && c == 'F')
				break;
			out.append(c);
		}
		return out.toString();
	}

	public static String getHexdump(byte[] data, int offset, int length,
			boolean ff) {
		StringBuffer out = new StringBuffer(data.length * 2);
		int byteValue;
		char c;
		for (int i = offset; i < offset + length && i < data.length; i++) {
			byteValue = data[i] & 0xFF;
			c = (char) highDigits[byteValue];
			if (ff && c == 'F')
				break;
			out.append(c);
			c = (char) lowDigits[byteValue];
			if (ff && c == 'F')
				break;
			out.append(c);
		}
		return out.toString();
	}

	public static int bcd2Int(byte b) {
		return (0x0f & (b >> 4)) * 10 + (0x0f & b);
	}

	public static int bcd2Int(byte b, byte b2) {
		return (bcd2Int(b) * 100) + bcd2Int(b2);
	}

	public static String getMoney4Display(String s) {
		int l = s.length();
		StringBuffer sb = new StringBuffer();
		try {
			
			sb.append(Long.parseLong(s.substring(0, l - 2)));
			sb.append(".");
			sb.append(s.substring(l - 2, l));
			sb.append("YUAN");
			return sb.toString();
		} finally {
			sb = null;
		}
	}

	public static String getNumDisplay(String s) {
		return String.valueOf(Integer.parseInt(s));
	}

}
