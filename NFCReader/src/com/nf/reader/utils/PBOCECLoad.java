package com.nf.reader.utils;



import java.security.NoSuchAlgorithmException;
import java.util.BitSet;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import android.util.Log;
public class PBOCECLoad {

	private static byte[] said = new byte[] { (byte) 0xa0, 0x00, 0x00, 0x00,
			0x03, 0x00, 0x00 };
	private static byte[] aid = new byte[] { (byte) 0xa0, 0x00, 0x00, 0x03,
			0x33, 0x01, 0x01, 0x02 };

	static Map<String,String> terminalData = new HashMap<String,String>();
	public static Map<String,String> cardDataMap = new HashMap<String,String>();
	public static String AIP = "";
	public static BitSet TVR_DEFAULT = new BitSet(40);
	
	// RID
	public final static String RID = "A000000333";

	/**
	 * 
	 * @param cardPan
	 * @param cardSeq
	 * @throws Exception 
	 */
	public static Map<String,String> transBerore(Pboc20Reader reader) throws Exception {
		//终端交易属性
		terminalData.put("9F66", "60000000");//标识支持非接触式借贷记
		// 授权金额
		terminalData.put("9F02", "000000001000");
		// 交易货币代码
		terminalData.put("5F2A", "0156");
		// 电子现金终端支持指示器
		terminalData.put("9F7A", "00");
		// PBOC-6 A.2 
		// 字节1 卡片数据输入性能 bit1 手工键盘输入 bit2 磁条 bit3 接触式IC
		// 字节2 CVM性能 bit1 IC 卡明文PIN 验证 bit2 加密PIN 联机验证 bit3 签名（纸） bit5 无需CVM bit8 持卡人证件验证 
		// 字节3 安全性能 bit1 静态数据认证（SDA） bit2 动态数据认证（DDA） bit3 吞卡 bit5 复合动态数据认证/应用密文生成（CDA） 
		terminalData.put("9F33", "E0E1C8");//11100000 11100001 11001000
		// 其他金额
		terminalData.put("9F03", "000000000000");
		// 终端国家代码
		terminalData.put("9F1A", "0156");
		// 终端验证结果TVR
		//terminalData.put("95", "8088047800");
		terminalData.put("95", "0000000000");
		// 交易日期
		terminalData.put("9A", "130521");
		// 交易类型
		//terminalData.put("9C", "63");
		terminalData.put("9C", "0000000000");
		
		// 不可预知数
		terminalData.put("9F37", "00000001");
		// 交易时间
		terminalData.put("9F21", "110118");
		// 商户名称 //ZhouZhe_Zontion_Soft
//		terminalData.put("9F4E", "5A686F755A68655F5A6F6E74696F6E5F536F6674");
		terminalData.put("9F4E", "544553544D455243484E414D4539393030303030");
        /**
         * 选择PSE
         */

		Pboc20Reader.Response resp = reader.selectByName(HexBinary.decode("325041592E5359532E4444463031"));
        // 拆分获得88标签
		// TODO
		/**
		 * read record
		 */
		resp = reader.readRecord(0x01, 0x01);
		// 解析获得AID
		//String aid = TlvParseUtils.paseReadRecordPSETlvS(resp.getBytes());
		String[] aid=new String[]{"A000000333010101","A000000333010102","A000000333010103"};
		String tag9F38="";
		for(int i=0;i<aid.length;i++){
		// 选择应用
		resp = reader.selectByName(HexBinary.decode(aid[i]));
		Log.d("com.nfc.reader", HexBinary.encode(resp.data));
		// 解析选择应用结果
		Map<String,String> selectResp = TlvParseUtils.parseSelectAdfResult(resp.getBytes());
		// 获取9F38
		tag9F38 = selectResp.get("9F38");
		if(tag9F38.equals("")||tag9F38==null){
			continue;
		}else{
			break;
		}
		}
		Log.d("com.nfc.reader", "9f38:"+tag9F38);
		Map<String,String> gpoNeed = TlvParseUtils.parse9F38forGpo(HexBinary.decode(tag9F38));
		System.out.println("=========卡片GPO需要参数");
		Set<String> key = gpoNeed.keySet();
		String gpodata = "";
		for (String name:key) {
			System.out.println("["+name+"]");
			gpodata = gpodata + terminalData.get(name);
			
		}
		System.out.println("gpodata:"+gpodata);
		// 使用83tag包裹数据
		TLV tag83 = TLVEncoder.genTLV("83", HexBinary.decode(gpodata));
		
		resp = reader.gpo(tag83.getData());
		// 解析GPO响应 获取AIP 和 AFL列表
		List<String> result = TlvParseUtils.parseGpoResult(resp.getBytes());
		// 解析AIP 第一字节 1 RFU 2 支持SDA 3支持DDA 4 支持持卡人认证 5 支持终端风险管理 6 支持发卡行认证 7 RFU 8 支持CDA
		AIP = result.get(0);
		result.remove(0);
		// 循环 read record
		for (String afl:result) {
			// 循环处理AFL
			//字节 1——短文件标识符（一个文件的数字标签）
			//字节 2——第1 个要读出的记录号
			//字节 3——最后一个要读出的记录号
			//字节 4——存放用于脱机数据认证的数据的连续记录个数，字节2 指出的
			//是第1 条要读的记录号
			// 无符号右移3位
			int sfi = Integer.valueOf(afl.substring(0,2),16)>>3;
			int startRec = Integer.valueOf(afl.substring(2,4),16);
			int endRec = Integer.valueOf(afl.substring(4,6),16);
			// 循环读取record
			for(int j=startRec;j<=endRec;j++) {
				System.out.println("========Read SFI:" + sfi + "  Read record:" + j + "==============");
				// 读取记录
				resp = reader.readRecord(sfi, j);
				TlvParseUtils.parseReadRecord(resp.getBytes(),cardDataMap);
			}
		}

		System.out.println("卡片应用交互特征：" + AIP);
		cardDataMap.put("82", AIP);
		System.out.println("分析卡片AIP和终端9F33字节3判定是否进行数据认证");
		// TODO 暂时使用DDA
		System.out.println("动态数据认证，DDA");
//		CAInfo info = CAConstants.getCaInfo(cardDataMap.get("8F"));
//		if (info==null) {
//			throw new Exception("CA公钥信息不存在");
//		}
//		System.out.println("CA公钥AID：" + RID);
//		System.out.println("CA公钥PKI [8F]:" + cardDataMap.get("8F"));
//		System.out.println("CA公钥模：" + info.getModules());
//		System.out.println("CA公钥模：" + info.getExponent());
		// 发卡行公钥证书
		System.out.println("发卡行公钥证书[90]：" + cardDataMap.get("90"));
		// TODO 脱机数据认证
		
		
		System.out.println("===================处理限制=========================" );
		System.out.println("卡片应用版本：" + cardDataMap.get("9F08"));
		System.out.println("终端应用版本：" + "0020");
		
		

		System.out.println("===================处理限制结束======================" );

		System.out.println("===================持卡人认证========================" );
		
		System.out.println("===================持卡人认证结束=====================" );
		
		

		System.out.println("===================终端风险管理========================" );
		System.out.println("主账号[5A]:" + cardDataMap.get("5A"));
		System.out.println("交易金额[9F02]:" + terminalData.get("9F02"));
		// TODO
		
		
		System.out.println("===================终端风险管理结束====================" );
		

		System.out.println("===================终端行为分析========================" );
		System.out.println("===================终端行为分析结束====================" );
		

		System.out.println("===================卡片行为分析========================" );
		System.out.println("卡片风险管理数据对象列表1(CDOL1):" + cardDataMap.get("8C"));
		System.out.println("Generate AC");
		// 生成第一次generate Ac指令
		Map<String,String> cdol1= TlvParseUtils.parseCDOLforGenerateAc(HexBinary.decode(cardDataMap.get("8C")));
		System.out.println("=========卡片第一次GenerateAc需要参数");
		Set<String> cdol1keys = cdol1.keySet();
		String cdol1data = "";
		for (String name:cdol1keys) {
			System.out.println("["+name+"]:" + terminalData.get(name));
			cdol1data = cdol1data + terminalData.get(name);
		}
		System.out.println("cdol1数据：" + cdol1data);
		// 第一次generate Ac
		// 0x80 生成ARQC
		//测试数据
		//String cdol1data = "00000000100000000000000001560000000000015613052163000000011101185A686F755A68655F5A6F6E74696F6E5F536F6674";
		//(byte)0x80
		resp = reader.generateAc(HexBinary.decode(cdol1data), (byte)0x40);
		// 分析resp
		// 如果以80开头
		String cdol1respdata = HexBinary.encode(resp.getBytes());
		if (cdol1respdata.startsWith("80")) {
			cdol1respdata = cdol1respdata.substring(4);
			String tag9F27 = cdol1respdata.substring(0,2);
			String tag9F36 = cdol1respdata.substring(2,6);
			String tag9F26 = cdol1respdata.substring(6,22);
			String tag9F10 = cdol1respdata.substring(22);
			System.out.println("Generate Ac result of Card:");
			System.out.println("9F27:" + tag9F27);
			System.out.println("9F36:" + tag9F36);
			System.out.println("9F26:" + tag9F26);
			System.out.println("9F10:" + tag9F10);
			cardDataMap.put("9F27", tag9F27);
			cardDataMap.put("9F36", tag9F36);
			cardDataMap.put("9F26", tag9F26);
			cardDataMap.put("9F10", tag9F10);
		} else {
			// 77开头 todo
		}
		System.out.println("");
		System.out.println("===================卡片行为分析结束=====================" );
		
		System.out.println("===================发卡行授权前处理结束=================" );
		// 发卡行授权处理必须字段放入 result
		Map<String,String> beforeResult = new LinkedHashMap<String, String>();
		beforeResult.put("9F02", terminalData.get("9F02"));
		beforeResult.put("9F03", terminalData.get("9F03"));
		beforeResult.put("9F1A", terminalData.get("9F1A"));
		beforeResult.put("95", terminalData.get("95"));
		beforeResult.put("5F2A", terminalData.get("5F2A"));
		beforeResult.put("9A", terminalData.get("9A"));
		beforeResult.put("9C", terminalData.get("9C"));
		beforeResult.put("9F37", terminalData.get("9F37"));
		// 应用交互特征
		beforeResult.put("82", cardDataMap.get("82"));
		beforeResult.put("9F36", cardDataMap.get("9F36"));
		// 卡片验证结果在9F10中上送
		beforeResult.put("9F10", cardDataMap.get("9F10"));

		beforeResult.put("9F27", cardDataMap.get("9F27"));
		beforeResult.put("9F26", cardDataMap.get("9F26"));
		beforeResult.put("5A", cardDataMap.get("5A"));
		beforeResult.put("5F34", cardDataMap.get("5F34"));
		System.out.println( "9F26 ARQC:"+cardDataMap.get("9F26"));
		return beforeResult;
		 //System.out.println("CardNo:" + cardNo + " seqNo:" + cardSeqNo);
	}
	
	
	/**
	 * 
	 * 发卡行授权后处理
	 * @param cardPan
	 * @param cardSeq
	 * @throws Exception 
	 */
	public static Map<String,String> transAfter(Pboc20Reader reader,Map<String,String> issuerData) throws Exception {
		System.out.println("===============发卡行授权后处理开始=====================");
        System.out.println("==============外部认证=====================");
        //Response resp;
        Pboc20Reader.Response resp = reader.externalAuth(HexBinary.decode(issuerData.get("91")));
        if (resp.getSw12()==0x9000) { 
        	System.out.println("发卡行认证-外部认证成功");
        	System.out.println("联机授权完成");
        }


        System.out.println("==============进行最终检查以及生成最终应用密文===================");
        System.out.println("卡片风险管理数据对象列表2(CDOL2)[8D]：" + cardDataMap.get("8D"));
        Map<String,String> cdol2= TlvParseUtils.parseCDOLforGenerateAc(HexBinary.decode(cardDataMap.get("8D")));

        System.out.println("=========卡片第二次GenerateAc需要参数");
		Set<String> cdol2keys = cdol2.keySet();
		String cdol2data = "";
		for (String name:cdol2keys) {
			String data = "";
			// 8A 发卡行授权码 从授权返回信息中返回
			if (name.equals("8A")) {
				data = issuerData.get("8A");
			} else {
				data = terminalData.get(name);
			}
			System.out.println("["+name+"]:" + data);
			cdol2data = cdol2data + data;
		}
		System.out.println("cdol2数据：" + cdol2data);
		// 第二次GenerateAc请求类型为TC
		resp = reader.generateAc(HexBinary.decode(cdol2data), (byte)0x40);
        
        System.out.println("==============外部认证结束=====================");
        System.out.println("==============发卡行脚本====================");
        
        System.out.println("执行发卡行脚本！！！");
        if (issuerData.get("72")!=null && !issuerData.get("72").equals("")) {
        	resp = reader.issuerBankScripts(HexBinary.decode(issuerData.get("72")));
        }
        System.out.println("==============读取卡内余额====================");
        resp = reader.getBalance();
        String res=String.valueOf(resp);
        System.out.println("执行结果："+res);
		// 发卡行授权处理必须字段放入 result
		Map<String,String> afterResult = new LinkedHashMap<String, String>();	
		return afterResult;
		 //System.out.println("CardNo:" + cardNo + " seqNo:" + cardSeqNo);
	}
	/**
	 * 获取计算密钥分散数据
	 * @param acctNO
	 * @param appNO
	 * @return
	 */
	private static String getPAN(String acctNO, String appNO) {
		String subAppNO = appNO.substring(0, 2);
		String pan = acctNO.substring(acctNO.length() - 14, acctNO.length())
				+ subAppNO;
		return pan;
	}
	
	/**
	 * Arqc计算元数据
	 * @param data
	 * @return
	 */
	public static String getArqcDataSrc(Map<String,String> data) {
		String dataSrc = "";
		dataSrc = dataSrc + data.get("9F02");
		dataSrc = dataSrc + data.get("9F03");
		dataSrc = dataSrc + data.get("9F1A");
		dataSrc = dataSrc + data.get("95");
		// 交易货币代码
		dataSrc = dataSrc + data.get("5F2A");
		dataSrc = dataSrc + data.get("9A");
		dataSrc = dataSrc + data.get("9C");
		dataSrc = dataSrc + data.get("9F37");
		dataSrc = dataSrc + data.get("82");
		dataSrc = dataSrc + data.get("9F36");
		// 发卡行数据中截取CVR
		// 例：07 01 01 03A0B0 0001 0A0100000000009A09BEEB
		dataSrc = dataSrc + data.get("9F10").substring(6,14);
		return dataSrc;
	}
}
