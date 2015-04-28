//
//  VoteOneViewController.m
//  VeryNC
//
//  Created by mac on 12-4-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "VoteOneViewController.h"
#import "CustomActionSheet.h"
#import "CustomActionSheetPollReview.h"
#import "ReaderController.h"
#import "MoreAccountViewController.h"
@interface VoteOneViewController ()

@end

@implementation VoteOneViewController
@synthesize api_url,polltitle,tid,ttitle,num;
- (void)dealloc
{
    [tipLabel release];
    [menuBtn release];
    [num release];
    [ttitle release];
    [tid release];
    [polltitle release];
    [api_url release];
    [super dealloc];
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
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    api_url = delegate.myDomainAndPathVeryNC;
    //调取当前用户信息
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *nowlogin_filePath = [documentsDirectory stringByAppendingPathComponent:@"nowlogin.plist"];
    NSDictionary *now = [NSKeyedUnarchiver unarchiveObjectWithFile:nowlogin_filePath];
    NSString *uid  = [now objectForKey:@"uid"];
    if(uid == nil){
        uid = @"";
    }
    
    //请求数据
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@topiclist.php?type=poll&pageno=%@&pagesize=1&uid=%@",api_url,num,uid]]];
	[request setTag:0];
	//[request setDownloadCache:[ASIDownloadCache sharedCache]];
	//[request setCachePolicy:ASIAskServerIfModifiedWhenStaleCachePolicy];
	[request setDelegate:self];
    [request setPersistentConnectionTimeoutSeconds:30];
	[request startAsynchronous];
    
    [ViewTool addUIImageView:self.view imageName:@"ico5.png" type:@"" x:10 y:185 x1:14 y1:14];
    UILabel *titleLabel = [ViewTool addUILable:self.view x:25 y:182 x1:50 y1:20 fontSize:15 lableText:@"投票问题"];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:12];
    
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

- (void)requestFinished:(ASIHTTPRequest *)request {
    NSString *requestString = [request responseString];
    requestString = [requestString stringByReplacingOccurrencesOfString:@"\"\"\\" withString:@"\"\\"] ;
    requestString = [requestString stringByReplacingOccurrencesOfString: @"\\'" withString: @"'"];
    NSArray *tmpArray = [[requestString JSONValue] valueForKey:@"datas"];
    if([tmpArray count] != 0){
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 170)];
        [self.view addSubview:imageView];
        [imageView release];
        [imageView setImageWithURL:[NSURL URLWithString:[[tmpArray objectAtIndex:0] objectForKey:@"pic"]] placeholderImage:[UIImage imageNamed:@"defalut_img_big.png"]];
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage)];
        [imageView addGestureRecognizer:singleTap];
        [ViewTool addUIImageView:self.view imageName:@"bigblack.png" type:@"" x:0 y:142 x1:320 y1:28].alpha = 0.7;
        UILabel *titleLabel = [ViewTool addUILable:self.view x:10 y:145 x1:320 y1:20 fontSize:15 lableText:[[tmpArray objectAtIndex:0] objectForKey:@"subject"]];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [ViewTool addUIImageView:self.view imageName:@"whiteline.png" type:@"" x:0 y:142 x1:320 y1:.5];
        
        UILabel *titleLabel_big = [ViewTool addUILable:self.view x:10 y:210 x1:300 y1:20 fontSize:16 lableText:[[tmpArray objectAtIndex:0] objectForKey:@"title"]];
        titleLabel_big.textColor = [UIColor blackColor];
        titleLabel_big.font = [UIFont boldSystemFontOfSize:16];
        
        //判断提示语信息
        int expiration = [[[tmpArray objectAtIndex:0] objectForKey:@"expiration"] intValue];
        int nowtime =  [[NSString stringWithFormat:@"%d", time(NULL)] intValue];
        NSString *pollTip;
        NSString *userpollstate = [[requestString JSONValue] valueForKey:@"count"];
        if(expiration != 0 && nowtime >= expiration){
            pollTip = @"投票已结束";
            //添加按钮
            menuBtn = [[UIButton alloc] initWithFrame:CGRectMake(85, 290, 150, 40)];
            [menuBtn setImage:[UIImage imageNamed:@"viewpoll.png"] forState:UIControlStateNormal];
            [menuBtn addTarget:self action:@selector(pollreview) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:menuBtn];
        }else{
            if([userpollstate isEqualToString:@"have voted"]){
                pollTip = @"感谢投票";
                //添加按钮
                menuBtn = [[UIButton alloc] initWithFrame:CGRectMake(85, 290, 150, 40)];
                [menuBtn setImage:[UIImage imageNamed:@"viewpoll.png"] forState:UIControlStateNormal];
                [menuBtn addTarget:self action:@selector(pollreview) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:menuBtn];
            }else{
                pollTip = @"投票进行中";
                //添加按钮
                menuBtn = [[UIButton alloc] initWithFrame:CGRectMake(85, 290, 150, 40)];
                [menuBtn setImage:[UIImage imageNamed:@"dopoll.png"] forState:UIControlStateNormal];
                [menuBtn addTarget:self action:@selector(polldolist) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:menuBtn];
            }
        }
        tipLabel = [ViewTool addUILable:self.view x:10 y:250 x1:100 y1:20 fontSize:15 lableText:pollTip];
        tipLabel.textColor = [UIColor grayColor];
        tipLabel.font = [UIFont systemFontOfSize:12];
        
        NSDateFormatter* formatter =[[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSTimeInterval timecontent=[[[tmpArray objectAtIndex:0] objectForKey:@"dateline"] doubleValue];//str是NSString类型
        NSDate *timeDate = [NSDate dateWithTimeIntervalSince1970:timecontent];
        NSString * time = [formatter stringFromDate:timeDate];
        UILabel *timeLabel = [ViewTool addUILable:self.view x:250 y:250 x1:100 y1:20 fontSize:15 lableText:time];
        timeLabel.textColor = [UIColor grayColor];
        timeLabel.font = [UIFont systemFontOfSize:12];
        
        
        
        //赋值
        self.ttitle = [[tmpArray objectAtIndex:0] objectForKey:@"subject"];
        self.polltitle = [[tmpArray objectAtIndex:0] objectForKey:@"title"];
        self.tid = [[tmpArray objectAtIndex:0] objectForKey:@"id"];
    }
}
- (void)requestFailed:(ASIHTTPRequest *)request {
    UIAlertView *alert;
    NSError *error = [request error];
    if (error)
        alert = [[UIAlertView alloc] initWithTitle:@"链接错误" 
                                           message:@"暂时不能连接服务器" 
                                          delegate:self cancelButtonTitle:@"知道了" 
                                 otherButtonTitles:nil];
    [alert show];
    [alert release];
}
-(void)polldolist
{
    //调取当前用户信息
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *nowlogin_filePath = [documentsDirectory stringByAppendingPathComponent:@"nowlogin.plist"];
    NSDictionary *now = [NSKeyedUnarchiver unarchiveObjectWithFile:nowlogin_filePath];
    NSString *uid  = [now objectForKey:@"uid"];

    if(uid == nil){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"notifyToPushAccountView" object:nil];
    }else{
        CustomActionSheet *sheet = [[CustomActionSheet alloc] initWithHeight:350.0f Title:polltitle withtid:tid];
        [sheet showInView:[UIApplication sharedApplication].keyWindow];
        [sheet release];
    }
}
- (void)pollreview
{
    CustomActionSheetPollReview *sheet = [[CustomActionSheetPollReview alloc] initWithHeight:350.0f Title:polltitle withtid:tid];
    [sheet showInView:[UIApplication sharedApplication].keyWindow];
    [sheet release];
}

- (void)onClickImage
{
    NSArray *readerinfo = [[NSArray alloc] initWithObjects:ttitle,tid,nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notifyToPushView" object:readerinfo];
}
@end
