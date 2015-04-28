//
//  MoreAccountViewController.m
//  化龙巷
//
//  Created by David Suen on 12-3-22.
//  Copyright (c) 2012年 Osugroup. All rights reserved.
//

#import "MoreAccountViewController.h"
#import "MoreAccountAddViewController.h"
#import "AppDelegate.h"
#import "DebugLog.h"
//腾讯微博用常量
#define oauth2TokenKey @"access_token="
#define oauth2OpenidKey @"openid="
#define oauth2OpenkeyKey @"openkey="
#define oauth2ExpireInKey @"expire_in="

@implementation MoreAccountViewController
@synthesize myDelegate,userinfo,thetableview,aiv,api_url,loginTip,loginURL,cellnum,weiBoEngine,opensdk,webView,nowuser,nowuser_info;

- (void)viewWillAppear:(BOOL)animated;  
{
    
    //[self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:0.267 green:0.490 blue:0.843  alpha:1.000]];
    
    [[self navigationItem] setTitle: @"帐户管理"]; 
    //读取user.plist
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"user.plist"];
    NSDictionary *userinfo_dict = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    self.userinfo = [NSMutableArray new];
    for(NSString *key in userinfo_dict){
        [userinfo addObject:key];
    }
    //cell数量
    cellnum = [userinfo count]+1;
    aiv.hidden = YES;
    [self.thetableview reloadData];//程序崩溃
}
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
    AppDelegate *delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    api_url = delegate.myDomainAndPathVeryNC;
    loginTip = delegate.loginTip;
    loginURL = delegate.loginURL;
    
    //读取user.plist
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"user.plist"];
    NSDictionary *userinfo_dict = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    [userinfo removeAllObjects];
    for(NSString *key in userinfo_dict){
        [userinfo addObject:key];
    }
    //cell数量
    cellnum = [userinfo count]+1;
    aiv.hidden = YES;
    rightButton=[[UIBarButtonItem alloc] initWithTitle:[NSString stringWithUTF8String:"编辑"] style:UIBarButtonItemStylePlain target:self action:@selector(editaccount)];   
    self.navigationItem.rightBarButtonItem=rightButton;
    edit = 1;
    
    [super viewDidLoad];
    
    
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
    // Do any additional setup after loading the view from its nib.
}
- (void)editaccount
{
    if(edit == 1){
        [self.thetableview setEditing:YES animated:YES];
        rightButton.title = @"完成";
        edit = 0;
    }else{
        [self.thetableview setEditing:NO animated:YES];
        rightButton.title = @"编辑";
        edit = 1;
    }
    
}
- (UITableViewCellEditingStyle)tableView:(UITableView*)tableView 

           editingStyleForRowAtIndexPath:(NSIndexPath*)indexPath {
    if(indexPath.row == cellnum-1 || indexPath.section == 1){
        return UITableViewCellEditingStyleNone;
    }
    return UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView *)tableView   
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle  forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {  
        //保存用户列表到本地文件中
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"user.plist"];
        NSMutableDictionary *userinfo_dict = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        [userinfo_dict removeObjectForKey:[userinfo objectAtIndex:indexPath.row]];
        [NSKeyedArchiver archiveRootObject:userinfo_dict toFile:filePath];
        //如果所删除的为当前登陆用户则去请求游客板块权限并保存
        NSString *nowlogin_filePath = [documentsDirectory stringByAppendingPathComponent:@"nowlogin.plist"];
        NSMutableDictionary *nowlogin = [NSKeyedUnarchiver unarchiveObjectWithFile:nowlogin_filePath];
        if([[nowlogin objectForKey:@"username"] isEqualToString:[userinfo objectAtIndex:indexPath.row]]){
            NSString *url_final = [api_url stringByAppendingString:@"topiclist.php?type=forum_list"];
            ASIHTTPRequest *head = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url_final]];
            [head setTag:3];
            [head setDelegate:self];
            [head setPersistentConnectionTimeoutSeconds:30];
            [head startAsynchronous];
        }
        //删除当前数据源数组中的用户名信息
        [userinfo removeObjectAtIndex:indexPath.row];
        self.cellnum = [userinfo count]+1;
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]  
                         withRowAnimation:UITableViewRowAnimationAutomatic];   
    }  
}
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 1){
        return NO;
    }
    return YES;
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)dealloc
{
    [thetableview release];
    [userinfo release];
    [aiv release];
    [super dealloc];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    thetableview = tableView;
    if(indexPath.section == 0){
    if(indexPath.row == (cellnum-1)){
        static NSString *CellIdentifier = @"account";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.textLabel.text = @"添加新账号";
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.accessoryView = UITableViewCellAccessoryNone;
        return cell;
    }else{
        static NSString *CellIdentifier = @"account";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        NSString *username = [userinfo objectAtIndex:indexPath.row];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *nowlogin_filePath = [documentsDirectory stringByAppendingPathComponent:@"nowlogin.plist"];
        NSDictionary *now = [NSKeyedUnarchiver unarchiveObjectWithFile:nowlogin_filePath];
        NSString *nowname  = [now objectForKey:@"username"];
        cell.textLabel.text = username;
        UISwitch *myswitch = [[UISwitch alloc] init];
        if([username isEqualToString:nowname]){
            [myswitch setOn:YES];
        }
        myswitch.tag = indexPath.row;
        [myswitch addTarget:self action:@selector(switchPress:) forControlEvents:UIControlEventValueChanged];
        cell.accessoryView = myswitch;
        [myswitch release];
        cell.accessoryType = UITableViewCellAccessoryNone;
        return cell;
    }
    }
    if(indexPath.section == 1){
        static NSString *CellIdentifier = @"another";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        switch(indexPath.row)
        {   
            case 0:
            {
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 5, 32, 32)];
                [cell addSubview:imageView];
                imageView.image = [UIImage imageNamed:@"sinawb.png"];
                UILabel *infolabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 15, 200, 20)];
                infolabel.text = @"分享到新浪微博";
                [cell addSubview:infolabel];
                cell.backgroundColor = [UIColor whiteColor];
                //添加按钮
                UIButton *sinaButton=[[UIButton alloc]initWithFrame:CGRectMake(250, 8, 50, 28)];
                [sinaButton setBackgroundImage:[UIImage imageNamed:@"but_key.png"] forState:UIControlStateNormal];
                [sinaButton addTarget:self action:@selector(sinawbmanage:) forControlEvents:UIControlEventTouchUpInside];
                if([weiBoEngine isLoggedIn] && ![weiBoEngine isAuthorizeExpired]){
                    [sinaButton setTitle:@"解绑" forState:UIControlStateNormal];
                    sinaButton.titleLabel.font=[UIFont fontWithName:@"Helvetica" size:13];
                    sinaButton.titleLabel.textColor=[UIColor blackColor];
                    sinaButton.tag = 0;
                }else{
                    [sinaButton setTitle:@"绑定" forState:UIControlStateNormal];
                    sinaButton.titleLabel.font=[UIFont fontWithName:@"Helvetica" size:13];
                    sinaButton.titleLabel.textColor=[UIColor blackColor];
                    sinaButton.tag = 1;
                }
                [cell addSubview:sinaButton];
                return cell;
                break;
            }
            case 1:
            {
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 5, 32, 32)];
                [cell addSubview:imageView];
                imageView.image = [UIImage imageNamed:@"tencentwb.png"];
                UILabel *infolabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 15, 200, 20)];
                infolabel.text = @"分享到腾讯微博";
                [cell addSubview:infolabel];
                cell.backgroundColor = [UIColor whiteColor];
                //添加按钮
                UIButton *tencentButton=[[UIButton alloc]initWithFrame:CGRectMake(250, 8, 50, 28)];
                [tencentButton setBackgroundImage:[UIImage imageNamed:@"but_key.png"] forState:UIControlStateNormal];
                [tencentButton addTarget:self action:@selector(tencentwbmanage:) forControlEvents:UIControlEventTouchUpInside];
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString *documentsDirectory = [paths objectAtIndex:0];
                NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"tencentWBauthinfo.plist"];
                NSDictionary *userlist_info = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
                NSString *accessToken = [userlist_info objectForKey:@"accessToken"];
                if (accessToken == nil) {
                    [tencentButton setTitle:@"绑定" forState:UIControlStateNormal];
                    tencentButton.titleLabel.font=[UIFont fontWithName:@"Helvetica" size:13];
                    tencentButton.titleLabel.textColor=[UIColor blackColor];
                    tencentButton.tag = 3;
                }else{
                    [tencentButton setTitle:@"解绑" forState:UIControlStateNormal];
                    tencentButton.titleLabel.font=[UIFont fontWithName:@"Helvetica" size:13];
                    tencentButton.titleLabel.textColor=[UIColor blackColor];
                    tencentButton.tag = 2;
                }
                [cell addSubview:tencentButton];
                return cell;
                break;
            }
        }
    }
}
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView 
{
	return 2;
} 
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return cellnum;
            break;
        case 1:
            return 2;
            break;
        default:
            return 1;
            break;
    }
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return loginTip;
            break;
        case 1:
            return @"其他平台";
            break;
        default:
            return @"";
            break;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0 && indexPath.row ==  [userinfo count]){
        MoreAccountAddViewController *addaccount = [[MoreAccountAddViewController alloc] initWithNibName:@"MoreAccountAddViewController" bundle:nil];
        [self.navigationController pushViewController:addaccount animated:YES];
    }
}
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int indexnum = indexPath.row;
    if(indexnum == [userinfo count]){
        return indexPath;
    }else{
        return nil;
    }
}
//UISwitch开关触发函数
-(void)switchPress:(UISwitch *)InSwitch
{
    aiv.hidden = NO;
    if(InSwitch.on){
        //获取被选择登陆的用户名
        nowuser = [userinfo objectAtIndex:InSwitch.tag];
        //从文件中调取用户信息
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"user.plist"]
        ;
        NSDictionary *userlist_info = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        nowuser_info = [[NSDictionary alloc] initWithDictionary:[userlist_info objectForKey:nowuser]];
        //登陆后将该用户论坛板块权限信息写入文件中
        NSString *url_start = [api_url stringByAppendingString:@"topiclist.php?type=forum_list&uid="];
        NSString *uidno     = [nowuser_info objectForKey:@"uid"];
        NSString *url_final = [url_start stringByAppendingString:uidno];
        ASIHTTPRequest *head = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url_final]];
        [head setTag:1];
        [head setDelegate:self];
        [head setPersistentConnectionTimeoutSeconds:30];
        [head startAsynchronous];
    }else{//退出登陆
        //更新forumlist.plist为游客账户权限
        NSString *url_final = [api_url stringByAppendingString:@"topiclist.php?type=forum_list"];
        ASIHTTPRequest *head = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url_final]];
        [head setTag:2];
        [head setDelegate:self];
        [head setPersistentConnectionTimeoutSeconds:30];
        [head startAsynchronous];
    }
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    if(request.tag == 1){
        aiv.hidden = YES;
        NSString *requestString = [request responseString];
        NSArray *forumlist_array = [[requestString JSONValue] valueForKey:@"datas"];
        NSString *forumlist_filePath = [documentsDirectory stringByAppendingPathComponent:@"forumlist.plist"];
        [NSKeyedArchiver archiveRootObject:forumlist_array toFile:forumlist_filePath];
        //登陆后将该用户写入当前登陆用户文件中
        NSDictionary *nowlogin = [[NSDictionary alloc] initWithObjectsAndKeys:nowuser,@"username",[nowuser_info objectForKey:@"sessionid"],@"sessionid",[nowuser_info objectForKey:@"uid"],@"uid",nil];
        NSString *nowlogin_filePath = [documentsDirectory stringByAppendingPathComponent:@"nowlogin.plist"];
        [NSKeyedArchiver archiveRootObject:nowlogin toFile:nowlogin_filePath];
        [nowlogin release];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"notifyToloadPostListNotification" object:nil];
    }
    if(request.tag == 2){
        aiv.hidden = YES;
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *requestString = [request responseString];
        
        NSArray *forumlist_array = [[requestString JSONValue] valueForKey:@"datas"];
        NSString *forumlist_filePath = [documentsDirectory stringByAppendingPathComponent:@"forumlist.plist"];
        [NSKeyedArchiver archiveRootObject:forumlist_array toFile:forumlist_filePath];
        //清空nowlogin.plist
        NSDictionary *nowlogin = [[NSDictionary alloc] initWithObjectsAndKeys:nil,@"username",nil,@"sessionid",nil,@"uid",nil];
        NSString *nowlogin_filePath = [documentsDirectory stringByAppendingPathComponent:@"nowlogin.plist"];
        [NSKeyedArchiver archiveRootObject:nowlogin toFile:nowlogin_filePath];
        [nowlogin release];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"notifyToloadPostListNotification" object:nil];
    }
    if(request.tag == 3){
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *requestString = [request responseString];
        
        NSArray *forumlist_array = [[requestString JSONValue] valueForKey:@"datas"];
        NSString *forumlist_filePath = [documentsDirectory stringByAppendingPathComponent:@"forumlist.plist"];
        [NSKeyedArchiver archiveRootObject:forumlist_array toFile:forumlist_filePath];
        //清空nowlogin.plist
        NSDictionary *nowlogin = [[NSDictionary alloc] initWithObjectsAndKeys:nil,@"username",nil,@"sessionid",nil,@"uid",nil];
        NSString *nowlogin_filePath = [documentsDirectory stringByAppendingPathComponent:@"nowlogin.plist"];
        [NSKeyedArchiver archiveRootObject:nowlogin toFile:nowlogin_filePath];
        [nowlogin release];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"notifyToloadPostListNotification" object:nil];
    }
    //重载tableview数据
    [self.thetableview reloadData];
}
- (void)requestFailed:(ASIHTTPRequest *)request
{
    if(request.tag == 1){
        aiv.hidden = YES;
        UIAlertView *error_alert = [[UIAlertView alloc] initWithTitle:nil message:@"登陆失败,请重试" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil];
        [error_alert show];
        [error_alert release];
    }
    if(request.tag == 2){
        aiv.hidden = YES;
        UIAlertView *error_alert = [[UIAlertView alloc] initWithTitle:nil message:@"退出失败,请重试" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil];
        [error_alert show];
        [error_alert release];
    }
    if(request.tag == 3){
        UIAlertView *error_alert = [[UIAlertView alloc] initWithTitle:nil message:@"刷新为游客权限失败" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil];
        [error_alert show];
        [error_alert release];
    }
}
- (void)sinawbmanage:(UIButton *)sender
{
    if(sender.tag == 0){
        [weiBoEngine logOut];
        [thetableview reloadData];
    }
    if(sender.tag == 1){
        [weiBoEngine logIn];
    }
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
    [thetableview reloadData];
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
- (void)tencentwbmanage:(UIButton *)sender
{
    if(sender.tag == 2){
        //绑定信息写入plist文件中
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"tencentWBauthinfo.plist"];
        NSDictionary *new_userinfo = [[NSDictionary alloc] initWithObjectsAndKeys:nil,@"accessToken",nil,@"openid",nil,@"openkey",nil];
        [NSKeyedArchiver archiveRootObject:new_userinfo toFile:filePath];
        [thetableview reloadData];
    }
    if(sender.tag == 3){
        webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
        webView.scalesPageToFit = YES;
        webView.userInteractionEnabled = YES;
        webView.delegate = self;
        webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:webView];
        [opensdk doWebViewAuthorize:webView];
    }
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
            [thetableview reloadData];
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
@end
