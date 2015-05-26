package com.grabparking.utils;
/**
 * 内置第三方应用的对应模块名
 * 其实就是9宫格要显示的内容的模块代码
 * @author Administrator
 *
 */
public class Modules {
	
	/**
	 * 一级模块：充值(需要弹出二级选项框)
	 */
	public static final String TOP_Recharge = "TOP_Recharge";
	/**
	 * 充值二级模块：话费充值(应用内打开)
	 */
	public static final String Bill_Recharge = "Bill_Recharge";
	
	/**
	 * 充值二级模块：快捷充值(应用内打开)
	 */
	
	public static final String Quick_Recharge = "Quick_Recharge";
	
	/**
	 * 一级模块：限时抢购(应用内打开)
	 */
	public static final String limitSale = "limitSale";
	
	/**
	 * 一级模块：转账(应用内打开)
	 */
	public static final String Zhuanzhang = "Zhuanzhang";
	
	/**
	 * 一级模块：信用支付(应用内打开)
	 */
	public static final String Credit = "Credit";
	
	/**
	 * 一级模块：提现(应用内打开)
	 */
	public static final String Withdrawals = "Withdrawals";
	
	/**
	 * 一级模块：代理商充值(第三方网站)
	 */
	public static final String agentsRecharge = "agentsRecharge";
	
	/**
	 * 一级模块：理财(第三方网站)
	 */
	public static final String Fund = "Fund";
	
	/**
	 * 一级模块：彩票(需要弹出二级选项框)
	 */
	public static final String TOPlottery = "TOPlottery";
	/**
	 * 彩票二级模块：我中啦(第三方网站)
	 */
	public static final String lottery = "lottery";
	/**
	 * 彩票二级模块：中彩手彩票(第三方网站)
	 */
	public static final String TXWlottery = "TXWlottery";
	
	/**
	 * 一级模块：游戏点卡(第三方网站)
	 */
	public static final String handpayGame = "handpayGame";
	
	/**
	 * 一级模块：商城(第三方网站)
	 */
	public static final String handpayMarket = "handpayMarket";
	
	/**
	 * 一级模块：电影票(第三方网站)
	 */
	public static final String DYP = "DYP";
	
	/**
	 * 一级模块：团购(第三方网站)
	 */
	public static final String Tuangou = "Tuangou";
	
	/**
	 * 一级模块：水电煤(第三方网站)
	 */
	public static final String payWater = "payWater";
	
	/**
	 * 一级模块： 保险(第三方网站)
	 */
	public static final String TBURL = "TBURL";
	
	/**
	 * 一级模块：Q币(第三方网站)
	 */
	public static final String qBi = "qBi";
	/**
	 * 旺铺
	 */
	public static final String WANGSHOP = "WANGSHOP";
	public static final String REMENHUDONG = "REMENHUODONG";
	/**
	 * 判断是否为一级模块
	 * @param moduleName
	 * @return
	 */
	public static boolean isAppTopModule(String moduleName){
		
	
			if(TOP_Recharge.equals(moduleName)
					||agentsRecharge.equals(moduleName)
					||TOPlottery.equals(moduleName)
					||qBi.equals(moduleName)
					||handpayGame.equals(moduleName)
					||handpayMarket.equals(moduleName)
					||DYP.equals(moduleName)
					||Tuangou.equals(moduleName)
					||payWater.equals(moduleName)
					||TBURL.equals(moduleName)
					||limitSale.equals(moduleName)
					||Zhuanzhang.equals(moduleName)
					||Fund.equals(moduleName)
					||Credit.equals(moduleName)
					||"WANGSHOP".equals(moduleName)
					||Withdrawals.equals(moduleName)
					){
				return true;	
		}
		return false;
	}
	
	/**
	 * 判断是否为二级模块
	 * @param moduleName
	 * @return
	 */
	public static boolean isAppTwoModule(String moduleName){
		
		if(lottery.equals(moduleName)
				||TXWlottery.equals(moduleName)
				||Bill_Recharge.equals(moduleName)
				||Quick_Recharge.equals(moduleName)
				){
			return true;
			
		}
		return false;
	}
	
	
	
	


}
