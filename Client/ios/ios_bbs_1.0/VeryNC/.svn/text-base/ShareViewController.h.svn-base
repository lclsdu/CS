//
//  ShareViewController.h
//  VeryNC
//
//  Created by mac on 12-5-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "Tools.h"
#import <CoreLocation/CoreLocation.h>
//新浪微博头文件
#import "WBEngine.h"
#import "WBSendView.h"
//腾讯微博头文件
#import "OpenSdkOauth.h"
#import "OpenApi.h"
//#import "WBLogInAlertView.h"

@interface ShareViewController : UIViewController<UITextViewDelegate,WBEngineDelegate,WBSendViewDelegate,UIAlertViewDelegate,UIWebViewDelegate>
{
    UITextView *textview;
    
    UIActivityIndicatorView *_activityView;
	UILabel *_loadLabel;
    UIImageView *_loadingView;
    UILabel *remainnum;
    UIBarButtonItem *refresh_btn;
}
@property (nonatomic,strong) NSString *typetitle;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) UIImage *image;
@property (nonatomic,retain) WBEngine *weiBoEngine;
@property (nonatomic,retain) OpenSdkOauth *opensdk;
@property (nonatomic,retain) UIWebView *webView;
@property (nonatomic,strong) UILabel *wbstate;
@property (nonatomic,retain) UITextView *textview;
@property (nonatomic,retain) UIBarButtonItem *refresh_btn;
@end
