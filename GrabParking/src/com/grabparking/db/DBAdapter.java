package com.grabparking.db;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.SQLException;
import android.database.sqlite.SQLiteCursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.util.Log;

//����������ֶ�AppName  AppPass
public class DBAdapter {
	
	public static final String KEY_ROWID = "_id";
	public static  final String AppName="name";
	public static  final String AppAccount="account";
	public static final String AppPass="pass";
	public static final String UserName="username";
	public static final String UserPass="password";
	private static final String TAG = "DBAdapter";
	private static final String DATABASE_NAME = "BOX";
	private static final String DATABASE_TABLE = "yuyu";
	private static final String DATABASE_USERTABLE = "USER";
	private static final int DATABASE_VERSION = 1;
	private static final String DATABASE_CREATE =
	"create table yuyu (_id integer primary key autoincrement, "
	+ "name text not null,account text not null, pass text not null);";
	private static final String DATABASE_USER =
			"create table USER ( username text not null,password text not null);";
	private final Context context;
	private DatabaseHelper DBHelper;
	private SQLiteDatabase db;
	
	public DBAdapter(Context ctx)
	{
	this.context = ctx;
	DBHelper = new DatabaseHelper(context);
	}
	
	
	private static class DatabaseHelper extends SQLiteOpenHelper
	{
	DatabaseHelper(Context context)
	{
	super(context, DATABASE_NAME, null, DATABASE_VERSION);
	}
	//����һ���µ���ݿ�
	public void onCreate(SQLiteDatabase db)
	{
	db.execSQL(DATABASE_CREATE);
	db.execSQL(DATABASE_USER);
	}
	//����ݿ�
	public void onUpgrade(SQLiteDatabase db, int oldVersion,
	int newVersion)
	{
	Log.w(TAG, "Upgrading database from version " + oldVersion
	+ " to "
	+ newVersion + ", which will destroy all old data");
	db.execSQL("DROP TABLE IF EXISTS titles");
	onCreate(db);
	}
	}
	//---����ݿ�---

	public DBAdapter open() throws SQLException
	{
	db = DBHelper.getWritableDatabase();
	return this;
	}
	//---�ر���ݿ�---

	public void close()
	{
	DBHelper.close();
	}
	//---����ݿ����һ������---

	public long insertTitle(String name,String account ,String pass)
	{
	ContentValues initialValues = new ContentValues();
	//initialValues.put(KEY_ROWID, _id);
	initialValues.put(AppName, name);
	initialValues.put(AppAccount, account);
	initialValues.put(AppPass, pass);
	return db.insert(DATABASE_TABLE, null, initialValues);
	}
	
	//---����ݿ����һ������---

		public long insertUserTitle(String name,String pass)
		{
		ContentValues initialValues = new ContentValues();
		//initialValues.put(KEY_ROWID, _id);
		initialValues.put(UserName, name);
		initialValues.put(UserPass, pass);
		return db.insert(DATABASE_USERTABLE, null, initialValues);
		}
	//---ɾ��һ��ָ���ı���---

	public boolean deleteTitle(long rowId)
	{
	return db.delete(DATABASE_TABLE, KEY_ROWID + "=" + rowId, null) > 0;
	}
	//---�������б���---

	public Cursor getAllTitles()
	{
	return db.query(DATABASE_TABLE, new String[] {KEY_ROWID,AppName,AppAccount,AppPass},null,null,null,null,null);
	}
	
	//---����user���б���---

		public Cursor getUserAllTitles()
		{
		return db.query(DATABASE_USERTABLE, new String[] {UserName,UserPass},null,null,null,null,null);
		}
	//---����һ��ָ���ı���---

	public Cursor getTitle(long rowId) throws SQLException
	{
	Cursor mCursor =
	db.query(true, DATABASE_TABLE, new String[] {
	KEY_ROWID,
	
	AppName,
	AppAccount,
	AppPass
	},
	KEY_ROWID + "=" + rowId,
	null,
	null,
	null,
	null,
	null);
	if (mCursor != null) {
	mCursor.moveToFirst();
	}
	return mCursor;
	}
	//---����һ������---

	public boolean updateTitle(long rowId,
	String name,String account, String pass)
	{
	ContentValues args = new ContentValues();
	args.put(AppName, name);
	args.put(AppAccount, account);
	args.put(AppPass, pass);
	return db.update(DATABASE_TABLE, args,
	KEY_ROWID + "=" + rowId, null) > 0;
	}


}
