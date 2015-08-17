package com.nfc.reader.bean;

import com.nfc.reader.SPEC;

import android.util.SparseArray;
/**
 * 应用信息的存取类
 * @author unicom
 *
 */
public class Application {
	//SparseArray 性能好于 hashMap  android中建议使用
	private final SparseArray<Object> properties = new SparseArray<Object>();

	public final void setProperty(SPEC.PROP prop, Object value) {
		properties.put(prop.ordinal(), value);
	}

	public final Object getProperty(SPEC.PROP prop) {
		return properties.get(prop.ordinal());
	}

	public final boolean hasProperty(SPEC.PROP prop) {
		return getProperty(prop) != null;
	}

	public final String getStringProperty(SPEC.PROP prop) {
		final Object v = getProperty(prop);
		return (v != null) ? v.toString() : "";
	}

	public final float getFloatProperty(SPEC.PROP prop) {
		final Object v = getProperty(prop);

		if (v == null)
			return Float.NaN;

		if (v instanceof Float)
			return ((Float) v).floatValue();

		return Float.parseFloat(v.toString());
	}
}
