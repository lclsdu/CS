package com.nfc.reader.rd;

import android.nfc.Tag;
import android.nfc.tech.IsoDep;
import android.nfc.tech.NfcF;
import android.os.AsyncTask;

import com.nfc.reader.SPEC;
import com.nfc.reader.Util;
import com.nfc.reader.bean.Card;
import com.nfc.reader.pboc.StandardPboc;
/**
 * AsyncTask 轻量级异步操作
 * AsyncTask,是android提供的轻量级的异步类,
 * 可以直接继承AsyncTask,在类中实现异步操作,
 * 并提供接口反馈当前异步执行的程度(可以通过接口实现UI进度更新),
 * 最后反馈执行的结果给UI主线程.
 * @author unicom
 *
 */
public final class ReaderManager extends AsyncTask<Tag, SPEC.EVENT, Card> {

	public static void readCard(Tag tag, ReaderListener listener) {
		new ReaderManager(listener).execute(tag);
	}

	private ReaderListener realListener;

	private ReaderManager(ReaderListener listener) {
		realListener = listener;
	}
	/**
	 * 后台执行，比较耗时的操作都可以放在这里。
	 */
	@Override
	protected Card doInBackground(Tag... detectedTag) {
		return readCard(detectedTag[0]);
	}
	/**
	 * 可以使用进度条增加用户体验度。 此方法在主线程执行，
	 * 用于显示任务执行时不同的进度。
	 * 进行中更新
	 */
	@Override
	protected void onProgressUpdate(SPEC.EVENT... events) {
		if (realListener != null)
			realListener.onReadEvent(events[0]);
	}
	/**
	 *  相当于Handler 处理UI的方式，在这里面可以使用在doInBackground 得到
	 *  的结果处理操作UI。此方法在主线程执行，任务执行的结果作为此方法的参数返回
	 *  最终结果
	 */
	@Override
	protected void onPostExecute(Card card) {
		if (realListener != null)
			realListener.onReadEvent(SPEC.EVENT.FINISHED, card);
	}

	private Card readCard(Tag tag) {

		final Card card = new Card();

		try {
			//读取中的进度   
			publishProgress(SPEC.EVENT.READING);
			
			card.setProperty(SPEC.PROP.ID, Util.toHexString(tag.getId()));

			final IsoDep isodep = IsoDep.get(tag);
			if (isodep != null)
				//处理isoDep的tag
				StandardPboc.readCard(isodep, card);

			final NfcF nfcf = NfcF.get(tag);
			if (nfcf != null)
				//处理nfc f的tag
				FelicaReader.readCard(nfcf, card);
			//处理结束
			publishProgress(SPEC.EVENT.IDLE);

		} catch (Exception e) {
			card.setProperty(SPEC.PROP.EXCEPTION, e);
			publishProgress(SPEC.EVENT.ERROR);
		}

		return card;
	}
}
