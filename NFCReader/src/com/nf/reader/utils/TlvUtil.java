package com.nf.reader.utils;

import java.nio.ByteBuffer;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class TlvUtil {
	/**
	 * 解析DGI长度
	 * 
	 * DGI的Length域遵循EMV CPS规范，长度为1或3字节：
	 * 当Value域长度从 ‘00’ 到 “FE’ (0 到 254 字节)时，Length域为1字节；
	 * 当Value域长度大于254字节时，Length域为3字节，包含第一个字节‘FF’，
	 * 后面2字节为数据长度，例如，‘FF0100’ 表示Value域长度为256字节
	 * 
	 * @param dgiBuf
	 * @return
	 */
	public static int decodeDGILen(ByteBuffer dgiBuf){
		byte[] len ;
	    byte firstByte = dgiBuf.get();
	    if((firstByte ^ 0xFF ) == 0){
	    	//Length域为3字节，包含第一个字节‘FF’,后面2字节为数据长度
	    	len = new byte[2];
	    	dgiBuf.get(len);
	    }else{
	    	len = new byte []{firstByte};
	    }
	    
	    return  Integer.parseInt(GPUtil.byteArrayToString(len), 16);
	}
	/**
	 * 解析一个DGI
	 * 
	 * 只支持如下格式的DGI：
	 * 1)DGINAME + DIGLEN + TLV + TLV+ TLV......
	 *   如：(9104分组不使用70模版组装，包含两个标签: 82和94) 91041682027C00941008010200100104011801030020010100
	 * 
	 * 2)DGINAME + DIGLEN + 70 + LEN + TLV + TLV+ TLV ......
	 *   如：(0401分组使用70模版组装，包含两个标签:9F14和9F23)04010A70089F1401009F230100
	 * 
	 * 
	 * @param dgiBuf   一个完整的DGI值(dgiName + dgiLen + dgiValue)
	 * @param dgiName   该DGI对应的名称(16进制串格式)
	 * @return   map    给DGI中包含的所有TLV
	 */
	public static Map<String, String> decodeDGI(byte[] dgiBuf) throws Exception{
		
		Map<String, String>  tlvMap = new LinkedHashMap<String, String>();
		
//		ByteBuffer  tempBuf = ByteBuffer.wrap(dgiBuf);
//		// 不用读取DGI
//		byte[]  realDgiNameBuf = new byte[2];  //实际读取出来的DGI名称
//		tempBuf.get(realDgiNameBuf);
		
//		//读取DGI长度
//		int len = decodeDGILen(tempBuf);
		
//		//读取DGI值
//		byte[] dgiValue = TLVDecoder.decodeValue(tempBuf, len);
		
		//TODO DGI value是不是只包含两种格式：直接是一个个平级的TLV或一个个平级的TLV嵌套在TAG70中  ？？？
		ByteBuffer  dgiValueBuffer = ByteBuffer.wrap(dgiBuf);
		//判断是不是有TAG70
		byte firstByte = dgiValueBuffer.get();
		if((firstByte ^ 0x70) == 0){
			//解析70域长度
			byte[] lenBuf = TLVDecoder.decodeLen(dgiValueBuffer);
			int len  = Integer.parseInt(GPUtil.byteArrayToString(lenBuf),16);
			//解析70域值
			byte[] dgiValue = TLVDecoder.decodeValue(dgiValueBuffer, len);
			//TODO
			dgiValueBuffer = ByteBuffer.wrap(dgiValue);
		}else{
			dgiValueBuffer.position(dgiValueBuffer.position() - 1);
		}
		
		TLVList list = TLVDecoder.decode(dgiValueBuffer);
		List<TLV> tlvs = list.toArrayList();
		for(TLV tlv : tlvs){
			tlvMap.put(GPUtil.byteArrayToString(tlv.getTag()), GPUtil.byteArrayToString(tlv.getValue()));
		}
		return tlvMap;
	}
	
}
