package com.nfc.reader;

import com.nfc.reader.bean.CityCode;

public final class SPEC {
	public enum PAGE {
		DEFAULT, INFO, ABOUT,
	}

	public enum EVENT {
		IDLE, ERROR, READING, FINISHED,
	}

	public enum PROP {
		ID(R.string.spec_prop_id),							//ID号码
		SERIAL(R.string.spec_prop_serial),     			//序列号
		PARAM(R.string.spec_prop_param),			//参数
		VERSION(R.string.spec_prop_version),		//版本号
		DATE(R.string.spec_prop_date),					//日期
		COUNT(R.string.spec_prop_count),			//交易次数
		CURRENCY(R.string.spec_prop_currency),	//币种
		TLIMIT(R.string.spec_prop_tlimit),				//最高限额
		DLIMIT(R.string.spec_prop_dlimit),				//最低限额
		ECASH(R.string.spec_prop_ecash),				//电子现金
		BALANCE(R.string.spec_prop_balance),		//余额
		OLIMIT(R.string.spec_prop_olimit),				//透支上限
		TRANSLOG(R.string.spec_prop_translog),	//交易日志
		ACCESS(R.string.spec_prop_access),			//访问受限
		EXCEPTION(R.string.spec_prop_exception);//异常信息

		public String toString() {
			return ThisApplication.getStringResource(resId);
		}

		private final int resId;

		private PROP(int resId) {
			this.resId = resId;
		}
	}

	public enum APP {
		UNKNOWN(R.string.spec_app_unknown),
		UNKNOWNCITY(R.string.spec_zip_unknown),
		SHENZHENTONG(R.string.spec_app_shenzhentong),
		QUICKPASS(R.string.spec_app_quickpass),
		OCTOPUS(R.string.spec_app_octopus_hk),
		BEIJINGMUNICIPAL(R.string.spec_app_beijing),
		WUHANTONG(R.string.spec_app_wuhantong),
		CHANGANTONG(R.string.spec_app_changantong),
		SHANGHAIGJ(R.string.spec_app_shanghai),
		DEBIT(R.string.spec_app_debit),
		CREDIT(R.string.spec_app_credit),
		QCREDIT(R.string.spec_app_qcredit),
		TUNIONEC(R.string.spec_app_tunion_ec),
		TUNIONEP(R.string.spec_app_tunion_ep),
		CITYUNION(R.string.spec_app_cityunion);

		public String toString() {
			return ThisApplication.getStringResource(resId);
		}

		private final int resId;

		private APP(int resId) {
			this.resId = resId;
		}
	}

	public enum CUR {
		UNKNOWN(R.string.spec_cur_unknown),
		USD(R.string.spec_cur_usd),
		CNY(R.string.spec_cur_cny),
		HKD(R.string.spec_cur_hkd);

		public String toString() {
			return ThisApplication.getStringResource(resId);
		}

		private final int resId;

		private CUR(int resId) {
			this.resId = resId;
		}
	}

	public static final String TAG_BLK = "div";
	public static final String TAG_TIP = "t_tip";
	public static final String TAG_ACT = "t_action";
	public static final String TAG_EM = "t_em";
	public static final String TAG_H1 = "t_head1";
	public static final String TAG_H2 = "t_head2";
	public static final String TAG_H3 = "t_head3";
	public static final String TAG_SP = "t_splitter";
	public static final String TAG_TEXT = "t_text";
	public static final String TAG_LAB = "t_label";
	public static final String TAG_PARAG = "t_parag";
	
	
	public static String getCityUnionCardNameByZipcode(String zip) {
			String name=CityCode.getCityCode(zip);
		if(name!=null){
			return String.format(APP.CITYUNION.toString(), name);
		}
		return String.format(APP.CITYUNION.toString(), APP.UNKNOWNCITY.toString());
	}
}
