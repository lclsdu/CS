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

package com.nfc.reader.bean;

import java.util.Collection;

import com.nfc.reader.SpecConf;
/**
 * 拼凑html代码类
 * @author unicom
 *
 */
public final class HtmlFormatter {
	static String formatCardInfo(Card card) {

		final StringBuilder ret = new StringBuilder();
		//<div>
		startTag(ret, SpecConf.TAG_BLK);
		//卡片上应用数目
		Collection<CardApplications> apps = card.getApplications();

		boolean first = true;
		for (CardApplications app : apps) {

			if (first) {
				first = false;
			} else {
				//第二个应用信息空两行
				//<br/>
				newline(ret);
				//<br/>
				newline(ret);
			}

			formatApplicationInfo(ret, app);
		}

		endTag(ret, SpecConf.TAG_BLK);

		return ret.toString();
	}

	private static void startTag(StringBuilder out, String tag) {
		out.append('<').append(tag).append('>');
	}

	private static void endTag(StringBuilder out, String tag) {
		out.append('<').append('/').append(tag).append('>');
	}

	private static void newline(StringBuilder out) {
		out.append("<br />");
	}

	private static void spliter(StringBuilder out) {
		out.append("\n<").append(SpecConf.TAG_SP).append(" />\n");
	}

	private static boolean formatProperty(StringBuilder out, String tag, Object value) {
		if (value == null)
			return false;
		//<t_head1>
		startTag(out, tag);
		out.append(value.toString());
		endTag(out, tag);

		return true;
	}

	private static boolean formatProperty(StringBuilder out, String tag, Object prop, String value) {
		if (value == null || value.isEmpty())
			return false;

		startTag(out, tag);
		out.append(prop.toString());
		endTag(out, tag);

		startTag(out, SpecConf.TAG_TEXT);
		out.append(value);
		endTag(out, SpecConf.TAG_TEXT);

		return true;
	}

	private static boolean formatApplicationInfo(StringBuilder out, CardApplications app) {
		//卡号
		if (!formatProperty(out, SpecConf.TAG_H1, app.getProperty(SpecConf.PROP.ID)))
			return false;
		//<br/>
		newline(out);
		spliter(out);
		newline(out);
		

		{
			SpecConf.PROP prop = SpecConf.PROP.SERIAL;
			if (formatProperty(out, SpecConf.TAG_LAB, prop, app.getStringProperty(prop)))
				newline(out);
		}
		//卡應用序列號
		{
			SpecConf.PROP prop = SpecConf.PROP.APPSERIAL;
			if (formatProperty(out, SpecConf.TAG_LAB, prop, app.getStringProperty(prop)))
				newline(out);
		}
		{
			SpecConf.PROP prop = SpecConf.PROP.PARAM;
			if (formatProperty(out, SpecConf.TAG_LAB, prop, app.getStringProperty(prop)))
				newline(out);
		}
		//版本号
		{
			SpecConf.PROP prop = SpecConf.PROP.VERSION;
			if (formatProperty(out, SpecConf.TAG_LAB, prop, app.getStringProperty(prop)))
				newline(out);
		}
		//日期
		{
			SpecConf.PROP prop = SpecConf.PROP.DATE;
			if (formatProperty(out, SpecConf.TAG_LAB, prop, app.getStringProperty(prop)))
				newline(out);
		}
		//交易次数
		{
			SpecConf.PROP prop = SpecConf.PROP.COUNT;
			if (formatProperty(out, SpecConf.TAG_LAB, prop, app.getStringProperty(prop)))
				newline(out);
		}
		
		{
			SpecConf.PROP prop = SpecConf.PROP.TLIMIT;
			Float balance = (Float) app.getProperty(prop);
			if (balance != null && !balance.isNaN()) {
				String cur = app.getProperty(SpecConf.PROP.CURRENCY).toString();
				String val = String.format("%.2f %s", balance, cur);
				if (formatProperty(out, SpecConf.TAG_LAB, prop, val))
					newline(out);
			}
		}

		{
			SpecConf.PROP prop = SpecConf.PROP.DLIMIT;
			Float balance = (Float) app.getProperty(prop);
			if (balance != null && !balance.isNaN()) {
				String cur = app.getProperty(SpecConf.PROP.CURRENCY).toString();
				String val = String.format("%.2f %s", balance, cur);
				if (formatProperty(out, SpecConf.TAG_LAB, prop, val))
					newline(out);
			}
		}

		{
			SpecConf.PROP prop = SpecConf.PROP.ECASH;
			Float balance = (Float) app.getProperty(prop);

			if (balance != null) {
				formatProperty(out, SpecConf.TAG_LAB, prop);
				if (balance.isNaN()) {
					out.append(SpecConf.PROP.ACCESS);
				} else {
					formatProperty(out, SpecConf.TAG_H2, String.format("%.2f ", balance));
					formatProperty(out, SpecConf.TAG_LAB, app.getProperty(SpecConf.PROP.CURRENCY)
							.toString());
				}
				newline(out);
			}
		}

		{
			SpecConf.PROP prop = SpecConf.PROP.BALANCE;
			Float balance = (Float) app.getProperty(prop);

			if (balance != null) {
				formatProperty(out, SpecConf.TAG_LAB, prop);
				if (balance.isNaN()) {
					out.append(SpecConf.PROP.ACCESS);
				} else {
					formatProperty(out, SpecConf.TAG_H2, String.format("%.2f ", balance));
					formatProperty(out, SpecConf.TAG_LAB, app.getProperty(SpecConf.PROP.CURRENCY)
							.toString());
				}
				newline(out);
			}
		}

		{
			SpecConf.PROP prop = SpecConf.PROP.OLIMIT;
			Float balance = (Float) app.getProperty(prop);
			if (balance != null && !balance.isNaN()) {
				String cur = app.getProperty(SpecConf.PROP.CURRENCY).toString();
				String val = String.format("%.2f %s", balance, cur);
				if (formatProperty(out, SpecConf.TAG_LAB, prop, val))
					newline(out);
			}
		}

		{
			SpecConf.PROP prop = SpecConf.PROP.TRANSLOG;
			String[] logs = (String[]) app.getProperty(prop);
			if (logs != null && logs.length > 0) {

				spliter(out);
				newline(out);

				startTag(out, SpecConf.TAG_PARAG);

				formatProperty(out, SpecConf.TAG_LAB, prop);
				newline(out);

				endTag(out, SpecConf.TAG_PARAG);

				for (String log : logs) {
					formatProperty(out, SpecConf.TAG_H3, log);
					newline(out);
				}

				newline(out);
			}
		}

		return true;
	}
}
