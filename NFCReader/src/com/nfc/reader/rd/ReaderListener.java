package com.nfc.reader.rd;

import com.nfc.reader.SpecConf;

public interface ReaderListener {
	void onReadEvent(SpecConf.EVENT event, Object... obj);
}
