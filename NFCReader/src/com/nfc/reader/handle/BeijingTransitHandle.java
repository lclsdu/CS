package com.nfc.reader.handle;

import java.io.IOException;
import java.util.ArrayList;

import com.nfc.reader.SpecConf;
import com.nfc.reader.Util;
import com.nfc.reader.bean.CardApplications;
import com.nfc.reader.bean.Card;
import com.nfc.reader.tech.Iso7816;

final class BeijingTransitHandle extends ProtocolAssembler {

	@Override
	protected SpecConf.APP getApplicationId() {
		return SpecConf.APP.BEIJINGMUNICIPAL;
	}

	@SuppressWarnings("unchecked")
	@Override
	protected HINT readCard(Iso7816.StdTag tag, Card card) throws IOException {

		Iso7816.Response INFO, CNT, BALANCE;

		/*--------------------------------------------------------------*/
		// read card info file, binary (4)
		/*--------------------------------------------------------------*/
		INFO = tag.readBinary(SFI_EXTRA_LOG);
		if (!INFO.isOkey())
			return HINT.GONEXT;

		/*--------------------------------------------------------------*/
		// read card operation file, binary (5)
		/*--------------------------------------------------------------*/
		CNT = tag.readBinary(SFI_EXTRA_CNT);

		/*--------------------------------------------------------------*/
		// select Main Application
		/*--------------------------------------------------------------*/
		if (!tag.selectByID(DFI_EP).isOkey())
			return HINT.RESETANDGONEXT;

		BALANCE = tag.getBalance(0, true);

		/*--------------------------------------------------------------*/
		// read log file, record (24)
		/*--------------------------------------------------------------*/
		ArrayList<byte[]> LOG = readLog24(tag, SFI_LOG);

		/*--------------------------------------------------------------*/
		// build result
		/*--------------------------------------------------------------*/
		final CardApplications app = createApplication();

		parseBalance(app, BALANCE);

		parseInfo4(app, INFO, CNT);

		parseLog24(app, LOG);

		configApplication(app);

		card.addApplication(app);

		return HINT.STOP;
	}

	private final static int SFI_EXTRA_LOG = 4;
	private final static int SFI_EXTRA_CNT = 5;

	private void parseInfo4(CardApplications app, Iso7816.Response info,
			Iso7816.Response cnt) {

		if (!info.isOkey() || info.size() < 32) {
			return;
		}

		final byte[] d = info.getBytes();
		app.setProperty(SpecConf.PROP.SERIAL, Util.toHexString(d, 0, 8));
		app.setProperty(SpecConf.PROP.VERSION,
				String.format("%02X.%02X%02X", d[8], d[9], d[10]));
		app.setProperty(SpecConf.PROP.DATE, String.format(
				"%02X%02X.%02X.%02X - %02X%02X.%02X.%02X", d[24], d[25], d[26],
				d[27], d[28], d[29], d[30], d[31]));

		if (cnt != null && cnt.isOkey() && cnt.size() > 4) {
			byte[] e = cnt.getBytes();
			final int n = Util.toInt(e, 1, 4);
			if (e[0] == 0)
				app.setProperty(SpecConf.PROP.COUNT, String.format("%d", n));
			else
				app.setProperty(SpecConf.PROP.COUNT, String.format("%d*", n));
		}
	}
}
