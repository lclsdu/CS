package com.grabparking.utils;

/**
 * Created with IntelliJ IDEA.
 * User: fuxueliang
 * Date: 14-5-23
 * Time: 下午3:42
 * Application:通讯加密验签 SignatureCharacter SHA1加密 “整个报文体内容两端去除空格”
 */

import java.io.UnsupportedEncodingException;

public class SHA1EncryptionUtil {
    public static String SHA1(String inStr) {
        String outStr = null;
        try {
            outStr = new SHA1EncryptionUtil().getDigestOfString(inStr.getBytes("UTF-8"));
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return outStr.toLowerCase();
    }

    private final int[] abcde = {
            0x67452301, 0xefcdab89, 0x98badcfe, 0x10325476, 0xc3d2e1f0
    };
    // 摘要数据存储数组
    private int[] digestInt = new int[5];
    // 计算过程中的临时数据存储数组
    private int[] tmpData = new int[80];
    // 计算sha-1摘要
    private int process_input_bytes(byte[] bytedata) {
        // 初试化常量
        System.arraycopy(abcde, 0, digestInt, 0, abcde.length);
        // 格式化输入字节数组，补10及长度数据
        byte[] newbyte = byteArrayFormatData(bytedata);
        // 获取数据摘要计算的数据单元个数
        int MCount = newbyte.length / 64;
        // 循环对每个数据单元进行摘要计算
        for (int pos = 0; pos < MCount; pos++) {
            // 将每个单元的数据转换成16个整型数据，并保存到tmpData的前16个数组元素中
            for (int j = 0; j < 16; j++) {
                tmpData[j] = byteArrayToInt(newbyte, (pos * 64) + (j * 4));
            }
            // 摘要计算函数
            encrypt();
        }
        return 20;
    }
    // 格式化输入字节数组格式
    private byte[] byteArrayFormatData(byte[] bytedata) {
        // 补0数量
        int zeros = 0;
        // 补位后总位数
        int size = 0;
        // 原始数据长度
        int n = bytedata.length;
        // 模64后的剩余位数
        int m = n % 64;
        // 计算添加0的个数以及添加10后的总长度
        if (m < 56) {
            zeros = 55 - m;
            size = n - m + 64;
        } else if (m == 56) {
            zeros = 63;
            size = n + 8 + 64;
        } else {
            zeros = 63 - m + 56;
            size = (n + 64) - m + 64;
        }
        // 补位后生成的新数组内容
        byte[] newbyte = new byte[size];
        // 复制数组的前面部分
        System.arraycopy(bytedata, 0, newbyte, 0, n);
        // 获得数组Append数据元素的位置
        int l = n;
        // 补1操作
        newbyte[l++] = (byte) 0x80;
        // 补0操作
        for (int i = 0; i < zeros; i++) {
            newbyte[l++] = (byte) 0x00;
        }
        // 计算数据长度，补数据长度位共8字节，长整型
        long N = (long) n * 8;
        byte h8 = (byte) (N & 0xFF);
        byte h7 = (byte) ((N >> 8) & 0xFF);
        byte h6 = (byte) ((N >> 16) & 0xFF);
        byte h5 = (byte) ((N >> 24) & 0xFF);
        byte h4 = (byte) ((N >> 32) & 0xFF);
        byte h3 = (byte) ((N >> 40) & 0xFF);
        byte h2 = (byte) ((N >> 48) & 0xFF);
        byte h1 = (byte) (N >> 56);
        newbyte[l++] = h1;
        newbyte[l++] = h2;
        newbyte[l++] = h3;
        newbyte[l++] = h4;
        newbyte[l++] = h5;
        newbyte[l++] = h6;
        newbyte[l++] = h7;
        newbyte[l++] = h8;
        return newbyte;
    }
    private int f1(int x, int y, int z) {
        return (x & y) | (~x & z);
    }
    private int f2(int x, int y, int z) {
        return x ^ y ^ z;
    }
    private int f3(int x, int y, int z) {
        return (x & y) | (x & z) | (y & z);
    }
    private int f4(int x, int y) {
        return (x << y) | x >>> (32 - y);
    }
    // 单元摘要计算函数
    private void encrypt() {
        for (int i = 16; i <= 79; i++) {
            tmpData[i] = f4(tmpData[i - 3] ^ tmpData[i - 8] ^ tmpData[i - 14] ^
                    tmpData[i - 16], 1);
        }
        int[] tmpabcde = new int[5];
        for (int i1 = 0; i1 < tmpabcde.length; i1++) {
            tmpabcde[i1] = digestInt[i1];
        }
        for (int j = 0; j <= 19; j++) {
            int tmp = f4(tmpabcde[0], 5) +
                    f1(tmpabcde[1], tmpabcde[2], tmpabcde[3]) + tmpabcde[4] +
                    tmpData[j] + 0x5a827999;
            tmpabcde[4] = tmpabcde[3];
            tmpabcde[3] = tmpabcde[2];
            tmpabcde[2] = f4(tmpabcde[1], 30);
            tmpabcde[1] = tmpabcde[0];
            tmpabcde[0] = tmp;
        }
        for (int k = 20; k <= 39; k++) {
            int tmp = f4(tmpabcde[0], 5) +
                    f2(tmpabcde[1], tmpabcde[2], tmpabcde[3]) + tmpabcde[4] +
                    tmpData[k] + 0x6ed9eba1;
            tmpabcde[4] = tmpabcde[3];
            tmpabcde[3] = tmpabcde[2];
            tmpabcde[2] = f4(tmpabcde[1], 30);
            tmpabcde[1] = tmpabcde[0];
            tmpabcde[0] = tmp;
        }
        for (int l = 40; l <= 59; l++) {
            int tmp = f4(tmpabcde[0], 5) +
                    f3(tmpabcde[1], tmpabcde[2], tmpabcde[3]) + tmpabcde[4] +
                    tmpData[l] + 0x8f1bbcdc;
            tmpabcde[4] = tmpabcde[3];
            tmpabcde[3] = tmpabcde[2];
            tmpabcde[2] = f4(tmpabcde[1], 30);
            tmpabcde[1] = tmpabcde[0];
            tmpabcde[0] = tmp;
        }
        for (int m = 60; m <= 79; m++) {
            int tmp = f4(tmpabcde[0], 5) +
                    f2(tmpabcde[1], tmpabcde[2], tmpabcde[3]) + tmpabcde[4] +
                    tmpData[m] + 0xca62c1d6;
            tmpabcde[4] = tmpabcde[3];
            tmpabcde[3] = tmpabcde[2];
            tmpabcde[2] = f4(tmpabcde[1], 30);
            tmpabcde[1] = tmpabcde[0];
            tmpabcde[0] = tmp;
        }
        for (int i2 = 0; i2 < tmpabcde.length; i2++) {
            digestInt[i2] = digestInt[i2] + tmpabcde[i2];
        }
        for (int n = 0; n < tmpData.length; n++) {
            tmpData[n] = 0;
        }
    }
    // 4字节数组转换为整数
    private int byteArrayToInt(byte[] bytedata, int i) {
        return ((bytedata[i] & 0xff) << 24) | ((bytedata[i + 1] & 0xff) << 16) |
                ((bytedata[i + 2] & 0xff) << 8) | (bytedata[i + 3] & 0xff);
    }
    // 整数转换为4字节数组
    private void intToByteArray(int intValue, byte[] byteData, int i) {
        byteData[i] = (byte) (intValue >>> 24);
        byteData[i + 1] = (byte) (intValue >>> 16);
        byteData[i + 2] = (byte) (intValue >>> 8);
        byteData[i + 3] = (byte) intValue;
    }
    // 将字节转换为十六进制字符串
    private static String byteToHexString(byte ib) {
        char[] Digit = {
                '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C',
                'D', 'E', 'F'
        };
        char[] ob = new char[2];
        ob[0] = Digit[(ib >>> 4) & 0X0F];
        ob[1] = Digit[ib & 0X0F];
        String s = new String(ob);
        return s;
    }
    // 将字节数组转换为十六进制字符串
    private static String byteArrayToHexString(byte[] bytearray) {
        String strDigest = "";
        for (int i = 0; i < bytearray.length; i++) {
            strDigest += byteToHexString(bytearray[i]);
        }
        return strDigest;
    }
    // 计算sha-1摘要，返回相应的字节数组
    public byte[] getDigestOfBytes(byte[] byteData) {
        process_input_bytes(byteData);
        byte[] digest = new byte[20];
        for (int i = 0; i < digestInt.length; i++) {
            intToByteArray(digestInt[i], digest, i * 4);
        }
        return digest;
    }
    // 计算sha-1摘要，返回相应的十六进制字符串
    public String getDigestOfString(byte[] byteData) {
        return byteArrayToHexString(getDigestOfBytes(byteData));
    }
    public static void main(String[] args) {
        // String  data="wopay123$%^&*()你好啊";
       // String data = "<?xml version=\"1.0\" encoding=\"GB2312\" standalone=\"yes\" ?><inputdatas><controlinfo><ver>3.0.0<ver><did>862845023539591</did><dtype>2</dtype><operation>JY03</operation></controlinfo><params sets=\"1\"><param rows=\"1\" cols=\"20\" set_id=\"101\"><row rownum=\"1\"><col colnum=\"1\" param_id =\"101101\">2</col><col colnum=\"2\" param_id =\"101102\">13244440001</col><col colnum=\"3\" param_id =\"101103\">301100710000243</col><col colnum=\"4\" param_id =\"101104\">0141223094354607</col><col colnum=\"5\" param_id =\"101105\">1</col><col colnum=\"6\" param_id =\"101106\">100</col><col colnum=\"7\" param_id =\"101107\"></col><col colnum=\"8\" param_id =\"101108\">孙尅</col><col colnum=\"9\" param_id =\"101109\">110101</col><col colnum=\"10\" param_id =\"101110\">三里屯</col><col colnum=\"11\" param_id =\"101111\">13422220001</col><col colnum=\"12\" param_id =\"101112\"></col><col colnum=\"13\" param_id =\"101113\">20141226211015</col><col colnum=\"14\" param_id =\"101114\">BS001</col><col colnum=\"15\" param_id =\"101115\">0</col><col colnum=\"16\" param_id =\"101116\"></col><col colnum=\"17\" param_id =\"101117\"></col><col colnum=\"18\" param_id =\"101118\"></col><col colnum=\"19\" param_id =\"101119\">信用还款</col><col colnum=\"20\" param_id =\"101120\">5677</col></row></param></params></inputdatas>";
        String data = "<?xml version=\"1.0\" encoding=\"GB2312\" standalone=\"yes\" ?><inputdatas><controlinfo><ver>3.0.0<ver><did>862845023539591</did><dtype>2</dtype><operation>JY03</operation></controlinfo><params sets=\"1\"><param rows=\"1\" cols=\"20\" set_id=\"101\"><row rownum=\"1\"><col colnum=\"1\" param_id =\"101101\">2</col><col colnum=\"2\" param_id =\"101102\">13244440001</col><col colnum=\"3\" param_id =\"101103\">301100710000243</col><col colnum=\"4\" param_id =\"101104\">0141223094354607</col><col colnum=\"5\" param_id =\"101105\">1</col><col colnum=\"6\" param_id =\"101106\">100</col><col colnum=\"7\" param_id =\"101107\"></col><col colnum=\"8\" param_id =\"101108\">孙尅</col><col colnum=\"9\" param_id =\"101109\">110101</col><col colnum=\"10\" param_id =\"101110\">三里屯</col><col colnum=\"11\" param_id =\"101111\">13422220001</col><col colnum=\"12\" param_id =\"101112\"></col><col colnum=\"13\" param_id =\"101113\">20141226212415</col><col colnum=\"14\" param_id =\"101114\">BS001</col><col colnum=\"15\" param_id =\"101115\">0</col><col colnum=\"16\" param_id =\"101116\"></col><col colnum=\"17\" param_id =\"101117\"></col><col colnum=\"18\" param_id =\"101118\"></col><col colnum=\"19\" param_id =\"101119\">信用还款</col><col colnum=\"20\" param_id =\"101120\">5677</col></row></param></params></inputdatas>";
        String data1=SHA1EncryptionUtil.SHA1(SHA1EncryptionUtil.SHA1("2"+"3.0.0")+data.trim());
        //System.out.print(SHA1EncryptionUtil.SHA1(content));
        // String data = "123456"; 3b35a8944c1bf13b72f14f63b6a7b63df50ebcca

        System.out.println(data1);
       // String digest = SHA1EncryptionUtil.SHA1(data);
       // System.out.println(digest);

    }


}