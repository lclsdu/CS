package com.nfc.reader.handle;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import android.util.Log;

import com.nf.reader.utils.PBOCECLoad;
import com.nf.reader.utils.Pboc20Reader;
import com.nfc.reader.SpecConf;
import com.nfc.reader.Util;
import com.nfc.reader.bean.CardApplications;
import com.nfc.reader.bean.Card;
import com.nfc.reader.bean.IssuerBankName;
import com.nfc.reader.tech.Iso7816;
import com.nfc.reader.tech.Iso7816.BerHouse;
import com.nfc.reader.tech.Iso7816.BerTLV;

final class ECashHandle extends ProtocolAssembler {
	protected final static byte[] DFN_PPSE = { (byte) '2', (byte) 'P', (byte) 'A', (byte) 'Y',
			(byte) '.', (byte) 'S', (byte) 'Y', (byte) 'S', (byte) '.', (byte) 'D', (byte) 'D',
			(byte) 'F', (byte) '0', (byte) '1', };

	protected final static byte[] AID_DEBIT = { (byte) 0xA0, 0x00, 0x00, 0x03, 0x33, 0x01, 0x01,
			0x01 };
	protected final static byte[] AID_CREDIT = { (byte) 0xA0, 0x00, 0x00, 0x03, 0x33, 0x01, 0x01,
			0x02 };
	protected final static byte[] AID_QUASI_CREDIT = { (byte) 0xA0, 0x00, 0x00, 0x03, 0x33, 0x01,
			0x01, 0x03 };

	public final static short MARK_LOG = (short) 0xDFFF;

	protected final static short[] TAG_GLOBAL = { (short) 0x9F79 /* 电子现金余额 */,
			(short) 0x9F78 /* 电子现金单笔上限 */, (short) 0x9F77 /* 电子现金余额上限 */,
			(short) 0x9F13 /* 联机ATC */, (short) 0x9F36 /* ATC */, (short) 0x9F51 /* 货币代码 */,
			(short) 0x9F4F /* 日志文件格式 */, (short) 0x9F4D /* 日志文件ID */, (short) 0x5A /* 帐号 */,
			(short) 0x5F24 /* 失效日期 */, (short) 0x5F25 /* 生效日期 */, (short) 0xDF63 /* 透支数目 */,
			(short) 0xDF62 /* 透支上限 */, (short)0x5F34/*应用序列号*/,};
   /**
    * 55域基本信息
    * 9F26 应用密文；      9F27 密文信息数据 ；
    * 9F10 发卡行应用数据；9F37 不可预知数；
    * 9F36 应用交易计数器；95 终端验证结果；9A 交易日期；
    * 9C 交易类型；9F02 授权金额；5F2A 交易货币代码；82 应用交互特征；
    * 9F1A 终端国家代码 ；9F03 其它金额；9F33 终端性能
    */
	@Override
	protected SpecConf.APP getApplicationId() {
		return SpecConf.APP.UNKNOWN;
	}

	@Override
	protected boolean resetTag(Iso7816.StdTag tag) throws IOException {
		Iso7816.Response rsp = tag.selectByName(DFN_PPSE);
		if (!rsp.isOkey())
			return false;

		BerTLV.extractPrimitives(topTLVs, rsp);
		return true;
	}

	protected HINT readCard(Iso7816.StdTag tag, Card card) throws IOException {
		
		final ArrayList<Iso7816.ID> aids = getApplicationIds(tag);
		Pboc20Reader reader=new Pboc20Reader(tag);
		Map<String, String> beforeMap=null;
		try {
			beforeMap=PBOCECLoad.transBerore(reader);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Log.d("com.nfc.reader", beforeMap.get("9F26").toString());
		
		
		
		for (Iso7816.ID aid : aids) {

			/*--------------------------------------------------------------*/
			// select application
			/*--------------------------------------------------------------*/
			Iso7816.Response rsp = tag.selectByName(aid.getBytes());
			if (!rsp.isOkey())
				continue;

			final BerHouse subTLVs = new BerHouse();

			/*--------------------------------------------------------------*/
			// collect info
			/*--------------------------------------------------------------*/
			BerTLV.extractPrimitives(subTLVs, rsp);

			collectTLVFromGlobalTags(tag, subTLVs);

			/*--------------------------------------------------------------*/
			// parse PDOL and get processing options
			// 这是正规途径，但是每次GPO都会使ATC加1，达到65535卡片就锁定了
			/*--------------------------------------------------------------*/
			// rsp = tag.getProcessingOptions(buildPDOL(subTLVs));
			// if (rsp.isOkey())
			// BerTLV.extractPrimitives(subTLVs, rsp);

			/*--------------------------------------------------------------*/
			// 遍历目录下31个文件，山寨途径，微暴力，不知会对卡片折寿多少
			// 相对于GPO不停的增加ATC，这是一种折中
			// (遍历过程一般不会超过15个文件就会结束)
			/*--------------------------------------------------------------*/
			collectTLVFromRecords(tag, subTLVs);

			// String dump = subTLVs.toString();

			/*--------------------------------------------------------------*/
			// build result
			/*--------------------------------------------------------------*/
			final CardApplications app = createApplication();

			parseInfo(app, subTLVs);

			parseLogs(app, subTLVs);

			card.addApplication(app);
		}

		return card.isUnknownCard() ? HINT.RESETANDGONEXT : HINT.STOP;
	}

	private static void parseInfo(CardApplications app, BerHouse tlvs) {
		String pan = parseString(tlvs, (short) 0x5A);
		if (pan != null) {
			if (pan.length() > 19)
				pan = pan.substring(0, 19);

			app.setProperty(SpecConf.PROP.SERIAL, pan);
		}
		String issuerBankName = IssuerBankName.getIssuerName(pan.substring(0,6));
		Object prop = parseApplicationName(tlvs, pan);
		if (prop != null)
			app.setProperty(SpecConf.PROP.ID, issuerBankName+prop.toString());

		prop = parseInteger(tlvs, (short) 0x9F08);
		if (prop != null)
			app.setProperty(SpecConf.PROP.VERSION, prop);

		prop = parseInteger(tlvs, (short) 0x9F36);
		if (prop != null)
			app.setProperty(SpecConf.PROP.COUNT, prop);
		/**
		 * 应用序列号
		 */
		prop = parseInteger(tlvs, (short) 0x5F34);
		if (prop != null)
			Log.d("com.nfc.reader", prop.toString());
			app.setProperty(SpecConf.PROP.APPSERIAL, prop);

		prop = parseValidity(tlvs, (short) 0x5F25, (short) 0x5F24);
		if (prop != null)
			app.setProperty(SpecConf.PROP.DATE, prop);

		prop = parseCurrency(tlvs, (short) 0x9F51);
		if (prop != null)
			app.setProperty(SpecConf.PROP.CURRENCY, prop);

		prop = parseAmount(tlvs, (short) 0x9F77);
		if (prop != null)
			app.setProperty(SpecConf.PROP.DLIMIT, prop);

		prop = parseAmount(tlvs, (short) 0x9F78);
		if (prop != null)
			app.setProperty(SpecConf.PROP.TLIMIT, prop);

		Float balance = parseAmount(tlvs, (short) 0x9F79);
		if (balance != null) {
			if (balance < 0.01f) {
				Float over = parseAmount(tlvs, (short) 0xDF63);
				if (over != null && over > 0.01f) {
					balance -= over;
					Float limit = parseAmount(tlvs, (short) 0xDF62);
					app.setProperty(SpecConf.PROP.OLIMIT, limit);
				}
			}

			app.setProperty(SpecConf.PROP.ECASH, balance);
		}
	}

	private ArrayList<Iso7816.ID> getApplicationIds(Iso7816.StdTag tag) throws IOException {

		final ArrayList<Iso7816.ID> ret = new ArrayList<Iso7816.ID>();

		// try to read DDF
		BerTLV sfi = topTLVs.findFirst(Iso7816.BerT.CLASS_SFI);
		if (sfi != null && sfi.length() == 1) {
			final int SFI = sfi.v.toInt();
			Iso7816.Response r = tag.readRecord(SFI, 1);
			for (int p = 2; r.isOkey(); ++p) {
				BerTLV.extractPrimitives(topTLVs, r);
				r = tag.readRecord(SFI, p);
			}
		}

		// add extracted
		ArrayList<BerTLV> aids = topTLVs.findAll(Iso7816.BerT.CLASS_AID);
		if (aids != null) {
			for (BerTLV aid : aids)
				ret.add(new Iso7816.ID(aid.v.getBytes()));
		}

		// use default list
		if (ret.isEmpty()) {
			ret.add(new Iso7816.ID(AID_DEBIT));
			ret.add(new Iso7816.ID(AID_CREDIT));
			ret.add(new Iso7816.ID(AID_QUASI_CREDIT));
		}

		return ret;
	}

	/**
	 * private static void buildPDO(ByteBuffer out, int len, byte... val) {
	 * final int n = Math.min((val != null) ? val.length : 0, len);
	 * 
	 * int i = 0; while (i < n) out.put(val[i++]);
	 * 
	 * while (i++ < len) out.put((byte) 0); }
	 * 
	 * private static byte[] buildPDOL(Iso7816.BerHouse tlvs) {
	 * 
	 * final ByteBuffer buff = ByteBuffer.allocate(64);
	 * 
	 * buff.put((byte) 0x83).put((byte) 0x00);
	 * 
	 * try { final byte[] pdol = tlvs.findFirst((short) 0x9F38).v.getBytes();
	 * 
	 * ArrayList<BerTLV> list = BerTLV.extractOptionList(pdol); for
	 * (Iso7816.BerTLV tlv : list) { final int tag = tlv.t.toInt(); final int
	 * len = tlv.l.toInt();
	 * 
	 * switch (tag) { case 0x9F66: // 终端交易属性 buildPDO(buff, len, (byte) 0x48);
	 * break; case 0x9F02: // 授权金额 buildPDO(buff, len); break; case 0x9F03: //
	 * 其它金额 buildPDO(buff, len); break; case 0x9F1A: // 终端国家代码 buildPDO(buff,
	 * len, (byte) 0x01, (byte) 0x56); break; case 0x9F37: // 不可预知数
	 * buildPDO(buff, len); break; case 0x5F2A: // 交易货币代码 buildPDO(buff, len,
	 * (byte) 0x01, (byte) 0x56); break; case 0x95: // 终端验证结果 buildPDO(buff,
	 * len); break; case 0x9A: // 交易日期 buildPDO(buff, len); break; case 0x9C: //
	 * 交易类型 buildPDO(buff, len); break; default: throw null; } } // 更新数据长度
	 * buff.put(1, (byte) (buff.position() - 2)); } catch (Exception e) {
	 * buff.position(2); }
	 * 
	 * return Arrays.copyOfRange(buff.array(), 0, buff.position()); }
	 */

	private static void collectTLVFromGlobalTags(Iso7816.StdTag tag, BerHouse tlvs)
			throws IOException {

		for (short t : TAG_GLOBAL) {
			Iso7816.Response r = tag.getData(t);
			if (r.isOkey())
				tlvs.add(BerTLV.read(r));
		}
	}

	private static void collectTLVFromRecords(Iso7816.StdTag tag, BerHouse tlvs) throws IOException {

		// info files
		for (int sfi = 1; sfi <= 10; ++sfi) {
			Iso7816.Response r = tag.readRecord(sfi, 1);
			for (int idx = 2; r.isOkey() && idx <= 10; ++idx) {
				BerTLV.extractPrimitives(tlvs, r);
				r = tag.readRecord(sfi, idx);
			}
		}

		// check if already get sfi of log file
		BerTLV logEntry = tlvs.findFirst((short) 0x9F4D);

		final int S, E;
		if (logEntry != null && logEntry.length() == 2) {
			S = E = logEntry.v.getBytes()[0] & 0x000000FF;
		} else {
			S = 11;
			E = 31;
		}

		// log files
		for (int sfi = S; sfi <= E; ++sfi) {
			Iso7816.Response r = tag.readRecord(sfi, 1);
			boolean findOne = r.isOkey();

			for (int idx = 2; r.isOkey() && idx <= 10; ++idx) {
				tlvs.add(MARK_LOG, r);
				r = tag.readRecord(sfi, idx);
			}

			if (findOne)
				break;
		}
	}

	private static SpecConf.APP parseApplicationName(BerHouse tlvs, String serial) {
		String f = parseString(tlvs, (short) 0x84);
		if (f != null) {
			Matcher m = Pattern.compile("^([0-9A-F]{10})([0-9A-F]{6})").matcher(f);
			if (m.find()) {
				String rid = m.group(1);
				String pix = m.group(2);

				if ("A000000333".equals(rid)) {
					if ("010101".equals(pix))
						return SpecConf.APP.DEBIT;

					if ("010102".equals(pix))
						return SpecConf.APP.CREDIT;

					if ("010103".equals(pix))
						return SpecConf.APP.QCREDIT;

				} 
			}
		}

		return SpecConf.APP.UNKNOWN;
	}

	private static SpecConf.CUR parseCurrency(BerHouse tlvs, short tag) {
		return SpecConf.CUR.CNY;
	}

	private static String parseValidity(BerHouse tlvs, short from, short to) {
		final byte[] f = BerTLV.getValue(tlvs.findFirst(from));
		final byte[] t = BerTLV.getValue(tlvs.findFirst(to));

		if (t == null || t.length != 3 || t[0] == 0 || t[0] == (byte) 0xFF)
			return null;

		if (f == null || f.length != 3 || f[0] == 0 || f[0] == (byte) 0xFF)
			return String.format("? - 20%02x.%02x.%02x", t[0], t[1], t[2]);

		return String.format("20%02x.%02x.%02x - 20%02x.%02x.%02x", f[0], f[1], f[2], t[0], t[1],
				t[2]);
	}

	private static String parseString(BerHouse tlvs, short tag) {
		final byte[] v = BerTLV.getValue(tlvs.findFirst(tag));
		return (v != null) ? Util.toHexString(v) : null;
	}

	private static Float parseAmount(BerHouse tlvs, short tag) {
		Integer v = parseIntegerBCD(tlvs, tag);
		return (v != null) ? v / 100.0f : null;
	}

	private static Integer parseInteger(BerHouse tlvs, short tag) {
		final byte[] v = BerTLV.getValue(tlvs.findFirst(tag));
		return (v != null) ? Util.toInt(v) : null;
	}

	private static Integer parseIntegerBCD(BerHouse tlvs, short tag) {
		final byte[] v = BerTLV.getValue(tlvs.findFirst(tag));
		return (v != null) ? Util.BCDtoInt(v) : null;
	}

	private static void parseLogs(CardApplications app, BerHouse tlvs) {
		final byte[] rawTemp = BerTLV.getValue(tlvs.findFirst((short) 0x9F4F));
		if (rawTemp == null)
			return;

		final ArrayList<BerTLV> temp = BerTLV.extractOptionList(rawTemp);
		if (temp == null || temp.isEmpty())
			return;

		final ArrayList<BerTLV> logs = tlvs.findAll(MARK_LOG);

		final ArrayList<String> ret = new ArrayList<String>(logs.size());
		for (BerTLV log : logs) {
			String l = parseLog(temp, log.v.getBytes());
			if (l != null)
				ret.add(l);
		}

		if (!ret.isEmpty())
			app.setProperty(SpecConf.PROP.TRANSLOG, ret.toArray(new String[ret.size()]));
	}

	private static String parseLog(ArrayList<BerTLV> temp, byte[] data) {
		try {
			int date = -1, time = -1;
			int amount = 0, type = -1;

			int cursor = 0;
			for (BerTLV f : temp) {
				final int n = f.length();
				switch (f.t.toInt()) {
				case 0x9A: // 交易日期
					date = Util.BCDtoInt(data, cursor, n);
					break;
				case 0x9F21: // 交易时间
					time = Util.BCDtoInt(data, cursor, n);
					break;
				case 0x9F02: // 授权金额
					amount = Util.BCDtoInt(data, cursor, n);
					break;
				case 0x9C: // 交易类型
					type = Util.BCDtoInt(data, cursor, n);
					break;
				case 0x9F03: // 其它金额
				case 0x9F1A: // 终端国家代码
				case 0x5F2A: // 交易货币代码
				case 0x9F4E: // 商户名称
				case 0x9F36: // 应用交易计数器(ATC)
				default:
					break;
				}
				cursor += n;
			}

			if (amount <= 0)
				return null;

			final char sign;
			switch (type) {
			case 0: // 刷卡消费
			case 1: // 取现
			case 8: // 转账
			case 9: // 支付
			case 20: // 退款
			case 40: // 持卡人账户转账
				sign = '-';
				break;
			default:
				sign = '+';
				break;
			}

			String sd = (date <= 0) ? "****.**.**" : String.format("20%02d.%02d.%02d",
					(date / 10000) % 100, (date / 100) % 100, date % 100);
			String st = (time <= 0) ? "**:**" : String.format("%02d:%02d", (time / 10000) % 100,
					(time / 100) % 100);

			final StringBuilder ret = new StringBuilder();

			ret.append(String.format("%s %s %c%.2f", sd, st, sign, amount / 100f));

			return ret.toString();
		} catch (Exception e) {
			return null;
		}
	}

	private final BerHouse topTLVs = new BerHouse();
}
