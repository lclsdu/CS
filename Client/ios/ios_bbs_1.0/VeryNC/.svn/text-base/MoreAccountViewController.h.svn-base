//
//  MoreAccountViewController.h
//  化龙巷
//
//  Created by David Suen on 12-3-22.
//  Copyright (c) 2012年 Osugroup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tools.h"
#import "MyProtocol.h"
#import "Constants.h"
#import  "DebugLog.h"
//新浪微博头文件
#import "WBEngine.h"
#import "WBSendView.h"
//腾讯微博头文件
#import "OpenSdkOauth.h"
#import "OpenApi.h"
@interface MoreAccountViewController : UIViewController< MyprotocolDelegate,UITableViewDataSource,UITableViewDelegate,WBEngineDelegate,UIWebViewDelegate >
{
    id<MyprotocolDelegate> myDelegate;
    int edit;
    int cellnum;
    UIBarButtonItem * rightButton;
}

@property (nonatomic, assign) id<MyprotocolDelegate > myDelegate;
@property (nonatomic,retain) NSMutableArray *userinfo;
@property (nonatomic,retain) UITableView *thetableview;
@property (nonatomic,retain) IBOutlet UIActivityIndicatorView *aiv;
@property (nonatomic,strong) NSString *api_url;
@property (nonatomic,strong) NSString *loginTip;
@property (nonatomic,strong) NSString *loginURL;
@property (nonatomic,assign) int cellnum;

@property (nonatomic,retain) WBEngine *weiBoEngine;
@property (nonatomic,retain) OpenSdkOauth *opensdk;
@property (nonatomic,retain) UIWebView *webView;

@property (nonatomic,strong) NSString *nowuser;
@property (nonatomic,strong) NSDictionary *nowuser_info;
@end
