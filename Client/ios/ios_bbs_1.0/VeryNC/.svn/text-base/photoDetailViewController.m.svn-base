//
//  photoDetailViewController.m
//  VeryNC
//
//  Created by mac on 12-5-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "photoDetailViewController.h"
#import "photoDetailOneViewController.h"
#import "ReaderController.h"
#import "ShareViewController.h"
#import "Constants.h"
#import "MoreAccountViewController.h"
@interface photoDetailViewController ()

@end

@implementation photoDetailViewController
@synthesize api_url,picshow_id,scrollview,tmparray,picshow_title,tid,fid,picshow_coverpic,shareimage;
- (void)dealloc
{
    [shareimage release];
    [picshow_coverpic release];
    [fid release];
    [tid release];
    [picshow_title release];
    [tmparray release];
    [scrollview release];
    [picshow_id release];
    [api_url release];
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    hiddennavbar = 0;
    self.view.backgroundColor = [UIColor blackColor];
    
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    api_url = delegate.myDomainAndPathVeryNC;
    
    [[self navigationItem] setTitle: @"图片浏览"];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:0.300]];
    //self.navigationController.navigationBar.hidden = NO;
    
    UIBarButtonItem *map_btn = [[UIBarButtonItem alloc] initWithTitle:@"原帖" style:UITabBarSystemItemContacts target:self action:@selector(pushtoreader)];
    self.navigationItem.rightBarButtonItem = map_btn;
    
    //获得图片数据
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@topiclist.php?type=picshow_pic_info&picshow_id=%@",api_url,picshow_id]]];
	//[request setDownloadCache:[ASIDownloadCache sharedCache]];
	//[request setCachePolicy:ASIAskServerIfModifiedWhenStaleCachePolicy];
	[request setDelegate:self];
    [request setPersistentConnectionTimeoutSeconds:30];
	[request startAsynchronous];
    
    //添加通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hiddennavbar:) name:@"notifytohidenavbar" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushtoshareview:) name:@"notifytoshowshareview" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushtoaccountview:) name:@"notifytopushtoaccountview" object:nil];
    // Do any additional setup after loading the view from its nib.
}
- (void)pushtoshareview:(NSNotification*)notification
{
    NSString *typetitle = [notification object];
    ShareViewController *share = [[ShareViewController alloc] initWithNibName:@"ShareViewController" bundle:nil];
    share.typetitle = typetitle;
    share.content = [NSString stringWithFormat:@"//%@ %@/forum.php?mod=viewthread&tid=%@",picshow_title,_quoteImageVeryNC,self.tid];
    [self.navigationController pushViewController:share animated:YES];
}
- (void)pushtoaccountview:(NSNotification*)notification
{
    MoreAccountViewController *moreaccount = [[MoreAccountViewController alloc] initWithNibName:@"MoreAccountViewController" bundle:nil];
    [self.navigationController pushViewController:moreaccount animated:YES];
}
- (void)hiddennavbar:(NSNotification*)notification
{
    if(hiddennavbar == 0){
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        hiddennavbar = 1;
    }else{
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        hiddennavbar = 0;
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:0.300]];
}
- (void)pushtoreader
{
    ReaderController *reader = [[ReaderController alloc] init];
    reader.Title = picshow_title;
    reader.tid   = [tid intValue];
    reader.fid   = [fid intValue];
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
- (void)requestFinished:(ASIHTTPRequest *)request {
    NSString *requestString = [request responseString];
    requestString = [requestString stringByReplacingOccurrencesOfString:@"\"\"\\" withString:@"\"\\"] ;
    requestString = [requestString stringByReplacingOccurrencesOfString: @"\\'" withString: @"'"];
    tmparray = [[requestString JSONValue] valueForKey:@"datas"];
    int totalnum = [tmparray count];
    scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width, 480)];
    scrollview.showsVerticalScrollIndicator = NO;
    scrollview.showsHorizontalScrollIndicator = NO;
    scrollview.pagingEnabled = YES;
    scrollview.contentSize=CGSizeMake(scrollview.frame.size.width*totalnum, scrollview.frame.size.height); //可以滚动的大小
    scrollview.scrollsToTop = NO;
    scrollview.delegate = self;
    scrollview.bounces = NO;
    scrollview.directionalLockEnabled = YES;
    [scrollview setMinimumZoomScale:1.0];
    [scrollview setMaximumZoomScale:5.0];
    
    for(int i=0;i<totalnum;i++){
        photoDetailOneViewController *photodetailone = [[photoDetailOneViewController alloc]init];
        photodetailone.picshow_id  = [[tmparray objectAtIndex:i] objectForKey:@"picshow_id"];
        photodetailone.pic_url     = [[tmparray objectAtIndex:i] objectForKey:@"pic_photo"];
        photodetailone.pic_title   = [[tmparray objectAtIndex:i] objectForKey:@"picshow_title"];; 
        photodetailone.pic_message = [[tmparray objectAtIndex:i] objectForKey:@"pic_message"];
        photodetailone.pageshow    = [NSString stringWithFormat:@"%d/%d",i+1,totalnum];
        photodetailone.tid         = self.tid;
        photodetailone.fid         = self.fid;
        photodetailone.picshow_coverpic = self.picshow_coverpic;
        photodetailone.view.frame  = CGRectMake(self.view.frame.size.width*i, 0, self.view.frame.size.width, self.view.frame.size.height);
        [scrollview addSubview:photodetailone.view];
    }
    
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
