package com.nf.reader.utils;



import java.io.IOException;
import java.nio.ByteBuffer;
import java.util.Arrays;

import javax.smartcardio.CardChannel;
import javax.smartcardio.CardException;
import javax.smartcardio.CommandAPDU;
import javax.smartcardio.ResponseAPDU;

import com.nfc.reader.tech.Iso7816;


public class Pboc20Reader {
	Iso7816.StdTag  tag;
	public static final short SW_NO_ERROR = (short) 0x9000;
	public static final short SW_BYTES_REMAINING_00 = 0x6100;
	public static final short SW_WRONG_LENGTH = 0x6700;
	public static final short SW_SECURITY_STATUS_NOT_SATISFIED = 0x6982;
	public static final short SW_FILE_INVALID = 0x6983;
	public static final short SW_DATA_INVALID = 0x6984;
	public static final short SW_CONDITIONS_NOT_SATISFIED = 0x6985;
	public static final short SW_COMMAND_NOT_ALLOWED = 0x6986;
	public static final short SW_APPLET_SELECT_FAILED = 0x6999;
	public static final short SW_WRONG_DATA = 0x6A80;
	public static final short SW_FUNC_NOT_SUPPORTED = 0x6A81;
	public static final short SW_FILE_NOT_FOUND = 0x6A82;
	public static final short SW_RECORD_NOT_FOUND = 0x6A83;
	public static final short SW_INCORRECT_P1P2 = 0x6A86;
	public static final short SW_WRONG_P1P2 = 0x6B00;
	public static final short SW_CORRECT_LENGTH_00 = 0x6C00;
	public static final short SW_INS_NOT_SUPPORTED = 0x6D00;
	public static final short SW_CLA_NOT_SUPPORTED = 0x6E00;
	public static final short SW_UNKNOWN = 0x6F00;
	public static final short SW_FILE_FULL = 0x6A84;
	
	public Pboc20Reader(Iso7816.StdTag tag) {
		this.tag = tag;
	}

	/**
	 * select
	 * @param name
	 * @return
	 */
	public Response selectByName(byte... name) {
		ByteBuffer buff = ByteBuffer.allocate(name.length + 6);
		buff.put((byte) 0x00) // CLA Class
				.put((byte) 0xA4) // INS Instruction
				.put((byte) 0x04) // P1 Parameter 1
				.put((byte) 0x00) // P2 Parameter 2
				.put((byte) name.length) // Lc
				.put(name).put((byte) 0x00); // Le

		return transceive(buff.array());
	}
	
	public Response readRecord(int sfi, int index) {
		final byte[] cmd = { (byte) 0x00, // CLA Class
				(byte) 0xB2, // INS Instruction
				(byte) index, // P1 Parameter 1
				(byte) ((sfi << 3) | 0x04), // P2 Parameter 2
				(byte) 0x00, // Le
		};

		return transceive(cmd);
	}
	
	/**
	 * Gpo
	 * @param gpoData
	 * @return
	 */
	public Response gpo(byte[] gpoData) {
		ByteBuffer buff = ByteBuffer.allocate(gpoData.length + 6);
		buff.put((byte) 0x80) // CLA Class
				.put((byte) 0xA8) // INS Instruction
				.put((byte) 0x00) // P1 Parameter 1
				.put((byte) 0x00) // P2 Parameter 2
				.put((byte) gpoData.length) // Lc
				.put(gpoData).put((byte) 0x00); // Le
		return transceive(buff.array());
	}
	
	public Response externalAuth(byte[] arpc) {
		ByteBuffer buff = ByteBuffer.allocate(arpc.length + 6);
		buff.put((byte) 0x00) // CLA Class
				.put((byte) 0x82) // INS Instruction
				.put((byte) 0x00) // P1 Parameter 1
				.put((byte) 0x00) // P2 Parameter 2
				.put((byte) arpc.length) // Lc
				.put(arpc).put((byte) 0x00); // Le
		return transceive(buff.array());
	}
	/**
	 * Generate Ac
	 * @param gpoData
	 * @return
	 */
	public Response generateAc(byte[] cdolData, byte p1) {
		ByteBuffer buff = ByteBuffer.allocate(cdolData.length + 6);
		buff.put((byte) 0x80) // CLA Class
				.put((byte) 0xAE) // INS Instruction
				.put(p1) // P1 Parameter 1
				.put((byte) 0x00) // P2 Parameter 2
				.put((byte) cdolData.length) // Lc
				.put(cdolData).put((byte) 0x00); // Le测试屏蔽
		return transceive(buff.array());
	}
	
	
	public Response updateData(byte[] Data, byte p1, byte p2) {
		ByteBuffer buff = ByteBuffer.allocate(Data.length + 6);
		buff.put((byte) 0x04) // CLA Class
				.put((byte) 0xDC) // INS Instruction
				.put(p1) // P1 Parameter 1
				.put(p2) // P2 Parameter 2
				.put((byte) Data.length) // Lc
				.put(Data).put((byte) 0x00); // Le
		return transceive(buff.array());
	}
	/**
	 * 发卡行脚本执行
	 * @param gpoData
	 * @return
	 */
	public Response issuerBankScripts(byte[] scripts) {
		return transceive(scripts);
	}
	
	/**
	 * 获取余额
	 * @param isEP
	 * @return
	 */
	public Response getBalance() {
		final byte[] cmd = { (byte) 0x80, // CLA Class
				(byte) 0xCA, // INS Instruction
				(byte) 0x9F, // P1 Parameter 1
				(byte) 0x79, // P2 Parameter 2
				(byte) 0x04, // Le
		};

		return transceive(cmd);
	}
	/**
	 * resp
	 * @author sparrow
	 *
	 */
	public final static class Response {
		public static final byte[] EMPTY = {};
		public static final byte[] ERROR = { 0x6F, 0x00 }; // SW_UNKNOWN
		protected byte[] data;

		public Response(byte[] bytes) {
			data = (bytes == null || bytes.length < 2) ? Response.ERROR : bytes;
		}

		public byte getSw1() {
			return data[data.length - 2];
		}

		public byte getSw2() {
			return data[data.length - 1];
		}

		public short getSw12() {
			final byte[] d = this.data;
			int n = d.length;
			return (short) ((d[n - 2] << 8) | (0xFF & d[n - 1]));
		}

		public boolean isOkey() {
			return equalsSw12(SW_NO_ERROR);
		}

		public boolean equalsSw12(short val) {
			return getSw12() == val;
		}

		public int size() {
			return data.length - 2;
		}

		public byte[] getBytes() {
//			return isOkey() ? Arrays.copyOfRange(data, 0, size())
//					: Response.EMPTY;
			return Arrays.copyOfRange(data, 0, size());
		}
	}
	
	public Response transceive(byte[] cmmdByte) {
		if (tag == null) 
			new Response(null);
		System.out.println("Send------->" + HexBinary.encode(cmmdByte));
		byte[] resp = null;
		try {
			resp = tag.transceive(cmmdByte);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("return<-------" + HexBinary.encode(resp));
		return new Response(resp);
	}
}
