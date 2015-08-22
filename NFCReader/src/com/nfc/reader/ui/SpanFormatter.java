package com.nfc.reader.ui;
/**
 * 对html文件进行解析
 */
import java.lang.ref.WeakReference;

import org.xml.sax.XMLReader;

import android.graphics.Canvas;
import android.graphics.DashPathEffect;
import android.graphics.Paint;
import android.graphics.Paint.FontMetricsInt;
import android.graphics.Paint.Style;
import android.graphics.Path;
import android.graphics.PathEffect;
import android.graphics.Typeface;
import android.text.Editable;
import android.text.Html;
import android.text.Spannable;
import android.text.Spanned;
import android.text.TextPaint;
import android.text.style.ClickableSpan;
import android.text.style.LineHeightSpan;
import android.text.style.MetricAffectingSpan;
import android.text.style.ReplacementSpan;
import android.util.DisplayMetrics;
import android.view.View;

import com.nfc.reader.R;
import com.nfc.reader.SpecConf;
import com.nfc.reader.MyApplication;

public final class SpanFormatter implements Html.TagHandler {
	
	//接口actionHandler 
	//CharSequence与String都能用于定义字符串，但CharSequence的值是可读可写序列，而String的值是只读序列
	public interface ActionHandler {
		void handleAction(CharSequence name);
	}

	private final ActionHandler handler;
	//构造参数中 初始化actionHandler
	public SpanFormatter(ActionHandler handler) {
		this.handler = handler;
	}

	public CharSequence toSpanned(String html) {
		return Html.fromHtml(html, null, this);
	}
	/**
	 * TextView 的响应事件类
	 * @author unicom
	 *
	 */
	private static final class ActionSpan extends ClickableSpan {
		private final String action;
		private final ActionHandler handler;
		private final int color;

		ActionSpan(String action, ActionHandler handler, int color) {
			this.action = action;
			this.handler = handler;
			this.color = color;
		}

		@Override
		public void onClick(View widget) {
			if (handler != null)
				handler.handleAction(action);
		}

		@Override
		public void updateDrawState(TextPaint ds) {
			super.updateDrawState(ds);
			ds.setColor(color);
		}
	}
	/**
	 * 
	 * @MetricAffectingSpan The classes that affect character-level text formatting 
	 * in a way that changes the width or height of characters extend this class
	 * @FontSpan   字体修饰类
	 *
	 */
	private static final class FontSpan extends MetricAffectingSpan {

		final int color;
		final float size;
		final Typeface face;
		final boolean bold;

		FontSpan(int color, float size, Typeface face) {
			this.color = color;
			this.size = size;

			if (face == Typeface.DEFAULT) {
				this.face = null;
				this.bold = false;
			} else if (face == Typeface.DEFAULT_BOLD) {
				this.face = null;
				this.bold = true;
			} else {
				this.face = face;
				this.bold = false;
			}
		}

		@Override
		public void updateDrawState(TextPaint ds) {
			ds.setTextSize(size);
			ds.setColor(color);

			if (face != null) {
				ds.setTypeface(face);
			} else if (bold) {
				Typeface tf = ds.getTypeface();

				if (tf != null) {
					int style = tf.getStyle() | Typeface.BOLD;
					tf = Typeface.create(tf, style);
					ds.setTypeface(tf);

					style &= ~tf.getStyle();

					if ((style & Typeface.BOLD) != 0) {
						ds.setFakeBoldText(true);
					}
				}
			}
		}

		@Override
		public void updateMeasureState(TextPaint p) {
			updateDrawState(p);
		}
	}
	/**
	 * 
	 * @LineHeightSpan 
	 *
	 */
	private static final class ParagSpan implements LineHeightSpan {
		private final int linespaceDelta;

		ParagSpan(int linespaceDelta) {
			this.linespaceDelta = linespaceDelta;
		}

		@Override
		public void chooseHeight(CharSequence text, int start, int end, int spanstartv, int v,
				FontMetricsInt fm) {
			fm.bottom += linespaceDelta;
			fm.descent += linespaceDelta;
		}
	}

	private static final class SplitterSpan extends ReplacementSpan {
		private final int color;
		private final int width;
		private final int height;
		private final Path path;
		private final PathEffect effe;

		SplitterSpan(int color, int width, int height) {
			this.color = color;
			this.width = width;
			this.height = height;

			this.path = new Path();
			this.effe = new DashPathEffect(new float[] { 6, 3, 6, 3 }, 0);
		}

		@Override
		public void updateDrawState(TextPaint ds) {
			ds.setTextSize(1);
		}

		@Override
		public int getSize(Paint paint, CharSequence text, int start, int end,
				Paint.FontMetricsInt fm) {
			return 0;
		}

		@Override
		public void draw(Canvas canvas, CharSequence text, int start, int end, float x, int top,
				int y, int bottom, Paint paint) {

			canvas.save();
			canvas.translate(x, (bottom + top) / 2 - height);

			final int c = paint.getColor();
			final float w = paint.getStrokeWidth();
			final Style s = paint.getStyle();
			final PathEffect e = paint.getPathEffect();

			paint.setColor(color);
			paint.setStyle(Paint.Style.STROKE);
			paint.setStrokeWidth(height);
			paint.setPathEffect(effe);

			path.moveTo(x, 0);
			path.lineTo(x + width, 0);

			canvas.drawPath(path, paint);

			paint.setColor(c);
			paint.setStyle(s);
			paint.setStrokeWidth(w);
			paint.setPathEffect(e);

			canvas.restore();
		}
	}
	/**
	 * TagHandler接口并在handleTag方法中对自定义的标签做相应的处理即可
	 *  @ opening：为true时表示开始解析,为false时表示解析完 
     *  @ tag :当前解析的标签 
     *  @ output:文本中的内容 
     *  @ xmlReader:xml解析器 
	 */
	@Override
	public void handleTag(boolean opening, String tag, Editable output, XMLReader xmlReader) {

		final int len = output.length();

		if (opening) {

			if (SpecConf.TAG_TEXT.equals(tag)) {
				markFontSpan(output, len, R.color.tag_text, R.dimen.tag_text, Typeface.DEFAULT);
			} else if (SpecConf.TAG_TIP.equals(tag)) {
				markParagSpan(output, len, R.dimen.tag_parag);
				markFontSpan(output, len, R.color.tag_tip, R.dimen.tag_tip, Typeface.DEFAULT);
				//markFontSpan(output, len, R.color.tag_tip, R.dimen.tag_tip, getTipFont());
			} else if (SpecConf.TAG_LAB.equals(tag)) {
				markFontSpan(output, len, R.color.tag_lab, R.dimen.tag_lab, Typeface.DEFAULT_BOLD);
			} else if (SpecConf.TAG_H1.equals(tag)) {
				markFontSpan(output, len, R.color.tag_h1, R.dimen.tag_h1, Typeface.DEFAULT_BOLD);
			} else if (SpecConf.TAG_H2.equals(tag)) {
				markFontSpan(output, len, R.color.tag_h2, R.dimen.tag_h2, Typeface.DEFAULT_BOLD);
			} else if (SpecConf.TAG_H3.equals(tag)) {
				markFontSpan(output, len, R.color.tag_h3, R.dimen.tag_h3, Typeface.SERIF);
			} else if (tag.startsWith(SpecConf.TAG_ACT)) {
				markActionSpan(output, len, tag, R.color.tag_action);
			} else if (SpecConf.TAG_PARAG.equals(tag)) {
				markParagSpan(output, len, R.dimen.tag_parag);
			} else if (SpecConf.TAG_SP.equals(tag)) {
				markSpliterSpan(output, len, R.color.tag_spliter, R.dimen.tag_spliter);
			}
		} else {
			if (SpecConf.TAG_TEXT.equals(tag)) {
				setSpan(output, len, FontSpan.class);
			} else if (SpecConf.TAG_TIP.equals(tag)) {
				setSpan(output, len, FontSpan.class);
				setSpan(output, len, ParagSpan.class);
			} else if (SpecConf.TAG_LAB.equals(tag)) {
				setSpan(output, len, FontSpan.class);
			} else if (SpecConf.TAG_H1.equals(tag)) {
				setSpan(output, len, FontSpan.class);
			} else if (SpecConf.TAG_H2.equals(tag)) {
				setSpan(output, len, FontSpan.class);
			} else if (SpecConf.TAG_H3.equals(tag)) {
				setSpan(output, len, FontSpan.class);
			} else if (tag.startsWith(SpecConf.TAG_ACT)) {
				setSpan(output, len, ActionSpan.class);
			} else if (SpecConf.TAG_PARAG.equals(tag)) {
				setSpan(output, len, ParagSpan.class);
			}
		}
	}
	
	/**
	 * Spanned.SPAN_EXCLUSIVE_EXCLUSIVE前后都不包括；
		Spanned.SPAN_INCLUSIVE_EXCLUSIVE包括前面，不包括后面；
		Spanned.SPAN_EXCLUSIVE_INCLUSIVE不包括前面，包括后面；
		Spanned.SPAN_INCLUSIVE_INCLUSIVE前后都包括；
	 * @param out
	 * @param pos
	 * @param colorId
	 * @param heightId
	 */
	private static void markSpliterSpan(Editable out, int pos, int colorId, int heightId) {
		DisplayMetrics dm = MyApplication.getDisplayMetrics();
		int color = MyApplication.getColorResource(colorId);
		int height = MyApplication.getDimensionResourcePixelSize(heightId);
		int width = dm.heightPixels > dm.widthPixels ? dm.heightPixels : dm.widthPixels;

		out.append("-------------------").setSpan(new SplitterSpan(color, width, height), pos,
				out.length(), Spannable.SPAN_EXCLUSIVE_EXCLUSIVE);
	}

	private static void markFontSpan(Editable out, int pos, int colorId, int sizeId, Typeface face) {
		int color = MyApplication.getColorResource(colorId);
		float size = MyApplication.getDimensionResourcePixelSize(sizeId);
		FontSpan span = new FontSpan(color, size, face);
		out.setSpan(span, pos, pos, Spannable.SPAN_MARK_MARK);
	}

	private static void markParagSpan(Editable out, int pos, int linespaceId) {
		int linespace = MyApplication.getDimensionResourcePixelSize(linespaceId);
		ParagSpan span = new ParagSpan(linespace);
		out.setSpan(span, pos, pos, Spannable.SPAN_MARK_MARK);
	}

	private void markActionSpan(Editable out, int pos, String tag, int colorId) {
		int color = MyApplication.getColorResource(colorId);
		out.setSpan(new ActionSpan(tag, handler, color), pos, pos, Spannable.SPAN_MARK_MARK);
	}

	private static void setSpan(Editable out, int pos, Class<?> kind) {
		Object span = getLastMarkSpan(out, kind);
		out.setSpan(span, out.getSpanStart(span), pos, Spannable.SPAN_EXCLUSIVE_EXCLUSIVE);
	}

	private static Object getLastMarkSpan(Spanned text, Class<?> kind) {
		Object[] objs = text.getSpans(0, text.length(), kind);

		if (objs.length == 0) {
			return null;
		} else {
			return objs[objs.length - 1];
		}
	}

	private static Typeface getTipFont() {

		Typeface ret = null;

		WeakReference<Typeface> wr = TIPFONT;
		if (wr != null)
			ret = wr.get();

		return ret;
	}

	private static WeakReference<Typeface> TIPFONT;
}
