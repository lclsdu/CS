//
//  Constants.h
//   
//
//  Created by David Suen on 12-3-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#ifndef  _Constants_h
#define  _Constants_h

//API域名路径相关
//#define _customDomainandPathVeryNC @"http://192.168.1.50/dx2app2/app2/"

#define _customDomainVeryNC @"http://192.168.1.50"//www.shopnc.net"///app/
#define _customPathVeryNC @"app"           //dx2app/app2"
#define _customDomainandPathVeryNC @"http://localhost/discuzx2_5/api2/"
#define _quoteImageVeryNC @"http://www.shopnctest.com/dx2apptest"
//登陆界面相关提示信息
#define _loginTip @"VeryNC通行证"
#define _loginURL @"http://www.verync.com"
//是否开启ftp图片服务器支持模式
#define _useftppic @"yes"
#define _ftpurl @"61.136.60.46"
#define _ftpusername @"dx2apptest_ftp"
#define _ftppassword @"dx2apptest_ftp_pw"

bool isRunningImagePickerController;

//公共常量
#define _timeOut 30
//分享相关
#define SinaWeiboAppID @"2319314039"
#define SinaWeiboAppSecretKey @"e495b4a134027345097f52db8056c4f7"

int faceAmountGlobal;


//news section

#define _newsHeaderURL [NSString stringWithFormat:@"%@topiclist.php?type=top_name_list",_customDomainandPathVeryNC]
#define _newsHeadLineRequestURLWithPage(x) [NSString stringWithFormat:@"%@topiclist.php?type=tops&pageno=%d&pagesize=20",_customDomainandPathVeryNC,x]
#define _newskTeaBowlRequestURLWithPage(x) [NSString stringWithFormat:@"%@topiclist.php?type=index2&pageno=%d&pagesize=20",_customDomainandPathVeryNC,x]
#define _newskFocuslRequestURLWithPage(x) [NSString stringWithFormat:@"%@topiclist.php?type=index3&pageno=%d&pagesize=20",_customDomainandPathVeryNC,x]
#define _newskEntertainmentRequestURLWithPage(x) [NSString stringWithFormat:@"%@topiclist.php?type=index4&pageno=%d&pagesize=20",_customDomainandPathVeryNC,x]
#define _newskEmotionRequestURLWithPage(x) [NSString stringWithFormat:@"%@topiclist.php?type=index5&pageno=%d&pagesize=20",_customDomainandPathVeryNC,x]

#define _newskFoodRequestURLWithPage(x) [NSString stringWithFormat:@"%@topiclist.php?type=second1&pageno=%d&pagesize=20",_customDomainandPathVeryNC,x]
#define _newskCarRequestURLWithPage(x) [NSString stringWithFormat:@"%@topiclist.php?type=second2&pageno=%d&pagesize=20",_customDomainandPathVeryNC,x]
#define _newskHouseRequestURLWithPage(x) [NSString stringWithFormat:@"%@topiclist.php?type=second3&pageno=%d&pagesize=20",_customDomainandPathVeryNC,x]
#define _newskFurnitureRequestURLWithPage(x) [NSString stringWithFormat:@"%@topiclist.php?type=second4&pageno=%d&pagesize=20",_customDomainandPathVeryNC,x]
#define _newskMarriageRequestURLWithPage(x) [NSString stringWithFormat:@"%@topiclist.php?type=second5&pageno=%d&pagesize=20",_customDomainandPathVeryNC,x]
#define _newskMotherRequestURLWithPage(x) [NSString stringWithFormat:@"%@topiclist.php?type=second6&pageno=%d&pagesize=20",_customDomainandPathVeryNC,x]

#define kForumsRequestURLWithPage(x) [NSString stringWithFormat:@"%@topiclist.php?type=forum_list&uid=%@",_customDomainandPathVeryNC,x];
#define kForumsRequestURLWithPageWithoutUID [NSString stringWithFormat:@"%@topiclist.php?type=forum_list&uid=%@",_customDomainandPathVeryNC,@""];
#define kListRequestURLWithPage(fid,x) [NSString stringWithFormat:@"%@topiclist.php?type=thread_list&fid=%d&pageno=%d&pagesize=20&uid=",_customDomainandPathVeryNC,fid,x]




//当远程获得的二级栏目标题为空的时候，使用默认的栏目标题
#define _news_name_index1 @"头条"
#define _news_name_index2 @"茶座"
#define _news_name_index3 @"焦点"
#define _news_name_index4 @"娱乐"
#define _news_name_index5 @"情感"
//#define _news_name_second1 @"美食"
//#define _news_name_second2 @"汽车"
//#define _news_name_second3 @"房产"
//#define _news_name_second4 @"家装"
//#define _news_name_second5 @"婚嫁"
//#define _news_name_second6 @"母婴"

//topic section

#define _topic

//photo section

#define _photo

//business section

#define _business

//vote section

#define _vote



#endif
