//
//  MoreAccountAddViewController.m
//  化龙巷
//
//  Created by mac on 12-3-22.
//  Copyright (c) 2012年 Osugroup. All rights reserved.
//

#import "MoreAccountAddViewController.h"
#import "ASIFormDataRequest.h"
#import "AppDelegate.h"
#import "DebugLog.h"
@interface MoreAccountAddViewController ()

@end

@implementation MoreAccountAddViewController
@synthesize username,password,aiv,api_url,loginTip,loginURL;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"登陆";
    }
    return self;
}

- (void)viewDidLoad
{
    AppDelegate *delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    api_url = delegate.myDomainAndPathVeryNC;
    loginTip = delegate.loginTip;
    loginURL = delegate.loginURL;
    
    UIBarButtonItem *loginbtn = [[UIBarButtonItem alloc] initWithTitle:@"登陆" style:UITabBarSystemItemContacts target:self action:@selector(logindo:)];
    self.navigationItem.rightBarButtonItem = loginbtn;
    aiv.hidden = YES;
    
    UIButton *url_link = [[UIButton alloc] initWithFrame:CGRectMake(60, 120, 200, 20)];
    [url_link setTitle:loginURL forState:UIControlStateNormal];
    [url_link setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    url_link.titleLabel.font = [UIFont fontWithName:@"helvetica" size:16];
    [url_link addTarget:self action:@selector(openlink) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:url_link];
    [url_link release];
    

    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}



-(void)openlink
{
    NSURL *url = [NSURL URLWithString:loginURL];
    [[UIApplication sharedApplication] openURL:url];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)dealloc
{
    [username release];
    [password release];
    [aiv release];
    [super dealloc];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
//构建登陆表单
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        static NSString *CellIdentifier = @"account";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.textLabel.text = @"用户名:";
        username = [[UITextField alloc] initWithFrame:CGRectMake(80, 10, 200, 28)];
        username.placeholder = @"请输入用户名";
        [cell addSubview:username];
        return cell;
    }else{
        static NSString *CellIdentifier = @"account";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.textLabel.text = @"密    码:";
        password = [[UITextField alloc] initWithFrame:CGRectMake(80, 10, 200, 28)];
        password.secureTextEntry = YES;
        password.placeholder =@"请输入密码";
        [cell addSubview:password];
        return cell;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return @"注册账户请登陆";
}
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}
//md5加密函数
-(NSString *)encode:(NSString *)value{
	[value retain];
	const char *cStr = [value UTF8String];
	[value release];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result ); // This is the md5 call
    return [NSString stringWithFormat:
			@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
			result[0], result[1], result[2], result[3], 
			result[4], result[5], result[6], result[7],
			result[8], result[9], result[10], result[11],
			result[12], result[13], result[14], result[15]
			];  
}
//登陆执行
-(void)logindo:(id)sender
{
    //关键盘开Loading动画
    [username resignFirstResponder];
    [password resignFirstResponder];
    aiv.hidden = NO;
    
    NSString *username_text = username.text;
    NSString *password_text = password.text;
    if([username_text length]==0 || [password_text length]==0){
        aiv.hidden = YES;
        UIAlertView *null_alert = [[UIAlertView alloc] initWithTitle:nil message:@"用户名或密码不能为空" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil];
        [null_alert show];
        [null_alert release];
    }else{
        NSURL *login_url = [NSURL URLWithString:[api_url stringByAppendingString:@"login.php?type=onlinedo"]];
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:login_url];
        [request setPostValue:username.text forKey:@"useracc"];
        NSString *password_md5  = [self encode:password_text];
        [request setPostValue:password_md5 forKey:@"userpw"];
        [request setDelegate:self];
        [request setTimeOutSeconds:30];//设置延迟时间，单位秒
        [request startAsynchronous];
    }
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    if(request.tag == 99){
        NSString *requestString = [request responseString];
        NSArray *forumlist_array = [[requestString JSONValue] valueForKey:@"datas"];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *forumlist_filePath = [documentsDirectory stringByAppendingPathComponent:@"forumlist.plist"];
        [NSKeyedArchiver archiveRootObject:forumlist_array toFile:forumlist_filePath];
    }else{
        NSString *username_text = username.text;
        NSString *requestString = [request responseString];
        NSArray *response_info = [[requestString JSONValue] valueForKey:@"datas"];
        NSDictionary *login_info = [response_info objectAtIndex:0];
        NSString *sid = [login_info objectForKey:@"sessionid"];
        NSNumber *uid = [login_info objectForKey:@"uid"];
        if([sid isEqualToString:@"aperror"]){
            aiv.hidden = YES;
            UIAlertView *error_alert = [[UIAlertView alloc] initWithTitle:nil message:@"用户名或密码错误" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil];
            [error_alert show];
            [error_alert release];
        }else{
            //归档用户信息数据
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"user.plist"];
            NSDictionary *userinfo = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
            NSMutableDictionary *new_userinfo = [[NSMutableDictionary alloc] init];
            for(NSString *key in userinfo){
                [new_userinfo setValue:(NSDictionary *)[userinfo objectForKey:key] forKey:key];
            }
            [new_userinfo setValue:login_info forKey:username_text];
            [NSKeyedArchiver archiveRootObject:new_userinfo toFile:filePath];
            [new_userinfo release];
            //登陆后将该用户写入当前登陆用户文件中
            NSDictionary *nowlogin = [[NSDictionary alloc] initWithObjectsAndKeys:username_text,@"username",sid,@"sessionid",uid,@"uid",nil];
            NSString *nowlogin_filePath = [documentsDirectory stringByAppendingPathComponent:@"nowlogin.plist"];
            [NSKeyedArchiver archiveRootObject:nowlogin toFile:nowlogin_filePath];
            //登陆后将该用户论坛板块权限信息写入文件中
            NSString *url_start = [api_url stringByAppendingString:@"topiclist.php?type=forum_list&uid="];
            NSString *uidno     = [NSString stringWithFormat:@"%@",uid];
            NSString *url_final = [url_start stringByAppendingString:uidno];
            //NSLog(@"loginrequest_url = %@",url_final);
            ASIHTTPRequest *head = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url_final]];
            [head setTag:99];
            [head setDelegate:self];
            [head setPersistentConnectionTimeoutSeconds:30];
            [head startAsynchronous];
            
            //        NSString *requestString = [head responseString];
            //        NSArray *forumlist_array = [[requestString JSONValue] valueForKey:@"datas"];
            //        NSString *forumlist_filePath = [documentsDirectory stringByAppendingPathComponent:@"forumlist.plist"];
            //        [NSKeyedArchiver archiveRootObject:forumlist_array toFile:forumlist_filePath];
            //返回之前的账号列表
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"notifyToloadPostListNotification" object:nil];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
}
- (void)requestFailed:(ASIHTTPRequest *)request
{
    aiv.hidden = YES;
    UIAlertView *error_alert = [[UIAlertView alloc] initWithTitle:nil message:@"登陆失败,请重试" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil];
    [error_alert show];
    [error_alert release];
}
@end
