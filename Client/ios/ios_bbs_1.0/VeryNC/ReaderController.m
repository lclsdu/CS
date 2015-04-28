//
//  ReaderController.m
//  化龙巷
//
//  Created by Kryhear on 12-2-24.
//  Copyright (c) 2012年 Osugroup. All rights reserved.
//

#import "ReaderController.h"
#import "AppDelegate.h"
#define kDefaultTag 200
#define kMasterTag 201
#define kLastCommentTag 202


#define kpublishTag 400

#define kHomePageTag 300
#define kPrevPageTag 301
#define kNextPageTag 302
#define kLastPageTag 303
#define kReloadPageTag 304
 
#define kDefaultRequestURLWithPage(tid,x) [NSString stringWithFormat:@"%@topiclist.php?type=thread_detail&tid=%d&pageno=%d&pagesize=20&dev=iphone",api_url,tid,x]
#define kMasterDetailRequestURLWithPage(tid,x) [NSString stringWithFormat:@"%@topiclist.php?type=thread_detail&tid=%d&pageno=%d&pagesize=20&addtype=only_owner&dev=iphone",api_url,tid,x]
#define kLastCommentRequestURLWithPage(tid,x) [NSString stringWithFormat:@"%@topiclist.php?type=thread_detail&tid=%d&pageno=%d&pagesize=20&addtype=last_post&dev=iphone",api_url,tid,x]


@implementation ReaderController

@synthesize isFromDetail;
@synthesize tid=_itd; 
@synthesize Title;
@synthesize fid;
@synthesize htmlString;
@synthesize htmlWebView;
@synthesize api_url;
//@synthesize myRequest ;
@synthesize isWorkingASI=_isWorkingASI;


@synthesize quoteImage_url;

@synthesize pid;
@synthesize ptid;
@synthesize authorQuote;
@synthesize messageQuote;
@synthesize datelineQuote;

@synthesize myDelegate, appDelegate;

@synthesize isclosed;




 
-(bool)checkIfHasRightToReply:(NSInteger)temfid;
{
    //  fid（板块ID）、ispost（0不可以发帖1可以发帖）、isreply（0不可以回帖1可以回帖）、ispostimage（0不能带图片1可以带图片）
    
    
    //  fid（板块ID）、ispost（0不可以发帖1可以发帖）、isreply（0不可以回帖1可以回帖）、ispostimage（0不能带图片1可以带图片）
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; 
    
    
    NSArray *forumlist_array;
    
    
    
    NSString *forumlist_filePath = [documentsDirectory stringByAppendingPathComponent:@"forumlist.plist"];
    
    forumlist_array =[NSKeyedUnarchiver unarchiveObjectWithFile:forumlist_filePath];
    
    for (int i=0;i<[forumlist_array count]; i++ ) {
        
        NSInteger tfid=[[[forumlist_array objectAtIndex:i] objectForKey:@"fid"] intValue];
        if (temfid==tfid) {
            
            NSInteger tisreply=[[[forumlist_array objectAtIndex:i] objectForKey:@"isreply"] intValue];
            if(tisreply==0)
                return false;
            else
                return true;
        };
        DebugLog(@":::     %d ",tfid );
        
        
    }
    
    return false;
    
}

-(bool)checkIfHasRightToAttachImage:(NSInteger)temfid;
{
    //  fid（板块ID）、ispost（0不可以发帖1可以发帖）、isreply（0不可以回帖1可以回帖）、ispostimage（0不能带图片1可以带图片）
    
    
    //  fid（板块ID）、ispost（0不可以发帖1可以发帖）、isreply（0不可以回帖1可以回帖）、ispostimage（0不能带图片1可以带图片）
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; 
    
    
    NSArray *forumlist_array;
    
    
    
    NSString *forumlist_filePath = [documentsDirectory stringByAppendingPathComponent:@"forumlist.plist"];
    
    forumlist_array =[NSKeyedUnarchiver unarchiveObjectWithFile:forumlist_filePath];
    
    for (int i=0;i<[forumlist_array count]; i++ ) {
        
        NSInteger tfid=[[[forumlist_array objectAtIndex:i] objectForKey:@"fid"] intValue];
        if (temfid==tfid) {
            
            NSInteger tisreply=[[[forumlist_array objectAtIndex:i] objectForKey:@"ispostimage"] intValue];
            if(tisreply==0)
                return false;
            else
                return true;
        };
        DebugLog(@":::     %d ",tfid );
        
        
    }
    
    return false;
    
}

//[self.webView loadHTMLString:htmlString baseURL:nil];
#pragma -mark UIWebViewDelegate

- (void)loadRequest:(NSURLRequest *)request
{
    [self retain];
    if ([htmlWebView isLoading])
        [htmlWebView stopLoading];
    [htmlWebView loadRequest:request];
    [self release];
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self retain];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self release];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self release];
}

 

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (navigationType == UIWebViewNavigationTypeLinkClicked)
    {   
        
        
        if ([[UIApplication sharedApplication] openURL:[request URL]]){
            
            return NO;
        }else {
            quoteTag=YES;
            [[NSNotificationCenter defaultCenter]postNotificationName:@"QuoteReplyNotification" object:request];
        }
        
    }
    else
    {
        
        return YES;
    }
    return  NO;
    
}




- (NSString *)removeNewlinesAndTabulation:(NSString *)fromString appending:(BOOL)appending
{
    NSArray *a = [fromString componentsSeparatedByString:@"\n"];
    NSMutableString *res = [NSMutableString stringWithString:appending ? @" " : @""];
    for (NSString *s in a) {
        s = [s stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if (s.length > 0 
            && res.length > (appending ? 1 : 0)) [res appendString:@" "];
        [res appendString:s];
    }
    return res;
}


-(void)setRightBarItemStatus;
{
    
    
    UIBarButtonItem *barButton;
    
    if([self checkIfHasLogIn])   
    { 
        DebugLog(@"%d",fid);
        if([self checkIfHasRightToReply:fid])
        {
            
            barButton= self.navigationItem.rightBarButtonItem ;
//            barButton.image = [UIImage imageNamed:@"reply.png"];
            barButton.title = @"回帖";
            
            //barButton=self.navigationItem.rightBarButtonItem;
            
            
            
            
        }
        else
        {
            
            self.navigationItem.rightBarButtonItem = nil;
            
        }
        
        
    }
    else {
        barButton=   self.navigationItem.rightBarButtonItem ;
        
        //barButton=self.navigationItem.rightBarButtonItem;
        
        barButton.title = @"登陆";
        
    }

    
}
-(void)viewWillAppear:(BOOL)animated {
    
   [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:158.0/255.0 green:26.0/255.0 blue:36.0/255.0 alpha:1.000]];
    quoteTag=NO;
    isInReader=true;
    
    UIBarButtonItem *barButton=self.navigationItem.rightBarButtonItem;
    
    /*if([self checkIfHasLogIn])   
    { 
 
        barButton.image = [UIImage imageNamed:@"reply.png"];
    }
    else {
 
        barButton.image = [UIImage imageNamed:@"login.png"];
        
    }*/
     //[self pressMenu:[btnArray objectAtIndex:0] More:NO];
    if(fid!=-1)
 
       [self setRightBarItemStatus];

    
}


//user defaults
-(bool)checkIfHasLogIn;
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; 
    
    
    NSFileManager* fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:[documentsDirectory stringByAppendingPathComponent:@"nowlogin.plist"] isDirectory:NULL]) 
        
    {
        
        NSDictionary *now = [NSKeyedUnarchiver unarchiveObjectWithFile:[documentsDirectory stringByAppendingPathComponent:@"nowlogin.plist"]];
        NSString *nowname  = [now objectForKey:@"username"];
        
        if(nowname==nil)
            return NO;
        else  
            
            return YES;
    }
    else {
        
        return NO;
        
    }
    
    
}



-(void)defaultSaveAppSetting_onlylouzhu:(bool)b;

{
	NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    [defaults setBool:b forKey:@"onlylouzhu"]; 
    
    
	[defaults synchronize];
    
}
-(void)defaultSaveAppSetting_forbiddisplaypic:(bool)b;

{
	NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    
    [defaults setBool:b forKey:@"forbiddisplaypic"];  
    
	[defaults synchronize];
    
}


-(bool)defaultLoadAppSetting_forbiddisplaypic;
{
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:@"forbiddisplaypic"];
    
    
    
}
-(bool)defaultLoadAppSetting_onlylouzhu;
{
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:@"onlylouzhu"];
    
    
    
}
//---------------end of user default
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"notifyToReloadPageNotification" object:nil];
//    self.Title = nil;
    [htmlWebView setDelegate:nil];
    [htmlWebView release];
     [collectionButton release];
    [writeView release];
    [removeView release];
    [textView release];
    [publishButton release];

    //[fid release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
 
-(void)viewWillDisappear:(BOOL)animated {
    
    for (ASIHTTPRequest *request in ASIHTTPRequest.sharedQueue.operations)
    {
        [request cancel];
        [request setDelegate:nil];
    } 
    if ([htmlWebView isLoading])
        [htmlWebView stopLoading];
    
  
}

- (void)viewDidDisappear:(BOOL)animated{

   


}


-(void)replyAccordingQuote:(NSNotification *)notification{
    
    NSURLRequest *request=[notification object];
    NSURL * URL=[request URL];
    DebugLog(@"URL---%@",URL);
    NSString * requestString=[URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    DebugLog(@"requestString---%@",requestString);
    if (requestString != nil) {
        
        
        NSRange range=[requestString rangeOfString:@"quote.php?"];
        NSString * subString=[requestString substringFromIndex:range.location+range.length];
        NSArray * arr=[subString componentsSeparatedByString:@"&"];
        DebugLog(@"arr--%@", arr);
        for (int i=0; i<[arr count]; i++) {
            
            if (i==0) {
                NSArray * arr0=[[arr objectAtIndex:i] componentsSeparatedByString: @"="];
                self.pid=[[arr0 objectAtIndex:1] intValue];
            }
            
            else if(i==1){
                NSArray * arr1=[[arr objectAtIndex:i] componentsSeparatedByString: @"="];
                self.ptid=[[arr1 objectAtIndex:1] intValue];
            }
            else if(i==2){
                
                NSArray * arr2=[[arr objectAtIndex:i] componentsSeparatedByString: @"="];
                self.authorQuote=[arr2 objectAtIndex:1] ;
            }
            else if(i==3){
                
                NSArray * arr3=[[arr objectAtIndex:i] componentsSeparatedByString: @"="];
                self.datelineQuote=[arr3 objectAtIndex:1] ;
            }
            else if(i==4){
                NSArray * arr4=[[arr objectAtIndex:i] componentsSeparatedByString: @"="];
                self.messageQuote=[arr4 objectAtIndex:1] ;
            }
            
        }
        
        UIButton * dummy =[[UIButton alloc]init];
        [self tapBarItemButton:dummy];
        [dummy release];
    }
    
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    
    
        [self setMyDelegate:self.tabBarController]; 
    
        [super viewDidLoad];
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    api_url = delegate.myDomainAndPathVeryNC;
    
 
 
    
    writeViewTag=NO;
    quoteImage_url=delegate.quoteImageURL;
    
    DebugLog(@"%d",self.tid);
    
    //beta2
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadPageNotification:) name:@"notifyToReloadPageNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(replyAccordingQuote:) name:@"QuoteReplyNotification" object:nil];
        
    
    
    NSLog(@"%@", delegate.isFirstResponder);
    
    
    int n=self.tid;
	
	[self.view setBackgroundColor:[UIColor colorWithRed:0.922 green:0.922 blue:0.922 alpha:1.000]];
	[self.navigationItem setTitle:@"帖子正文"];
	resultArray = [[NSMutableArray alloc] init];
	btnArray = [[NSMutableArray alloc] init];
	pageNum = 1;
    
      
	UIImageView *menuBack = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menuback.png"]];
	[[self view] addSubview:menuBack];
	[menuBack release];
	
	
	selectView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navi.png"]];
	[selectView setFrame:CGRectMake(11, 5, 100, 23)];
	[selectView.layer setMasksToBounds:YES];
	[selectView.layer setCornerRadius:4.0];
	[[self view] addSubview:selectView];
	[selectView release];
	 
	NSArray *btnTitleArray = [NSArray arrayWithObjects:@"默认", @"只看楼主", @"最新回复", nil];
   
	for (int i = 0; i < [btnTitleArray count]; i++) {	
		UIButton *menuBtn = [[UIButton alloc] initWithFrame:CGRectMake(11 + 100*i, 5, 100, 23)];
		[menuBtn setTitle:[btnTitleArray objectAtIndex:i] forState:UIControlStateNormal];
		[menuBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
		[menuBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
		[menuBtn setTag:kDefaultTag + i];
		[menuBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
		[menuBtn addTarget:self action:@selector(pressMenu:) forControlEvents:64];
		[[self view] addSubview:menuBtn];
		//[menuBtn release];
		[btnArray addObject:menuBtn];
		[menuBtn release];
	}
  
    
    /*
	CGSize  contentSize  = [self.Title sizeWithFont:[UIFont boldSystemFontOfSize:18] constrainedToSize:CGSizeMake(300, 1000) lineBreakMode:UILineBreakModeCharacterWrap];
    
 
	UILabel *titleLabel = [ViewTool addUILable:self.view x:7 y:39 x1:300 y1:contentSize.height fontSize:16 lableText:self.Title];
	[titleLabel setTextColor:[UIColor blackColor]];
	[titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
	[titleLabel setNumberOfLines:0];
	
	SSLineView *LineView = [[SSLineView alloc] initWithFrame:CGRectMake(0, contentSize.height + 44, 320, 2)];
	[self.view addSubview:LineView];
	[LineView release];
	

	tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, contentSize.height + 46, 320, 326 - contentSize.height) style:UITableViewStylePlain];
	[tableView setDelegate:self];
	[tableView setDataSource:self];
	[self.view addSubview:tableView];
	[tableView setSeparatorColor:[UIColor clearColor]];
	[tableView setBackgroundColor:[UIColor colorWithRed:0.922 green:0.922 blue:0.922 alpha:1.000]];
	[tableView release];
	
	 
	if (_refreshHeaderView == nil) {
		
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - tableView.bounds.size.height, self.view.frame.size.width, tableView.bounds.size.height)];
		view.delegate = self;
		[tableView addSubview:view];
		_refreshHeaderView = view;
		[view release];
		
	}
     */
     //(0, contentSize.height + 46, 320, 326 - contentSize.height)
  
    //beta2
    
    
    
//    UIWebView *temWebView=[[UIWebView alloc]initWithNibName:@"WebViewController" bundle:nil];
//    [temWebViewController.view setFrame:CGRectMake(0, 32, 320, 385)];
//    
//    temWebViewController.mWindow.controllerThatObserves=self;
//    self.htmlWebViewController=temWebViewController;
//    [htmlWebViewController.mHtmlViewer setDelegate:self];
//    [self.view addSubview :htmlWebViewController.view];
//
//    [temWebViewController release];
    
    UIWebView *temWebView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 32, 320, 350)];
    self.htmlWebView=temWebView;
    [self.view addSubview:self.htmlWebView];
    [htmlWebView setDelegate:self];
    [temWebView release];
    

    UIImageView * imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 372, 320, 44)];
    [imageView  setImage:[UIImage imageNamed:@"bg2.png"]];
    [self.view addSubview:imageView];
    
    
    UIButton * writeComment = [[UIButton alloc]initWithFrame:CGRectMake(10, 381, 152, 26)];
    [writeComment setBackgroundImage:[UIImage imageNamed:@"btn2.png"] forState:UIControlStateNormal];
    [writeComment addTarget:self action:@selector(writeCommentButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:writeComment];
    [writeComment release];
    
    
    
    UIButton * shareButton = [[UIButton alloc]initWithFrame:CGRectMake(232, 382, 19, 23)];
    [shareButton setBackgroundImage:[UIImage imageNamed:@"ico7.png"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(shareButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareButton];
    [shareButton release];
    
    
    collectionButton = [[UIButton alloc]initWithFrame:CGRectMake(281, 382, 24, 24)];
    if ([self isFavorite:self.tid]) {
        [collectionButton setImage:[UIImage imageNamed:@"ico10.png"] forState:UIControlStateNormal];
    }else{
        [collectionButton setImage:[UIImage imageNamed:@"ico8.png"] forState:UIControlStateNormal];
    }
    [collectionButton addTarget:self action:@selector(collectionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:collectionButton];
   
    
    
    [imageView release];


/*	
	NSDateFormatter *formater = [[NSDateFormatter alloc] init];
	[formater setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
	NSString *time = [formater stringFromDate:[NSDate date]];
	NSString *sql = [NSString stringWithFormat:@"REPLACE INTO RecentView VALUES(%d,'%@','%@')",self.tid,self.Title,time];
	[formater release];
	DebugLog(@"SQL : %@",sql);
//	[SqliteSet InsertRecentView:sql];
*/
 
    
    
    if([self defaultLoadAppSetting_onlylouzhu]){
        [self pressMenu:[btnArray objectAtIndex:1] More:NO];
	}
    else{ 
        [self pressMenu:[btnArray objectAtIndex:0] More:NO];
	}
    
    
    
    if(isclosed != 1){
    UIBarButtonItem *barButton=
    [[UIBarButtonItem alloc] initWithTitle:@"回帖"
                                     style:UIBarButtonItemStyleBordered
                                    target:self
                                    action:@selector(tapBarItemButton:)];
    
 
    
    self.navigationItem.rightBarButtonItem = barButton;
    [barButton release];//ooo
    }
    
    if(fid==-1)
    {
       // self.navigationItem.rightBarButtonItem=nil;
    }
    
    
    

  
   // [super viewDidLoad];
}


#pragma -mark button clicked




-(void)writeCommentButtonClicked:(id)sender{
    
    DebugLog(@"%d",self.fid);
    if (![self checkIfHasLogIn]) {
        
        //UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"您尚未登录" delegate:self cancelButtonTitle:@"好" otherButtonTitles: nil];
        //[alert show];
        //[alert release];
        MoreAccountViewController *moreaccount = [[MoreAccountViewController alloc] initWithNibName:@"MoreAccountViewController" bundle:nil];
        [self.navigationController pushViewController:moreaccount animated:YES];
        
    }else {
        if (![self checkIfHasRightToReply:fid]) {
            UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"您没有发帖权限" delegate:self cancelButtonTitle:@"好" otherButtonTitles: nil];
            [alert show];
            [alert release];

        }else {
            
            
            writeView=[[UIView alloc]initWithFrame:CGRectMake( 0.0f, 448.0f, 320.0f, 292.0f)];
            [writeView setBackgroundColor:[UIColor whiteColor]];
            [self.view addSubview:writeView];
    
    
            removeView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 157)];
            [removeView setBackgroundColor:[UIColor clearColor]];
            UITapGestureRecognizer * removeGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleRemoveComment:)];
            [removeView addGestureRecognizer:removeGesture];
            [self.view addSubview:removeView];
    
   
  
    
    
            UIImageView * imageBg=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
            [imageBg setImage:[UIImage imageNamed:@"navi_key.png"]];
            [writeView addSubview:imageBg];
            [imageBg release];
    
            textView=[[UITextView alloc]initWithFrame:CGRectMake(5, 8, 250, 28)];
            textView.font=[UIFont fontWithName:@"Helvetica" size:13];
            //    textView.keyboardAppearance=UIKeyboardAppearanceAlert; 
            textView.delegate = self;
            [writeView addSubview:textView];
            [textView becomeFirstResponder];


    
            publishButton=[[UIButton alloc]initWithFrame:CGRectMake(262, 8, 50, 28)];
            [publishButton setBackgroundImage:[UIImage imageNamed:@"but_key.png"] forState:UIControlStateNormal];
            [publishButton setTitle:@"发表" forState:UIControlStateNormal];
            publishButton.titleLabel.font=[UIFont fontWithName:@"Helvetica" size:13];
            publishButton.titleLabel.textColor=[UIColor blackColor];
            [publishButton addTarget:self action:@selector(publishButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
            [writeView addSubview:publishButton];
            
    
    
    
            [writeView setFrame:CGRectMake( 0.0f, 448.0f, 320.0f, 292.0f)]; //notice this is OFF screen!
   
    

     
    
            [UIView beginAnimations:@"animateTableView" context:nil];
            [UIView setAnimationDuration:0.25];
            [writeView setFrame:CGRectMake( 0.0f, 157.0f, 320.0f, 292.0f)]; //notice this is ON screen!
            [UIView commitAnimations];
        }
    }
        

}
- (void)textViewDidChangeSelection:(UITextView *)textView
{
    if ([[[UITextInputMode currentInputMode] primaryLanguage] isEqualToString:@"en-US"]) { 
        [writeView setFrame:CGRectMake( 0.0f, 157.0f, 320.0f, 292.0f)];
    } 
    else 
    { 
        if([[[UITextInputMode currentInputMode] performSelector:NSSelectorFromString(@"identifier")] isEqualToString:@"zh_Hans-HWR@sw=HWR"]){
            [writeView setFrame:CGRectMake( 0.0f, 157.0f, 320.0f, 292.0f)];
        }else{
            [writeView setFrame:CGRectMake( 0.0f, 122.0f, 320.0f, 292.0f)];
            [removeView setFrame:CGRectMake(0, 0, 320, 127)];
        }
    }
}

- (void)publishButtonClicked:(id)sender{
    
    NSString *s1=[self removeNewlinesAndTabulation:[textView text] appending:false];

    if([s1 length]<1 )
    {
        
            
            UIAlertView *alert=[[UIAlertView alloc]
                                initWithTitle:@"帖子内容不能为空"
                                
                                message:@""//\n\n\n\n"
                                delegate:self
                                cancelButtonTitle:@"知道了"
                                otherButtonTitles:nil,nil];
            
            [alert show];
            [alert release];
            
            
            return;

    }
    
    else {
        if([s1 length]>300 )
        {
            
            UIAlertView *alert=[[UIAlertView alloc]
                                initWithTitle:@"帖子内容太多"
                                
                                message:@""//\n\n\n\n"
                                delegate:self
                                cancelButtonTitle:@"知道了"
                                otherButtonTitles:nil,nil];
            
            
            //---------------------------------------------------------
            [alert show];
            [alert release];
            
            
            return;
        }
        
    }
    [publishButton  setEnabled:NO];
     NSURL *url;
     NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
     NSString *documentsDirectory = [paths objectAtIndex:0]; 
    
     url=[NSURL URLWithString:[NSString stringWithFormat: @"%@topicpost.php?type=reply&fid=%d&tid=%d",api_url,self.fid,self.tid ]];
        
     DebugLog(@"%@",url);
     ASIFormDataRequest  *request = [ASIFormDataRequest requestWithURL:url];
    

    NSDictionary *now = [NSKeyedUnarchiver unarchiveObjectWithFile:[documentsDirectory stringByAppendingPathComponent:@"nowlogin.plist"]];
    
    NSString* author  = [now objectForKey:@"username"];
    NSString* sessionid  = [now objectForKey:@"sessionid"];
    NSString* authorid  = [now objectForKey:@"uid"];
    
    
    //[request setPostValue:text forKey:@"subject"];
    [request setPostValue:author forKey:@"author"];
    [request setPostValue:authorid forKey:@"authorid"];  
    
    
    [request setPostValue:sessionid forKey:@"sid"];
    

        NSString * message=[NSString stringWithFormat:@"%@",[textView text]];
        [request setPostValue:message  forKey:@"message"];  

    
    [request setPostValue:@"i" forKey:@"status"];
    
    DebugLog(@"1-%@ 2-%@  3-%@ 4-%@ ",author,authorid,sessionid, [textView text]); 
    
    [request setTag:kpublishTag];
//    [request setCachePolicy:ASIAskServerIfModifiedCachePolicy | ASIFallbackToCacheIfLoadFailsCachePolicy]; 
//    [request setCachePolicy:ASIOnlyLoadIfNotCachedCachePolicy];

    [request setDelegate:self];
    [request setPersistentConnectionTimeoutSeconds:120];//_timeOut
    
    //   isSubmitSuccess=false;
    //myRequest= [request retain];
    [request startAsynchronous];


}

-(void)handleRemoveComment:(UITapGestureRecognizer *)gesture{
    
    
    
    [removeView removeFromSuperview];
    [writeView removeFromSuperview];
    DebugLog(@"handleRemoveComment");




}

-(void)shareButtonClicked:(id)sender{
    UIActionSheet *callphone = [[UIActionSheet alloc] initWithTitle:@"分享到" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"新浪微博",@"腾讯微博",nil];
    [callphone setTag:1];
    [callphone showInView:[UIApplication sharedApplication].keyWindow];
}
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0){
        NSString *typetitle = @"新浪微博分享";
        ShareViewController *share = [[ShareViewController alloc] initWithNibName:@"ShareViewController" bundle:nil];
        share.typetitle = typetitle;
        share.content = [NSString stringWithFormat:@"//%@ %@/forum.php?mod=viewthread&tid=%@",self.Title,_quoteImageVeryNC,[NSString stringWithFormat:@"%d",self.tid]];
        [self.navigationController pushViewController:share animated:YES];
    }
    if(buttonIndex == 1){
        NSString *typetitle = @"腾讯微博分享";
        ShareViewController *share = [[ShareViewController alloc] initWithNibName:@"ShareViewController" bundle:nil];
        share.typetitle = typetitle;
        share.content = [NSString stringWithFormat:@"//%@ %@/forum.php?mod=viewthread&tid=%@",self.Title,_quoteImageVeryNC,[NSString stringWithFormat:@"%d",self.tid]];
        [self.navigationController pushViewController:share animated:YES];
    }
}
-(bool)isFavorite:(NSInteger) fid;
{
    
    return [SqliteSet queryFavouriteAItem :[NSString stringWithFormat:@"%d",fid]]; ;
    
}


-(void)collectionButtonClicked:(id)sender{
    
    if(![self isFavorite:self.tid])
    {
        
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO Favourite VALUES(%d,'%@' )",self.tid,self.Title];
        
        DebugLog(@"SQL : %@",sql);
        [SqliteSet InsertFavouriteItem:sql];
        
        
        [collectionButton setImage:[UIImage imageNamed:@"ico10.png"] forState:UIControlStateNormal];
        
        
    }
    else
    {
        
        
        
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM Favourite where Fid=%d  ",self.tid ];
        
        DebugLog(@"SQL : %@",sql);
        [SqliteSet deleteFavouriteItem:sql];
        
        [collectionButton setImage:[UIImage imageNamed:@"ico8.png"] forState:UIControlStateNormal];
        
        
        
    }    
    
    [[NSNotificationCenter defaultCenter] postNotificationName: @"notifyToRefreshFavoriteNotification"
                                                        object: nil];
    
}
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
-(void)tapBarItemButton:(id)sender;

{
    if(fid==-1) return;
    if([self checkIfHasLogIn])
    {
        
        
        ReplyViewController	*temController=[[ReplyViewController	 alloc]initWithNibName:@"ReplyViewController" bundle:nil]  ;
        
        
        DebugLog(@"%d ---    %d",self.fid,self.tid);
        
        
        temController.isFromDetail=self.isFromDetail;
        temController.fid=self.fid ;
        temController.tid=self.tid ;
    
        
        temController.isQuote=NO;
        if (quoteTag) {
            temController.pid=self.pid;
            temController.ptid=self.ptid;
            temController.authorQuote=self.authorQuote;
            temController.messageQuote=self.messageQuote;
            temController.datelineQuote=self.datelineQuote;
            temController.isQuote=YES;
        }

        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *nowlogin_filePath = [documentsDirectory stringByAppendingPathComponent:@"nowlogin.plist"];
        NSDictionary *now = [NSKeyedUnarchiver unarchiveObjectWithFile:nowlogin_filePath];
        NSString *uid  = [now objectForKey:@"uid"];
        
        NSString *timestamp = [NSString stringWithFormat:@"%d%@",time(NULL),uid];
        temController.imgname = [NSString stringWithFormat:@"m%@.jpg",[self encode:timestamp]];
        
        [self.navigationController pushViewController:temController animated:YES];
        
        
        //[temc

        //[temController release];
        
    }
    
    else {
        
        
        MoreAccountViewController	*temController=[ [MoreAccountViewController alloc]initWithNibName:@"MoreAccountViewController" bundle:nil]  ;
        
        //vMoreAccountViewController= temController ;
        
        [self.navigationController  pushViewController:temController animated:YES];
        
        
        [temController release];
        
    }
    
    
    
}
-(void)reloadPageNotification:(NSNotification *)notification;
{
    
    //isChange = YES;
 
    [resultArray removeAllObjects];
    [tableView reloadData];
    [self pressMenu:[btnArray objectAtIndex:selectTag-200] More:NO];
    

}
- (void)pressPageBtn:(UIBarButtonItem *)sender {
	BOOL isChange = NO;
	switch (sender.tag) {
		case kHomePageTag:
		{
			if (pageNum != 1) {
				pageNum = 1;
				isChange = YES;
			}
			break;
		}
		case kPrevPageTag:
		{
			if (pageNum > 1) {
				pageNum--;
				isChange = YES;
			}
			break;
		}	
		case kNextPageTag:
		{
			if (pageNum < maxPage) {
				pageNum++;
				isChange = YES;
			}
			break;
		}	
        case kLastPageTag:
		{
			if (pageNum < maxPage) {
				pageNum=maxPage;
				isChange = YES;
			}
			break;
		}
		case kReloadPageTag:
		{
			isChange = YES;
			break;
		}	
		default:
			break;
	}
	if (isChange) {
		[resultArray removeAllObjects];
		[tableView reloadData];
		[self pressMenu:[btnArray objectAtIndex:selectTag-200] More:NO];
	}
}




- (void)pressMenu:(UIButton *)sender {
	if (sender.tag != selectTag) {
		pageNum = 1;
		[resultArray removeAllObjects];
		[tableView reloadData];
		[self pressMenu:sender More:NO];
	}
	
}


- (void)pressMenu:(UIButton *)sender More:(BOOL)isMore{
	for (UIButton *tmpBtn in btnArray) {
		[tmpBtn setSelected:NO];
	}
	[sender setSelected:YES];
	[UIView animateWithDuration:0.2f animations:^{
		CGRect frame = [sender frame];
		frame.origin.x -= 1;	 
		[selectView setFrame:frame];
	}];
	selectTag = sender.tag;
	NSString *requestURL;
	switch (selectTag) {
		case kDefaultTag:{
			requestURL = kDefaultRequestURLWithPage(self.tid, pageNum);
            _viewLou = YES;            
			break;
		}
		case kMasterTag:{
			requestURL = kMasterDetailRequestURLWithPage(self.tid, pageNum);
            _viewLou = NO;
			break;
		}
		case kLastCommentTag:{
			requestURL = kLastCommentRequestURLWithPage(self.tid, pageNum);           
            _viewLou = NO;
			break;
		}
		default:
			break;
	}
//	NSLog(@"requestURL%@",requestURL);
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:requestURL]];
	[request setTag:selectTag];
    
 
 
    
//	[request setDownloadCache:[ASIDownloadCache sharedCache]];
//	[request setCachePolicy:ASIAskServerIfModifiedCachePolicy | ASIFallbackToCacheIfLoadFailsCachePolicy]; 
	[request setDelegate:self];
                [request setPersistentConnectionTimeoutSeconds:30];//_timeOut
      //  myRequest=request;
  //  myRequest= [request retain];
    
    _isWorkingASI=true;
	[request startAsynchronous];
	
}

#pragma -mark TapDetectingWindowDelegate
- (void)userDidTapWebView:(id)tapPoint{
  
    if (writeViewTag) {
        writeViewTag=NO;
        [UIView beginAnimations:@"animateTableView" context:nil];
        [UIView setAnimationDuration:0.15];
        [writeView setFrame:CGRectMake( 0.0f, 448.0f, 320.0f, 292.0f)];         
        [UIView commitAnimations];
        
    }
    
    
    DebugLog(@"userDidTapWebView");
    
}


//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
//    DebugLog(@"shouldRecognizeSimultaneouslyWithGestureRecognizer");
//    return YES;
//}

#pragma mark - ASIHTTPDelegate

- (void)requestStarted:(ASIHTTPRequest *)request {
	//if (hashLoad[selectTag] == 0) {
	//	hashLoad[selectTag] = 1;
    
    
    /*
	if (_activityView ) {
        
		[_activityView removeFromSuperview];
		_activityView = nil;
		[_loadLabel removeFromSuperview];
		_loadLabel = nil;
 
	}
	_activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	_activityView.frame = CGRectMake(110.0f, 160.0f, 20.0f, 20.0f);
	[self.view addSubview:_activityView];
	[_activityView startAnimating];
	
	_loadLabel = [ViewTool addUILable:self.view x:135.0 y:158 x1:100 y1:20 fontSize:15 lableText:@"加载中..."];
	[_loadLabel setTextColor:[UIColor grayColor]];
	*/
    //beta2
    
    
    //取消加载
    
    
//    if (_activityView ) {
//        
//		[_activityView removeFromSuperview];
//		_activityView = nil;
//		[_loadLabel removeFromSuperview];
//		_loadLabel = nil;
// 
//        [_loadingView removeFromSuperview];
//        _loadingView=nil;
//        
//	}
    
    [myDelegate removeLoadingPatternIfNeed];
    
    //加载
//    _loadingView=[[UIImageView alloc] initWithFrame:CGRectMake(90.0f, 140.0f,140.0f, 70.0f)];
//    _loadingView.image=[UIImage imageNamed:@"duqu.png"];
//    _loadingView.alpha=0.8;
//    [self.view addSubview:_loadingView];
//    
//    _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
//	_activityView.frame = CGRectMake(110.0f, 162.0f, 20.0f, 20.0f);
//	[self.view addSubview:_activityView];
//	[_activityView startAnimating];
//	
//	//_loadLabel = [ViewTool addUILable:self.view x:140.0 y:158 x1:100 y1:20 fontSize:15 lableText:@"加载中..."];
//	_loadLabel = [ViewTool addUILable:self.view x:140.0 y:162 x1:100 y1:20 fontSize:15 lableText:@"加载中..."];
//	
//    [_loadLabel setTextColor:[UIColor grayColor]];
    
    [myDelegate drawLoadingPattern:@"加载中" isWithAnimation:NO];
 
}

//只看楼主和最新回复待修改
- (NSString *)returnLou:(int)i page:(int)p
{
    int a = i;
    int b = p;
    if (a == 0 && b == 1) {
        return @"楼主";
    } else if (a == 1 && b == 1) {
        return @"沙发";
    } else if (a == 2 && b == 1) {
        return @"板凳";
    } else if (a == 3 && b == 1) {
        return @"地板";
    } else if (b > 1) {
        return [NSString stringWithFormat:@"%d#", (a+1)+(20*(b-1))];
    } else {
        return [NSString stringWithFormat:@"%d#", (a+1)];
    }
}

-(unichar) getAChar:(NSString*)s position:(int)position;
{
    
    return [s characterAtIndex:position]; 
    
}

-(int) ungetNChar:(int)position n:(int)n;
{
    int v=position-n;
    return v; 
    
}


-(NSString*)getJSONSubJectAndMessageArray:(NSString *)s  aArray:(NSMutableArray *)aArray;
//return 0 is failure
{
    NSString *newString=@"";
    
    
    
    
    int mark=0;
    
    
    unsigned int i=1;
    NSString *temS=@"" ;//subject
    
    NSString *temS1=@"" ;//message
    bool needToExitLoop;
    needToExitLoop=false;
    
    NSInteger  hasNewObject;
    hasNewObject=0;
    TemMessageArrayObject *temObject ; 
    
    NSString *temtems;
    newString=@"{";
    while (  i<[s length]  ) {
        
        
        unichar c=[self getAChar:s position:i];
        ;
        
        // c='l';
        newString=[NSString stringWithFormat:@"%@%c",newString,c ];
        
        i=i+1;
        
        if(c=='"') 
        {
            
            
            
            
            unichar c=[self getAChar:s position:i];
            //newString=[NSString stringWithFormat:@"%@%c",newString,c ];
            
            i=i+1;
            if(c=='s') //subject
            {
                mark=12;
                
                
                
                
                temS =@"";
                temtems=@"s";
                needToExitLoop=false;
                while ( (i<=[s length])&&(!needToExitLoop)) {
                    
                    unichar c=[self getAChar:s position:i];
                    i=i+1;
                    
                    
                    if (c == 'u') 
                    {
                        
                        if(mark==12)
                        {
                            
                            temtems=@"su";
                            mark=13;
                            
                            
                            
                        } 
                        else
                        {
                            mark=0;
                            newString=[NSString stringWithFormat:@"%@%@%c",newString,temtems,c];
                            //DebugLog(@"%@",newString );
                            break;
                        }
                        
                    }        
                    
                    else if (c == 'b') 
                    {
                        
                        if(mark==13)
                        {
                            temtems=@"sub";
                            mark=14;
                            
                            
                        } 
                        else
                        {
                            mark=0;
                            //newString=[NSString stringWithFormat:@"%@su%c",newString,c];
                            newString=[NSString stringWithFormat:@"%@%@%c",newString,temtems,c];
                            //DebugLog(@"%@",newString );
                            
                            break;
                        }
                        
                    }        
                    else if (c== 'j') 
                    {
                        
                        if(mark==14)
                        {
                            temtems=@"subj";
                            mark=15;
                            
                            
                        } 
                        else
                        {
                            mark=0;
                            newString=[NSString stringWithFormat:@"%@%@%c",newString,temtems,c];
                            //DebugLog(@"%@",newString );
                            break;
                        }
                        
                    }        
                    
                    else if (c== 'e') 
                    {
                        
                        if(mark==15)
                        {
                            temtems=@"subje";
                            mark=16;
                            
                            
                            
                        } 
                        else
                        {
                            mark=0;
                            newString=[NSString stringWithFormat:@"%@%@%c",newString,temtems,c];
                            //DebugLog(@"%@",newString );
                            break;
                        }
                        
                    }        
                    
                    
                    else if (c== 'c') 
                    {
                        
                        if(mark==16)
                        {
                            temtems=@"subjec";
                            mark=17;
                            
                        } 
                        else
                        {
                            mark=0;
                            newString=[NSString stringWithFormat:@"%@%@%c",newString,temtems,c];
                            //DebugLog(@"%@",newString );
                            break;
                        }
                        
                    }        
                    
                    
                    else if (c == 't') 
                    {
                        
                        if(mark==17)
                        {
                            temtems=@"subject";
                            mark=18;
                            
                            
                        } 
                        else
                        {
                            mark=0;
                            newString=[NSString stringWithFormat:@"%@%@%c",newString,temtems,c];
                            //DebugLog(@"%@",newString );
                            break;
                        }
                        
                    }        
                    
                    else if (c== ':') 
                    {
                        
                        if(mark==19)
                        {
                            temtems=@"subject\":";
                            mark=20;
                            
                            
                        } 
                        else
                        {
                            mark=0;
                            newString=[NSString stringWithFormat:@"%@%@%c",newString,temtems,c];
                            //DebugLog(@"%@",newString );
                            break;
                        }
                        
                    }  
                    
                    
                    else if (c== '"') 
                    {
                        if(mark==18)
                        {
                            temtems=@"subject\"";
                            mark=19;
                            
                            
                            
                        } 
                        
                        else
                            
                            if(mark==20)
                            {
                                
                                
                                newString=[NSString stringWithFormat:@"%@subject\":\"",newString];
                                
                                
                                
                                ////NSLog(@"",newString);
                                temS=@"";
                                while ( (i<=[s length])&&(!needToExitLoop)) {
                                    
                                    unichar c1=[self getAChar:s position:i];
                                    i=i+1;
                                    
                                    
                                    
                                    
                                    if (c1 == '"') 
                                    {
                                        
                                        mark=30;
                                        
                                        
                                        
                                        
                                    }        
                                    
                                    else if (c1 == ',') 
                                    {
                                        
                                        if(mark==30)
                                        {
                                            
                                            
                                            
                                            
                                            newString=[NSString stringWithFormat:@"%@\",",newString ];
                                            
                                            
                                            
                                            
                                            hasNewObject=1;
                                            
                                            
                                            needToExitLoop=true;
                                            
                                            break;
                                            
                                            
                                        } 
                                        else
                                        {
                                            mark=0;
                                            temS=[NSString stringWithFormat:@"%@%c",temS ,c1 ];
                                            
                                            
                                        }
                                        
                                    }        
                                    else {
                                        mark=0;
                                        temS=[NSString stringWithFormat:@"%@%c",temS ,c1 ];
                                        
                                        
                                    }
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                }
                                
                                
                                
                            } 
                            else
                            {
                                mark=0;
                                
                                newString=[NSString stringWithFormat:@"%@%@%c",newString,temtems,c];
                                //DebugLog(@"%@",newString );
                                break;
                            }
                        
                    } 
                    else {
                        mark=0;
                        
                        newString=[NSString stringWithFormat:@"%@%@%c",newString,temtems,c];
                        //DebugLog(@"%@",newString );
                        break;
                    }
                    
                    // //NSLog(@"%@",temS  );
                    
                }//while
                
                //  //NSLog(@"%@",newString );
                
                
            }   //           if(c=='s') //subject
            
            
            else if(c=='m') //message
                
            {
                mark=12;
                
                
                //NSLog(@"!%@!",newString );
                
                
                temS1 =@"";
                
                
                needToExitLoop=false;
                temtems=@"m";
                while ( (i<=[s length])&&(!needToExitLoop)) {
                    
                    unichar c=[self getAChar:s position:i];
                    
                    
                    i=i+1;
                    
                    
                    if (c == 'e') 
                    {
                        
                        if(mark==12)
                        {
                            
                            temtems=@"me";
                            mark=13;
                            
                            
                            
                        } 
                        else if(mark==17)
                        {
                            temtems=@"message";
                            mark=18;
                            
                        } 
                        else
                        {
                            mark=0;
                            newString=[NSString stringWithFormat:@"%@%@%c",newString,temtems,c];
                            //DebugLog(@"%@",newString );
                            break;
                        }
                        
                    }        
                    
                    else if (c == 's') 
                    {
                        
                        if(mark==13)
                        {
                            temtems=@"mes";
                            mark=14;
                            
                            
                        } 
                        else 
                            if(mark==14)
                                
                            {
                                temtems=@"mess";
                                mark=15;
                                
                                
                            }
                            else
                            {
                                mark=0;
                                //newString=[NSString stringWithFormat:@"%@su%c",newString,c];
                                newString=[NSString stringWithFormat:@"%@%@%c",newString,temtems,c];
                                //DebugLog(@"%@",newString );
                                
                                break;
                            }
                        
                    }        
                    else if (c== 'a') 
                    {
                        
                        if(mark==15)
                        {
                            temtems=@"messa";
                            mark=16;
                            
                            
                        } 
                        else
                        {
                            mark=0;
                            newString=[NSString stringWithFormat:@"%@%@%c",newString,temtems,c];
                            //DebugLog(@"%@",newString );
                            break;
                        }
                        
                    }        
                    
                    else if (c== 'g') 
                    {
                        
                        if(mark==16)
                        {
                            temtems=@"messag";
                            mark=17;
                            
                            
                            
                        } 
                        else
                        {
                            mark=0;
                            newString=[NSString stringWithFormat:@"%@%@%c",newString,temtems,c];
                            //DebugLog(@"%@",newString );
                            break;
                        }
                        
                    }        
                    
                    
                    
                    
                    else if (c== ':') 
                    {
                        
                        if(mark==19)
                        {
                            temtems=@"message\":";
                            mark=20;
                            
                            
                        } 
                        else
                        {
                            mark=0;
                            newString=[NSString stringWithFormat:@"%@%@%c",newString,temtems,c];
                            //DebugLog(@"%@",newString );
                            break;
                        }
                        
                    }  
                    
                    
                    else if (c== '"') 
                    {
                        
                        
                        if(mark==18)
                        {
                            temtems=@"message\":";
                            mark=19;
                            
                            
                        } 
                        else 
                            
                            if(mark==20)
                            {
                                
                                
                                newString=[NSString stringWithFormat:@"%@message\":\"",newString];
                                
                                
                                
                                ////NSLog(@"",newString);
                                temS1=@"";
                                while ( (i<=[s length])&&(!needToExitLoop)) {
                                    
                                    unichar c1=[self getAChar:s position:i];
                                    i=i+1;
                                    
                                    
                                    
                                    
                                    if (c1 == '"') 
                                    {
                                        
                                        mark=30;
                                        
                                        
                                        
                                        
                                    }        
                                    
                                    else if (c1 == ',') 
                                    {
                                        
                                        if(mark==30)
                                        {
                                            
                                            
                                            newString=[NSString stringWithFormat:@"%@\",",newString ];
                                            
                                            
                                            
                                            hasNewObject=2;
                                            
                                            
                                            needToExitLoop=true;
                                            
                                            break;
                                            
                                            
                                        } 
                                        else
                                        {
                                            mark=0;
                                            temS1=[NSString stringWithFormat:@"%@%c",temS1 ,c1 ];
                                            
                                            
                                        }
                                        
                                    }        
                                    else {
                                        mark=0;
                                        temS1=[NSString stringWithFormat:@"%@%c",temS1 ,c1 ];
                                        
                                        
                                    }
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                }
                                
                                
                                
                            } 
                            else
                            {
                                mark=0;
                                
                                newString=[NSString stringWithFormat:@"%@%@%c",newString,temtems,c];
                                DebugLog(@"%@",newString );
                                break;
                            }
                        
                        
                    }
                    
                    else {
                        mark=0;
                        
                        newString=[NSString stringWithFormat:@"%@%@%c",newString,temtems,c];
                        //NSLog(@"%@",newString );
                        break;
                    }
                    
                    
                    // //NSLog(@"%@",temS  );
                    
                } 
                
                
                
                
            }   //           if(c=='s') //subject
            
            else {
                mark=0;
                newString=[NSString stringWithFormat:@"%@%c",newString,c];
                //DebugLog(@"%@",newString );
                
            }
        }
        
        
        //  //NSLog(@"one object finished: %@",newString);
        // //NSLog(@"#%@# %d %d",temS,i,[s length]  );
        if(hasNewObject==2)
        {
            
            
            hasNewObject=0;
            
            temObject=[[TemMessageArrayObject alloc] init];
            temObject.subject=temS;
            temObject.message=temS1;
            
            [aArray addObject:temObject];
            [temObject release];
            
            
            
        }
        
        
    }     //    while ( (i<[s length])&&(!needToExitLoop)) {   
    
    
    
    
    
    return  newString  ;
    
}


-(NSString*) unescapeUnicodeString:(NSString*)string
{
    // unescape quotes and backwards slash
    NSString* unescapedString = [string stringByReplacingOccurrencesOfString:@"\\\"" withString:@"\""];
    unescapedString = [unescapedString stringByReplacingOccurrencesOfString:@"\\\\" withString:@"\\"];
    //NSLog(@"%@",unescapedString);
    // tokenize based on unicode escape char
    NSMutableString* tokenizedString = [NSMutableString string];
    NSScanner* scanner = [NSScanner scannerWithString:unescapedString];
    while ([scanner isAtEnd] == NO)
    {
        // read up to the first unicode marker
        // if a string has been scanned, it's a token
        // and should be appended to the tokenized string
        NSString* token = @"";
        [scanner scanUpToString:@"\\u" intoString:&token];
        if (token != nil && token.length > 0)
        {
            [tokenizedString appendString:token];
            continue;
        }
        
        // skip two characters to get past the marker
        // check if the range of unicode characters is
        // beyond the end of the string (could be malformed)
        // and if it is, move the scanner to the end
        // and skip this token
        NSUInteger location = [scanner scanLocation];
        NSInteger extra = scanner.string.length - location - 4 - 2;
        if (extra < 0)
        {
            NSRange range = {location, -extra};
            [tokenizedString appendString:[scanner.string substringWithRange:range]];
            [scanner setScanLocation:location - extra];
            continue;
        }
        
        // move the location pas the unicode marker
        // then read in the next 4 characters
        location += 2;
        NSRange range = {location, 4};
        token = [scanner.string substringWithRange:range];
        unichar codeValue = (unichar) strtol([token UTF8String], NULL, 16);
        [tokenizedString appendString:[NSString stringWithFormat:@"%C", codeValue]];
        
        // move the scanner past the 4 characters
        // then keep scanning
        location += 4;
        [scanner setScanLocation:location];
    };
    
    
    
    return  tokenizedString  ;
}


- (void)requestFinished:(ASIHTTPRequest *)request
{
    
    if(request.tag==kpublishTag){
        [publishButton setEnabled:YES];
        
        //取消加载
//        if (_activityView ) {
//            [_activityView removeFromSuperview];
//            _activityView = nil;
//            [_loadLabel removeFromSuperview];
//            _loadLabel = nil;
//            [_loadingView removeFromSuperview];
//            _loadLabel =nil;
//            [_loadingView removeFromSuperview];
//            _loadingView=nil;
//        }
        
        [myDelegate removeLoadingPatternIfNeed];
        
        NSString *requestString = [[request responseString] stringByConvertingHTMLToPlainText];
        
        
        
        
        
        
        //---------------------------------------------------------
        
        NSArray *tmpArray = [[requestString JSONValue] valueForKey:@"datas"];
        
        if([tmpArray count]>0)
        {
        
            NSString *s = [[tmpArray objectAtIndex:0] valueForKey:@"result"];
            if([s isEqualToString:@"reply succ"])
            {
                UIAlertView *alert=[[UIAlertView alloc]
                                    initWithTitle:@"回帖成功"
                                    
                                    message:@""//\n\n\n\n"
                                    delegate:self
                                    cancelButtonTitle:@"知道了"
                                    otherButtonTitles:nil,nil];
                
                
                //---------------------------------------------------------
                [alert show];
                [alert release];
                //  isSubmitSuccess=true;
                
                [removeView removeFromSuperview];
                [writeView removeFromSuperview];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"notifyToReloadPageNotification" object:nil];
                
                
                
                //fix bug
                if(isFromDetail)
                {
                    [[NSNotificationCenter defaultCenter] postNotificationName: @"notifyToReloadDetailNotification"
                                                                        object: nil];
                }
            }
            else  if([s isEqualToString:@"reply failed"])
            {   
                UIAlertView *alert=[[UIAlertView alloc]
                                    initWithTitle:@"回帖失败"
                                    
                                    message:@""//\n\n\n\n"
                                    delegate:self
                                    cancelButtonTitle:@"知道了"
                                    otherButtonTitles:nil,nil];
                
                
                //---------------------------------------------------------
                [alert show];
                [alert release];
                
                //[self.navigationController popViewControllerAnimated:true];
                
            }
            else  if([s isEqualToString:@"dangerous word"])
            {   
                UIAlertView *alert=[[UIAlertView alloc]
                                    initWithTitle:@"请不要包含敏感字符"
                                    
                                    message:@""//\n\n\n\n"
                                    delegate:self
                                    cancelButtonTitle:@"知道了"
                                    otherButtonTitles:nil,nil];
                
                
                //---------------------------------------------------------
                [alert show];
                [alert release];
                
                //[self.navigationController popViewControllerAnimated:true];
                
            }
            else  if([s isEqualToString:@"forbidden_time"])
            {   
                UIAlertView *alert=[[UIAlertView alloc]
                                    initWithTitle:@"当前时间段不允许发帖"
                                    
                                    message:@""//\n\n\n\n"
                                    delegate:self
                                    cancelButtonTitle:@"知道了"
                                    otherButtonTitles:nil,nil];
                
                
                //---------------------------------------------------------
                [alert show];
                [alert release];
                
                //[self.navigationController popViewControllerAnimated:true];
                
            }
            else       {    
                
                UIAlertView *alert=[[UIAlertView alloc]
                                    initWithTitle:@"回帖失败"
                                    
                                    message:@""//\n\n\n\n"
                                    delegate:self
                                    cancelButtonTitle:@"知道了"
                                    otherButtonTitles:nil,nil];
                
                
                //---------------------------------------------------------
                [alert show];
                [alert release];
                
                
                //[self.navigationController popViewControllerAnimated:true];
                
                
                
            }
            
            
        
        }
        
        
        
    
    
    }
    else {

    //    NSLog(@"%@", [request responseString]);
    
    //    return;
    
    
    NSMutableArray *temArray =[[NSMutableArray alloc] init];
 
    
    NSString *tems=[request responseString];//[self JSONString:[request responseString]];
    NSString *formatJsonString =[self getJSONSubJectAndMessageArray:tems  aArray:temArray];
 
    [resultArray removeAllObjects];
    
    
    /*
     
     formatJsonString = [formatJsonString stringByReplacingOccurrencesOfString: @"&quot;"withString: @""];  
     
     formatJsonString = [formatJsonString stringByReplacingOccurrencesOfString: @""withString: @""];      
     */
    
    
    
    
    NSString *requestString =formatJsonString;
    
    
    
    //[formatJsonString stringByConvertingHTMLToPlainText];
    
    
    //DebugLog(@"%@", requestString);
    bool isNeedTosetRightBarItemStatus;
    if (fid<=0) isNeedTosetRightBarItemStatus=true;
    else isNeedTosetRightBarItemStatus=false;
    
	maxPage = ceil([[[requestString JSONValue] valueForKey:@"count"] doubleValue] / 20.0);
	if (maxPage == 0) {
		maxPage = 1;
	}
    
    
    
	[pageNumLabel setText:[NSString stringWithFormat:@"%d/%d",pageNum,maxPage]];
    
    
    htmlString = [NSString stringWithFormat:@"<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\"><html xmlns=\"http://www.w3.org/1999/xhtml\"><head><meta name=\"format-detection\" content=\"telephone=no\"><style type=\"text/css\">body {background-color:f7f7f7; padding: 0; margin:0; font:16px / 1.5 \"Lucida Grande\",\"Lucida Sans Unicode\",Helvetica,Arial,Verdana,sans-serif;} img { border: 0;}table{border-collapse:collapse;border-spacing:0}.app{ width:300px; padding:4px;}.app1{ width:61px;}.app1 img{ width:48px; height:48px;}.app1_h1{color: #888; font-size: 12px;}.app1_h1 span{ color:#1D5796; display:block; font-size: 16px; line-height: 24px;}.app_con{ padding:4px 0;}.zoom{ padding:4px 0;}.app_con3{border-bottom:1px solid #F1F1F1;}.app1 img{border:1px solid #888; padding:2px;}.yinyong{ background:#F0F5FB; color:#1D5796; padding:4px;}.yinyong font{ background:url(/static/image/common/icon_quote_s.gif) no-repeat; padding-left: 20px; font-size: 12px; color: #888888;}.yinyong span{ background:url(/static/image/common/icon_quote_e.gif) no-repeat right; padding-right: 20px;}.app_tit{ background:#FBFBFB; border-bottom:1px solid #AAADB0; font-size:18px; font-weight:bold; padding:5px;}</style></head><body onload=\"myloader();\">"];
        
        //2012.6.6 第二版比第一版多的css
        /*
         
.app_tit{ background:#FBFBFB; border-bottom:1px solid #AAADB0; font-size:18px; font-weight:bold; padding:5px;         
         
         */
        
    
    NSArray *tmpArray = [[requestString JSONValue] valueForKey:@"datas"];
    
    // NSLog(@"%d +++ %d",[tmpArray count], [temArray count]);
    
    
    if(([tmpArray count]!=0) && ([temArray count]!=0)) //robust
    {    
        
        self.fid= [[[tmpArray objectAtIndex:0] valueForKey:@"fid"] intValue];
        
        
        for (int i = 0 ; i < [tmpArray count]; i++)
        { 
            
            //            NSLog(@"%@", [temArray objectAtIndex:i]);
            
            TemMessageArrayObject *a=[temArray objectAtIndex:i];
            
            
            NSString *s;
            s=a.subject  ;
            
            
            //NSLog(@"%@",s);
            //  s=[self unescapeUnicodeString:s]; 
            
            //NSLog(@"%@",s);
            
            //  s= [s stringByReplacingOccurrencesOfString: @"\n" withString: @"\\n" ]; 
            
            [[tmpArray objectAtIndex:i] setValue:s  forKey:@"subject"];
            
            
            NSString *s1;
            // s1=[a.message   stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ;
            
            
            
            s1= a.message ;        
            
            //            NSLog(@"%@",s1);
            
            
            
            
            // will cause trouble if you have "abc\\\\uvw"
            NSString* esc1 = [s1 stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
            NSString* esc2 = [esc1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
            NSString* quoted = [[@"\"" stringByAppendingString:esc2] stringByAppendingString:@"\""];
            NSData* data = [quoted dataUsingEncoding:NSUTF8StringEncoding];
            NSString* unesc = [NSPropertyListSerialization propertyListFromData:data
                                                               mutabilityOption:NSPropertyListImmutable format:NULL
                                                               errorDescription:NULL];
            
            
            [[tmpArray objectAtIndex:i] setValue:unesc forKey:@"message"];
            
            
        }
        
        
        
        
        
        htmlString = [NSString stringWithFormat:@"%@<div class=\"app\"><table border=0 width=\"100%%\">", htmlString]; 
        
        htmlString = [NSString stringWithFormat:@"%@<tr><td class=\"app_tit\" colspan=\"3\">%@</td></tr>", htmlString, self.Title]; 
        
        
        
        
        //---------------------------------------------------------------
        
        NSString *strLou = [[NSString alloc] init];
        for (int i = 0 ; i < [tmpArray count]; i++)
        {   
            if (_viewLou) {
                strLou = [self returnLou:i page:pageNum];            
            }
            
            htmlString = [NSString stringWithFormat:@"%@<tr><td style=\"padding-top:8px;\" class=\"app1\"><img src=\"%@\"></td> <td class=\"app1_h1\"> <span>%@</span>发布日期: %@</td><td align=\"right\">%@</td></tr>", htmlString,[[tmpArray objectAtIndex:i] valueForKey:@"avatar_url"],[[tmpArray objectAtIndex:i] valueForKey:@"author"],[self timeStampeToNSDateString:[[tmpArray objectAtIndex:i] valueForKey:@"dateline"]], strLou]; 
            
            NSString * originString=[[tmpArray objectAtIndex:i] valueForKey:@"message"];
            //DebugLog(@"%@",originString);
            
            if ([originString hasPrefix:@"[quote][size=2][color=#999999]"]){
                //DebugLog(@"originString---%@",originString);
                NSString * originStringWho=[self formatMessageAndAuthor:[[tmpArray objectAtIndex:i] valueForKey:@"message"] ]; 
                
                htmlString=[NSString stringWithFormat:@"%@<tr><td colspan=\"3\" class=\"app_con\"></td></tr><tr><td colspan=\"3\" class=\"app_con yinyong\"><img src= \"%@/static/image/common/icon_quote_s.gif\"></img><font>&nbsp %@ </font><br>%@  &nbsp <img src= \"%@/static/image/common/icon_quote_e.gif\"></img><span></span></td></tr><tr><td colspan=\"3\" class=\"app_con\"></td></tr>",htmlString,quoteImage_url,originStringWho,[self formatQuoteFromURL:originString],quoteImage_url];
                
                
            }
            
            //DebugLog(@"%@",htmlString);
            
            NSString *messageString = [self formatContent:[self praseString:[[tmpArray objectAtIndex:i] valueForKey:@"message"]]];
            
            //修改流程后的来自这样表示
            NSString *statusFrom = [[tmpArray objectAtIndex:i] valueForKey:@"status"];
            if (statusFrom.length > 5) {
                messageString = [NSString stringWithFormat:@"%@<br /><br /><font size=\"2\" color=\"#888888\">%@</font>", messageString, statusFrom];
            }
            
            
            NSString *quoteString = [self formatQuote:[[tmpArray objectAtIndex:i] valueForKey:@"message"]];  
            
            //DebugLog(@"aaaa=====%@", quoteString);                 
            
            htmlString = [NSString stringWithFormat:@"%@<tr><td colspan=\"3\" class=\"app_con\">%@</td></tr>", htmlString, messageString]; 
            
            
            NSString *attachmentString = [[tmpArray objectAtIndex:i] valueForKey:@"attachment"];
            
            //DebugLog(@"=%@=", attachmentString);
            
            if (![attachmentString isKindOfClass:[NSNull class]]&&!(attachmentString ==nil) &&!(attachmentString ==NULL))
            {
                
                if([self checkIfIsWifi])
                {
                    
                    if ( ([attachmentString length]>5)  ) {
                        NSArray *arr = [attachmentString componentsSeparatedByString:@","];  
                        for(NSString* str in arr) htmlString = [NSString stringWithFormat:@"%@<tr><td colspan=\"3\" class=\"app_con\"><font color=blue>附件图片</font><br><img width=\"200\" src=\"%@\" /></td></tr>", htmlString, str];         
                    }
                    
                }
                else {
                    if ( ([attachmentString length]>5) && ![self defaultLoadAppSetting_forbiddisplaypic] ) {
                        
                        NSArray *arr = [attachmentString componentsSeparatedByString:@","];  
                        for(NSString* str in arr) htmlString = [NSString stringWithFormat:@"%@<tr><td colspan=\"3\" class=\"app_con\"><font color=blue>附件图片</font><br><img width=\"200\" src=\"%@\" /></td></tr>", htmlString, str];         
                    }
                    
                }
                
            }
            
            if([self checkIfHasLogIn])   {
                DebugLog(@"%d", fid);
                
                if ([self checkIfHasRightToReply:fid]) {
                    if (selectTag==kDefaultTag||selectTag==kMasterTag) {
                        
                        
                        if (i!=0) {  
                            
                            
                            htmlString = [NSString stringWithFormat:@"%@<tr class=\"app_con3\"><td align=\"right\" style=\"padding-top:3px\" colspan=\"3\"><a href=\"quote.php?pid=%d&ptid=%d&author=%@&dateline=%@&message=%@\">引用回复</a></td></tr>", htmlString, [[tmpArray objectAtIndex:i] valueForKey:@"pid"], [[tmpArray objectAtIndex:i] valueForKey:@"tid"], [[tmpArray objectAtIndex:i] valueForKey:@"author"], [[tmpArray objectAtIndex:i] valueForKey:@"dateline"], quoteString];
                        }
                    }
                    else if(selectTag==kLastCommentTag){
                        
                        if (i!=[tmpArray count]-1) {
                            htmlString = [NSString stringWithFormat:@"%@<tr class=\"app_con3\"><td align=\"right\" style=\"padding-top:3px\" colspan=\"3\"><a href=\"quote.php?pid=%d&ptid=%d&author=%@&dateline=%@&message=%@\">引用回复</a></td></tr>", htmlString, [[tmpArray objectAtIndex:i] valueForKey:@"pid"], [[tmpArray objectAtIndex:i] valueForKey:@"tid"], [[tmpArray objectAtIndex:i] valueForKey:@"author"], [[tmpArray objectAtIndex:i] valueForKey:@"dateline"], quoteString];
                            
                        }
                        
                        
                        
                    }
                    
                    
                    
                }
            }
            
            
            
            //DebugLog(@"%@",htmlString);
            
            
            
            htmlString = [NSString stringWithFormat:@"%@<tr class=\"app_con3\"><td style=\"padding-top:3px\" colspan=\"3\"></td></tr>", htmlString];
            
            
            
        }
        
        
        //beta2
        
        
        
        
    }
    else //robust
    {
        NSString *s = [[requestString JSONValue] valueForKey:@"code"];
        
        if ([s isEqualToString:@"500"]) {
            htmlString = [NSString stringWithFormat:@"抱歉，指定的主题不存在或已被删除或正在被审核", htmlString];
        }
        
        else  
            htmlString = [NSString stringWithFormat:@"帖子内容有非法字符或结构不正确", htmlString];
        
        
    }        
    
    
    
    
    
    
    
    [temArray release];
    
    
    htmlString=[NSString stringWithFormat:@"%@</table></div>", htmlString]; 
    htmlString=[NSString stringWithFormat:@"%@</body></html>",htmlString];
    
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"<br /><br /><br /><br /><br />" withString:@""];    
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"<br /><br /><br /><br />" withString:@""];    
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"<br /><br /><br />" withString:@""];   
    
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"<br /> <br /> <br /> <br /> <br />" withString:@""];    
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"<br /> <br /> <br /> <br />" withString:@""];        
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"<br /> <br /> <br />" withString:@""];  
    
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"<br />　　<br />　　<br />　　<br />　　<br />" withString:@""];    
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"<br />　　<br />　　<br />　　<br />" withString:@""];    
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"<br />　　<br />　　<br />" withString:@""];              
    
    
   //NSLog(@"%@", htmlString);
//    quick answer
    /*
    htmlString=[NSString stringWithFormat:@"%@function myloader() {document.location = \"myscheme:mycommand?myarguments\"  document.addEventListener( 'touchcancel' , touch_cancel , false );  document.addEventListener( 'touchstart' , touch_start , false );    document.addEventListener( 'touchmove' , touch_move , false );      document.addEventListener( 'touchend' , touch_end , false );};",htmlString];
     */
    
    
    
    [self.htmlWebView loadHTMLString:htmlString baseURL:nil];
    
    if(isNeedTosetRightBarItemStatus) [self setRightBarItemStatus];
    
    //取消加载
        
//    if (_activityView ) {
//		[_activityView removeFromSuperview];
//		_activityView = nil;
//		[_loadLabel removeFromSuperview];
//		_loadLabel = nil;
//        [_loadingView removeFromSuperview];
//        _loadLabel =nil;
//	}
        
        [myDelegate removeLoadingPatternIfNeed];
    
    } 
    
    	
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    _isWorkingASI=false;
    
    //取消加载
    
//	if (_activityView ) {
//		[_activityView stopAnimating];
//		[_activityView removeFromSuperview];
//		_activityView = nil;
//		[_loadLabel removeFromSuperview];
//		_loadLabel = nil;
//        
//        [_loadingView removeFromSuperview];
//        _loadingView=nil;
//	}
    
    [myDelegate removeLoadingPatternIfNeed];
 
        UIAlertView *alert;
        NSError *error = [request error];
        if (error)
            alert = [[UIAlertView alloc] initWithTitle:@"链接错误" 
                                               message:@"暂时不能连接服务器" 
                                              delegate:self cancelButtonTitle:@"知道了" 
                                     otherButtonTitles:nil];
        [alert show];
    
}

- (NSString *)timeStampeToNSDateString:(NSString *)timeStame {
	NSDate *tranData = [NSDate dateWithTimeIntervalSince1970:[timeStame doubleValue]];
	return [tranData formatRelativeTime];
}

-(NSString *)formatMessageAndAuthor:(NSString *)string
{
    
    
    NSRange range1=[string rangeOfString:@"[quote][size=2][color=#999999]"];
    NSString * subString1=[string substringFromIndex:range1.location+range1.length];
    NSRange range2=[subString1 rangeOfString:@"[/color] [url=forum.php?mod=redirect&goto=findpost&"];
    NSString * aimString1=[subString1 substringToIndex:range2.location];
    DebugLog(@"----%@",aimString1);
    
    
    return aimString1;
    
    
    
    
    
    
}

- (NSString *)formatQuoteFromURL:(NSString *)string{
    DebugLog(@"%@",string);
    NSScanner *theScanner;
    NSString *text = nil;
    theScanner = [NSScanner scannerWithString:string];
    
    
    
    while ([theScanner isAtEnd] == NO) {
        [theScanner scanUpToString:@"[size=2]" intoString:NULL];
        [theScanner scanUpToString:@"[/size]" intoString:&text];
        string = [string stringByReplacingOccurrencesOfString:[ NSString stringWithFormat:@"%@[/size]", text] withString:@""];
        
    }
    DebugLog(@"theScanner----%@",string);
    
    
    theScanner = [NSScanner scannerWithString:string];
    while ([theScanner isAtEnd] == NO) {
        [theScanner scanUpToString:@"[quote]" intoString:NULL];
        [theScanner scanUpToString:@"[/quote]" intoString:&text];
        
        
    }
    DebugLog(@"%@",text);
    string=text;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(\\[(.*?)\\]|\\[/(.*?)\\])" options:0 error:nil];
    string = [regex stringByReplacingMatchesInString:string options:0 range:NSMakeRange(0, string.length) withTemplate:@""];   
    
    
    DebugLog(@"%@",string);
    return string;
    
    
}


- (NSString *)formatQuote:(NSString *)string
{
	NSScanner *theScanner;
    NSString *text = nil;
    
	theScanner = [NSScanner scannerWithString:string];
    while ([theScanner isAtEnd] == NO) {
        [theScanner scanUpToString:@"[img" intoString:NULL];
        [theScanner scanUpToString:@"[/img]" intoString:&text];
        string = [string stringByReplacingOccurrencesOfString:[ NSString stringWithFormat:@"%@[/img]", text] withString:@""];
    }       
    
	theScanner = [NSScanner scannerWithString:string];
    while ([theScanner isAtEnd] == NO) {
        [theScanner scanUpToString:@"[ncsmiley]" intoString:NULL];
        [theScanner scanUpToString:@"[/ncsmiley]" intoString:&text];
        string = [string stringByReplacingOccurrencesOfString:[ NSString stringWithFormat:@"%@[/ncsmiley]", text] withString:@""];
    }      
    
	theScanner = [NSScanner scannerWithString:string];
    while ([theScanner isAtEnd] == NO) {
        [theScanner scanUpToString:@"[attach]" intoString:NULL];
        [theScanner scanUpToString:@"[/attach]" intoString:&text];
        string = [string stringByReplacingOccurrencesOfString:[ NSString stringWithFormat:@"%@[/attach]", text] withString:@""];
    }       
    
    //过滤[quote]
	theScanner = [NSScanner scannerWithString:string];
    while ([theScanner isAtEnd] == NO) {
        [theScanner scanUpToString:@"[quote]" intoString:NULL];
        [theScanner scanUpToString:@"[/quote]" intoString:&text];
        string = [string stringByReplacingOccurrencesOfString:[ NSString stringWithFormat:@"%@[/quote]", text] withString:@""];
    }  
    
    //过滤[code]
	theScanner = [NSScanner scannerWithString:string];
    while ([theScanner isAtEnd] == NO) {
        [theScanner scanUpToString:@"[code]" intoString:NULL];
        [theScanner scanUpToString:@"[/code]" intoString:&text];
        string = [string stringByReplacingOccurrencesOfString:[ NSString stringWithFormat:@"%@[/code]", text] withString:@""];
    }       
    
    //过滤[code]
	theScanner = [NSScanner scannerWithString:string];
    while ([theScanner isAtEnd] == NO) {
        [theScanner scanUpToString:@"[indent]" intoString:NULL];
        [theScanner scanUpToString:@"[/indent]" intoString:&text];
        string = [string stringByReplacingOccurrencesOfString:[ NSString stringWithFormat:@"%@[/indent]", text] withString:@""];
    }         
    
    //处理常用标签
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(\\[(.*?)\\]|\\[/(.*?)\\])" options:0 error:nil];
    string = [regex stringByReplacingMatchesInString:string options:0 range:NSMakeRange(0, string.length) withTemplate:@""];  
    
    //修改流程，字符串中不会再出现以下2个字符
    //    string = [string stringByReplacingOccurrencesOfString:@"来自iPhone客户端" withString:@""];
    //    string = [string stringByReplacingOccurrencesOfString:@"来自Android客户端" withString:@""];
    
	theScanner = [NSScanner scannerWithString:string];
    while ([theScanner isAtEnd] == NO) {
        [theScanner scanUpToString:@"本帖最后由" intoString:NULL];
        [theScanner scanUpToString:@"编辑" intoString:&text];
        string = [string stringByReplacingOccurrencesOfString:[ NSString stringWithFormat:@"%@编辑", text] withString:@""];
    }      
    
    //    string = [string stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
    //    string = [string stringByReplacingOccurrencesOfString:@"<BR>" withString:@"\n"];
    //    string = [string stringByReplacingOccurrencesOfString:@"<BR />" withString:@"\n"];
    //    string = [string stringByReplacingOccurrencesOfString:@"<br />" withString:@"\n"];    
    
    //48个字
    
    
    
    if (string.length > 48) {
        return [string substringToIndex:48];
    } else {
        return string;
    }
    
    
    
    
}

-(bool) checkIfIsWifi;
{
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
	
	NetworkStatus remoteHostStatus = [reachability currentReachabilityStatus];
	
    if (remoteHostStatus !=ReachableViaWiFi) {
        
		return FALSE;
    }  else {
        return TRUE;
    }
}

-(NSString *)JSONString:(NSString *)aString {
	NSMutableString *s = [NSMutableString stringWithString:aString];
	[s replaceOccurrencesOfString:@"\"" withString:@"\\\"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
	[s replaceOccurrencesOfString:@"/" withString:@"\\/" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
	[s replaceOccurrencesOfString:@"\n" withString:@"\\n" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
	[s replaceOccurrencesOfString:@"\b" withString:@"\\b" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
	[s replaceOccurrencesOfString:@"\f" withString:@"\\f" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
	[s replaceOccurrencesOfString:@"\r" withString:@"\\r" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
	[s replaceOccurrencesOfString:@"\t" withString:@"\\t" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
	return [NSString stringWithString:s];
}

-(NSString *)praseString:(NSString *)aString {
	NSMutableString *s = [NSMutableString stringWithString:aString];
	[s replaceOccurrencesOfString:@"\\\"" withString:@"\"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
	[s replaceOccurrencesOfString:@"\\/" withString:@"/" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
	[s replaceOccurrencesOfString:@"\\n" withString:@"\n" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
	[s replaceOccurrencesOfString:@"\\b" withString:@"\b" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
	[s replaceOccurrencesOfString:@"\\f" withString:@"\f" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
	[s replaceOccurrencesOfString:@"\\r" withString:@"\r" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
	[s replaceOccurrencesOfString:@"\\t" withString:@"\t" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
	return [NSString stringWithString:s];
}




//这个点还需要再分解

- (NSString *)formatContent:(NSString *)string
{
	NSScanner *theScanner;
    NSString *text = nil;
    //    string = [string stringByReplacingOccurrencesOfString:@"\n\n\n\n\n\n\n" withString:@"\n\n\n\n\n"];    
    //    string = [string stringByReplacingOccurrencesOfString:@"\n\n\n\n\n\n" withString:@"\n\n\n\n\n"];    
    //    string = [string stringByReplacingOccurrencesOfString:@"\n\n\n\n\n" withString:@"\n\n\n\n"];
    //    string = [string stringByReplacingOccurrencesOfString:@"\n\n\n\n" withString:@"\n\n\n"];    
    //    string = [string stringByReplacingOccurrencesOfString:@"\n\n\n" withString:@"\n\n"];        
    
    //    DebugLog(@"%@", string);
    
    //处理BBCode
    
    //过滤[attach]
	theScanner = [NSScanner scannerWithString:string];
    while ([theScanner isAtEnd] == NO) {
        [theScanner scanUpToString:@"[attach]" intoString:NULL];
        [theScanner scanUpToString:@"[/attach]\n\n" intoString:&text];
        string = [string stringByReplacingOccurrencesOfString:[ NSString stringWithFormat:@"%@[/attach]\n\n", text] withString:@""];
    }   
    
	theScanner = [NSScanner scannerWithString:string];
    while ([theScanner isAtEnd] == NO) {
        [theScanner scanUpToString:@"[attach]" intoString:NULL];
        [theScanner scanUpToString:@"[/attach]\n" intoString:&text];
        string = [string stringByReplacingOccurrencesOfString:[ NSString stringWithFormat:@"%@[/attach]\n", text] withString:@""];
    }       
	theScanner = [NSScanner scannerWithString:string];
    while ([theScanner isAtEnd] == NO) {
        [theScanner scanUpToString:@"[attach]" intoString:NULL];
        [theScanner scanUpToString:@"[/attach]" intoString:&text];
        string = [string stringByReplacingOccurrencesOfString:[ NSString stringWithFormat:@"%@[/attach]", text] withString:@""];
    }      
    
    //过滤[ncsmiley] 暂时先都过滤了
    /*
     theScanner = [NSScanner scannerWithString:string];
     while ([theScanner isAtEnd] == NO) {
     [theScanner scanUpToString:@"[ncsmiley]" intoString:NULL];
     [theScanner scanUpToString:@"[/ncsmiley]" intoString:&text];
     string = [string stringByReplacingOccurrencesOfString:[ NSString stringWithFormat:@"%@[/ncsmiley]", text] withString:@""];
     } 
     */
    string = [string stringByReplacingOccurrencesOfString:@"[ncsmiley]" withString:@"<img src=\""];
    string = [string stringByReplacingOccurrencesOfString:@"[/ncsmiley]" withString:@"\" />"];   
    
    //替换干扰字符
    NSRegularExpression *regex2 = [NSRegularExpression regularExpressionWithPattern:@"(\\[img(.*?)\\])" options:0 error:nil];
    NSString *template = @"[img]";
    string = [regex2 stringByReplacingMatchesInString:string options:0 range:NSMakeRange(0, string.length) withTemplate:template];    
    
    if (![self defaultLoadAppSetting_forbiddisplaypic]) {
        string = [string stringByReplacingOccurrencesOfString:@"[img]" withString:@"<div class=\"zoom\"><img style=\"max-width: 100%; width: auto; height: auto;\" src=\""];
        string = [string stringByReplacingOccurrencesOfString:@"[/img]" withString:@"\" /></div>"];               
    } else {
        theScanner = [NSScanner scannerWithString:string];
        while ([theScanner isAtEnd] == NO) {
            [theScanner scanUpToString:@"[img]" intoString:NULL];
            [theScanner scanUpToString:@"[/img]" intoString:&text];
            string = [string stringByReplacingOccurrencesOfString:[ NSString stringWithFormat:@"%@[/img]", text] withString:@""];
        }         
    }
    
    
    string = [string stringByReplacingOccurrencesOfString:@"　　" withString:@"<br />　　"];    
    
    //修改流程，字符串中不会再出现类似字符
    //    string = [string stringByReplacingOccurrencesOfString:@"来自iPhone客户端" withString:@"<br /><br /><font size=\"2\" color=\"#888888\">来自iPhone客户端</font>"];    
    //    string = [string stringByReplacingOccurrencesOfString:@"来自Android客户端" withString:@"<br /><br /><font size=\"2\" color=\"#888888\">来自Android客户端</font>"];        
    
    
    //过滤[quote]
	theScanner = [NSScanner scannerWithString:string];
    while ([theScanner isAtEnd] == NO) {
        [theScanner scanUpToString:@"[quote]" intoString:NULL];
        [theScanner scanUpToString:@"[/quote]" intoString:&text];
        string = [string stringByReplacingOccurrencesOfString:[ NSString stringWithFormat:@"%@[/quote]", text] withString:@""];
    }  
    
    //过滤[code]
	theScanner = [NSScanner scannerWithString:string];
    while ([theScanner isAtEnd] == NO) {
        [theScanner scanUpToString:@"[code]" intoString:NULL];
        [theScanner scanUpToString:@"[/code]" intoString:&text];
        string = [string stringByReplacingOccurrencesOfString:[ NSString stringWithFormat:@"%@[/code]", text] withString:@""];
    }       
    
    //过滤[code]
	theScanner = [NSScanner scannerWithString:string];
    while ([theScanner isAtEnd] == NO) {
        [theScanner scanUpToString:@"[indent]" intoString:NULL];
        [theScanner scanUpToString:@"[/indent]" intoString:&text];
        string = [string stringByReplacingOccurrencesOfString:[ NSString stringWithFormat:@"%@[/indent]", text] withString:@""];
    }     
    
    //处理常用标签
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(\\[i(.*?)\\]|\\[/i\\]|\\[/u\\]|\\[font(.*?)\\]|\\[/font\\]|\\[backcolor(.*?)\\]|\\[/backcolor\\]|\\[color(.*?)\\]|\\[/color\\]|\\[b(.*?)\\]|\\[/b\\]|\\[p(.*?)\\]|\\[/p\\]|\\[align(.*?)\\]|\\[/align\\]|\\[size(.*?)\\]|\\[/size\\]|\\[media(.*?)\\]|\\[/media\\]|\\[audio(.*?)\\]|\\[/audio\\]|\\[list(.*?)\\]|\\[\\*\\]|\\[/list\\]|\\[table(.*?)\\]|\\[/table\\]|\\[td(.*?)\\]|\\[/td\\]|\\[tr(.*?)\\]|\\[/tr\\]|\\[float(.*?)\\]|\\[/float\\])" options:0 error:nil];
    string = [regex stringByReplacingMatchesInString:string options:0 range:NSMakeRange(0, string.length) withTemplate:@""];
    
    //
    
    //    cell.contentView addSubView:imageView;
    
    
    
    //media和audio可能需要单独处理
    
    //附件也要处理
    
    //表情标签需要单独处理
    
    
    //过滤<br>
    //    string = [string stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
    //    string = [string stringByReplacingOccurrencesOfString:@"<BR>" withString:@"\n"];
    //    string = [string stringByReplacingOccurrencesOfString:@"<BR />" withString:@"\n"];
    //    string = [string stringByReplacingOccurrencesOfString:@"<br />" withString:@"\n"];
    
    
    //[url=http://www.sina.com.cn/]aaaa[/url]
    //\\[url(.*?)\\]|\\[/url\\]    
    
    //<a target="_blank" href="http://www.phpbb.com/">aaaa</a>
    
    //处理url
    string = [string stringByReplacingOccurrencesOfString:@"[url=" withString:@"<a target=\"_blank\" href=\""];
    string = [string stringByReplacingOccurrencesOfString:@"[/url]" withString:@"</a>"];  
    NSRegularExpression *regex3 = [NSRegularExpression regularExpressionWithPattern:@"(\\[u(.*?)\\])" options:0 error:nil];
    string = [regex3 stringByReplacingMatchesInString:string options:0 range:NSMakeRange(0, string.length) withTemplate:@""];        
    string = [string stringByReplacingOccurrencesOfString:@"]" withString:@"\">"];   
    
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@"<br />"];       
    string = [string stringByReplacingOccurrencesOfString:@"\r\n" withString:@"<br />"];       
    
    
    //    DebugLog(@"%@", string);
    
    return string;
}


#pragma mark - TableViewDelegate


 

//点击的table项
- (void)tableView:(UITableView *)_tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [_tableView deselectRowAtIndexPath:indexPath animated:YES];
   
 
	
}


// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [resultArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	DetailObject *indexDetail = [resultArray objectAtIndex:indexPath.row];
	return indexDetail.contentHeight + 55;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *CellIdentifier = [NSString stringWithFormat:@"Cell_%d_%d",indexPath.section,indexPath.row];
    
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:nil];
    if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	}
	
	DetailObject *indexDetail = [resultArray objectAtIndex:indexPath.row];
	UIImageView *faceView = [[UIImageView alloc] initWithFrame:CGRectMake(7, 7, 36, 36)];
	[cell addSubview:faceView];
	[faceView release];
	[faceView setImageWithURL:[NSURL URLWithString:indexDetail.micon] placeholderImage:[UIImage imageNamed:@"head.png"]];
	faceView.contentMode = UIViewContentModeScaleAspectFit;

    
//    DebugLog(@"%@", indexDetail.number);
    
    //indexDetail 目前是空
    
    //NSArray *array = [self.tableView indexPathsForVisibleRows]; 
    
    //还有就是处理分页的时候，楼层应该如何去处理
    indexDetail.number=indexPath.row;
    DebugLog(@"%d",indexDetail.number);
    
	if (indexDetail.number == 0) {
		authorid = indexDetail.authorid; //记录楼主ID，以便查看最新回复使用；
		[ViewTool addUILable:cell x:49 y:9 x1:50 y1:15 fontSize:15 lableText:@"楼主:"].textColor = [UIColor grayColor];
	}
	else if (indexDetail.number == 1) {
		[ViewTool addUILable:cell x:49 y:9 x1:50 y1:15 fontSize:15 lableText:@"沙发:"].textColor = [UIColor grayColor];
	}
	else if (indexDetail.number == 2) {
		[ViewTool addUILable:cell x:49 y:9 x1:50 y1:15 fontSize:15 lableText:@"板凳:"].textColor = [UIColor grayColor];
	}
	else if (indexDetail.number == 3) {
		[ViewTool addUILable:cell x:49 y:9 x1:50 y1:15 fontSize:15 lableText:@"地板:"].textColor = [UIColor grayColor];
	}
	else {
		[ViewTool addUILable:cell x:49 y:9 x1:50 y1:15 fontSize:15 lableText:[NSString stringWithFormat:@"%d楼:",indexDetail.number]].textColor = [UIColor grayColor];
	}
	
    //
	[ViewTool addUILable:cell x:93 y:9 x1:200 y1:15 fontSize:15 lableText:indexDetail.author].textColor = [UIColor colorWithRed:0.267 green:0.490 blue:0.843 alpha:1.000];
	[ViewTool addUILable:cell x:49 y:29 x1:306 y1:15 fontSize:13 lableText:indexDetail.postdate];
	UILabel *contentLaeble = [ViewTool addUILable:cell x:7 y:48 x1:306 y1:indexDetail.contentHeight fontSize:16 lableText:indexDetail.content];
	contentLaeble.numberOfLines = 0;
	[contentLaeble setLineBreakMode:UILineBreakModeCharacterWrap];
	SSLineView *lineView = [[SSLineView alloc] initWithFrame:CGRectMake(0, indexDetail.contentHeight + 53, 320, 2)];
	[cell addSubview:lineView];
	[lineView release];
	[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}


- (void)viewDidUnload
{
  
 
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
