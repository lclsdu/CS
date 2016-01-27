package com.nf.reader.utils;

import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;


public class TlvParseUtils {
	/**
	 * 读取 701B61194F08A000000333010101500A50424F43204445424954870101
	 * 701A611A4F08A000000333010102500B50424F4320437265646974870101
	 * 
	 * @param 
	 * @return aid
	 */
	public static String paseReadRecordPSETlvS(byte[] pseRespData)
	{

		if (pseRespData == null || pseRespData.length <= 2)
		{
			throw new IllegalArgumentException("传入要解析的读取记录的pse数据不能为空");
		}

		if (pseRespData[0]!=(byte)0x70)
		{
			throw new IllegalArgumentException("数据格式非法");
		}

		TLVList tagList = getTlv(pseRespData);
		TLV tag70 = tagList.get(0);
		if (tag70==null) {
			throw new IllegalArgumentException("数据格式非法");
		}
		tagList = getTlv(tag70.getValue());
		TLV tag61 = tagList.get(0);
		if (tag61==null) {
			throw new IllegalArgumentException("数据格式非法");
		}
		// 解析tag61 
		tagList = getTlv(tag61.getValue());
		// 取得4F
		String aid = null;
		for (TLV tlv:tagList.toArrayList()) {
			if (HexBinary.encode(tlv.getTag()).equals("4F")) {
				aid = HexBinary.encode(tlv.getValue());
			}
		}
		return aid;
	}
	
	/**
	 * 解析选择应用结果
	 * 
	 * @param 
	 * @return aid
	 */
	public static Map<String,String> parseSelectAdfResult(byte[] data) {
		if (data == null || data.length<=2)
		{
			throw new IllegalArgumentException("传入要解析的读取记录的adf数据不能为空");
		}

		if (data[0]!=(byte)0x6F)
		{
			throw new IllegalArgumentException("数据格式非法");
		}

		Map<String,String> tvs = new HashMap<String,String>();

		// 解析6F标签
		TLVList tagList = getTlv(data);
		TLV tag6F = tagList.get(0);
		if (tag6F==null) {
			throw new IllegalArgumentException("数据格式非法");
		}
		tagList = getTlv(tag6F.getValue());
		TLV tag84 = tagList.get(0);
		TLV tagA5 = tagList.get(1);
		
		if (tag84==null||tagA5==null) {
			throw new IllegalArgumentException("数据格式非法");
		}
		// 解析a5 
		tagList = getTlv(tagA5.getValue());
		for (TLV tlv:tagList.toArrayList()) {
			if (HexBinary.encode(tlv.getTag()).equals("50")) {
				tvs.put("50", HexBinary.encode(tlv.getValue()));
			} else if (HexBinary.encode(tlv.getTag()).equals("87")) {
				tvs.put("87", HexBinary.encode(tlv.getValue()));
			} else if (HexBinary.encode(tlv.getTag()).equals("9F38")) {
				tvs.put("9F38", HexBinary.encode(tlv.getValue()));
			} else if (HexBinary.encode(tlv.getTag()).equals("5F2D")) {
				tvs.put("5F2D", HexBinary.encode(tlv.getValue()));
			} else if (HexBinary.encode(tlv.getTag()).equals("9F11")) {
				tvs.put("9F11", HexBinary.encode(tlv.getValue()));
			} else if (HexBinary.encode(tlv.getTag()).equals("9F12")) {
				tvs.put("9F12", HexBinary.encode(tlv.getValue()));
			} else if (HexBinary.encode(tlv.getTag()).equals("BF0C")) {
				tvs.put("BF0C", HexBinary.encode(tlv.getValue()));
			}
		}
		// 解析BF0C
		if (tvs.get("BF0C")!=null) {
			tagList = getTlv(HexBinary.decode(tvs.get("BF0C")));
			for (TLV tlv:tagList.toArrayList()) {
				if (HexBinary.encode(tlv.getTag()).equals("9F4D")) {
					tvs.put("9F4D", HexBinary.encode(tlv.getValue()));
				}
			}
		}
		return tvs;
	}
	
	/**
	 * 解析选择应用结果
	 * 第一个是AIP
	 * 后续是AFL
	 * @param 
	 * @return aid
	 */
	public static List<String> parseGpoResult(byte[] data) {
		if (data == null || data.length<=2)
		{
			throw new IllegalArgumentException("传入要解析的读取记录的adf数据不能为空");
		}

		List<String> tvs = new ArrayList<String>();

		// 解析6F标签
		TLVList tagList = getTlv(data);
		TLV tag80 = tagList.get(0);
		System.out.println(HexBinary.encode(tag80.getValue()));
		String aipAndAfl = HexBinary.encode(tag80.getValue());
		// 前4个字节
		tvs.add(aipAndAfl.substring(0,4));
		aipAndAfl=aipAndAfl.substring(4);
		int len = aipAndAfl.length();
		// 后续 每6位截取
		for(int i=0;i<len/8;i++) {
			tvs.add(aipAndAfl.substring(0,8));
			aipAndAfl=aipAndAfl.substring(8);
		}
		return tvs;
	}
	
	/**
	 * 解析9F38 GPO数据
	 * value = length
	 * 
	 * @param 
	 * @return aid
	 */
	public static Map<String,String> parse9F38forGpo(byte[] data) {
		Map<String,String> tvs = new LinkedHashMap<String,String>();
		String dataS = HexBinary.encode(data);
		for (int i=0;i<dataS.length();i++) {
			String tag = null;
			String length = null;
			int inter = Integer.parseInt(dataS.substring(0,2), 16);
			if ((inter & 0x1f) == 0x1f) {
				tag = dataS.substring(0,4);
				length = dataS.substring(4,6);
				dataS = dataS.substring(6);
			} else {
				tag = dataS.substring(0,2);
				length = dataS.substring(2,4);
				dataS = dataS.substring(4);
			}
			tvs.put(tag, length);
		}
		
		return tvs;
	}
	
	/**
	 * 解析read Record
	 * @param pseRespData
	 * @return
	 */
	public static void parseReadRecord(byte[] readRecordData, Map<String,String> mapData)
	{

		if (readRecordData == null || readRecordData.length <= 2)
		{
			throw new IllegalArgumentException("传入要解析的读取记录的pse数据不能为空");
		}

		if (readRecordData[0]!=(byte)0x70)
		{
			throw new IllegalArgumentException("数据格式非法");
		}

		TLVList tagList = getTlv(readRecordData);
		TLV tag70 = tagList.get(0);
		if (tag70==null) {
			throw new IllegalArgumentException("数据格式非法");
		}
		// 解析tag70 
		tagList = getTlv(tag70.getValue());
		for(int i=0;i<tagList.size();i++) {
			TLV tlv = tagList.get(i);
			System.out.println("[" + HexBinary.encode(tlv.getTag()) + "]:" + HexBinary.encode(tlv.getValue()));
			mapData.put(HexBinary.encode(tlv.getTag()), HexBinary.encode(tlv.getValue()));
		}
		return;
	}
	
	/**
	 * 解析CDOL 生成Map
	 * value = length
	 * 
	 * @param 
	 * @return aid
	 */
	public static Map<String,String> parseCDOLforGenerateAc(byte[] data) {
		Map<String,String> cdol1 = new LinkedHashMap<String,String>();
		String dataS = HexBinary.encode(data);
		while (dataS.length()!=0) {
			String tag = null;
			String length = null;
			int inter = Integer.parseInt(dataS.substring(0,2), 16);
			if ((inter & 0x1f) == 0x1f) {
				tag = dataS.substring(0,4);
				length = dataS.substring(4,6);
				dataS = dataS.substring(6);
			} else {
				tag = dataS.substring(0,2);
				length = dataS.substring(2,4);
				dataS = dataS.substring(4);
			}
			cdol1.put(tag, length);
		}
		
		return cdol1;
	}
	
	private static TLVList getTlv(byte[] data) {
		ByteBuffer buff = ByteBuffer.wrap(data);
		TLVList list = TLVDecoder.decode(buff);
		return list;
	}
}
