package com.android.volley.toolbox;

import com.android.volley.AuthFailureError;
import com.android.volley.NetworkError;
import com.android.volley.NetworkResponse;
import com.android.volley.NoConnectionError;
import com.android.volley.ServerError;
import com.android.volley.TimeoutError;
import com.android.volley.VolleyError;

/**
 * 自定义错误信息组装提示类
 * @author Administrator
 *
 */
public class VolleyErrorHelper {
	/** 
     * Returns appropriate message which is to be displayed to the user  
     * against the specified error object. 
     *  
     * @param error 
     * @param context 
     * @return 
     */  
  public static String getMessage(Object error) {  
      if (error instanceof TimeoutError) {  
          return "TimeoutError";  
      }  
      else if (isServerProblem(error)) {  
          return handleServerError(error);  
      }  
      else if (isNetworkProblem(error)) {  
          return "NetworkError";  
      }  
      return "GenericError";  
  }  
    
  /** 
  * Determines whether the error is related to network 
  * @param error 
  * @return 
  */  
  private static boolean isNetworkProblem(Object error) {  
      return (error instanceof NetworkError) || (error instanceof NoConnectionError);  
  }  
  /** 
  * Determines whether the error is related to server 
  * @param error 
  * @return 
  */  
  private static boolean isServerProblem(Object error) {  
      return (error instanceof ServerError) || (error instanceof AuthFailureError);  
  }  
  
  /**
   * 处理VolleyError，主要获取http的状态码，如果无状态码返回-1，表示请求无响应
   * @param err
   * @param context
   * @return
   */
  private static String handleServerError(Object err) {  
      VolleyError error = (VolleyError) err;  
    
      NetworkResponse response = error.networkResponse;  
    
      if (response != null) {  
          return response.statusCode+"";
      }  
      return "ServerError";  
  }
}
