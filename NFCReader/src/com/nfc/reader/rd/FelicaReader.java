/* NFCard is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 3 of the License, or
(at your option) any later version.

NFCard is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Wget.  If not, see <http://www.gnu.org/licenses/>.

Additional permission under GNU GPL version 3 section 7 */

package com.nfc.reader.rd;

import java.io.IOException;

import com.nfc.reader.SpecConf;
import com.nfc.reader.Util;
import com.nfc.reader.bean.CardApplications;
import com.nfc.reader.bean.Card;
import com.nfc.reader.tech.FeliCa;

import android.nfc.tech.NfcF;

final class FelicaReader {

	static void readCard(NfcF tech, Card card) throws IOException {

		final FeliCa.Tag tag = new FeliCa.Tag(tech);

		tag.connect();

		/*
		 * 
		FeliCa.SystemCode systems[] = tag.getSystemCodeList();
		if (systems.length == 0) {
			systems = new FeliCa.SystemCode[] { new FeliCa.SystemCode(
					tag.getSystemCodeByte()) };
		}

		for (final FeliCa.SystemCode sys : systems)
			card.addApplication(readApplication(tag, sys.toInt()));
		*/
		
		// better old card compatibility 
		card.addApplication(readApplication(tag, SYS_OCTOPUS));

		try {
			card.addApplication(readApplication(tag, SYS_SZT));
		} catch (IOException e) {
			// for early version of OCTOPUS which will throw shit
		}

		tag.close();
	}

	private static final int SYS_SZT = 0x8005;
	private static final int SYS_OCTOPUS = 0x8008;

	private static final int SRV_SZT = 0x0118;
	private static final int SRV_OCTOPUS = 0x0117;

	private static CardApplications readApplication(FeliCa.Tag tag, int system)
			throws IOException {

		final FeliCa.ServiceCode scode;
		final CardApplications app;
		if (system == SYS_OCTOPUS) {
			app = new CardApplications();
			app.setProperty(SpecConf.PROP.ID, SpecConf.APP.OCTOPUS);
			app.setProperty(SpecConf.PROP.CURRENCY, SpecConf.CUR.HKD);
			scode = new FeliCa.ServiceCode(SRV_OCTOPUS);
		} else {
			return null;
		}

		app.setProperty(SpecConf.PROP.SERIAL, tag.getIDm().toString());
		app.setProperty(SpecConf.PROP.PARAM, tag.getPMm().toString());

		tag.polling(system);

		final float[] data = new float[] { 0, 0, 0 };

		int p = 0;
		for (byte i = 0; p < data.length; ++i) {
			final FeliCa.ReadResponse r = tag.readWithoutEncryption(scode, i);
			if (!r.isOkey())
				break;

			data[p++] = (Util.toInt(r.getBlockData(), 0, 4) - 350) / 10.0f;
		}

		if (p != 0)
			app.setProperty(SpecConf.PROP.BALANCE, parseBalance(data));
		else
			app.setProperty(SpecConf.PROP.BALANCE, Float.NaN);
		
		return app;
	}

	private static float parseBalance(float[] value) {
		float balance = 0f;

		for (float v : value)
			balance += v;

		return balance;
	}
}
