//
//  ShareViewController.m
//  VeryNC
//
//  Created by mac on 12-5-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ShareViewController.h"
#import <QuartzCore/QuartzCore.h>
//腾讯微博用常量
#define oauth2TokenKey @"access_token="
#define oauth2OpenidKey @"openid="
#define oauth2OpenkeyKey @"openkey="
#define oauth2ExpireInKey @"expire_in="
@interface ShareViewController ()

@end

@implementation ShareViewController
@synthesize typetitle,content,image,weiBoEngine,opensdk,webView,wbstate,textview,refresh_btn;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self navigationItem] setTitle: typetitle];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:158.0/255.0 green:26.0/255.0 blue:36.0/255.0 alpha:1.000]];
    
    refresh_btn = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UITabBarSystemItemContacts target:self action:@selector(sendshare)];
    self.navigationItem.rightBarButtonItem = refresh_btn;
    UIBarButtonItem *goback_btn = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UITabBarSystemItemContacts target:self action:@selector(goback)];
    self.navigationItem.leftBarButtonItem = goback_btn;
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    remainnum = [[UILabel alloc] initWithFrame:CGRectMake(220, 10, 100, 20)];
    //remainnum.text = remainstring;
    remainnum.font = [UIFont systemFontOfSize:14];
    remainnum.backgroundColor = [UIColor clearColor];
    remainnum.textColor = [UIColor blackColor];
    [self.view addSubview:remainnum];
    
    textview = [[UITextView alloc] initWithFrame:CGRectMake(10, 30, 300, 130)];
    textview.font = [UIFont systemFontOfSize:14];
    textview.layer.borderColor  = [UIColor grayColor].CGColor;
    textview.layer.borderWidth  = 1.0;
    textview.layer.cornerRadius = 10.0;
    textview.text = content;
    textview.selectedRange = NSMakeRange(0,0);//光标始终在最初点
    [textview becomeFirstResponder];//默认自动显示出键盘
    textview.delegate = self;
    [self.view addSubview:textview];
    
    NSString  * nsTextContent=textview.text;  
    int existTextNum=[nsTextContent length];  
    remainnum.text = [NSString stringWithFormat:@"还可输入%d字",140-existTextNum];
    
    //实例化新浪微博
    WBEngine *engine = [[WBEngine alloc] initWithAppKey:SinaWeiboAppID appSecret:SinaWeiboAppSecretKey];
    [engine setRootViewController:self];
    [engine setDelegate:self];
    [engine setRedirectURI:@"http://"];
    [engine setIsUserExclusive:NO];
    self.weiBoEngine = engine;
    [engine release];
    //实例化腾讯微博
    opensdk = [[OpenSdkOauth alloc] initAppKey:[OpenSdkBase getAppKey] appSecret:[OpenSdkBase getAppSecret]];
    
    //账户绑定判断
    wbstate = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 100, 20)];
    wbstate.font = [UIFont systemFontOfSize:14];
    wbstate.backgroundColor = [UIColor clearColor];
    wbstate.textColor = [UIColor blackColor];
    [self.view addSubview:wbstate];
    
    if([typetitle isEqualToString:@"新浪微博分享"]){
        if([weiBoEngine isLoggedIn] && ![weiBoEngine isAuthorizeExpired]){
            wbstate.text= @"已绑定";
        }else{
            wbstate.text= @"未绑定";
        }
    }
    
    if([typetitle isEqualToString:@"腾讯微博分享"]){
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"tencentWBauthinfo.plist"];
        NSDictionary *userlist_info = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        NSString *accessToken = [userlist_info objectForKey:@"accessToken"];
        if (accessToken == nil) {
            wbstate.text= @"未绑定";
        }else{
            wbstate.text= @"已绑定";
        }
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changewbstate) name:@"notifytochangewbstate" object:nil];
}
- (void)changewbstate
{
    wbstate.text= @"已绑定";
}
- (void)textViewDidChange:(UITextView *)textView  
{  
    NSString  *nsTextContent=textView.text;  
    int existTextNum=[nsTextContent length];  
    //remainnum.text = [NSString stringWithFormat:@"还可输入%d字",140-existTextNum];
    if(140-existTextNum < 0){
        remainnum.text = [NSString stringWithFormat:@"已超过%d字",-(140-existTextNum)];
        remainnum.textColor = [UIColor redColor];
        [refresh_btn setEnabled:NO];
    }else{
        remainnum.text = [NSString stringWithFormat:@"还可输入%d字",140-existTextNum];
        remainnum.textColor = [UIColor blackColor];
        [refresh_btn setEnabled:YES];
    }
} 

- (void)goback
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)sendshare
{
    [textview resignFirstResponder];
    //新浪微博登陆判断
    if([typetitle isEqualToString:@"新浪微博分享"]){
        if([weiBoEngine isLoggedIn] && ![weiBoEngine isAuthorizeExpired]){
            //WBSendView *sendView = [[WBSendView alloc] initWithAppKey:SinaWeiboAppID appSecret:SinaWeiboAppSecretKey text:textview.text image:nil];
            //[sendView setDelegate:self];
            //[sendView show:YES];
            //[sendView release];
            _loadingView=[[UIImageView alloc] initWithFrame:CGRectMake(90.0f, 140.0f,140.0f, 70.0f)];
            _loadingView.image=[UIImage imageNamed:@"duqu.png"];
            _loadingView.alpha=0.8;
            [self.view addSubview:_loadingView];
            
            _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
            _activityView.frame = CGRectMake(110.0f, 162.0f, 20.0f, 20.0f);
            [self.view addSubview:_activityView];
            [_activityView startAnimating];
            
            _loadLabel = [ViewTool addUILable:self.view x:140.0 y:162 x1:100 y1:20 fontSize:15 lableText:@"发送中..."];
            
            [_loadLabel setTextColor:[UIColor grayColor]];
            [weiBoEngine sendWeiBoWithText:textview.text image:nil];
        }else{
            [weiBoEngine logIn];
        }
    }
    //腾讯微博登陆判断
    if([typetitle isEqualToString:@"腾讯微博分享"]){
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"tencentWBauthinfo.plist"]
        ;
        NSDictionary *userlist_info = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        //NSLog(@"%@",userlist_info);
        NSString *accessToken = [userlist_info objectForKey:@"accessToken"];
        NSString *openid = [userlist_info objectForKey:@"openid"];
        NSString *openkey = [userlist_info objectForKey:@"openkey"];
        
        if (accessToken == nil) {
            webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
            webView.scalesPageToFit = YES;
            webView.userInteractionEnabled = YES;
            webView.delegate = self;
            webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            [self.view addSubview:webView];
            [opensdk doWebViewAuthorize:webView];
        }else {
            opensdk.accessToken = accessToken;
            opensdk.openid      = openid;
            opensdk.openkey     = openkey;
            OpenApi *_OpenApi = [[OpenApi alloc] initForApi:opensdk.appKey appSecret:opensdk.appSecret accessToken:opensdk.accessToken accessSecret:opensdk.accessSecret openid:opensdk.openid oauthType:opensdk.oauthType];
            [_OpenApi publishWeibo:textview.text jing:@"" wei:@"" format:@"json" clientip:@"" syncflag:@"0"];
            //[_OpenApi publishWeiboWithImage:nil weiboContent:textview.text jing:nil wei:nil format:@"json" clientip:nil syncflag:@"0"];
        }
    }
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark - WBEngineDelegate Methods
- (void)engineDidLogIn:(WBEngine *)engine
{
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil 
													   message:@"登录成功！" 
													  delegate:self
											 cancelButtonTitle:@"确定" 
											 otherButtonTitles:nil];
	[alertView show];
	[alertView release];
}

- (void)engine:(WBEngine *)engine didFailToLogInWithError:(NSError *)error
{
    //NSLog(@"didFailToLogInWithError: %@", error);
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil 
													   message:@"登录失败！" 
													  delegate:nil
											 cancelButtonTitle:@"确定" 
											 otherButtonTitles:nil];
	[alertView show];
	[alertView release];
}

#pragma mark - WBSendViewDelegate Methods
- (void)engine:(WBEngine *)engine requestDidFailWithError:(NSError *)error
{
    [_activityView removeFromSuperview];
    _activityView = nil;
    [_loadLabel removeFromSuperview];
    _loadLabel = nil;
    
    [_loadingView removeFromSuperview];
    _loadingView=nil;
    //NSLog(@"requestDidFailWithError: %@", error);
    
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
                                                       message:@"微博发送失败"
                                                      delegate:nil
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}
- (void)engine:(WBEngine *)engine requestDidSucceedWithResult:(id)result
{
    [_activityView removeFromSuperview];
    _activityView = nil;
    [_loadLabel removeFromSuperview];
    _loadLabel = nil;
    
    [_loadingView removeFromSuperview];
    _loadingView=nil;
    
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
                                                       message:@"微博发送成功！"
                                                      delegate:nil
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}

#pragma mark - webviewDelegate Methods
- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSURL* url = request.URL;
    
    //NSLog(@"response url is %@", url);
	NSRange start = [[url absoluteString] rangeOfString:oauth2TokenKey];
    
    //如果找到tokenkey,就获取其他key的value值
	if (start.location != NSNotFound)
	{
        NSString *accessToken = [OpenSdkBase getStringFromUrl:[url absoluteString] needle:oauth2TokenKey];
        NSString *openid = [OpenSdkBase getStringFromUrl:[url absoluteString] needle:oauth2OpenidKey];
        NSString *openkey = [OpenSdkBase getStringFromUrl:[url absoluteString] needle:oauth2OpenkeyKey];
		NSString *expireIn = [OpenSdkBase getStringFromUrl:[url absoluteString] needle:oauth2ExpireInKey];
        
		NSDate *expirationDate =nil;
		if (opensdk.expireIn != nil) {
			int expVal = [opensdk.expireIn intValue];
			if (expVal == 0) {
				expirationDate = [NSDate distantFuture];
			} else {
				expirationDate = [NSDate dateWithTimeIntervalSinceNow:expVal];
			} 
		} 
        
        //NSLog(@"token is %@, openid is %@, expireTime is %@", accessToken, openid, expirationDate);
        
        if ((accessToken == (NSString *) [NSNull null]) || (accessToken.length == 0) 
            || (openid == (NSString *) [NSNull null]) || (openkey.length == 0) 
            || (openkey == (NSString *) [NSNull null]) || (openid.length == 0)) {
            [opensdk oauthDidFail:InWebView success:YES netNotWork:NO];
        }
        else {
            [opensdk oauthDidSuccess:accessToken accessSecret:nil openid:openid openkey:openkey expireIn:expireIn];
        }
        self.webView.delegate = nil;
        [self.webView setHidden:YES];
        
		return NO;
	}
	else
	{
        start = [[url absoluteString] rangeOfString:@"code="];
        if (start.location != NSNotFound) {
            [opensdk refuseOauth:url];
        }
	}
    return YES;
}
- (void)dealloc
{
    [weiBoEngine release];
    [opensdk release];
    [webView release];
    [image release];
    [typetitle release];
    [content release];
    [textview release];
    [_activityView release];
    [_loadingView release];
    [_loadLabel release];
    [super dealloc];
}
@end
