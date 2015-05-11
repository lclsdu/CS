package com.grabparking.exception;
public class ResNotOkException extends Exception
{
  /**
	 * 应答错误异常
	 */
	private static final long serialVersionUID = 1L;
private int code;
  private String title;
  private String msg;

  public ResNotOkException(int code, String title, String msg)
  {
    this.code = code;
    this.msg = msg;
    this.title = title;
  }
  public int getCode() { return this.code; } 
  public String getMessage() { return this.msg; } 
  public String getTitle() { return this.title; }
}

