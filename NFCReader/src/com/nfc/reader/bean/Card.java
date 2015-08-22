package com.nfc.reader.bean;

import java.util.Collection;
import java.util.LinkedHashMap;

import com.nfc.reader.SpecConf;
/**
 * 卡片实体类 
 * @author unicom
 *
 */
public class Card extends CardApplications {
	private static final long serialVersionUID = 1L;

	public static final Card EMPTY = new Card();

	private final LinkedHashMap<Object, CardApplications> applications;

	public Card() {
		applications = new LinkedHashMap<Object, CardApplications>(2);
	}

	public Exception getReadingException() {
		return (Exception) getProperty(SpecConf.PROP.EXCEPTION);
	}

	public boolean hasReadingException() {
		return hasProperty(SpecConf.PROP.EXCEPTION);
	}

	public final boolean isUnknownCard() {
		return applicationCount() == 0;
	}

	public final int applicationCount() {
		return applications.size();
	}

	public final Collection<CardApplications> getApplications() {
		return applications.values();
	}

	public final void addApplication(CardApplications app) {
		if (app != null) {
			Object id = app.getProperty(SpecConf.PROP.ID);
			if (id != null && !applications.containsKey(id))
				applications.put(id, app);
		}
	}

	public String toHtml() {
		return HtmlFormatter.formatCardInfo(this);
	}
}
