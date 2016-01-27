/*
 * gpj - Global Platform for Java SmartCardIO
 *
 * Copyright (C) 2009 Wojciech Mostowski, woj@cs.ru.nl
 * Copyright (C) 2009 Francois Kooman, F.Kooman@student.science.ru.nl
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 3.0 of the License, or (at your option) any later version.
 * 
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
 *
 */

package com.nf.reader.utils;

import java.io.ByteArrayOutputStream;
import java.io.IOException;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import javax.smartcardio.CardChannel;
import javax.smartcardio.CardException;
import javax.smartcardio.CommandAPDU;
import javax.smartcardio.ResponseAPDU;


public class GPUtil {

    public static boolean debug = true;
    public static final int SCP_ANY = 0;

    public static final int SCP_01_05 = 1;

    public static final int SCP_01_15 = 2;

    public static final int SCP_02_04 = 3;

    public static final int SCP_02_05 = 4;

    public static final int SCP_02_0A = 5;

    public static final int SCP_02_0B = 6;

    public static final int SCP_02_14 = 7;

    public static final int SCP_02_15 = 8;

    public static final int SCP_02_1A = 9;

    public static final int SCP_02_1B = 10;

    public static final int APDU_CLR = 0x00;

    public static final int APDU_MAC = 0x01;

    public static final int APDU_ENC = 0x02;

    public static final int APDU_RMAC = 0x10;

    public static final int DIVER_NONE = 0;

    public static final int DIVER_VISA2 = 1;

    public static final int DIVER_EMV = 2;
    
    public static final byte CLA_GP = (byte) 0x80;

    public static final byte CLA_MAC = (byte) 0x84;

    public static final byte INIT_UPDATE = (byte) 0x50;

    public static final byte EXT_AUTH = (byte) 0x82;

    public static final byte GET_DATA = (byte) 0xCA;

    public static final byte INSTALL = (byte) 0xE6;

    public static final byte LOAD = (byte) 0xE8;

    public static final byte DELETE = (byte) 0xE4;

    public static final byte GET_STATUS = (byte) 0xF2;
    public static void debug(Object o) {
        if (debug) {
            System.out.println("DEBUG: " + o.toString());
        }
    }

    public static String byteArrayToReadableString(byte[] array) {
        if (array == null) {
            return "NULL";
        }
        String s = "";
        for (int i = 0; i < array.length; i++) {
            char c = (char) array[i];
            s += (c >= 0x20 && c < 0x7f) ? (c) : (".");
        }
        return "|" + s + "|";
    }

    public static byte[] readableStringToByteArray(String s) {
        if (!s.startsWith("|") && !s.endsWith("|"))
            return null;
        s = s.substring(1, s.length() - 1);
        return s.getBytes();
    }

    public static String byteArrayToString(byte[] a) {
        String result = "";
        String onebyte = null;
        for (int i = 0; i < a.length; i++) {
            onebyte = Integer.toHexString(a[i]);
            if (onebyte.length() == 1)
                onebyte = "0" + onebyte;
            else
                onebyte = onebyte.substring(onebyte.length() - 2);
            result = result + onebyte.toUpperCase();
        }
        return result;
    }

    public static byte[] stringToByteArray(String s) {
    	if(s == null || s == ""){
    		return null;
    	}
        java.util.Vector<Integer> v = new java.util.Vector<Integer>();
        String operate = new String(s);
        operate = operate.replaceAll(" ", "");
        operate = operate.replaceAll("\t", "");
        operate = operate.replaceAll("\n", "");
        if (operate.endsWith(";"))
            operate = operate.substring(0, operate.length() - 1);
        if (operate.length() % 2 != 0)
            return null;
        int num = 0;
        while (operate.length() > 0) {
            try {
                num = Integer.parseInt(operate.substring(0, 2), 16);
            } catch (NumberFormatException nfe) {
                return null;
            }
            v.add(new Integer(num));
            operate = operate.substring(2);
        }
        byte[] result = new byte[v.size()];
        java.util.Iterator<Integer> it = v.iterator();
        int i = 0;
        while (it.hasNext())
            result[i++] = it.next().byteValue();
        return result;
    }

    public static String swToString(int sw1, int sw2) {
        String result = "";
        String onebyte = null;
        onebyte = Integer.toHexString(sw1);
        if (onebyte.length() == 1)
            onebyte = "0" + onebyte;
        else
            onebyte = onebyte.substring(onebyte.length() - 2);

        result = result + onebyte.toUpperCase() + " ";
        onebyte = Integer.toHexString(sw2);
        if (onebyte.length() == 1)
            onebyte = "0" + onebyte;
        else
            onebyte = onebyte.substring(onebyte.length() - 2);

        result = result + onebyte.toUpperCase() + " ";
        return result;
    }

    public static String swToString(int sw) {
        int sw1 = (sw & 0x0000FF00) >> 8;
        int sw2 = (sw & 0x000000FF);
        return swToString(sw1, sw2);
    }

    public static byte[] pad80(byte[] text, int offset, int length) {
        if (length == -1)
            length = text.length - offset;
        int totalLength = length;
        for (totalLength++; totalLength % 8 != 0; totalLength++)
            ;
        int padlength = totalLength - length;
        byte[] result = new byte[totalLength];
        System.arraycopy(text, offset, result, 0, length);
        result[length] = (byte) 0x80;
        for (int i = 1; i < padlength; i++)
            result[length + i] = (byte) 0x00;
        return result;
    }

    public static byte[] pad80(byte[] text) {
        return pad80(text, 0, text.length);
    }


    
    /**
     * for C-MAC calculate 
     * 算法，除去最后block，前面进行DES-CBC，结果作为最后Block 3DES的初始向量
     * @param key 3DES key DES计算使用前8字节
     * @param text
     * @param offset
     * @param length
     * @param cv
     * @return
     * @throws CardException
     */
    public static byte[] mac_des_3des_ex(byte[] key, byte[] text,byte[] cv) throws CardException {
    	// input para check
    	if (key.length!=16 && key.length!=24) {
    		throw new CardException("invalid key length.");
    	}
    	if (cv==null || cv.length!=8){
    		cv = new byte[8];
    	}
    	if (text.length < 16) {
    		throw new CardException("invalid text length.");
    	}
    	if (text.length%8 != 0) {
    		throw new CardException("invalid text length.data field must be mulriple of 8");
    	}
    	
        try {
        	SecretKey desKey = new SecretKeySpec(getKey(key,8), "DES");
        	SecretKey desSedKey = new SecretKeySpec(getKey(key,24), "DESede");
        	
        	Cipher cp1 = Cipher.getInstance("DES/CBC/NoPadding");
            Cipher cp2 = Cipher.getInstance("DESede/CBC/NoPadding");
            cp1.init(Cipher.ENCRYPT_MODE, desKey);

            byte[] result = new byte[8];
            byte[] temp;
            IvParameterSpec ivSpec = new IvParameterSpec(cv); 
            int blocks = text.length / 8;
            for (int i = 0; i < blocks - 1; i++) {
            	cp1.init(Cipher.ENCRYPT_MODE, desKey, ivSpec);
                byte[] block = cp1.doFinal(text, i * 8, 8);
                ivSpec = new IvParameterSpec(block);
            }
            int offset = (blocks - 1) * 8;
            // 以前方的DES计算结果作为最后一个block的出事计算分量
            cp2.init(Cipher.ENCRYPT_MODE, desSedKey, ivSpec);
            byte[] cMac = cp2.doFinal(text, offset, 8);
            return cMac;
            
        } catch (Exception e) {
            e.printStackTrace();
            throw new CardException("MAC computation failed(mac_des_3des_ex).");
        }
    }
    
    /**
     * 标准DES，可以指定cv
     * @param key
     * @param text
     * @param cv
     * @return
     */
    public static byte[] singleDes(byte[] key, byte[] text, byte[] cv)  throws CardException  {
        
    	try {
	        /**
	         * 计算下一次CMAC的ICV
	         * 使用C-MAC session key 左 8字节作为密钥
	         */
	    	IvParameterSpec ivSpec = new IvParameterSpec(new byte[8]);
	    	Cipher cp1 = Cipher.getInstance("DES/CBC/NoPadding");
	    	SecretKey desKey = new SecretKeySpec(getKey(key,8), "DES");
	        cp1.init(Cipher.ENCRYPT_MODE, desKey, ivSpec);
	        byte[] icvNextCommand = cp1.doFinal(text);
	        System.out.println("NEXT ICV is:" + GPUtil.byteArrayToString(icvNextCommand));
	        return icvNextCommand;
    	} catch (Exception e) {
    		e.printStackTrace();
    		throw new CardException(".");
    	}
    }
    
    /**
     * 标准3DES/CBC，可以指定cv
     * @param key
     * @param text
     * @param cv
     * @return
     */
    public static byte[] singleTripleDesCBC(byte[] key, byte[] text, byte[] cv)  throws CardException  {
        
    	try {
	    	IvParameterSpec ivSpec = new IvParameterSpec(new byte[8]);
	    	Cipher cp1 = Cipher.getInstance("DESede/CBC/NoPadding");
	    	SecretKey desKey = new SecretKeySpec(getKey(key,24), "DESede");
	        cp1.init(Cipher.ENCRYPT_MODE, desKey, ivSpec);
	        byte[] result = cp1.doFinal(text);
	        System.out.println("TripleDes result is:" + GPUtil.byteArrayToString(result));
	        return result;
    	} catch (Exception e) {
    		e.printStackTrace();
    		throw new CardException(".");
    	}
    }

    /**
     * 标准3DES/ECB，可以指定cv
     * @param key
     * @param text
     * @param cv
     * @return
     */
    public static byte[] singleTripleDesECB(byte[] key, byte[] text)  throws CardException  {
        
    	try {
	    	IvParameterSpec ivSpec = new IvParameterSpec(new byte[8]);
	    	Cipher cp1 = Cipher.getInstance("DESede/ECB/NoPadding");
	    	SecretKey desKey = new SecretKeySpec(getKey(key,24), "DESede");
	    	
	        cp1.init(Cipher.ENCRYPT_MODE, desKey);
	        byte[] result = cp1.doFinal(text);
	        System.out.println("TripleDes result is:" + GPUtil.byteArrayToString(result));
	        return result;
    	} catch (Exception e) {
    		e.printStackTrace();
    		throw new CardException(".");
    	}
    }
    
    public static byte[] singleTripleDesECB(byte[] key, byte[] text,int mode)  throws CardException  {
        
    	try {
	    	IvParameterSpec ivSpec = new IvParameterSpec(new byte[8]);
	    	Cipher cp1 = Cipher.getInstance("DESede/ECB/NoPadding");
	    	SecretKey desKey = new SecretKeySpec(getKey(key,24), "DESede");
	    	
	        cp1.init(mode, desKey);
	        byte[] result = cp1.doFinal(text);
	        System.out.println("TripleDes result is:" + GPUtil.byteArrayToString(result));
	        return result;
    	} catch (Exception e) {
    		e.printStackTrace();
    		throw new CardException(".");
    	}
    }
    
    public static byte[] getKey(byte[] key, int length) {
        if (length == 24) {
            byte[] key24 = new byte[24];
            System.arraycopy(key, 0, key24, 0, 16);
            System.arraycopy(key, 0, key24, 16, 8);
            return key24;
        } else {
            byte[] key8 = new byte[8];
            System.arraycopy(key, 0, key8, 0, 8);
            return key8;
        }
    }
    
   
	
	
	public static void main(String[] args)
	{
		 byte[] defaultMacKey = { 0x40, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, 0x48, 0x49, 0x4A, 0x4B, 0x4C, 0x4D, 0x4E, 0x4F };
		   byte[] result=GPUtil.getKey(defaultMacKey, 24);
		   System.out.println("len="+result.length);
		   System.out.println( GPUtil.byteArrayToString(result));
		  
	}
	
	
}
