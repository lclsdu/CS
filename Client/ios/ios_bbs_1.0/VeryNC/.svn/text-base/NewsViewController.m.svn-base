//
//  NewsViewController.m
//  VeryNC
//
//  Created by wu jinjin on 12-4-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NewsViewController.h"
#import "WEPopoverThreadOrderViewController.h"
#import "RootController.h"
#import "AppDelegate.h"

#define kHeadLineBigPictureTag 999999
#define kHeadLineTag 1000000
#define kTeaBowlTag 1000001
#define kFocusTag 1000002
#define kEntertainmentTag 1000003
#define kEmotionTag 1000004
#define kFoodTag 1000005
#define kCarTag 1000006
#define kHouseTag 1000007
#define kFurnitureTag 1000008
#define kMarriageTag 1000009
#define kMotherTag 1000010
#define kMoreTag 1000011

#define kEditTag 999998 

@implementation NewsViewController
@synthesize buttonFrameArray;
@synthesize sqlArray;
@synthesize appDelegate;
@synthesize myDelegate;
@synthesize orderButton;
@synthesize popoverOrderController;
@synthesize myDomainAndPathVeryNC;
@synthesize moreTip;

//去除黄叹号
@synthesize cellHLine2;
@synthesize cellHLine3;
@synthesize requestURL;
@synthesize cellHLine1;

 
-(void)cancelAllASICall;
{

    for (ASIHTTPRequest *request in ASIHTTPRequest.sharedQueue.operations)
    {
        [request cancel];
        [request setDelegate:nil];
    }
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewWillAppear:(BOOL)animated{
    
    self.orderButton.hidden=NO;
    [myDelegate showImage];
    
    
    
    switch (selectTag) {
		case kHeadLineTag:{
            forumOrderButton.hidden = YES;
			break;
		}
		case kTeaBowlTag:{
            forumOrderButton.hidden = YES;
			break;
		}
            
		case kFocusTag:{
            forumOrderButton.hidden = YES;
			break;
		}
		case kEntertainmentTag:{
            forumOrderButton.hidden = YES;
			break;
		}
		case kEmotionTag:{
            forumOrderButton.hidden = YES;
			break;
		}
            
        case kMoreTag:{
            forumOrderButton.hidden = YES;
            break;
        }
            
		default:/// others board
            forumOrderButton.hidden = NO;
            break;
	}
    
    
}
- (void)viewDidDisappear:(BOOL)animated
{
    forumOrderButton.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated{
    
    [myDelegate showImage];
    
    
}

- (void)viewDidLoad
{   

  
    [super viewDidLoad];
    numberPageUnderHeadBigPicture=-1;
    


    

    
    
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(infoTableReload:) name:@"notifyToThreadListReload" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newsHeaderReload:) name:@"notifyToNewsHeaderReload" object:nil];
    
    
    appDelegate=[[UIApplication sharedApplication] delegate];
   /* appDelegate.newsHeaderArray1=[SqliteSet queryNewsheaderItem];
    //    appDelegate.newsHeaderMoreArray=nil;
    NSLog(@"count----%d",[appDelegate.newsHeaderArray1 count]);
    appDelegate.newsHeaderMoreArray=[SqliteSet queryNewsheaderMoreItem];
    NSLog(@"newsHeaderArray:%@--newsHeaderMoreArray:--%@",appDelegate.newsHeaderArray1,appDelegate.newsHeaderMoreArray);
    */
    moreBtn=[[ KButton alloc]init];
    sqlTag=NO;
    discuzTag=NO;
    
    myDomainAndPathVeryNC = appDelegate.myDomainAndPathVeryNC;
    NSMutableArray *aa=[[NSMutableArray alloc]init];
    buttonFrameArray =aa;
    // [aa release];
    
    
    [[self navigationItem] setTitle: @"新闻"]; 
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:158.0/255.0 green:26.0/255.0 blue:36.0/255.0 alpha:1.000]];
    
    //parameter initilize
    countOfRequest=0;
    countOfHeader=0;
    pageNum = 1;
    //which page for big picture
    indexOfBigPic=0;
    //number of big picture from server
    countOfBigPic=0;
    resultArray=[[NSMutableArray alloc] init];
    resultHeadArray=[[NSMutableArray alloc] init];
    btnArray=[[NSMutableArray  alloc]init];
    resultMoreArray=[[NSMutableArray alloc]init];
    resultDiscuzArray=[[NSMutableArray alloc]init];
    
    
    NSURL *url = [NSURL URLWithString:_newsHeaderURL];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request startSynchronous];//同步请求
    NSString *requestString = [request responseString];
    
 
    
//    NSArray *tmpArray = self.appDelegate.indexTitleArray; 
    
	NSArray *tmpArray = [[requestString JSONValue] valueForKey:@"datas"];  
    
    NSString *n_index1;
    NSString *n_index2;
    NSString *n_index3;
    NSString *n_index4;
    NSString *n_index5;
    
    
    if ([tmpArray count]!=0)
    {
        
        n_index1 = ![[[tmpArray objectAtIndex:0] valueForKey:@"index1"] isEqualToString:@""] ? [[tmpArray objectAtIndex:0] valueForKey:@"index1"] : _news_name_index1;
        n_index2 = ![[[tmpArray objectAtIndex:0] valueForKey:@"index2"] isEqualToString:@""] ? [[tmpArray objectAtIndex:0] valueForKey:@"index2"] : _news_name_index2;
        n_index3 = ![[[tmpArray objectAtIndex:0] valueForKey:@"index3"] isEqualToString:@""] ? [[tmpArray objectAtIndex:0] valueForKey:@"index3"] : _news_name_index3;
        n_index4 = ![[[tmpArray objectAtIndex:0] valueForKey:@"index4"] isEqualToString:@""] ? [[tmpArray objectAtIndex:0] valueForKey:@"index4"] : _news_name_index4;
        n_index5 = ![[[tmpArray objectAtIndex:0] valueForKey:@"index5"] isEqualToString:@""] ? [[tmpArray objectAtIndex:0] valueForKey:@"index5"] : _news_name_index5;
        
        
    }
    else
    {
        n_index1 = _news_name_index1;
        n_index2 = _news_name_index2;
        n_index3 = _news_name_index3;
        n_index4 = _news_name_index4;
        n_index5 = _news_name_index5;
        
        
    }
    
    
    
    NSDictionary * D_index1=[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@" %@ ", n_index1],@"name", @"1000000",@"tag",nil];
    NSDictionary * D_index2=[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@" %@ ", n_index2],@"name" ,@"1000001",@"tag",nil];
    NSDictionary * D_index3=[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@" %@ ", n_index3],@"name", @"1000002",@"tag",nil];
    NSDictionary * D_index4=[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@" %@ ", n_index4],@"name", @"1000003",@"tag",nil];
    NSDictionary * D_index5=[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@" %@ ", n_index5],@"name" ,@"1000004",@"tag",nil];
    NSDictionary * D_index6=[NSDictionary dictionaryWithObjectsAndKeys:@" 更多 ",@"name" ,@"1000011",@"tag",nil];
    
    
    
    
    
    NSMutableArray * newsHeaderArrayTmp=[NSMutableArray arrayWithObjects:D_index1, D_index2, D_index3, D_index4, D_index5,D_index6, nil];
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
    NSString *documentsDirectory = [paths objectAtIndex:0]; 
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"distribution.plist"]; 
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    
    
    if (![fileManager fileExistsAtPath: path]) 
    {
        [appDelegate.newsHeaderArray1 removeAllObjects];
        [fileManager createFileAtPath:path contents:nil  attributes:nil  ];
        
        
        for (int x=0; x<[newsHeaderArrayTmp count]; x++) {
            
            NSDictionary * tmp=[newsHeaderArrayTmp objectAtIndex:x];
            DebugLog(@"%@",[tmp valueForKey:@"tag"]);
            DebugLog(@"%d",[[tmp valueForKey:@"tag"] intValue]);
            NSString *sql = [NSString stringWithFormat:@"INSERT INTO Newsheader VALUES(%d,'%@','%@')",x,[tmp valueForKey:@"tag"] ,[tmp valueForKey:@"name"]];
            
            DebugLog(@"SQL : %@",sql);
            [SqliteSet InsertNewsHeader:sql];
         
            
        } 
        
    }
    appDelegate.newsHeaderArray1=[SqliteSet queryNewsheaderItem];
    //    appDelegate.newsHeaderMoreArray=nil;
    //NSLog(@"count----%d",[appDelegate.newsHeaderArray1 count]);
    appDelegate.newsHeaderMoreArray=[SqliteSet queryNewsheaderMoreItem];
    //NSLog(@"newsHeaderArray:%@--newsHeaderMoreArray:--%@",appDelegate.newsHeaderArray1,appDelegate.newsHeaderMoreArray);
    
    
    

    self.sqlArray=[appDelegate newsHeaderArray1];
    
    
    //kkkkk
    [self  calculateButtonFrame];
    
    
    _scrollView.scrollEnabled = YES;
    _scrollView.scrollsToTop = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    //_scrollView.contentSize=CGSizeMake([appDelegate.newsHeaderArray1 count] * 60.0+16.0, 23.0);
    if([buttonFrameArray count]!=0)
    {

        FrameArrayObject *a=[buttonFrameArray objectAtIndex:[buttonFrameArray count]-1];
        _scrollView.contentSize=CGSizeMake(a.x+a.width, 29.0);
    }
    else {
         
 
        _scrollView.contentSize=CGSizeMake([appDelegate.newsHeaderArray1 count] * 60.0+16.0, 23.0);
    }
    
    [_scrollView setBackgroundColor:[UIColor clearColor]];
    //    [_scrollView setBackgroundColor:[UIColor colorWithRed:219.0/255.0 green:219.0/255.0 blue:219.0/255.0 alpha:1.0]];
    [_scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    [_scrollView setTag:10];
    
    selectView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navi.png"]];
	[selectView setFrame:CGRectMake(16, 3, 50, 29)];
    
	[selectView.layer setMasksToBounds:YES];
	[selectView.layer setCornerRadius:4.0];
	[_scrollView addSubview:selectView];
	[selectView release];
    
    
    
    
    
 	for (int i = 0; i < [appDelegate.newsHeaderArray1 count]; i++) {               //5,50,23
		//KButton *menuBtn = [[KButton alloc] initWithFrame:CGRectMake(16 + 60*i, 1, 50, 29)];
        
        //calculateButtonFrame
        
        
        
        newsHeaderObject * headerObject=[appDelegate.newsHeaderArray1 objectAtIndex:i];
        FrameArrayObject * aFrame=[buttonFrameArray objectAtIndex:i];
        KButton *menuBtn = [[KButton alloc] initWithFrame:CGRectMake(aFrame.x, aFrame.y, aFrame.width, aFrame.height)];
        
        menuBtn.hasPressed=false;
        
        
        DebugLog(@"%d,%@,%@",headerObject.primaryId,headerObject.tag,headerObject.name);
		[menuBtn setTitle:headerObject.name forState:UIControlStateNormal];
		[menuBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
		[menuBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
		[menuBtn setTag:[headerObject.tag intValue]];
		[menuBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
        
		[menuBtn addTarget:self action:@selector(pressMenu:) forControlEvents:64];
		[_scrollView addSubview:menuBtn];
		[btnArray addObject:menuBtn];
        [menuBtn release];
		
	}
    
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 32, 320, 336) style:UITableViewStylePlain];
	[tableView setDelegate:self];
	[tableView setDataSource:self];
	[self.view addSubview:tableView];
	[tableView setSeparatorColor:[UIColor clearColor]];
	[tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    //	[tableView setBackgroundColor:[UIColor colorWithRed:0.922 green:0.922 blue:0.922 alpha:1.000]];
	[tableView release];
    
    
    //排序图标
    orderButton = [[UIButton alloc] initWithFrame:CGRectMake(285, 8, 28, 28)];
    [orderButton addTarget:self action:@selector(orderButtonPress:) forControlEvents:UIControlEventTouchUpInside];    
    
    UIImage *backgroundImage = [[UIImage imageNamed:@"info.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:0];
    
    [orderButton setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    [self.navigationController.navigationBar addSubview:orderButton];    
    [orderButton release];
    
    
    //帖子排序按钮
    forumOrderButton = [[UIButton alloc] initWithFrame:CGRectMake(190, 10, 23, 23)];
    [forumOrderButton addTarget:self action:@selector(forumOrderButtonPress:) forControlEvents:UIControlEventTouchUpInside];    
    UIImage *backgroundImage2 = [[UIImage imageNamed:@"sort.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:0];
    [forumOrderButton setBackgroundImage:backgroundImage2 forState:UIControlStateNormal];
    forumOrderButton.hidden = YES;
    [self.navigationController.navigationBar addSubview:forumOrderButton];    
    [forumOrderButton release];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(homethreadlistreload:) name:@"notifyToThreadListReloadhome" object:nil];
    
    overflowLeftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_left.png"]];
	[overflowLeftView setFrame:CGRectMake(0, 0, 20, 32)];
	[_scrollView addSubview:overflowLeftView];
	overflowLeftView.hidden=YES;
    
    
    overflowRightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right.png"]];
	[overflowRightView setFrame:CGRectMake(300, 0, 20, 32)];
	[_scrollView addSubview:overflowRightView];
    overflowRightView.hidden=NO;
    
    
    
    [self pressMenu:[btnArray objectAtIndex:0]];
    
    
    if (_refreshHeaderView == nil) {
        
        EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - tableView.frame.size.height, self.view.frame.size.width, tableView.frame.size.height)];
        view.delegate = self;
        [tableView addSubview:view];
        _refreshHeaderView = view;
        [view release];
    }
    
    [_refreshHeaderView refreshLastUpdatedDate];
    
    moreTip = [[NSString alloc] init];

    
}



- (void)forumOrderButtonPress:(id)sender;
{
    
    //UIViewController
    WEPopoverThreadOrderViewController *contentViewController = [[WEPopoverThreadOrderViewController  alloc] initWithStyle:UITableViewStylePlain];
    contentViewController.funcname = @"home";
    contentViewController.arrayCount=5;
    [contentViewController.itemArray addObject:@" 发帖时间"];
    [contentViewController.itemArray addObject:@" 回复/查看"];
    [contentViewController.itemArray addObject:@" 查看"];
    [contentViewController.itemArray addObject:@" 最后发表"];
    [contentViewController.itemArray addObject:@" 热门"];
    [contentViewController reloadTableView];
    
    
    self.popoverOrderController = [[WEPopoverController alloc] initWithContentViewController:contentViewController   ];
    
    //UIButton *b=  (UIButton *)sender;
    
    //CGRect frame = b.frame;
    [self.popoverOrderController presentPopoverFromRect:  CGRectMake(100,-150,200,150)
                                                 inView:self.view 
                               permittedArrowDirections:UIPopoverArrowDirectionUp
                                               animated:YES];
    [contentViewController release];    
    
}
- (void)homethreadlistreload:(NSNotification *)notification{
//    _loadingView=[[UIImageView alloc] initWithFrame:CGRectMake(90.0f, 140.0f,140.0f, 70.0f)];
//    _loadingView.image=[UIImage imageNamed:@"duqu.png"];
//    _loadingView.alpha=0.8;
//    [self.view addSubview:_loadingView];
//    
//    _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
//    _activityView.frame = CGRectMake(110.0f, 162.0f, 20.0f, 20.0f);
//    [self.view addSubview:_activityView];
//    [_activityView startAnimating];
//    
//    //_loadLabel = [ViewTool addUILable:self.view x:140.0 y:158 x1:100 y1:20 fontSize:15 lableText:@"加载中..."];
//    _loadLabel = [ViewTool addUILable:self.view x:140.0 y:162 x1:100 y1:20 fontSize:15 lableText:@"加载中..."];
//    [_loadLabel setTextColor:[UIColor grayColor]];
    
    
    
    [myDelegate removeLoadingPatternIfNeed];
    [myDelegate drawLoadingPattern:@"加载中" isWithAnimation:NO];
    [resultDiscuzArray removeAllObjects];
    isMore = NO;
    NSString *ordertype = [notification object];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@topiclist.php?type=thread_list&fid=%d&pageno=1&pagesize=20&orderby=%@",myDomainAndPathVeryNC,selectTag,ordertype]]];
    [request setTag:selectTag];
    //[request setDownloadCache:[ASIDownloadCache sharedCache]];
    //[request setCachePolicy:ASIAskServerIfModifiedCachePolicy | ASIFallbackToCacheIfLoadFailsCachePolicy]; 
    [request setDelegate:self];
    [request setPersistentConnectionTimeoutSeconds:30];
    [self cancelAllASICall];
    [request startAsynchronous];
    [self.popoverOrderController dismissPopoverAnimated:YES];
}
-(float)calculateButtonWidth:(NSString *)s;
{
    //[tem setFont:[UIFont fontWithName:@"arial" size:15]];
    
    CGSize maximumSize = CGSizeMake(296,9999);
    
    CGSize expectedSize = [s sizeWithFont:[UIFont boldSystemFontOfSize:15]
                        constrainedToSize:maximumSize 
                            lineBreakMode:UILineBreakModeWordWrap]; 
    return expectedSize.width+10;
}

-(void)calculateButtonFrame;
{
    [buttonFrameArray removeAllObjects];
    //  KButton *menuBtn = [[KButton alloc] initWithFrame:CGRectMake(16 + 60*i, 1, 50, 29)];
    
    float h=16;
    for(int i=0;i<[appDelegate.newsHeaderArray1 count];i++)
    {
        
        
        newsHeaderObject * obj=[appDelegate.newsHeaderArray1 objectAtIndex:i];
        float w=[self calculateButtonWidth:obj.name];
        
        FrameArrayObject *a=[[FrameArrayObject alloc] init];
        a.x=h;
        a.y=1;
        a.width=w;
        a.height=29;
        
        [buttonFrameArray addObject:a];
        [a release];
        h=h+a.width+10;
    }
    
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
	_reloading = YES;
    [self performSelector:@selector(dragUpdateTableView)];
	
}

- (void)dragUpdateTableView{
    
    
    
    
    
    UIButton *tmpBtn = (UIButton *)[self.view viewWithTag:requestTag];
    [self pressMenu:tmpBtn More:NO];  
    
    
    isMore = NO;
}

- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:tableView];
	
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods



- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self reloadTableViewDataSource];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0.1];
	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
    _refreshHeaderView=nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)dealloc {
    
    [resultHeadArray release];
    [buttonFrameArray release];
    [appDelegate release];
    [myDelegate release];
    [orderButton release];
    [popoverOrderController release];
    [btnArray release];
    [resultArray release];
    [tabBar1Array release];
    [moreBtn release];
    
    [cellHLine1 release];
    [cellHLine2 release];
    [cellHLine3 release];
    
    [titleLabel release];
    [pageController release];
    
    _refreshHeaderView = nil;
    [super dealloc];
    
    
    
}

#pragma mark -check

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

#pragma mark -
#pragma mark button press


-(void)infoTableReload:(NSNotification *)notification


{
    NSString * infoTitle=[notification object];
    if([infoTitle isEqualToString:@"edit"])
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *nowlogin_filePath = [documentsDirectory stringByAppendingPathComponent:@"nowlogin.plist"];
        
        
        //if (([appDelegate.newsHeaderMoreArray count]==0) &&([appDelegate.newsHeaderArray1 count]==6))
        //{
                

            //说明是首次点编辑 需要调用asi 网络同步
            
            isEdit=true;
            if([self checkIfHasLogIn])
                
            {
                
                
                NSDictionary *now = [NSKeyedUnarchiver unarchiveObjectWithFile:nowlogin_filePath];
                NSString *uid  = [now objectForKey:@"uid"];
                
                
                requestURL = kForumsRequestURLWithPage(uid);
            }
            
            else {
                requestURL = kForumsRequestURLWithPageWithoutUID ;
                
            }
            
            
            ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:requestURL]];
            [request setTag:kEditTag];
            [request setDownloadCache:[ASIDownloadCache sharedCache]];
            [request setDelegate:self];
            [self cancelAllASICall];
            [request startAsynchronous];
        
    
    
    
        /*
        }
        else {
             
      
            
            editTableViewController * veditTableViewController=[[editTableViewController alloc]initWithNibName:@"editTableViewController" bundle:nil];
            self.orderButton.hidden=YES;
            [veditTableViewController setHidesBottomBarWhenPushed:YES];
            [myDelegate hideImage];
            
            [self.popoverOrderController dismissPopoverAnimated:YES];
            [self.navigationController pushViewController:veditTableViewController animated:YES];
            
            
            
        }
 
         */
        return;
        
    }
    if([infoTitle isEqualToString:@"set"])
    {
        ViewMoreSettingController *a=[[ViewMoreSettingController alloc]init];
        self.orderButton.hidden=YES;
        [a setHidesBottomBarWhenPushed:YES];
        [myDelegate hideImage];
        [self.popoverOrderController dismissPopoverAnimated:YES];
        [self.navigationController pushViewController:a animated:true];
        [a release];
        
        
    }
    if([infoTitle isEqualToString:@"night"])
    {
        
        
        
    }
    if([infoTitle isEqualToString:@"about"])
    {
        ViewMoreAboutController *a=[[ViewMoreAboutController alloc]init];
        self.orderButton.hidden=YES;
        [a setHidesBottomBarWhenPushed:YES];
        [myDelegate hideImage];
        [self.popoverOrderController dismissPopoverAnimated:YES];  
        [self.navigationController pushViewController:a animated:true];
        [a release];
        
        
    }
    if([infoTitle isEqualToString:@"collection"])
    {
        collectionViewController *a=[[collectionViewController alloc]init];
        self.orderButton.hidden=YES;
        [a setHidesBottomBarWhenPushed:YES];
        [myDelegate hideImage];
        [self.popoverOrderController dismissPopoverAnimated:YES];
        
        [self.navigationController pushViewController:a animated:true];
        [a release];
        
        
        
    }
    
}


-(void)newsHeaderReload:(NSNotification*)notification
{
    
    
    for (int i=0; i<[btnArray count]; i++) {
        [[btnArray objectAtIndex:i] removeFromSuperview];   
    }
    
    //kkkkk
    [self  calculateButtonFrame];
    // _scrollView.contentSize=CGSizeMake([appDelegate.newsHeaderArray1 count] * 60.0+16.0, 29.0);
    FrameArrayObject *a=[buttonFrameArray objectAtIndex:[buttonFrameArray count]-1];
    _scrollView.contentSize=CGSizeMake(a.x+a.width, 29.0);
    
    
    [_scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    [selectView setFrame:CGRectMake(16, 1, 50, 29)];//(16, 5, 50, 23)
    [btnArray removeAllObjects];
    
    
    
    
 	for (int i = 0; i < [appDelegate.newsHeaderArray1 count]; i++) {               //5,50,23
		//KButton *menuBtn = [[KButton alloc] initWithFrame:CGRectMake(16 + 60*i, 1, 50, 29)];
        
        //calculateButtonFrame
        
        
        
        newsHeaderObject * headerObject=[appDelegate.newsHeaderArray1 objectAtIndex:i];
        FrameArrayObject * aFrame=[buttonFrameArray objectAtIndex:i];
        KButton *menuBtn = [[KButton alloc] initWithFrame:CGRectMake(aFrame.x, aFrame.y, aFrame.width, aFrame.height)];
        
        menuBtn.hasPressed=false;
        
        
        DebugLog(@"%d,%@,%@",headerObject.primaryId,headerObject.tag,headerObject.name);
		[menuBtn setTitle:headerObject.name forState:UIControlStateNormal];
		[menuBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
		[menuBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
		[menuBtn setTag:[headerObject.tag intValue]];
		[menuBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
        
		[menuBtn addTarget:self action:@selector(pressMenu:) forControlEvents:64];
		[_scrollView addSubview:menuBtn];
		[btnArray addObject:menuBtn];
        [menuBtn release];
		
	}
    /*
     for (int i = 0; i < [appDelegate.newsHeaderArray1 count]; i++) {
     KButton *menuBtn = [[KButton alloc] initWithFrame:CGRectMake(16 + 60*i, 1, 50, 29)];
     menuBtn.hasPressed=false;
     newsHeaderObject * headerObject=[appDelegate.newsHeaderArray1 objectAtIndex:i];
     
     DebugLog(@"%d,%@,%@",headerObject.primaryId,headerObject.tag,headerObject.name);
     
     
     [menuBtn setTitle:headerObject.name forState:UIControlStateNormal];
     [menuBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
     [menuBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
     [menuBtn setTag:[headerObject.tag intValue]];
     [menuBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
     
     [menuBtn addTarget:self action:@selector(pressMenu:) forControlEvents:UIControlEventTouchUpInside];
     [_scrollView addSubview:menuBtn];
     [btnArray addObject:menuBtn];
     [menuBtn release];
     
     }
     */
    [self pressMenu:[btnArray objectAtIndex:0] More:NO ];
    
    
}






- (void)orderButtonPress:(id)sender;
{
    
    //UIViewController
    WEPopoverOrderViewController *contentViewController = [[WEPopoverOrderViewController  alloc] initWithStyle:UITableViewStylePlain];
    contentViewController.funcname = @"news";
    contentViewController.arrayCount=4;
    [contentViewController.itemArray addObject:@" 我的收藏"];
    //[contentViewController.itemArray addObject:@" 夜间模式"];
    [contentViewController.itemArray addObject:@" 设置"];
    [contentViewController.itemArray addObject:@" 编辑栏目"];
    [contentViewController.itemArray addObject:@" 关于我们"];
    [contentViewController reloadTableView];
    // contentViewController.itemArray=a;
    
    self.popoverOrderController = [[[WEPopoverController alloc] initWithContentViewController:contentViewController] autorelease];
    
    UIButton *b=  (UIButton *)sender;
    
    CGRect frame = b.frame;
    [self.popoverOrderController presentPopoverFromRect:  CGRectMake(200,-162,200,150)
                                                 inView:self.view 
                               permittedArrowDirections:UIPopoverArrowDirectionUp
                                               animated:YES];
    [contentViewController release];    
    
    
}

- (void)pressMenu:(UIButton *)sender {
    
    DebugLog(@"%d",sender.tag);
	if (sender.tag != selectTag) {
		pageNum = 1;
        
        
        //error        
        //		if (hashLoad[sender.tag] == 0) {
        //			[resultArray removeAllObjects];
        //			[tableView reloadData];
        //            
        //		}
        
        
        //         if(sender.tag==100)
        //         {_isHead=true; 
        //         [self pressMenu:sender More:NO];
        //         }
        //         else {
        //         
        //         
        //         [self pressMenu:sender More:NO];
        //         }
        [self pressMenu:sender More:NO];   
        
	}
	
}
-(NSInteger)getButtonIndex:(NSInteger)tag;
{
    
    for(int i=0;i<[btnArray count];i++)
    {
        
        KButton *a=[btnArray objectAtIndex:i];
        if(a.tag==tag)
        {
            
            return i;
        }
        
    }
    return -1;
    
}
- (void)pressMenu:(UIButton *)sender More:(BOOL)_isMore{
    if(_isMore == NO){
        pageNum = 1;
    }
    DebugLog(@"sender tag ---------  %d",sender.tag);
    discuzTag=NO;
    for (UIButton *tmpBtn in btnArray) {
		[tmpBtn setSelected:NO]; 
	}
	isMore = _isMore;
	[sender setSelected:YES];
	[UIView animateWithDuration:0.2f animations:^{
		CGRect frame =CGRectMake(sender.frame.origin.x, sender.frame.origin.y+4, sender.frame.size.width, sender.frame.size.height-8); //[sender frame];
		frame.origin.x -= 1;	 
		[selectView setFrame:frame];
	}];
	selectTag = sender.tag;
    
    KButton *a= [btnArray objectAtIndex:[self getButtonIndex:selectTag]];
    if(a.hasPressed==true)
    {
        return;
    }
    else 
    {
        a.hasPressed=false;// true;
    }
    requestTag = sender.tag;
    
    
    
    
	switch (selectTag) {
		case kHeadLineTag:{
            forumOrderButton.hidden = YES;
            orderButton.hidden = NO;
			requestURL = _newsHeadLineRequestURLWithPage(pageNum);
            numberPageUnderHeadBigPicture=-1;
			if (!isMore) {			
                [resultArray removeAllObjects];
                [tableView reloadData];
                numberPageUnderHeadBigPicture=pageNum;
                //头条大图 先下载
				ASIHTTPRequest *head = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@topiclist.php?type=top&pageno=1&pagesize=3",_customDomainandPathVeryNC]]];
                DebugLog(@"-head------%@",[NSString stringWithFormat:@"%@topiclist.php?type=top&pageno=1&pagesize=3",_customDomainandPathVeryNC]);
				[head setDownloadCache:[ASIDownloadCache sharedCache]];
                [head setPersistentConnectionTimeoutSeconds:_timeOut];
                [head setTag:kHeadLineBigPictureTag];
                [head setDelegate:self];
                    [self cancelAllASICall];
				[head startAsynchronous];
                
                return;
             
                /*
            
                [head startSynchronous];
               
              
				NSString *requestString = [head responseString];
                DebugLog(@"requestString------head,%@",requestString);
				NSArray *tmpArray = [[requestString JSONValue] valueForKey:@"datas"];
                
                if ([tmpArray count]<3) {
                    countOfBigPic=[tmpArray count];
                }else {
                    countOfBigPic=3;
                }
                if ([tmpArray count]>0) {
                    for (int i=0; i<[tmpArray count]; i++) {
                        
                        CommonObject *tmpHLine =  [[CommonObject alloc] init];
                        tmpHLine.img = [[tmpArray objectAtIndex:i] valueForKey:@"pic"];
                        
                        tmpHLine.tid = [[[tmpArray objectAtIndex:i] valueForKey:@"id"] intValue];
                        
                        NSString *tmpString = [[tmpArray objectAtIndex:i] valueForKey:@"title"];
                        if (tmpString.length > 17) {
                            tmpHLine.title = [tmpString substringToIndex:17];
                        } else {
                            tmpHLine.title = tmpString;
                        }
                        
                        
                        
                        //tmpHLine.url = [[tmpArray objectAtIndex:0] valueForKey:@"url"];
                        //tmpHLine.author = [[tmpArray objectAtIndex:0] valueForKey:@"author"];
                        if (i<3) {
                            [resultArray insertObject:tmpHLine atIndex:i];
                            
                        }
                        
                        [tmpHLine release];
                    }
                    cellHLine1=[resultArray objectAtIndex:0];
                    cellHLine2=[resultArray objectAtIndex:1];
                    cellHLine3=[resultArray objectAtIndex:2];
                    DebugLog(@"resultArray--PRESS---1-%@       2-----------:%@      3----------%@",cellHLine1.img,cellHLine2.img,cellHLine3.img);   
                } 
                 */
              
                
			}
			break;
		}
		case kTeaBowlTag:{
            forumOrderButton.hidden = YES;
            orderButton.hidden = NO;
			requestURL =_newskTeaBowlRequestURLWithPage(pageNum);
			break;
		}
            
		case kFocusTag:{
            forumOrderButton.hidden = YES;
            orderButton.hidden = NO;
			requestURL =_newskFocuslRequestURLWithPage(pageNum);
			break;
		}
		case kEntertainmentTag:{
            forumOrderButton.hidden = YES;
            orderButton.hidden = NO;
			requestURL = _newskEntertainmentRequestURLWithPage(pageNum);
			break;
		}
		case kEmotionTag:{
            forumOrderButton.hidden = YES;
            orderButton.hidden = NO;
			requestURL =_newskEmotionRequestURLWithPage(pageNum);
			break;
		}
            
        case kMoreTag:{
            forumOrderButton.hidden = YES;
            orderButton.hidden = NO;
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *nowlogin_filePath = [documentsDirectory stringByAppendingPathComponent:@"nowlogin.plist"];
            
            if([self checkIfHasLogIn])
                
            {
                
                
                NSDictionary *now = [NSKeyedUnarchiver unarchiveObjectWithFile:nowlogin_filePath];
                NSString *uid  = [now objectForKey:@"uid"];
                
                
                requestURL = kForumsRequestURLWithPage(uid);
            }
            
            else {
                requestURL = kForumsRequestURLWithPageWithoutUID ;
                
            }
            break;
        }
            
		default:/// others board
            forumOrderButton.hidden = NO;
            discuzTag=YES;
			requestURL = kListRequestURLWithPage(selectTag,pageNum);
            
            break;
            
            
	}
    for (ASIHTTPRequest *request in ASIHTTPRequest.sharedQueue.operations)
    {
        [request cancel];
        [request setDelegate:nil];
    } 
 
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:requestURL]];
	[request setTag:selectTag];
	[request setDownloadCache:[ASIDownloadCache sharedCache]];
    
	[request setDelegate:self];
    
        [self cancelAllASICall];
    [request startAsynchronous];
 
}
 
#pragma mark - ASIHTTPDelegate

- (void)requestStarted:(ASIHTTPRequest *)request {
    
    
    [myDelegate removeLoadingPatternIfNeed];
    [myDelegate drawLoadingPattern:@"加载中" isWithAnimation:NO];
//
//    
//	if (hashLoad[selectTag] == 0) {
//		hashLoad[selectTag] = 1;
//        if (_activityView ) {
//            
//            [_activityView removeFromSuperview];
//            _activityView = nil;
//            [_loadLabel removeFromSuperview];
//            _loadLabel = nil;
//            
//            [_loadingView removeFromSuperview];
//            _loadingView=nil;
//            
//        }
//        /*
//         _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//         _activityView.frame = CGRectMake(110.0f, 160.0f, 20.0f, 20.0f);
//         [self.view addSubview:_activityView];
//         [_activityView startAnimating];
//         
//         _loadLabel = [ViewTool addUILable:self.view x:135.0 y:158 x1:100 y1:20 fontSize:15 lableText:@"加载中..."];
//         [_loadLabel setTextColor:[UIColor grayColor]];
//         */
//        //beta2
//        if (_activityView ) {
//            
//            [_activityView removeFromSuperview];
//            _activityView = nil;
//            [_loadLabel removeFromSuperview];
//            _loadLabel = nil;
//            
//            [_loadingView removeFromSuperview];
//            _loadingView=nil;
//            
//        }
//        /*
//         _loadingView=[[UIImageView alloc] initWithFrame:CGRectMake(90.0f, 140.0f,140.0f, 70.0f)];
//         _loadingView.image=[UIImage imageNamed:@"duqu.png"];
//         
//         [self.view addSubview:_loadingView];
//         
//         _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//         _activityView.frame = CGRectMake(110.0f, 162.0f, 20.0f, 20.0f);
//         
//         [self.view addSubview:_activityView];
//         [_activityView startAnimating];
//         
//         //_loadLabel = [ViewTool addUILable:self.view x:140.0 y:158 x1:100 y1:20 fontSize:15 lableText:@"加载中..."];
//         _loadLabel = [ViewTool addUILable:self.view x:140.0 y:162 x1:100 y1:20 fontSize:15 lableText:@"加载中..."];
//         
//         [_loadLabel setTextColor:[UIColor grayColor]];
//         
//         */
//        _loadingView=[[UIImageView alloc] initWithFrame:CGRectMake(90.0f, 140.0f,140.0f, 70.0f)];
//        _loadingView.image=[UIImage imageNamed:@"duqu.png"];
//        
//        _loadingView.alpha=0.8;
//        [self.view addSubview:_loadingView];
//        
//        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
//        _activityView.frame = CGRectMake(110.0f, 162.0f, 20.0f, 20.0f);
//        
//        [self.view addSubview:_activityView];
//        [_activityView startAnimating];
//        
//        //_loadLabel = [ViewTool addUILable:self.view x:140.0 y:158 x1:100 y1:20 fontSize:15 lableText:@"加载中..."];
//        _loadLabel = [ViewTool addUILable:self.view x:140.0 y:162 x1:100 y1:20 fontSize:15 lableText:@"加载中..."];
//        
//        [_loadLabel setTextColor:[UIColor grayColor]];
//	}
//    
//    else {
//        
//        /*
//         if (_activityView ) {
//         [_activityView removeFromSuperview];
//         _activityView = nil;
//         [_loadLabel removeFromSuperview];
//         _loadLabel = nil;
//         
//         }
//         _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//         _activityView.frame = CGRectMake(110.0f, 160.0f, 20.0f, 20.0f);
//         [self.view addSubview:_activityView];
//         [_activityView startAnimating];
//         _loadLabel = [ViewTool addUILable:self.view x:135.0 y:158 x1:100 y1:20 fontSize:15 lableText:@"加载中..."];
//         [_loadLabel setTextColor:[UIColor grayColor]];
//         
//         */
//        //beta2
//        if (_activityView ) {
//            
//            [_activityView removeFromSuperview];
//            _activityView = nil;
//            [_loadLabel removeFromSuperview];
//            _loadLabel = nil;
//            
//            [_loadingView removeFromSuperview];
//            _loadingView=nil;
//            
//        }
//        
//        _loadingView=[[UIImageView alloc] initWithFrame:CGRectMake(90.0f, 140.0f,140.0f, 70.0f)];
//        _loadingView.image=[UIImage imageNamed:@"duqu.png"];
//        _loadingView.alpha=0.8;
//        [self.view addSubview:_loadingView];
//        
//        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
//        _activityView.frame = CGRectMake(110.0f, 162.0f, 20.0f, 20.0f);
//        [self.view addSubview:_activityView];
//        [_activityView startAnimating];
//        
//        //_loadLabel = [ViewTool addUILable:self.view x:140.0 y:158 x1:100 y1:20 fontSize:15 lableText:@"加载中..."];
//        _loadLabel = [ViewTool addUILable:self.view x:140.0 y:162 x1:100 y1:20 fontSize:15 lableText:@"加载中..."];
//        
//        [_loadLabel setTextColor:[UIColor grayColor]];
//    }
}

-(NSString *)preProcessResponseString:(NSString*)s;
{
    
    NSString *formatJsonString = s;
    formatJsonString = [formatJsonString stringByReplacingOccurrencesOfString: @"&quot;"withString: @""];      
    formatJsonString = [formatJsonString stringByReplacingOccurrencesOfString: @""withString: @""];      
    NSString *temS = [formatJsonString stringByConvertingHTMLToPlainText];
    temS=[temS stringByReplacingOccurrencesOfString:@"\"\"\\" withString:@"\"\\"] ;
    return [[s retain] autorelease];
    
}
-(void)processHTTPCallFromEdit:(ASIHTTPRequest *)request {
    
    
    NSString *requestString =[self preProcessResponseString:[request responseString]];
    
    NSArray *array = [[requestString JSONValue] valueForKey:@"datas"];
    NSMutableArray *temArray=[[NSMutableArray alloc]init] ;
    for (int i = 0; i < [array count]; i++) {
        //不是分组，copy object 到temArray
        if(![[[array objectAtIndex:i] valueForKey:@"fup"] isEqualToString:@"0"])
        {
            [temArray addObject:[array objectAtIndex:i]];
        }
    };
    
    int v=0;
    for (int i = 0; i < [array count]; i++) {
        
        //分组
        if([[[array objectAtIndex:i] valueForKey:@"fup"] isEqualToString:@"0"])
        {
            
            
            ColumnList *column = [[ColumnList alloc] init];
            column.listID = v;
            
            column.listName = [[array objectAtIndex:i] valueForKey:@"name"];
            column.isOpened = NO;
            
            NSMutableArray *childArray = [[NSMutableArray alloc] init];
            NSMutableArray *nameArray = [[NSMutableArray alloc] init];
            NSMutableArray *fidArray = [[NSMutableArray alloc] init];
            NSString *fidString=[[array objectAtIndex:i] valueForKey:@"fid"];
            
            
            
            int temK=0;
            for (int j = 0; j < [temArray count]; j++) {
                
                NSString *temString=[[temArray objectAtIndex:j] valueForKey:@"fup"];
                
                
                if([temString isEqualToString:fidString])
                {
                    temK=temK+1;
                    
                    NSMutableArray * nameContainArray=[[NSMutableArray alloc]init];
                    [nameContainArray addObject:[[temArray objectAtIndex:j ] valueForKey:@"name"]];                        
                    [nameArray addObject:nameContainArray];
                    [childArray addObject:[[temArray objectAtIndex:j ] valueForKey:@"name"]];
                    
                    NSMutableArray * fidContainArray=[[NSMutableArray alloc]init];
                    [fidContainArray addObject:[[temArray objectAtIndex:j ] valueForKey:@"fid"]];                        
                    [fidArray addObject:fidContainArray];                        
                    [nameContainArray release];
                    [fidContainArray release];
                    
                }
            }
            column.nameArray=nameArray;
            column.childArray = childArray;		
            column.fidArray = fidArray;		
            [resultMoreArray addObject:column];
            v=v+1;
            [fidArray release];
            [nameArray release];
            [childArray release];
            [column release];
            
        }  
    }
    //DebugLog(@"%@",resultMoreArray);
    
    [temArray release];
    for (int j=0; j<[resultMoreArray count]; j++) {
        
        ColumnList * second_column=[resultMoreArray objectAtIndex:j];
        for (int x=0; x<[second_column.fidArray count]; x++) {
            
            NSMutableArray * subFidArray=[[NSMutableArray alloc]init];
            NSMutableArray * subNameArray=[[NSMutableArray alloc]init];
            
            for (int i = 0; i < [array count]; i++) {
                
                if([[[array objectAtIndex:i] valueForKey:@"fup"] isEqualToString:(NSString *)[[second_column.fidArray objectAtIndex:x]objectAtIndex:0]])
                    
                {   
                    [subNameArray addObject:[[array objectAtIndex:i]valueForKey:@"name"]];
                    [subFidArray addObject:[[array objectAtIndex:i]valueForKey:@"fid"]];
                    
                }
                
                
            }   
            
            [[second_column.fidArray objectAtIndex:x]addObject:subFidArray];               
            
            [[second_column.nameArray objectAtIndex:x]addObject:subNameArray];
            [subFidArray release];
            [subNameArray release];
            
        }
        
    }
    
    
    int indextemp=0;
    
    if ([[SqliteSet queryNewsheaderMoreItem] count]<=0) {
        
        for (int n=0; n<[resultMoreArray count] ; n++) {
            
            ColumnList * atemp=[resultMoreArray objectAtIndex:n];
            for (int m=0; m<[atemp.fidArray count]; m++) {
                newsHeaderObject * a=[[newsHeaderObject alloc] init];
                a.primaryId=indextemp;
                a.tag=[[atemp.fidArray objectAtIndex:m] objectAtIndex:0] ;
                a.name=[[atemp.nameArray objectAtIndex:m] objectAtIndex:0];
                
                [appDelegate.newsHeaderMoreArray addObject:a];
                [a release];
                NSString *sql = [NSString stringWithFormat:@"INSERT INTO Newsheadermore VALUES(%d,'%@','%@')",indextemp,[[atemp.fidArray objectAtIndex:m] objectAtIndex:0] ,[[atemp.nameArray objectAtIndex:m] objectAtIndex:0]];
                
                DebugLog(@"SQL : %@",sql);
                [SqliteSet InsertNewsHeader:sql];
                indextemp++;
                for (int l=0; l<[[[atemp.fidArray objectAtIndex:m] objectAtIndex:1]count]; l++) 
                {
                    newsHeaderObject * b=[[newsHeaderObject alloc] init];
                    b.primaryId=indextemp;
                    b.tag=[[[atemp.fidArray objectAtIndex:m] objectAtIndex:1]objectAtIndex:l];
                    b.name=[[[atemp.nameArray objectAtIndex:m]objectAtIndex:1]objectAtIndex:l];
                    [appDelegate.newsHeaderMoreArray addObject:b];
                    
                    NSString *sql = [NSString stringWithFormat:@"INSERT INTO Newsheadermore VALUES(%d,'%@','%@')",indextemp,b.tag,b.name];
                    
                    DebugLog(@"SQL : %@",sql);
                    [SqliteSet InsertNewsHeader:sql];
                    [b release];
                    indextemp++;
                    
                }; 
            }
            
        }
    }
    
    
    //oooooo
    editTableViewController * veditTableViewController=[[editTableViewController alloc]initWithNibName:@"editTableViewController" bundle:nil];
    self.orderButton.hidden=YES;
    [veditTableViewController setHidesBottomBarWhenPushed:YES];
    [myDelegate hideImage];
    
    [self.popoverOrderController dismissPopoverAnimated:YES];
    [self.navigationController pushViewController:veditTableViewController animated:YES];
    

    
}
- (void)requestFinished:(ASIHTTPRequest *)request {
        
    [myDelegate removeLoadingPatternIfNeed];
 
 
    //如果是从点i图标里面的编辑来asihttp的
    if (isEdit) {
        isEdit=false;
        
 
        [self processHTTPCallFromEdit:request];
                
        return;

        
    }

 
 
    if(request.tag== kHeadLineBigPictureTag)
    
    {

 
        [resultArray removeAllObjects];
        [tableView reloadData];
        
        NSString *requestString = [request responseString];
        
        NSArray *tmpArray = [[requestString JSONValue] valueForKey:@"datas"];
        
        if (tmpArray.count<3) {
            countOfBigPic=tmpArray.count;
        }else {
            countOfBigPic=3;//限制图片最多三张
        }
        if (tmpArray.count>0) {
            for (int i=0; i<tmpArray.count; i++) {
                
                CommonObject * a =  [[CommonObject alloc] init];
                a.img = [[tmpArray objectAtIndex:i] valueForKey:@"pic"];
                a.tid = [[[tmpArray objectAtIndex:i] valueForKey:@"id"] intValue];
                a.isclosed = [[[tmpArray objectAtIndex:i] valueForKey:@"closed"] intValue];
                NSString *tmpString = [[tmpArray objectAtIndex:i] valueForKey:@"title"];
                if (tmpString.length > 17) {
                    a.title = [tmpString substringToIndex:17];
                } else {
                    a.title = tmpString;
                }

                if (i<3) {
                    [resultArray insertObject: a atIndex:i];//i
                    
                }
                
                [ a release];
            }
            cellHLine1=[resultArray objectAtIndex:0];
            cellHLine2=[resultArray objectAtIndex:1];
            cellHLine3=[resultArray objectAtIndex:2];
            DebugLog(@"resultArray--PRESS---1-%@       2-----------:%@      3----------%@",cellHLine1.img,cellHLine2.img,cellHLine3.img);   
        }   
     
      
        [tableView reloadData];
        
       
   
 
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:_newsHeadLineRequestURLWithPage(numberPageUnderHeadBigPicture)]];
        [request setTag:kHeadLineTag];
     
        [request setDownloadCache:[ASIDownloadCache sharedCache]];
        [request setDelegate:self];
            [self cancelAllASICall];
        [request startAsynchronous];
        
     
     } 
     else  
    if(! ((selectTag<=1000004 && selectTag >= 1000000 )|| selectTag==1000011)) {
        if(pageNum == 1){
            [resultDiscuzArray removeAllObjects]; 
        }
                 
       
        
        /*
        NSString *formatJsonString = [request responseString];
        formatJsonString = [formatJsonString stringByReplacingOccurrencesOfString: @"&quot;"withString: @""];      
        formatJsonString = [formatJsonString stringByReplacingOccurrencesOfString: @""withString: @""];      
        NSString *requestString = [formatJsonString stringByConvertingHTMLToPlainText];
        requestString=[requestString stringByReplacingOccurrencesOfString:@"\"\"\\" withString:@"\"\\"] ;
        requestString = [requestString stringByReplacingOccurrencesOfString: @"\\'" withString: @"'"];
         */

        NSLog(@"99999999    %@",[request responseString]);
        NSString *requestString =[self preProcessResponseString:[request responseString]];
      
        NSArray *tmpArray = [[requestString JSONValue] valueForKey:@"datas"];

        NSLog(@"8888888 %@",requestString);
        if([tmpArray count]>0)
        {
            for (int i = 0; i < [tmpArray count]; i++) {
                CommonObject * a =  [[CommonObject alloc] init];
                a.author = [[tmpArray objectAtIndex:i] valueForKey:@"author"];
                //		 a.subject = [[tmpArray objectAtIndex:i] valueForKey:@"subject"];
                a.postdate = [self timeStampeToNSDateString:[[tmpArray objectAtIndex:i] valueForKey:@"dateline"]];
                a.title = [[tmpArray objectAtIndex:i] valueForKey:@"subject"];
                //		 a.fid = [[[tmpArray objectAtIndex:i] valueForKey:@"id"] intValue];
                a.tid = [[[tmpArray objectAtIndex:i] valueForKey:@"tid"] intValue];
                a.views = [[[tmpArray objectAtIndex:i] valueForKey:@"views"] intValue];
                a.replies = [[[tmpArray objectAtIndex:i] valueForKey:@"replies"] intValue];
                a.isclosed = [[[tmpArray objectAtIndex:i] valueForKey:@"closed"] intValue];
                //		 a.authorid = [[[tmpArray objectAtIndex:i] valueForKey:@"authorid"] intValue];
                //		 a.ifupload = [[[tmpArray objectAtIndex:i] valueForKey:@"ifupload"] intValue];
                NSString *s=[[tmpArray objectAtIndex:i] valueForKey:@"tid"];
                NSLog(@"%@",s);
                a.isReaded = [[NSUserDefaults standardUserDefaults] boolForKey:s ];
                [resultDiscuzArray addObject: a];
                [ a release];
            }
            moreTip = @"显示下20条";
        }
        if([tmpArray count] == 0){
            if(isMore == YES){
                moreTip = @"已无更多内容";
            }else{
                moreTip = @"暂无数据";
            }
        }
        [tableView reloadData];
        
        
    }else {
        
        
        
   
                
        if (selectTag==kMoreTag) {
            
            
            
            NSString *formatJsonString = [request responseString];
            
            formatJsonString = [formatJsonString stringByReplacingOccurrencesOfString: @"&quot;"withString: @""];      
            
            formatJsonString = [formatJsonString stringByReplacingOccurrencesOfString: @""withString: @""];      
            
            NSString *requestString = [formatJsonString stringByConvertingHTMLToPlainText];
            
            
            
            
            if ([request tag] == kMoreTag) {
                
                
                
                requestString=[requestString stringByReplacingOccurrencesOfString:@"\"\"\\" withString:@"\"\\"] ;
                
                
                
                NSArray *array = [[requestString JSONValue] valueForKey:@"datas"];
                
                
                
                
                NSMutableArray *temArray=[[NSMutableArray alloc]init] ;
                
                for (int i = 0; i < [array count]; i++) {
                    
                    
                    //不是分组，copy object 到temArray
                    if(![[[array objectAtIndex:i] valueForKey:@"fup"] isEqualToString:@"0"])
                    {
                        
                        [temArray addObject:[array objectAtIndex:i]];
                        
                    }
                    
                    
                };
                
  
                
                
                int v=0;
                
                
                for (int i = 0; i < [array count]; i++) {
                    
                    //分组
                    if([[[array objectAtIndex:i] valueForKey:@"fup"] isEqualToString:@"0"])
                    {
                        
                        
                        ColumnList *column = [[ColumnList alloc] init];
                        column.listID = v;
                        
                        column.listName = [[array objectAtIndex:i] valueForKey:@"name"];
                        column.isOpened = NO;
                        
                        NSMutableArray *childArray = [[NSMutableArray alloc] init];
                        NSMutableArray *nameArray = [[NSMutableArray alloc] init];
                        NSMutableArray *fidArray = [[NSMutableArray alloc] init];
                        NSString *fidString=[[array objectAtIndex:i] valueForKey:@"fid"];
                        
                        
                        
                        int temK=0;
                        for (int j = 0; j < [temArray count]; j++) {
                            
                            NSString *temString=[[temArray objectAtIndex:j] valueForKey:@"fup"];
                            
                            
                            if([temString isEqualToString:fidString])
                            {
                                temK=temK+1;
                                
                                NSMutableArray * nameContainArray=[[NSMutableArray alloc]init];
                                [nameContainArray addObject:[[temArray objectAtIndex:j ] valueForKey:@"name"]];                        
                                [nameArray addObject:nameContainArray];
                                [childArray addObject:[[temArray objectAtIndex:j ] valueForKey:@"name"]];
                                
                                NSMutableArray * fidContainArray=[[NSMutableArray alloc]init];
                                [fidContainArray addObject:[[temArray objectAtIndex:j ] valueForKey:@"fid"]];
                                
                                [fidArray addObject:fidContainArray];
                                
                                [nameContainArray release];
                                
                                [fidContainArray release];
                                
                            }
                            
                            
                        }
                        
                        
                        
                        column.nameArray=nameArray;
                        
                        
                        
                        column.childArray = childArray;		
                        
                        column.fidArray = fidArray;		
                        
                        
                        [resultMoreArray addObject:column];
                        
                        v=v+1;
                        
                        
                        
                        [fidArray release];
                        [nameArray release];
                        [childArray release];
                        
                        
                        [column release];
                        
                    }
                    
                }
                DebugLog(@"%@",resultMoreArray);
                
                [temArray release];
                
                
                for (int j=0; j<[resultMoreArray count]; j++) {
                    
                    ColumnList * second_column=[resultMoreArray objectAtIndex:j];
                    for (int x=0; x<[second_column.fidArray count]; x++) {
                        
                        NSMutableArray * subFidArray=[[NSMutableArray alloc]init];
                        NSMutableArray * subNameArray=[[NSMutableArray alloc]init];
                        
                        for (int i = 0; i < [array count]; i++) {
                            
                            if([[[array objectAtIndex:i] valueForKey:@"fup"] isEqualToString:(NSString *)[[second_column.fidArray objectAtIndex:x]objectAtIndex:0]])
                                
                            {   
                                [subNameArray addObject:[[array objectAtIndex:i]valueForKey:@"name"]];
                                [subFidArray addObject:[[array objectAtIndex:i]valueForKey:@"fid"]];
                                
                            }
                            
                            
                        }   
                        
                        [[second_column.fidArray objectAtIndex:x]addObject:subFidArray];               
                        
                        [[second_column.nameArray objectAtIndex:x]addObject:subNameArray];
                        [subFidArray release];
                        [subNameArray release];
                        
                    }
                    
                }
                
            }
            int indextemp=0;
            if ([[SqliteSet queryNewsheaderMoreItem] count]<=0) {
                
                for (int n=0; n<[resultMoreArray count] ; n++) {
                    
                    ColumnList * atemp=[resultMoreArray objectAtIndex:n];
                    for (int m=0; m<[atemp.fidArray count]; m++) {
                        newsHeaderObject * a=[[newsHeaderObject alloc] init];
                        a.primaryId=indextemp;
                        a.tag=[[atemp.fidArray objectAtIndex:m] objectAtIndex:0] ;
                        a.name=[[atemp.nameArray objectAtIndex:m] objectAtIndex:0];
                        
                        [appDelegate.newsHeaderMoreArray addObject:a];
                        [a release];
                        NSString *sql = [NSString stringWithFormat:@"INSERT INTO Newsheadermore VALUES(%d,'%@','%@')",indextemp,[[atemp.fidArray objectAtIndex:m] objectAtIndex:0] ,[[atemp.nameArray objectAtIndex:m] objectAtIndex:0]];
                        
                        DebugLog(@"SQL : %@",sql);
                        [SqliteSet InsertNewsHeader:sql];
                        indextemp++;
                        //                    DebugLog(@"%@",[[atemp.fidArray objectAtIndex:m] objectAtIndex:1]);
                        
                        
                        
                        
                        
                        for (int l=0; l<[[[atemp.fidArray objectAtIndex:m] objectAtIndex:1]count]; l++) 
                        {
                            newsHeaderObject * b=[[newsHeaderObject alloc] init];
                            b.primaryId=indextemp;
                            b.tag=[[[atemp.fidArray objectAtIndex:m] objectAtIndex:1]objectAtIndex:l];
                            b.name=[[[atemp.nameArray objectAtIndex:m]objectAtIndex:1]objectAtIndex:l];
                            [appDelegate.newsHeaderMoreArray addObject:b];
                            
                            NSString *sql = [NSString stringWithFormat:@"INSERT INTO Newsheadermore VALUES(%d,'%@','%@')",indextemp,b.tag,b.name];
                            
                            DebugLog(@"SQL : %@",sql);
                            [SqliteSet InsertNewsHeader:sql];
                            [b release];
                            indextemp++;
                            
                            
                        };
                        
                        
                        
                        //                    
                        
                        
                        
                        
                    }
                    
                    
                    
                }
                
            }
            
            [tableView reloadData];
            
            
            
            
        }else {
            
            DebugLog(@"%d======",selectTag);
            if (!isMore) {
                if (selectTag==kHeadLineTag ) {
                    
                    
                }
                else
                    
                    [resultArray removeAllObjects];
                [tableView reloadData];//new way
            }
            else [resultArray removeLastObject];	//将“更多”移出来
            
            
            
            NSString *formatJsonString = [request responseString];
            
            formatJsonString = [formatJsonString stringByReplacingOccurrencesOfString: @"&quot;"withString: @""];     
            formatJsonString = [formatJsonString stringByReplacingOccurrencesOfString: @""withString: @""];          
            
            NSString *requestString = [formatJsonString stringByConvertingHTMLToPlainText];
            
//            NSLog(@"kkk %@",requestString);
            
            
            
            NSArray *tmpArray = [[requestString JSONValue] valueForKey:@"datas"];
            int rongCuoCount=[tmpArray count];
            if(rongCuoCount>0)
            {

                for (int i = 0; i < [tmpArray count]; i++) {
                    
                    
                    
                    
                    CommonObject * a =  [[CommonObject alloc] init];
                    a.img = [[tmpArray objectAtIndex:i] valueForKey:@"pic"];
                    DebugLog(@"%@", a.img);
                    a.descrip = [[tmpArray objectAtIndex:i] valueForKey:@"summary"];
                    a.tid = [[[tmpArray objectAtIndex:i] valueForKey:@"id"] intValue];
                    
                    //beta2
                    a.fid =-1;
                    a.title = [[tmpArray objectAtIndex:i] valueForKey:@"title"];
                    a.isclosed = [[[tmpArray objectAtIndex:i] valueForKey:@"closed"] intValue];
                    //			 a.author = [[tmpArray objectAtIndex:i] valueForKey:@"author"];
                    //			 a.url = [[tmpArray objectAtIndex:i] valueForKey:@"url"];
                    a.isReaded = [[NSUserDefaults standardUserDefaults] boolForKey:[[tmpArray objectAtIndex:i] valueForKey:@"id"]];
                    [resultArray addObject: a];
                    [ a release];
                }
            }
            
            
            DebugLog(@"%@",resultArray);
            
            
            //[resultArray addObject:@"更多"];
            //(* +) shopnc codes
            if([tmpArray count]>0)
                
                [resultArray addObject:@"显示下20条"];
            
            else  
                [resultArray addObject:@"已无更多内容"];
            
            
            
            [tableView reloadData];
            
        }
        
        
    }
    
 
	
}

- (void)requestFailed:(ASIHTTPRequest *)request {
 
    [myDelegate removeLoadingPatternIfNeed];
    [myDelegate ShowConnectionFailureAlert];
}

- (NSString *)timeStampeToNSDateString:(NSString *)timeStame {
	NSDate *tranData = [NSDate dateWithTimeIntervalSince1970:[timeStame doubleValue]];
	return [tranData formatRelativeTime];
}

#pragma mark - TableViewDelegate






// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if ((selectTag<=1000004 && selectTag >= 1000000 )|| selectTag==1000011) {
        
        
        if (selectTag==kMoreTag) {
            
            return [appDelegate.newsHeaderMoreArray count]+1;
            
        }else if (selectTag==kHeadLineTag){
            
            DebugLog(@"%d",[resultArray count]);
            return [resultArray count]-countOfBigPic+1;
            
        }else{
            return [resultArray count];
            
            
        }
    }else {
        
        //        more  detail
        return [resultDiscuzArray count]+1;
        
        
    }
    
}



// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	NSString *CellIdentifier = [NSString stringWithFormat:@"Cell_%d_%d",selectTag,indexPath.row];
    
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:nil];
    if ((selectTag<=1000004 && selectTag >= 1000000 )|| selectTag==1000011) {    
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            //首页 - 头条
            if (selectTag == kHeadLineTag) {
                if (indexPath.row==0) {
                    SSLineView *lineView = [[SSLineView alloc] initWithFrame:CGRectMake(0, 170, 320, 2)];
                    [cell addSubview:lineView];
                    [lineView release];
                    
                }else{
                    SSLineView *lineView = [[SSLineView alloc] initWithFrame:CGRectMake(0, 70, 320, 2)];
                    [cell addSubview:lineView];
                    [lineView release];
                }
                if ([indexPath row] == [resultArray count]-countOfBigPic && [resultArray count] != countOfBigPic) {
                    
                    //[cell.textLabel setText:@"更多"];
                    DebugLog(@"cellForRowAtIndexPath+++++++resultArray last one: %@",[resultArray  objectAtIndex:[resultArray count] - 1]);
//                    [cell.textLabel setText:  [resultArray  objectAtIndex:[resultArray count] - 1]];
//                    
//                    [cell.textLabel setTextAlignment:UITextAlignmentCenter];
                    UIButton *morebtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 310, 35)];
                    [morebtn setBackgroundImage:[UIImage imageNamed:@"bigmorebtn.png"] forState:UIControlStateNormal];
                    [morebtn addTarget:self action:@selector(loadmoretoutiao) forControlEvents:UIControlEventTouchUpInside];
                    [cell addSubview:morebtn];
                    UILabel *moreTiplabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 13, 200, 20)];
                    moreTiplabel.backgroundColor = [UIColor clearColor];
                    moreTiplabel.text = [resultArray  objectAtIndex:[resultArray count] - 1];
                    moreTiplabel.textAlignment = UITextAlignmentCenter;
                    [cell addSubview:moreTiplabel];
                }//更多
                else if ([indexPath row] == 0) {
                    
                    
                    
                    
                    scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0,320,170)];
                    scrollview.showsVerticalScrollIndicator = NO;
                    scrollview.showsHorizontalScrollIndicator = NO;
                    scrollview.pagingEnabled = YES;
                    [scrollview setTag:10];
                    scrollview.contentSize=CGSizeMake(scrollview.frame.size.width*countOfBigPic, scrollview.frame.size.height); //可以滚动的大小
                    if (countOfBigPic==0) {
                        [scrollview setContentSize: CGSizeMake(scrollview.frame.size.width, scrollview.frame.size.height)];
                    }
                    
                    scrollview.scrollsToTop = NO;
                    scrollview.delegate=self;
                    scrollview.bounces=    NO;
                    scrollview.directionalLockEnabled = YES;
                    UITapGestureRecognizer * aScrollerGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleBigPictureTapped:)];
                    
                    [scrollview addGestureRecognizer:aScrollerGesture];
                    
                    
                    [cell  addSubview: scrollview] ;
                    
                    
                    UIImageView *imageView1=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 170)];
                    UIImageView *imageView2=[[UIImageView alloc] initWithFrame:CGRectMake(320, 0, 320, 170)];
                    UIImageView *imageView3=[[UIImageView alloc] initWithFrame:CGRectMake(640, 0, 320, 170)];
                    
                    
                    //                cellHLine1=[[CommonObject alloc]init];
                    //                cellHLine2=[[CommonObject alloc]init];
                    //                cellHLine3=[[CommonObject alloc]init];
                    
                    
                    switch (countOfBigPic) {
                        case 0:
                            [imageView1 setImage:[UIImage imageNamed:@"defalut_img_big.png"]];
                            
                            [scrollview addSubview:imageView1];
                            
                            [imageView1 release];
                            
                            break;
                        case 1:
                            cellHLine1=[resultArray objectAtIndex:0];
                            
                            [imageView1 setImageWithURL:[NSURL URLWithString:cellHLine1.img] placeholderImage:[UIImage imageNamed:@"defalut_img_big.png"]];
                            
                            [scrollview addSubview:imageView1];
                            
                            [imageView1 release];
                            
                            break;
                        case 2:
                            cellHLine1=[resultArray objectAtIndex:0];
                            cellHLine2=[resultArray objectAtIndex:1];
                            
                            [imageView1 setImageWithURL:[NSURL URLWithString:cellHLine1.img] placeholderImage:[UIImage imageNamed:@"defalut_img_big.png"]];
                            DebugLog(@"%@",cellHLine1.img);
                            [imageView2 setImageWithURL:[NSURL URLWithString:cellHLine2.img] placeholderImage:[UIImage imageNamed:@"defalut_img_big.png"]];
                            DebugLog(@"%@", cellHLine2.img)
                            
                            [scrollview addSubview:imageView1];
                            [scrollview addSubview:imageView2];
                            
                            [imageView1 release];
                            [imageView2 release];
                            
                            
                            break;
                        case 3:
                            
                            cellHLine1=[resultArray objectAtIndex:0];
                            cellHLine2=[resultArray objectAtIndex:1];
                            cellHLine3=[resultArray objectAtIndex:2];
                            
                            [imageView1 setImageWithURL:[NSURL URLWithString:cellHLine1.img] placeholderImage:[UIImage imageNamed:@"defalut_img_big.png"]];
                            DebugLog(@"%@",cellHLine1.img);
                            [imageView2 setImageWithURL:[NSURL URLWithString:cellHLine2.img] placeholderImage:[UIImage imageNamed:@"defalut_img_big.png"]];
                            DebugLog(@"%@", cellHLine2.img)
                        [imageView3 setImageWithURL:[NSURL URLWithString:cellHLine3.img] placeholderImage:[UIImage  imageNamed: @"defalut_img_big.png"]];
                           DebugLog(@"%@", cellHLine3.img)
                           
                            [scrollview addSubview:imageView1];
                            [scrollview addSubview:imageView2];
                            [scrollview addSubview:imageView3];
                            
                            [imageView1 release];
                            [imageView2 release];
                            [imageView3 release];
                            
                            break;
                            
                        default:
                            break;
                    }
                    
                    
                    
                    
                    
                    [scrollview release];
                    
                    [ViewTool addUIImageView:cell imageName:@"bigblack.png" type:@"" x:0 y:142 x1:320 y1:28].alpha = 0.5;
                    titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 145, 320, 20)];
                    titleLabel.backgroundColor =[UIColor clearColor];
                    titleLabel.textColor = [UIColor whiteColor];
                    titleLabel.numberOfLines = 1;		
                    titleLabel.font=[UIFont fontWithName:@"Helvetica" size:15];
                    if (countOfBigPic>0) {
                        
                        titleLabel.text=cellHLine1.title;
                        
                    }
                    [titleLabel setTextAlignment:UITextAlignmentLeft];
                    titleLabel.font = [UIFont boldSystemFontOfSize:15];
                    
                    [cell addSubview:titleLabel];
                    
                    [ViewTool addUIImageView:cell imageName:@"whiteline@2x.png" type:@"" x:0 y:142 x1:320 y1:.5];      
                    pageController = [[UIPageControl alloc] initWithFrame:CGRectMake(240,142,80,28)];
                    [pageController setNumberOfPages:countOfBigPic];
                    [cell  addSubview:pageController];
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                }
                else {
                    DebugLog(@"%d--->%d",[resultArray count],indexPath.row);
                    //beta2
                    if([resultArray count]>countOfBigPic)
                    {
                        
                        
                        
                        CommonObject *cellHLine = [resultArray objectAtIndex:indexPath.row+countOfBigPic-1];
                        UIImageView *bgimageView = [[UIImageView alloc] initWithFrame:CGRectMake(9, 9, 79, 65)];
                        bgimageView.image = [UIImage imageNamed:@"yinying.png"];
                        [cell addSubview:bgimageView];
                        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 69, 55)];
                        [cell addSubview:imageView];
                        [imageView setContentMode:UIViewContentModeScaleToFill];
                        [imageView release];
                        [imageView.layer setBorderColor:[UIColor whiteColor].CGColor];
                        [imageView.layer setBorderWidth:1.0f];
                        //                    [imageView.layer setShadowColor:[UIColor blackColor].CGColor];
                        //                    [imageView.layer setShadowOffset:CGSizeMake(1.5, 1.5)];
                        //                    [imageView.layer setShadowOpacity:0.6];

                        [imageView setImageWithURL:[NSURL URLWithString:cellHLine.img] placeholderImage:[UIImage imageNamed:@"defalut_img_small.png"]];
                        UILabel *titleLabel = [ViewTool addUILable:cell x:90 y:7 x1:205 y1:20 fontSize:15 lableText:cellHLine.title];
                        if (cellHLine.isReaded) {
                            [titleLabel setTextColor:[UIColor grayColor]];
                        }
                        [titleLabel setHighlightedTextColor:[UIColor whiteColor]];
                        UILabel *subTitleLabel = [ViewTool addUILable:cell x:90 y:32 x1:205 y1:32 fontSize:13 lableText:cellHLine.descrip];
                        [subTitleLabel setHighlightedTextColor:[UIColor whiteColor]];
                        subTitleLabel.textColor = [UIColor grayColor];
                        subTitleLabel.numberOfLines = 2;
                    }
                }
            }
            else if(selectTag==kMoreTag){
                if(indexPath.row<[appDelegate.newsHeaderMoreArray count]){
                    SSLineView *lineView = [[SSLineView alloc] initWithFrame:CGRectMake(0, 54, 320, 2)];
                    [cell addSubview:lineView];
                    [lineView release];
                    newsHeaderObject * tmpObject=[appDelegate.newsHeaderMoreArray objectAtIndex:indexPath.row];
                    cell.textLabel.text=tmpObject.name;
                    [cell setAccessoryView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow.png"]]];
                }else {
                    cell.textLabel.text=@"编辑栏目";
                    [cell.textLabel setTextAlignment:UITextAlignmentCenter];
                }
                
            }
            
            
            //首页 - 焦点、茶座、娱乐、情感
            else {
                
                
                
                SSLineView *lineView = [[SSLineView alloc] initWithFrame:CGRectMake(0, 70, 320, 2)];
                [cell addSubview:lineView];
                [lineView release];
                if ([indexPath row] == [resultArray count] - 1 && [resultArray count] != 1) {
                    UIButton *morebtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 310, 35)];
                    [morebtn setBackgroundImage:[UIImage imageNamed:@"bigmorebtn.png"] forState:UIControlStateNormal];
                    [morebtn addTarget:self action:@selector(loadmoretuisong) forControlEvents:UIControlEventTouchUpInside];
                    [cell addSubview:morebtn];
                    UILabel *moreTiplabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 13, 200, 20)];
                    moreTiplabel.backgroundColor = [UIColor clearColor];
                    moreTiplabel.text = [resultArray  objectAtIndex:[resultArray count] - 1];//此处崩溃
                    moreTiplabel.textAlignment = UITextAlignmentCenter;
                    [cell addSubview:moreTiplabel];
                    
                }//更多
                
                else {
                    //DebugLog(@"%d--->%d",[resultArray count],indexPath.row);
                    //beta2
                    if([resultArray count]>1)
                    {
                        
                        CommonObject *cellHLine = [resultArray objectAtIndex:indexPath.row];
                        UIImageView *bgimageView = [[UIImageView alloc] initWithFrame:CGRectMake(9, 9, 79, 65)];
                        bgimageView.image = [UIImage imageNamed:@"yinying.png"];
                        [cell addSubview:bgimageView];
                        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 69, 55)];
                        [cell addSubview:imageView];
                        
                        [imageView setContentMode:UIViewContentModeScaleToFill];
                        [imageView release];
                        [imageView.layer setBorderColor:[UIColor whiteColor].CGColor];
                        [imageView.layer setBorderWidth:1.0f];
//                        [imageView.layer setShadowColor:[UIColor blackColor].CGColor];
//                        [imageView.layer setShadowOffset:CGSizeMake(1.5, 1.5)];
//                        [imageView.layer setShadowOpacity:0.6];
                        [imageView setImageWithURL:[NSURL URLWithString:cellHLine.img] placeholderImage:[UIImage imageNamed:@"defalut_img_small.png"]];
                        UILabel *titleLabel = [ViewTool addUILable:cell x:90 y:7 x1:205 y1:20 fontSize:15 lableText:cellHLine.title];
                        if (cellHLine.isReaded) {
                            [titleLabel setTextColor:[UIColor grayColor]];
                        }
                        [titleLabel setHighlightedTextColor:[UIColor whiteColor]];
                        UILabel *subTitleLabel = [ViewTool addUILable:cell x:90 y:32 x1:205 y1:32 fontSize:13 lableText:cellHLine.descrip];
                        [subTitleLabel setHighlightedTextColor:[UIColor whiteColor]];
                        subTitleLabel.textColor = [UIColor grayColor];
                        subTitleLabel.numberOfLines = 2;
                    }
                }
                
                
                
                
            }
            
            
            
            
            if (!(selectTag == kHeadLineTag && indexPath.row == 0) && [indexPath row] != [resultArray count] - 1 && !(selectTag==kMoreTag)) {
                [cell setAccessoryView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow.png"]]];
            }
        }
    }else {
        if (indexPath.row == [resultDiscuzArray count]) {
            if(cell == nil){
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
                UIButton *morebtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 310, 35)];
                [morebtn setBackgroundImage:[UIImage imageNamed:@"bigmorebtn.png"] forState:UIControlStateNormal];
                [morebtn addTarget:self action:@selector(loadmorediscuz) forControlEvents:UIControlEventTouchUpInside];
                [cell addSubview:morebtn];
                UILabel *moreTiplabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 13, 200, 20)];
                moreTiplabel.backgroundColor = [UIColor clearColor];
                moreTiplabel.text = moreTip;
                moreTiplabel.textAlignment = UITextAlignmentCenter;
                [cell addSubview:moreTiplabel];
            }
        }else{
        //    more detailcontroller
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        
        SSLineView *lineView = [[SSLineView alloc] initWithFrame:CGRectMake(0, 50, 320, 2)];
        [cell addSubview:lineView];
        [lineView release];
        CommonObject *cellObject = [resultDiscuzArray objectAtIndex:indexPath.row];
        UILabel *titleLabel = [ViewTool addUILable:cell x:25 y:7 x1:270 y1:20 fontSize:15 lableText:cellObject.title];//帖子标题
        [titleLabel setTag:1999];
        if (cellObject.isReaded) {
            [titleLabel setTextColor:[UIColor grayColor]];
        }
        else {
            UIImageView *pointView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cycle.png"]];
            [pointView setFrame:CGRectMake(7, 21, 8, 8)];
            [cell addSubview:pointView];
            [pointView setTag:1998];
            [pointView release];
        }
        [ViewTool addUILable:cell x:25 y:30 x1:95 y1:13 fontSize:11 lableText:cellObject.author].textColor = [UIColor colorWithRed:0.169 green:0.345 blue:0.839 alpha:1.000];//发帖者昵称
        
        //start
        //回复图标
        UIImageView *replyView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"huifu.png"]];
        [replyView setFrame:CGRectMake(105, 30, 12, 12)];
        [replyView setTag:997];
        [cell addSubview:replyView];
        [replyView release];
        
        //浏览图标
        UIImageView *viewView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"kan.png"]];
        [viewView setFrame:CGRectMake(160, 30, 12, 12)];
        [viewView setTag:997];
        [cell addSubview:viewView];
        [viewView release];            
        
        //回复数
        [ViewTool addUILable:cell x:120 y:30 x1:150 y1:13 fontSize:11 lableText:[NSString stringWithFormat:@"%d",cellObject.replies]];            
        //浏览数
        [ViewTool addUILable:cell x:175 y:30 x1:150 y1:13 fontSize:11 lableText:[NSString stringWithFormat:@"%d",cellObject.views]];
        //end    
        
        //    [ViewTool addUILable:cell x:115 y:30 x1:150 y1:13 fontSize:11 lableText:[NSString stringWithFormat:@"回复/浏览: %d/%d",cellObject.replies,cellObject.views]];//帖子流量回复
        [ViewTool addUILable:cell x:210 y:30 x1:85 y1:13 fontSize:11 lableText:cellObject.postdate].textAlignment = UITextAlignmentRight;//帖子发布时间
        
        
        }
        
    }
    return cell;
}
- (void)loadmoretoutiao
{
    if(![[resultArray objectAtIndex:[resultArray count] - 1] isEqualToString:@"已无更多内容"]) 
        
        
        pageNum++;
    
    isMore = YES;
    [self loadmore];
}
- (void)loadmoretuisong
{
    if(![[resultArray objectAtIndex:[resultArray count] - 1] isEqualToString:@"已无更多内容"]) 
        
        
        pageNum++;
    
    isMore = YES;
    [self loadmore];
}
- (void)loadmorediscuz
{
    pageNum++;
    
    isMore = YES;
    [self loadmore];
}
- (void)loadmore
{
    switch (selectTag) {
		case kHeadLineTag:{
            forumOrderButton.hidden = YES;
            orderButton.hidden = NO;
			requestURL = _newsHeadLineRequestURLWithPage(pageNum);
            numberPageUnderHeadBigPicture=-1;
			if (!isMore) {			
                [resultArray removeAllObjects];
                [tableView reloadData];
                numberPageUnderHeadBigPicture=pageNum;
                //头条大图 先下载
				ASIHTTPRequest *head = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@topiclist.php?type=top&pageno=1&pagesize=3",_customDomainandPathVeryNC]]];
                DebugLog(@"-head------%@",[NSString stringWithFormat:@"%@topiclist.php?type=top&pageno=1&pagesize=3",_customDomainandPathVeryNC]);
				[head setDownloadCache:[ASIDownloadCache sharedCache]];
                [head setPersistentConnectionTimeoutSeconds:_timeOut];
                [head setTag:kHeadLineBigPictureTag];
                [head setDelegate:self];
                [self cancelAllASICall];
				[head startAsynchronous];
                
                return;
                
                /*
                 
                 [head startSynchronous];
                 
                 
                 NSString *requestString = [head responseString];
                 DebugLog(@"requestString------head,%@",requestString);
                 NSArray *tmpArray = [[requestString JSONValue] valueForKey:@"datas"];
                 
                 if ([tmpArray count]<3) {
                 countOfBigPic=[tmpArray count];
                 }else {
                 countOfBigPic=3;
                 }
                 if ([tmpArray count]>0) {
                 for (int i=0; i<[tmpArray count]; i++) {
                 
                 CommonObject *tmpHLine =  [[CommonObject alloc] init];
                 tmpHLine.img = [[tmpArray objectAtIndex:i] valueForKey:@"pic"];
                 
                 tmpHLine.tid = [[[tmpArray objectAtIndex:i] valueForKey:@"id"] intValue];
                 
                 NSString *tmpString = [[tmpArray objectAtIndex:i] valueForKey:@"title"];
                 if (tmpString.length > 17) {
                 tmpHLine.title = [tmpString substringToIndex:17];
                 } else {
                 tmpHLine.title = tmpString;
                 }
                 
                 
                 
                 //tmpHLine.url = [[tmpArray objectAtIndex:0] valueForKey:@"url"];
                 //tmpHLine.author = [[tmpArray objectAtIndex:0] valueForKey:@"author"];
                 if (i<3) {
                 [resultArray insertObject:tmpHLine atIndex:i];
                 
                 }
                 
                 [tmpHLine release];
                 }
                 cellHLine1=[resultArray objectAtIndex:0];
                 cellHLine2=[resultArray objectAtIndex:1];
                 cellHLine3=[resultArray objectAtIndex:2];
                 DebugLog(@"resultArray--PRESS---1-%@       2-----------:%@      3----------%@",cellHLine1.img,cellHLine2.img,cellHLine3.img);   
                 } 
                 */
                
                
			}
			break;
		}
		case kTeaBowlTag:{
            forumOrderButton.hidden = YES;
            orderButton.hidden = NO;
			requestURL =_newskTeaBowlRequestURLWithPage(pageNum);
			break;
		}
            
		case kFocusTag:{
            forumOrderButton.hidden = YES;
            orderButton.hidden = NO;
			requestURL =_newskFocuslRequestURLWithPage(pageNum);
			break;
		}
		case kEntertainmentTag:{
            forumOrderButton.hidden = YES;
            orderButton.hidden = NO;
			requestURL = _newskEntertainmentRequestURLWithPage(pageNum);
			break;
		}
		case kEmotionTag:{
            forumOrderButton.hidden = YES;
            orderButton.hidden = NO;
			requestURL =_newskEmotionRequestURLWithPage(pageNum);
			break;
		}
            
        case kMoreTag:{
            forumOrderButton.hidden = YES;
            orderButton.hidden = NO;
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *nowlogin_filePath = [documentsDirectory stringByAppendingPathComponent:@"nowlogin.plist"];
            
            if([self checkIfHasLogIn])
                
            {
                
                
                NSDictionary *now = [NSKeyedUnarchiver unarchiveObjectWithFile:nowlogin_filePath];
                NSString *uid  = [now objectForKey:@"uid"];
                
                
                requestURL = kForumsRequestURLWithPage(uid);
            }
            
            else {
                requestURL = kForumsRequestURLWithPageWithoutUID ;
                
            }
            break;
        }
            
		default:/// others board
            forumOrderButton.hidden = NO;
            discuzTag=YES;
			requestURL = kListRequestURLWithPage(selectTag,pageNum);
            
            break;
            
            
	}
    for (ASIHTTPRequest *request in ASIHTTPRequest.sharedQueue.operations)
    {
        [request cancel];
        [request setDelegate:nil];
    } 
    
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:requestURL]];
	[request setTag:selectTag];
	[request setDownloadCache:[ASIDownloadCache sharedCache]];
    
	[request setDelegate:self];
    
    [self cancelAllASICall];
    [request startAsynchronous];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ((selectTag<=1000004 && selectTag >= 1000000 )|| selectTag==1000011) {
        if (selectTag == kHeadLineTag) {
            if ([indexPath row] == 0) {
                return 170;
            }
            else return 71;
        }
        else if(selectTag ==kMoreTag){
            
            return 55;
            
        }
        return 71;
    }else {
        //    more detailcontroller
        
        
        return 50;
    }
}






-(void)tableView:(UITableView *)_tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{        
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if ((selectTag<=1000004 && selectTag >= 1000000 )|| selectTag==1000011) {    
        
        
        if (selectTag == kHeadLineTag) {
            DebugLog(@"(%d %d)",[resultArray count],countOfBigPic);
            if ([indexPath row] ==[resultArray count]-countOfBigPic) {
                
 
                
//                if(![[resultArray objectAtIndex:[resultArray count] - 1] isEqualToString:@"已无更多内容"]) 
//          
//                
//                pageNum++;
//                
//                
//                [moreBtn setTag:selectTag];
//                if(selectTag==0)_isHead=true;
//                
//                [self pressMenu:moreBtn More:YES];
            }
            else {
                orderButton.hidden = YES;
                CommonObject *selectCell ;
                 
             
                        
                if (indexPath.row==0) {
                    //if([resultArray count]<=indexOfBigPic+1)//robust
                    //{
                    
                        selectCell = [resultArray objectAtIndex:indexOfBigPic];
                    //}
                    
                }else {
                    //if([resultArray count]<=indexPath.row+countOfBigPic)//robust
                    //{
                    selectCell = [resultArray objectAtIndex:indexPath.row+countOfBigPic-1];
                    //}
                }
       
                
                ReaderController *reader = [[ReaderController alloc] init];
                 
                selectCell.isReaded = YES;
                reader.Title = [selectCell title];
                reader.tid = [selectCell tid];
                reader.isclosed = [selectCell isclosed];
                NSUserDefaults *tmpUserDefaults = [NSUserDefaults standardUserDefaults];
                [tmpUserDefaults setBool:YES forKey:[NSString stringWithFormat:@"%d",selectCell.tid]];
                
                DebugLog(@"%d",selectCell.tid);
                DebugLog(@"%d",selectCell.fid);
                
                reader.fid=-1;
                
                reader.tid=selectCell.tid;
                [tmpUserDefaults synchronize];
                [reader setHidesBottomBarWhenPushed:YES];
                [myDelegate hideImage];
                [self.navigationController pushViewController:reader animated:YES];
                [reader release];
            }
        }else if (selectTag==kMoreTag) {
            DebugLog(@"-3");
            if (indexPath.row==[appDelegate.newsHeaderMoreArray count]) {//aaa
                orderButton.hidden = YES;
                editTableViewController * edit=[[editTableViewController alloc]initWithNibName:@"editTableViewController" bundle:nil];
                [self.navigationController pushViewController:edit animated:YES];
                [edit release];
            }else {
                orderButton.hidden=YES;
                DebugLog(@"-3");
                
                newsHeaderObject * a=[appDelegate.newsHeaderMoreArray objectAtIndex:indexPath.row];
                
                //            ColumnList *selectList = [resultArray objectAtIndex:indexPath.section];
                DetailController *detail = [[DetailController alloc] init];
                detail.fidSubArray=nil;
                detail.namesSubArray=nil;
                //            detail.fidSubArray=[[selectList.fidArray objectAtIndex:indexPath.row] objectAtIndex:1];
                //            detail.namesSubArray=[[selectList.nameArray objectAtIndex:indexPath.row]objectAtIndex:1];
                detail.fid = [a.tag intValue];
                detail.ftitle =a.name;
                [detail setHidesBottomBarWhenPushed:YES];
                [myDelegate hideImage];
                [self.navigationController pushViewController:detail animated:YES];
                [detail release];
                
                
            }
            
            
            
        }else {
            
            DebugLog(@"-4");
            
            
            if ([indexPath row] ==[resultArray count]-1) {
                
                
//                if(![[resultArray objectAtIndex:[resultArray count] - 1] isEqualToString:@"已无更多内容"]) 
//                  
//                
//                pageNum++;
//                
//                
//                [moreBtn setTag:selectTag];
//                if(selectTag==0)_isHead=true;
//                
//                [self pressMenu:moreBtn More:YES];
            }
            else {
                orderButton.hidden = YES;
                
                CommonObject *selectCell = [resultArray objectAtIndex:indexPath.row];
                
                ReaderController *reader = [[ReaderController alloc] init];
               
                selectCell.isReaded = YES;
                reader.Title = [selectCell title];
                reader.tid = [selectCell tid];
                reader.isclosed = [selectCell isclosed];
                
                NSUserDefaults *tmpUserDefaults = [NSUserDefaults standardUserDefaults];
                [tmpUserDefaults setBool:YES forKey:[NSString stringWithFormat:@"%d",selectCell.tid]];
                
                DebugLog(@"%d",selectCell.tid);
                DebugLog(@"%d",selectCell.fid);
                reader.fid=-1;
                
                reader.tid=selectCell.tid;
                [tmpUserDefaults synchronize];
                [reader setHidesBottomBarWhenPushed:YES];
                [myDelegate hideImage];
                [self.navigationController pushViewController:reader animated:YES];
                [reader release];
            }
            
            
        }
        
    }else {
        if(indexPath.row == [resultDiscuzArray count]){
//            pageNum++;
//            
//            
//            [moreBtn setTag:selectTag];
//            
//            [self pressMenu:moreBtn More:YES];
        }else{
            //    more detailController
            DebugLog(@"-5");
            
            //  [_tableView deselectRowAtIndexPath:indexPath animated:YES];
            CommonObject *selectCell = [resultDiscuzArray objectAtIndex:indexPath.row];
            ReaderController *reader = [[ReaderController alloc] init];
            reader.isFromDetail=true;
            selectCell.isReaded = YES;
            reader.Title = [selectCell title];
            reader.tid = [selectCell tid];
            reader.isclosed = [selectCell isclosed];
            //beta2
            reader.fid=selectTag;
            //      NSLog(@"---%d",[resultDiscuzArray count]);
            //NSLog(@"---%d",[resultArray count]);
            
            
            
            NSUserDefaults *tmpUserDefaults = [NSUserDefaults standardUserDefaults];
            [tmpUserDefaults setBool:YES forKey:[NSString stringWithFormat:@"%d",selectCell.tid]];
            [tmpUserDefaults synchronize];
            [reader setHidesBottomBarWhenPushed:YES];
            orderButton.hidden =YES;
            [myDelegate hideImage];
            //    loadingReader = TRUE;
            [self.navigationController pushViewController:reader animated:YES];
            
            
            
            
            [reader release];
        }
    }
}

#pragma mark -UIScrollViewDelegate


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
    
    if (scrollView.tag=10) {
        
        
        if (_scrollView.contentOffset.x < (_scrollView.contentSize.width-self.view.frame.size.width)) {
            
            //    右边边 图标
            [overflowRightView setFrame:CGRectMake(self.view.frame.size.width+_scrollView.contentOffset.x-20 , 0, 20,32 )];
            overflowRightView.hidden=NO;
            
            
        } else {
            
            overflowRightView.hidden=YES;
            
            
            
        }
        if (_scrollView.contentOffset.x > 0) {
            //    左边 图标 
            [overflowLeftView setFrame:CGRectMake(_scrollView.contentOffset.x,0, 20,32 )];
            overflowLeftView.hidden=NO;
            
            
        } else {
            overflowLeftView.hidden=YES;
            
            
            
        }
        
        
    }
    
    
    
}

//滑动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    if (scrollView.frame.size.height==170.0000) {
        int index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;//当前是第几个视图
        pageController.currentPage = index;
        indexOfBigPic=index;
        
        if (countOfBigPic==0) {
            titleLabel.text=@"";
        }else {
            
            switch (indexOfBigPic) {
                case 0:
                    titleLabel.text=cellHLine1.title;
                    break;
                case 1:
                    titleLabel.text=cellHLine2.title;
                    break;
                    
                case 2:
                    titleLabel.text=cellHLine3.title;
                    break;
                    
                default:
                    break;
            }
        }
        
    }
    
}




-(void)handleBigPictureTapped:(UITapGestureRecognizer *)gestureRecognizer{
    
    
    orderButton.hidden = YES;
    CommonObject *selectCell = [resultArray objectAtIndex:indexOfBigPic];
    ReaderController *reader = [[ReaderController alloc] init];
 
    selectCell.isReaded = YES;
    reader.Title = [selectCell title];
    reader.tid = [selectCell tid];
    reader.isclosed = [selectCell isclosed];
    NSUserDefaults *tmpUserDefaults = [NSUserDefaults standardUserDefaults];
    [tmpUserDefaults setBool:YES forKey:[NSString stringWithFormat:@"%d",selectCell.tid]];
    
    DebugLog(@"%d",selectCell.tid);
    DebugLog(@"%d",selectCell.fid);
    reader.fid=-1;
    
    reader.tid=selectCell.tid;
    [tmpUserDefaults synchronize];
    [reader setHidesBottomBarWhenPushed:YES];
    [myDelegate hideImage];
    [self.navigationController pushViewController:reader animated:YES];
    [reader release];
    
    
    
    
    
    
    
}






@end
