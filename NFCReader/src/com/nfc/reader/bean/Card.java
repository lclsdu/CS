package com.nfc.reader.bean;

import java.util.Collection;
import java.util.LinkedHashMap;

import com.nfc.reader.SPEC;
/**
 * 卡片实体类 
 * @author unicom
 *
 */
public class Card extends Application {
	public static final Card EMPTY = new Card();

	private final LinkedHashMap<Object, Application> applications;

	public Card() {
		applications = new LinkedHashMap<Object, Application>(2);
	}

	public Exception getReadingException() {
		return (Exception) getProperty(SPEC.PROP.EXCEPTION);
	}

	public boolean hasReadingException() {
		return hasProperty(SPEC.PROP.EXCEPTION);
	}

	public final boolean isUnknownCard() {
		return applicationCount() == 0;
	}

	public final int applicationCount() {
		return applications.size();
	}

	public final Collection<Application> getApplications() {
		return applications.values();
	}

	public final void addApplication(Application app) {
		if (app != null) {
			Object id = app.getProperty(SPEC.PROP.ID);
			if (id != null && !applications.containsKey(id))
				applications.put(id, app);
		}
	}

	public String toHtml() {
		return HtmlFormatter.formatCardInfo(this);
	}
}
