//
//  voteViewController.m
//  VeryNC
//
//  Created by wu jinjin on 12-4-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "voteViewController.h"
#import "VoteOneViewController.h"
#import "ReaderController.h"
@interface voteViewController ()

@end

@implementation voteViewController
@synthesize appDelegate;
@synthesize myDelegate;
@synthesize scrollview,pagecontrol,api_url;
- (void)dealloc
{
    [api_url release];
    [pagecontrol release];
    [scrollview release];
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
    [super viewDidLoad];
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    api_url = delegate.myDomainAndPathVeryNC;
    //得到有多少个投票信息
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@topiclist.php?type=allpoll",api_url]]];
	//[request setDownloadCache:[ASIDownloadCache sharedCache]];
	//[request setCachePolicy:ASIAskServerIfModifiedWhenStaleCachePolicy];
	[request setDelegate:self];
    [request setPersistentConnectionTimeoutSeconds:30];
	[request startAsynchronous];
    
    
    
    // Do any additional setup after loading the view from its nib.
    [[self navigationItem] setTitle: @"投票"]; 
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:158.0/255.0 green:26.0/255.0 blue:36.0/255.0 alpha:1.000]];
    //NSArray *readerinfo = nil;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushView:) name:@"notifyToPushView" object:nil];
    //添加一个修改提示语和按钮的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ChangeTipAndButton) name:@"notifyToChangeTipAndButton" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushtoaccountview) name:@"notifyToPushAccountView" object:nil];
    
    UIBarButtonItem *refresh_btn = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UITabBarSystemItemContacts target:self action:@selector(ChangeTipAndButton)];
    self.navigationItem.leftBarButtonItem = refresh_btn;
}
- (void)pushtoaccountview
{
    MoreAccountViewController *accountview = [[MoreAccountViewController alloc] initWithNibName:@"MoreAccountViewController" bundle:nil];
    [self.navigationController pushViewController:accountview animated:YES];
}
- (void)ChangeTipAndButton
{
    [pagecontrol removeFromSuperview];
    [scrollview removeFromSuperview];
    //得到有多少个投票信息
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@topiclist.php?type=allpoll",api_url]]];
	//[request setDownloadCache:[ASIDownloadCache sharedCache]];
	//[request setCachePolicy:ASIAskServerIfModifiedWhenStaleCachePolicy];
	[request setDelegate:self];
    [request setPersistentConnectionTimeoutSeconds:30];
	[request startAsynchronous];
}
- (void)pushView:(NSNotification*)notification
{
    NSArray *readerinfo = [notification object];
    ReaderController *reader = [[ReaderController alloc] init];
    reader.Title = [readerinfo objectAtIndex:0];
    reader.tid = [[readerinfo objectAtIndex:1] intValue];
    [self.navigationController pushViewController:reader animated:YES];
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

//滑动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;//当前是第几个视图
    pagecontrol.currentPage = index;
}

- (void)requestFinished:(ASIHTTPRequest *)request {
    NSString *requestString = [request responseString];
    requestString = [requestString stringByReplacingOccurrencesOfString:@"\"\"\\" withString:@"\"\\"] ;
    requestString = [requestString stringByReplacingOccurrencesOfString: @"\\'" withString: @"'"];
    NSArray *tmpArray = [[requestString JSONValue] valueForKey:@"datas"];
    int totalnum = [tmpArray count];
    scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width, 480)];
    scrollview.showsVerticalScrollIndicator = NO;
    scrollview.showsHorizontalScrollIndicator = NO;
    scrollview.pagingEnabled = YES;
    scrollview.contentSize=CGSizeMake(scrollview.frame.size.width*totalnum, scrollview.frame.size.height); //可以滚动的大小
    scrollview.scrollsToTop = NO;
    scrollview.delegate=self;
    scrollview.bounces=    NO;
    scrollview.directionalLockEnabled = YES;
    for(int i=0;i<totalnum;i++){
        VoteOneViewController *voteone = [[VoteOneViewController alloc]init];
        voteone.num = [NSString stringWithFormat:@"%d",i+1];
        voteone.view.frame = CGRectMake(self.view.frame.size.width*i, 0, self.view.frame.size.width, self.view.frame.size.height);
        [scrollview addSubview:voteone.view];
    }
    
    pagecontrol = [[UIPageControl alloc] initWithFrame:CGRectMake(0,350, 320, 20)]; 
    pagecontrol.backgroundColor = [UIColor blackColor];
    pagecontrol.hidesForSinglePage = YES; 
    pagecontrol.userInteractionEnabled = NO; 
    pagecontrol.numberOfPages = totalnum;     //几个小点  
    [self.view addSubview:pagecontrol];     
    [self.view insertSubview:scrollview atIndex:0];
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
@end
