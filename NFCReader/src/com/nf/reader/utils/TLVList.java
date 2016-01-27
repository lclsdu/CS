package com.nf.reader.utils;

import java.io.ByteArrayOutputStream;
import java.util.ArrayList;
import java.util.List;

/**
 * 
 * 用于存放一组TLV
 *
 */
public class TLVList {
	
	private List<TLV> list = new ArrayList<TLV>();
	
	
	public void add(TLV tlv){
		list.add(tlv);
	}
	
	/**
	 * 
	 * @return
	 * @throws Exception
	 */
	public byte[] toBinary() throws Exception{
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		for(int i=0; i<list.size(); i++){
			TLV tlv = list.get(i);
			out.write(tlv.toBinary());
		}
		return out.toByteArray();
	}

	
	public  int size(){
		return list.size();
	}
	
	public TLV get(int index){
		return list.get(index);
	}
	
	public List<TLV> toArrayList(){
		return list;
	}
	
	
}
