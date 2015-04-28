//
//  DetailController.m
//  化龙巷
//
//  Created by Kryhear on 12-3-8.
//  Copyright (c) 2012年 Osugroup. All rights reserved.
//

#import "DetailController.h"
#import "ReaderController.h"
#import "AppDelegate.h"
#import "subBBSViewController.h"
#import "WEPopoverController.h"
#import "WEPopoverThreadOrderViewController.h"
#define _space 25
#define _left 20


#define kListRequestURLWithPage(x) [NSString stringWithFormat:@"%@topiclist.php?type=thread_list&fid=%d&pageno=%d&pagesize=20&uid=",myDomainAndPathVeryNC,self.fid,x]
#define kTopRequestURLWithPage(x) [NSString stringWithFormat:@"%@topiclist.php?type=top_thread&fid=%d&pageno=%d&pagesize=20",myDomainAndPathVeryNC,self.fid,x]
#define kBestRequestURLWithPage(x) [NSString stringWithFormat:@"%@topiclist.php?type=digest_thread&fid=%d&pageno=%d&pagesize=20",myDomainAndPathVeryNC,self.fid,x]
#define kSearchRequestURLWithPage(key,x) [NSString stringWithFormat:@"%@topiclist.php?type=search_thread&fid=%d&keyword=%@&pageno=%d&pagesize=20",myDomainAndPathVeryNC,self.fid,key,x]




#define kDummyTag 99
#define kListTag 100
#define kTopTag 101
#define kBestTag 102
#define kSearchTag 103



#define kDefaultTag 200
#define kMasterTag 201
#define kLastCommentTag 202

#define kHomePageTag 300
#define kPrevPageTag 301
#define kNextPageTag 302
#define kLastPageTag 303

#define kFavoriteTag 304

@implementation DetailController

@synthesize myDelegate;
@synthesize appDelegate;
 
@synthesize favoriteButton;
@synthesize fid, ftitle;
@synthesize myDomainAndPathVeryNC;
@synthesize fidSubArray,namesSubArray,orderButton,popoverOrderController,ordertype,selectSubTag;

-(void)viewDidAppear:(BOOL)animated {
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:[tableView indexPathForSelectedRow]];
	UILabel *titleLabel = (UILabel *)[cell viewWithTag:1999];
	[titleLabel setTextColor:[UIColor grayColor]];
	UIImageView *pointView = (UIImageView *)[cell viewWithTag:1998];
	[pointView removeFromSuperview];
	[tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}

-(bool)checkIfHasRightToPost:(NSInteger)temfid;
{
    //  fid（板块ID）、ispost（0不可以发帖1可以发帖）、isreply（0不可以回帖1可以回帖）、ispostimage（0不能带图片1可以带图片）
    
    
    //  fid（板块ID）、ispost（0不可以发帖1可以发帖）、isreply（0不可以回帖1可以回帖）、ispostimage（0不能带图片1可以带图片）
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; 
    
    
    NSArray *forumlist_array;
    
    
    
    NSString *forumlist_filePath = [documentsDirectory stringByAppendingPathComponent:@"forumlist.plist"];
        NSFileManager* fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:[documentsDirectory stringByAppendingPathComponent:@"forumlist.plist"] isDirectory:NULL]) 
    {
        
        return false;
        
    }
    forumlist_array =[NSKeyedUnarchiver unarchiveObjectWithFile:forumlist_filePath];
    
    for (int i=0;i<[forumlist_array count]; i++ ) {
        DebugLog(@"%@      000       %@",[[forumlist_array objectAtIndex:i] objectForKey:@"fid"] ,[[forumlist_array objectAtIndex:i] objectForKey:@"ispost"] );
        
        NSInteger tfid=[[[forumlist_array objectAtIndex:i] objectForKey:@"fid"] intValue];
        if (temfid==tfid) {
            
            NSInteger tispost=[[[forumlist_array objectAtIndex:i] objectForKey:@"ispost"] intValue];
            if(tispost==0)
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
    NSFileManager* fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:[documentsDirectory stringByAppendingPathComponent:@"forumlist.plist"] isDirectory:NULL]) 
    {
        
        return false;
        
    }
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

-(void)viewWillDisappear:(BOOL)animated {
    
    orderButton.hidden = YES;
 
    for (ASIHTTPRequest *request in ASIHTTPRequest.sharedQueue.operations)
    {
        if (loadingReader == TRUE) {
            loadingReader = FALSE;
        } else {
            
            
            [request cancel];
  
            [request setDelegate:nil];
            
        }
        
    }
    

}
-(void)viewWillAppear:(BOOL)animated {
    
    orderButton.hidden = NO;
    
    DebugLog(@"selectSubTag  %d",selectSubTag);
    DebugLog(@"selectTag---%d",selectTag);
    DebugLog(@"pageNum---%d",pageNum);
  
    
    /*
     [UIView animateWithDuration:0.1 animations:^{
     for (int i = 0; i < [((CustomTabBar *)self.tabBarController).buttons count]; i++) {
     UIButton *btn = [((CustomTabBar *)self.tabBarController).buttons objectAtIndex:i];
     [btn setFrame:CGRectMake(btn.frame.size.width*i, self.tabBarController.tabBar.frame.origin.y, btn.frame.size.width, btn.frame.size.height)];
     [btn setHidden:false]; }
     UIView *slideView = ((CustomTabBar *)self.tabBarController).slideBg;
     
     [slideView setAlpha:1.0];
     
     [slideView setHidden:false];
     }]; 
     */

    
    
    
    UIBarButtonItem *barButton;
    
    if([self checkIfHasLogIn])   
    { 
        if([self checkIfHasRightToPost:fid])
        {
            
            barButton= self.navigationItem.rightBarButtonItem ;
            //barButton.image = [UIImage imageNamed:@"newThread.png"];
            barButton.title = @"发帖";
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
    

    
    if(exceptionTag){
        
        if([fidSubArray count]>0){
            DebugLog(@"selectBeforeSub--------%d",selectBeforeSub);
            [self pressMenu:[btnSubArray objectAtIndex:selectBeforeSub-99] More:NO];
            
        }else {
            
            [self pressMenu:[btnArray objectAtIndex:selectTag-100]More:NO];
            
        }
    }
    exceptionTag=YES;
    
    
    
  
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{   
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)reloadDetailNotification:(NSNotification *)notification;
{
    
    [resultArray removeAllObjects];
    [tableView reloadData];
    
    
    //    DebugLog(@"%d",[btnArray count]);
    //    [self pressMenu:[btnArray objectAtIndex:0] More:NO];
    
    if ([fidSubArray count]>0) {
        [self pressMenu:[btnSubArray objectAtIndex:0]More:NO];
        
    }else {
        [self pressMenu:[btnArray objectAtIndex:0] More:NO]; 
    }
    
    
    
    
    
}
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"notifyToReloadDetailNotification" object:nil];
    
     
    
 
    [btnArray release];
	btnArray = nil;
    
    [btnSubArray release];
	btnSubArray = nil;
    
 
    [ftitle release];;
    
    
    [ fidSubArray release];
    fidSubArray=nil;
    [namesSubArray release];
    namesSubArray=nil;
    [resultArray release];
    
    resultArray=nil;
    
 //   [favoriteButton release];
    
    [myDomainAndPathVeryNC release];
    
 
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView
 {
 }
 */
-(void)gotoLogin:(id)sender;// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.

{ 
    
    
}
-(void)tapBarItemButton:(id)sender;// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.

{ 
    if([self checkIfHasLogIn])
    {
        
        
        
        NewPostViewController	*temController= [[NewPostViewController	 alloc]initWithNibName:@"NewPostViewController" bundle:nil];
   
        temController.fid=fid;
        [self.navigationController pushViewController:temController animated:YES];
        
   
        [temController release];
        

    }
    else {
        
        MoreAccountViewController	*temController= [[MoreAccountViewController alloc]initWithNibName:@"MoreAccountViewController" bundle:nil]  ;
        
        
        [self.navigationController  pushViewController:temController animated:YES];
        

        [temController release];
        
    }
    
}


- (void)pressPageBtn:(UIBarButtonItem *)sender {
    DebugLog(@"pressPageBtn");
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
		case kFavoriteTag:
		{
			isChange = YES;
            if([self isFavorite:fid])
            {
                NSString *sql = [NSString stringWithFormat:@"INSERT INTO Favourite VALUES(%d,'%@' )",fid,self.ftitle];
                
                DebugLog(@"SQL : %@",sql);
                [SqliteSet InsertFavouriteItem:sql];
                return;
            }
			break;
		}	
		default:
			break;
	}
    
    
	if (isChange) {
        
		[resultArray removeAllObjects];
		[tableView reloadData];
        DebugLog(@"button array count---1--count:%d     fid: %d     selectag %d",[btnArray count],fid,selectTag);
		//[self pressMenu:[btnArray objectAtIndex:selectTag-300] More:NO];
        //	[self pressMenu:[btnArray objectAtIndex:selectTag-200] More:NO];
        if ([fidSubArray count]>0) {
            
            [self pressMenu:[btnSubArray objectAtIndex:selectSubTag-99] More:NO];
            
        }else {
            [self pressMenu:[btnArray objectAtIndex:selectTag-100] More:NO];
        }
	}
    
    
}

-(void)favouriteButtonClicked:(id)sender;
{
    
    
    if(![self isFavorite:fid])
    {
        
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO Favourite VALUES(%d,'%@' )",fid,self.ftitle];
        
        DebugLog(@"SQL : %@",sql);
        [SqliteSet InsertFavouriteItem:sql];
        
        
        [favoriteButton setImage:[UIImage imageNamed:@"fav.png"] forState:UIControlStateNormal];
        
        
    }
    else
    {
        
        
        
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM Favourite where Fid=%d  ",fid ];
        
        DebugLog(@"SQL : %@",sql);
        [SqliteSet deleteFavouriteItem:sql];
        
        [favoriteButton setImage:[UIImage imageNamed:@"unfav.png"] forState:UIControlStateNormal];
        
        
        
    }    
    
    [[NSNotificationCenter defaultCenter] postNotificationName: @"notifyToRefreshFavoriteNotification"
                                                        object: nil];
}

-(bool)isFavorite:(NSInteger) fid;
{
    
    return [SqliteSet queryFavouriteAItem :[NSString stringWithFormat:@"%d",fid]]; ;
    
}

- (void)viewDidLoad
{   
    
    [self setMyDelegate:self.tabBarController]; 
    
    appDelegate=( AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    //NSLog(@"%@",appDelegate.quoteImageURL);
    //NSLog(@"%@", myDelegate);
    //DebugLog(@"%d",fid);
    loadingReader = FALSE;
    selectTag=100;
    selectSubTag=99;
    
    exceptionTag=NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadDetailNotification:) name:@"notifyToReloadDetailNotification" object:nil];
    
    
    
    myDomainAndPathVeryNC = appDelegate.myDomainAndPathVeryNC;
    
	[[self navigationItem] setTitle:self.ftitle];
    
    resultArray = [[NSMutableArray alloc] init];
    btnArray = [[NSMutableArray alloc] init];
    btnSubArray=[[NSMutableArray alloc]init];
 
    ordertype = nil;
	pageNum = 1;
	nowpagenum = 1;
    moreTip = @"显示下20条";
    
	UIImageView *menuBack = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menuback.png"]];
	[[self view] addSubview:menuBack];
	[menuBack release];
	
	
	selectView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navi.png"]];
	[selectView setFrame:CGRectMake(_left, 5, 77, 23)];
	[selectView.layer setMasksToBounds:YES];
	[selectView.layer setCornerRadius:4.0];
	[[self view] addSubview:selectView];
	[selectView release];
 
    //排序按钮
    orderButton = [[UIButton alloc] initWithFrame:CGRectMake(230, 10, 23, 23)];
    [orderButton addTarget:self action:@selector(orderButtonPress:) forControlEvents:UIControlEventTouchUpInside];    
    
    UIImage *backgroundImage = [[UIImage imageNamed:@"sort.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:0];
    
    [orderButton setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    [self.navigationController.navigationBar addSubview:orderButton];    
    [orderButton release];
    
    if ([fidSubArray count]>0){
        NSArray *btnSubTitleArray = [NSArray arrayWithObjects:@"全部", @"子板",@"置顶", @"精华",  nil];
        for (int i = 0; i < [btnSubTitleArray count]; i++) {
            UIButton *menuBtn = [[UIButton alloc] initWithFrame:CGRectMake(_left + _space*i+52*i , 5, 52, 23)];
            [menuBtn setTitle:[btnSubTitleArray objectAtIndex:i] forState:UIControlStateNormal];
            [menuBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [menuBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [menuBtn setTag:kDummyTag + i];
            [menuBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
            [menuBtn addTarget:self action:@selector(pressMenu:) forControlEvents:64];
            [[self view] addSubview:menuBtn];
   
            [btnSubArray addObject:menuBtn];
            [menuBtn release];
        }
        
    }else {
        
        NSArray *btnTitleArray ;
        btnTitleArray = [NSArray arrayWithObjects:@"全部", @"置顶", @"精华",  nil];
        for (int i = 0; i < [btnTitleArray count]; i++) {
            UIButton *menuBtn = [[UIButton alloc] initWithFrame:CGRectMake(_left + _space*i+77*i , 5, 77, 23)];
            [menuBtn setTitle:[btnTitleArray objectAtIndex:i] forState:UIControlStateNormal];
            [menuBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [menuBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [menuBtn setTag:kListTag + i];
            [menuBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
            [menuBtn addTarget:self action:@selector(pressMenu:) forControlEvents:64];
            [[self view] addSubview:menuBtn];
 
            [btnArray addObject:menuBtn];
            [menuBtn release];
        }
    }
    
	tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 32, 320, 384) style:UITableViewStylePlain];
	[tableView setDelegate:self];
	[tableView setDataSource:self];
	[self.view addSubview:tableView];
	[tableView setSeparatorColor:[UIColor clearColor]];
	[tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
	[tableView setBackgroundColor:[UIColor colorWithRed:0.922 green:0.922 blue:0.922 alpha:1.000]];
	[tableView release];
    
    DebugLog(@"btnArray---%@",btnArray);
    DebugLog(@"btnSubArray-------%@",btnSubArray);
    
    if ([fidSubArray count]>0) {
        
        [self pressMenu:[btnSubArray objectAtIndex:0] More:NO];
        
    }else {
        
        [self pressMenu:[btnArray objectAtIndex:0] More:NO];
        
    }
    
	
    
    
    
    
    
    
    
    
    
    /*
  
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 368, 320, 48)];
    
    [toolBar setBarStyle:UIBarStyleBlack];
    [toolBar setTintColor:[UIColor blackColor]];
    UIBarButtonItem *homePage = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"home.png"] style:UIBarButtonItemStyleDone target:self action:@selector(pressPageBtn:)];
    [homePage setTag:kHomePageTag];  
    UIBarButtonItem *prevPage = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"pre.png"] style:UIBarButtonItemStyleDone target:self action:@selector(pressPageBtn:)];
    [prevPage setTag:kPrevPageTag]; 
    UIBarButtonItem *nextPage = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"next.png"] style:UIBarButtonItemStyleDone target:self action:@selector(pressPageBtn:)];
    [nextPage setTag:kNextPageTag]; 
    
    
    
    UIBarButtonItem *lastPage = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"right.png"] style:UIBarButtonItemStyleDone target:self action:@selector(pressPageBtn:)];
    [lastPage setTag:kLastPageTag]; 
    
    
    
    
    
    UIBarButtonItem *favoritePage;
 
    
    
    //-----------------------------
    
    
    UIButton *favButton = [[UIButton alloc] init];
    favoriteButton=favButton;
    bool b=[self isFavorite:fid];
    if(b )
    {
        
        [favButton setImage:[UIImage imageNamed:@"fav.png"] forState:UIControlStateNormal];
    }
    else
    {
        
        [favButton setImage:[UIImage imageNamed:@"unfav.png"] forState:UIControlStateNormal];
    }
    [favButton addTarget:self action:@selector(favouriteButtonClicked:)
        forControlEvents:UIControlEventTouchUpInside];
    [favButton setFrame:CGRectMake(0, 0, 49, 30)];
    
    favoritePage = [[UIBarButtonItem alloc]
                    initWithCustomView:favButton ];
     
        
    [favButton release];
    
    [favoritePage setTag:kFavoriteTag]; 
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace  target:self action:nil];
    
    
    btnSpace.width = 3;
    
    UIBarButtonItem * btnSpace1 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace  target:self action:nil];
    //[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
     btnSpace1.width = 100;
  pageNumLabel = [ViewTool addUILable:toolBar x:50 y:14 x1:160 y1:20 fontSize:14 lableText:[NSString stringWithFormat:@"%d/%d",pageNum,maxPage]];
      
    [pageNumLabel setTextAlignment:UITextAlignmentCenter];
    [pageNumLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [pageNumLabel setTextColor:[UIColor whiteColor]];
 
    //btnSpace,
    
    [toolBar setItems:[NSArray arrayWithObjects:homePage,  prevPage, btnSpace1,  nextPage,  lastPage,   favoritePage,nil]];
    [self.view addSubview:toolBar];
    
 
    [homePage release];
    [btnSpace release];
    [prevPage release];
    [btnSpace1 release];
    [nextPage release];
    [lastPage release];
    [favoritePage release];
    
    [toolBar release];
   */
    
//    UIBarButtonItem *barButton=
//    [[UIBarButtonItem alloc] initWithTitle:@""
//                                     style:UIBarButtonItemStyleBordered
//                                    target:self
//                                    action:@selector(tapBarItemButton:)];
//    
//    self.navigationItem.rightBarButtonItem = barButton;
//    [barButton release];
    
    if (_refreshHeaderView == nil) {
		
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - tableView.bounds.size.height, self.view.frame.size.width, tableView.bounds.size.height)];
		view.delegate = self;
		[tableView addSubview:view];
		_refreshHeaderView = view;
		[view release];
		
	}
    
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(threadlistreload:) name:@"notifyToDetailThreadListReload" object:nil];
}






- (void)orderButtonPress:(id)sender;
{
    
    //UIViewController
    WEPopoverThreadOrderViewController *contentViewController = [[WEPopoverThreadOrderViewController  alloc] initWithStyle:UITableViewStylePlain];
    contentViewController.funcname = @"forum";
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


- (void)threadlistreload:(NSNotification *)notification{
    
    //加载中
    
    /*
    _loadingView=[[UIImageView alloc] initWithFrame:CGRectMake(90.0f, 140.0f,140.0f, 70.0f)];
    _loadingView.image=[UIImage imageNamed:@"duqu.png"];
    _loadingView.alpha=0.8;
    [self.view addSubview:_loadingView];
    
    _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    _activityView.frame = CGRectMake(110.0f, 162.0f, 20.0f, 20.0f);
    [self.view addSubview:_activityView];
    [_activityView startAnimating];
    
    //_loadLabel = [ViewTool addUILable:self.view x:140.0 y:158 x1:100 y1:20 fontSize:15 lableText:@"加载中..."];
    _loadLabel = [ViewTool addUILable:self.view x:140.0 y:162 x1:100 y1:20 fontSize:15 lableText:@"加载中..."];
    
    [_loadLabel setTextColor:[UIColor grayColor]];
     */
    
    
    [myDelegate drawLoadingPattern:@"加载中" isWithAnimation:NO];
    
    
    moreTip = @"显示下20条";
    
    
    nowpagenum = 1;
    isMore = NO;
    ordertype = [notification object];
    switch (selectTag) {
        case kListTag:{
            ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@topiclist.php?type=thread_list&fid=%d&pageno=1&pagesize=20&orderby=%@",myDomainAndPathVeryNC,self.fid,ordertype]]];
            [request setTag:selectSubTag];
            [request setDownloadCache:[ASIDownloadCache sharedCache]];
            [request setCachePolicy:ASIAskServerIfModifiedCachePolicy | ASIFallbackToCacheIfLoadFailsCachePolicy]; 
            [request setDelegate:self];
            [request setPersistentConnectionTimeoutSeconds:_timeOut];
            
            [request startAsynchronous];
            break;
        }  
        case kTopTag:{
            ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@topiclist.php?type=top_thread&fid=%d&pageno=1&pagesize=20&orderby=%@",myDomainAndPathVeryNC,self.fid,ordertype]]];
            [request setTag:selectSubTag];
            [request setDownloadCache:[ASIDownloadCache sharedCache]];
            [request setCachePolicy:ASIAskServerIfModifiedCachePolicy | ASIFallbackToCacheIfLoadFailsCachePolicy]; 
            [request setDelegate:self];
            [request setPersistentConnectionTimeoutSeconds:_timeOut];
            
            [request startAsynchronous];
            break;
        }
        case kBestTag:{
            ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@topiclist.php?type=digest_thread&fid=%d&pageno=1&pagesize=20&orderby=%@",myDomainAndPathVeryNC,self.fid,ordertype]]];
            [request setTag:selectSubTag];
            [request setDownloadCache:[ASIDownloadCache sharedCache]];
            [request setCachePolicy:ASIAskServerIfModifiedCachePolicy | ASIFallbackToCacheIfLoadFailsCachePolicy]; 
            [request setDelegate:self];
            [request setPersistentConnectionTimeoutSeconds:_timeOut];
            
            [request startAsynchronous];
            
            break;
        }
    }
    [self.popoverOrderController dismissPopoverAnimated:YES];
}







- (void)pressMenu:(UIButton *)sender {
    DebugLog(@"pressMenu");
    
    if ([fidSubArray count]>0) {
        pageNum=1;
        [self pressMenu:sender More:NO];
        
        
        
    }
    else { 
        if (sender.tag != selectTag) {
            pageNum = 1;
            [self pressMenu:sender More:NO];
        }
    }
	
}

- (void)pressMenu:(UIButton *)sender More:(BOOL)_isMore{
    moreTip = @"显示下20条";
    
    //加载中
    /*
    _loadingView=[[UIImageView alloc] initWithFrame:CGRectMake(90.0f, 140.0f,140.0f, 70.0f)];
    _loadingView.image=[UIImage imageNamed:@"duqu.png"];
    _loadingView.alpha=0.8;
    [self.view addSubview:_loadingView];
    
    _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    _activityView.frame = CGRectMake(110.0f, 162.0f, 20.0f, 20.0f);
    [self.view addSubview:_activityView];
    [_activityView startAnimating];
    
    //_loadLabel = [ViewTool addUILable:self.view x:140.0 y:158 x1:100 y1:20 fontSize:15 lableText:@"加载中..."];
    _loadLabel = [ViewTool addUILable:self.view x:140.0 y:162 x1:100 y1:20 fontSize:15 lableText:@"加载中..."];
    
    [_loadLabel setTextColor:[UIColor grayColor]];
     
     */
    
    
    [myDelegate drawLoadingPattern:@"加载中" isWithAnimation:NO];
    
    
    
	for (UIButton *tmpBtn in btnArray) {
		[tmpBtn setSelected:NO];
	}
    
    for (UIButton *tmpBtn in btnSubArray) {
		[tmpBtn setSelected:NO];
	}
    
	[sender setSelected:YES];
	[UIView animateWithDuration:0.2f animations:^{
		CGRect frame = [sender frame];
		frame.origin.x -= 1;	 
		[selectView setFrame:frame];
	}];
    if ([fidSubArray count]>0) {
        if (sender.tag!=100) {
            
            selectSubTag=sender.tag;
            selectBeforeSub=sender.tag;
        }else{
            
            selectSubTag=sender.tag;
            
        }
        
        
        
    }else {
        selectTag = sender.tag;
    }
	isMore = _isMore;
	NSString *requestURL;
    
    nowpagenum = 1;
    ordertype = nil;
    //NSLog(@"pressmenu = %d",selectSubTag);
    if ([fidSubArray count]>0){
        DebugLog(@"pressbutton more");
        
        
        switch (selectSubTag) {
                
                
            case kDummyTag:{
                //NSLog(@"here is dummy");
                requestURL = kListRequestURLWithPage(pageNum);
                
                DebugLog(@"kDummyTag----%@",requestURL);
                ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:requestURL]];
                [request setTag:selectSubTag];
                [request setDownloadCache:[ASIDownloadCache sharedCache]];
                [request setCachePolicy:ASIAskServerIfModifiedCachePolicy | ASIFallbackToCacheIfLoadFailsCachePolicy]; 
                [request setDelegate:self];
                [request setPersistentConnectionTimeoutSeconds:_timeOut];
              
                [request startAsynchronous];
                break;
            }
            case kListTag:{
                subBBSViewController * subBBSController=[[subBBSViewController alloc]initWithNibName:@"subBBSViewController" bundle:nil];
                subBBSController.fidArray=fidSubArray;
                subBBSController.childArray=namesSubArray;
                [self.navigationController pushViewController:subBBSController animated:YES];
                selectSubTag=selectBeforeSub;
                [subBBSController release];
                
                break;
            }
                
                
            case kTopTag:{
                
                requestURL = kTopRequestURLWithPage(pageNum);
                ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:requestURL]];
                [request setTag:selectSubTag];
                [request setDownloadCache:[ASIDownloadCache sharedCache]];
                [request setCachePolicy:ASIAskServerIfModifiedCachePolicy | ASIFallbackToCacheIfLoadFailsCachePolicy]; 
                [request setDelegate:self];
                [request setPersistentConnectionTimeoutSeconds:_timeOut];
           
                [request startAsynchronous];
                break;
            }
            case kBestTag:{
                
                requestURL = kBestRequestURLWithPage(pageNum);
                ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:requestURL]];
                [request setTag:selectSubTag];
                [request setDownloadCache:[ASIDownloadCache sharedCache]];
                [request setCachePolicy:ASIAskServerIfModifiedCachePolicy | ASIFallbackToCacheIfLoadFailsCachePolicy]; 
                [request setDelegate:self];
                [request setPersistentConnectionTimeoutSeconds:_timeOut];
          
                [request startAsynchronous];
                
                break;
            }
            case kSearchTag:{
                requestURL = kSearchRequestURLWithPage(@"微软",pageNum);
                requestURL = [requestURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                DebugLog(@"search : %@",requestURL);
                break;
            }
        }
        
        
        
        
        
        
    }
    else {
        
        switch (selectTag) {
            case kListTag:{
                
                
                
                requestURL = kListRequestURLWithPage(1);
                
                DebugLog(@"%@",requestURL);
                ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:requestURL]];
                [request setTag:selectTag];
                [request setDownloadCache:[ASIDownloadCache sharedCache]];
                [request setCachePolicy:ASIAskServerIfModifiedCachePolicy | ASIFallbackToCacheIfLoadFailsCachePolicy]; 
                [request setDelegate:self];
                [request setPersistentConnectionTimeoutSeconds:_timeOut];
             
                [request startAsynchronous];
                break;
            }
            case kTopTag:{
                //NSLog(@"here is top");
                requestURL = kTopRequestURLWithPage(1);
                ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:requestURL]];
                [request setTag:selectTag];
                [request setDownloadCache:[ASIDownloadCache sharedCache]];
                [request setCachePolicy:ASIAskServerIfModifiedCachePolicy | ASIFallbackToCacheIfLoadFailsCachePolicy]; 
                [request setDelegate:self];
                [request setPersistentConnectionTimeoutSeconds:_timeOut];
 
                [request startAsynchronous];
                break;
            }
            case kBestTag:{
                //NSLog(@"here is best");
                requestURL = kBestRequestURLWithPage(1);
                ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:requestURL]];
                [request setTag:selectTag];
                [request setDownloadCache:[ASIDownloadCache sharedCache]];
                [request setCachePolicy:ASIAskServerIfModifiedCachePolicy | ASIFallbackToCacheIfLoadFailsCachePolicy]; 
                [request setDelegate:self];
                [request setPersistentConnectionTimeoutSeconds:_timeOut];
             
                [request startAsynchronous];
                
                break;
            }
            case kSearchTag:{
                requestURL = kSearchRequestURLWithPage(@"微软",pageNum);
                requestURL = [requestURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                DebugLog(@"search : %@",requestURL);
                break;
            }
        }
    }
}

#pragma mark - ASIHTTPDelegate

- (void)requestStarted:(ASIHTTPRequest *)request {
	if (hashLoad[selectTag] == 0) {
		hashLoad[selectTag] = 1;
     
        //beta2
        
        //停止显示加载中
        
        /*
        if (_activityView ) {
            
            [_activityView removeFromSuperview];
            _activityView = nil;
            [_loadLabel removeFromSuperview];
            _loadLabel = nil;
            
            [_loadingView removeFromSuperview];
            _loadingView=nil;
            
        }
         
         */
        
        [myDelegate removeLoadingPatternIfNeed];
        
        
        //加载中
        /*
        _loadingView=[[UIImageView alloc] initWithFrame:CGRectMake(90.0f, 140.0f,140.0f, 70.0f)];
        _loadingView.image=[UIImage imageNamed:@"duqu.png"];
        _loadingView.alpha=0.8;
        [self.view addSubview:_loadingView];
        
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _activityView.frame = CGRectMake(110.0f, 162.0f, 20.0f, 20.0f);
        [self.view addSubview:_activityView];
        [_activityView startAnimating];
        
        //_loadLabel = [ViewTool addUILable:self.view x:140.0 y:158 x1:100 y1:20 fontSize:15 lableText:@"加载中..."];
        _loadLabel = [ViewTool addUILable:self.view x:140.0 y:162 x1:100 y1:20 fontSize:15 lableText:@"加载中..."];
        
        [_loadLabel setTextColor:[UIColor grayColor]];
         
         */
        
        //NSLog(@"111");
        
        [myDelegate drawLoadingPattern:@"加载中" isWithAnimation:NO];
	}
}

- (void)requestFinished:(ASIHTTPRequest *)request {
    
    //NSLog(@"222");
    nowpagenum += 1;
	if (!isMore) {
		[resultArray removeAllObjects];
		//[tableView reloadData];
	}
	//else [resultArray removeLastObject];	//将“更多”移出来
    
    
    //  NSString *s=@"{\"code\":\"200\",\"datas\":[{\"subject\":\"\"\\u6d4b\\u8bd5\\u5e16\\u5b50\\u5217\\u8868\",\"author\":\"shopnc_admin\",\"dateline\":\"1334194030\",\"views\":\"1\",\"replies\":\"0\",\"tid\":\"553\",\"fid\":\"55\"} ],\"count\":\"1\"}";
    //@"{\"code\":\"200\",\"datas\":[{\"subject\":\" cbf\",\"author\":\"lzpsnake\",\"dateline\":\"1334054504\",\"views\":\"1\",\"replies\":\"7\",\"tid\":\"535\",\"fid\":\"52\"},{\"subject\":\"yy\",\"author\":\"lzpsnake\",\"dateline\":\"1334107234\",\"views\":\"999999\",\"replies\":\"999999\",\"tid\":\"539\",\"fid\":\"52\"},{\"subject\":\"yyy\",\"author\":\"lzpsnake\",\"dateline\":\"1334107216\",\"views\":\"1\",\"replies\":\"0\",\"tid\":\"538\",\"fid\":\"52\"},{\"subject\":\"hhhh\",\"author\":\"lzpsnake\",\"dateline\":\"1334054767\",\"views\":\"1\",\"replies\":\"0\",\"tid\":\"536\",\"fid\":\"52\"},{\"subject\":\"\\u5eb7\\u5e08\\u5085\\u5929\\u4ef7\\u725b\\u8089\\u9762\\u66b4\\u6da838%\\uff1a108\\u5143\\u53d8\\u53cc\\u4eba\\u4efd298\\u5143\",\"author\":\"\\u624d\\u5b50\",\"dateline\":\"1333636088\",\"views\":\"3\",\"replies\":\"1\",\"tid\":\"372\",\"fid\":\"52\"},{\"subject\":\"\\u5929\\u6d25\\u65b0\\u8fa3\\u9053 \\u4eab\\u5065\\u5eb7\\u201c\\u98df\\u5c1a\\u201d\",\"author\":\"\\u624d\\u5b50\",\"dateline\":\"1333636983\",\"views\":\"3\",\"replies\":\"0\",\"tid\":\"378\",\"fid\":\"52\"},{\"subject\":\"\\u4e50\\u5475\\u4e50\\u5475\\u5f97\\u4e86 \\u5929\\u6d25\\u76f8\\u58f0\\u81ea\\u52a9\\u6e38\\u5168\\u653b\\u7565(\\u7ec4\\u56fe)(8)\",\"author\":\"\\u624d\\u5b50\",\"dateline\":\"1333636940\",\"views\":\"1\",\"replies\":\"0\",\"tid\":\"377\",\"fid\":\"52\"},{\"subject\":\"\\u5357\\u5e02\\u98df\\u54c1\\u8857\\u672c\\u6708\\u6539\\u9020\\u5b8c\\u6210 800\\u7c73\\u957f\\u5eca\\u8fb9\\u5403\\u8fb9\\u770b\",\"author\":\"\\u624d\\u5b50\",\"dateline\":\"1333636739\",\"views\":\"1\",\"replies\":\"0\",\"tid\":\"376\",\"fid\":\"52\"},{\"subject\":\"\\u5988\\u5988\\u7684\\u6d25\\u5473\\u7f8e\\u98df1\\u2014\\u2014\\u8001\\u864e\\u722a\",\"author\":\"\\u624d\\u5b50\",\"dateline\":\"1333636621\",\"views\":\"1\",\"replies\":\"0\",\"tid\":\"375\",\"fid\":\"52\"},{\"subject\":\"\\u79e6\\u5c9a\\u72d7\\u4e0d\\u7406\\u5b66\\u5305\\u5305\\u5b50 \\u6d25\\u95e8\\u83b7\\u5956\\u6700\\u53d7\\u6b22\\u8fce(\\u56fe)\",\"author\":\"\\u624d\\u5b50\",\"dateline\":\"1333636290\",\"views\":\"1\",\"replies\":\"0\",\"tid\":\"374\",\"fid\":\"52\"},{\"subject\":\"\\u5496\\u5561\\u7231\\u597d\\u8005\\u7684\\u4e5d\\u5927\\u4f53\\u9a8c\",\"author\":\"\\u624d\\u5b50\",\"dateline\":\"1333636160\",\"views\":\"1\",\"replies\":\"0\",\"tid\":\"373\",\"fid\":\"52\"},{\"subject\":\"\\u4e0d\\u53ea\\u6709\\u201c\\u72d7\\u4e0d\\u7406\\u201d \\u5e26\\u4f60\\u73a9\\u8f6c\\u5929\\u6d25\",\"author\":\"\\u624d\\u5b50\",\"dateline\":\"1333636050\",\"views\":\"1\",\"replies\":\"0\",\"tid\":\"371\",\"fid\":\"52\"},{\"subject\":\"\\u5c0f\\u5403\\u8857\\u6108\\u6f14\\u6108\\u70c8 \\u5929\\u6d25\\u5e02\\u897f\\u9752\\u533a\\u5927\\u5b66\\u57ce\\u201c\\u6ca6\\u9677\\u201d\",\"author\":\"\\u624d\\u5b50\",\"dateline\":\"1333635897\",\"views\":\"1\",\"replies\":\"0\",\"tid\":\"370\",\"fid\":\"52\"},{\"subject\":\"\\u5370\\u5ea6\\u7f8e\\u98df\\u8282\\u5728\\u5929\\u6d25\\u6ee8\\u6d77\\u65b0\\u533a\\u5f00\\u5e55 \\u6d3b\\u52a83\\u6708\\u5e95\\u7ed3\\u675f\",\"author\":\"\\u624d\\u5b50\",\"dateline\":\"1333635837\",\"views\":\"1\",\"replies\":\"0\",\"tid\":\"369\",\"fid\":\"52\"},{\"subject\":\"\\u5929\\u6d25\\u7f8e\\u98df\\u201c\\u5582\\u201d\\u80d6\\u5973\\u4e3b\\u89d2\",\"author\":\"\\u624d\\u5b50\",\"dateline\":\"1333635788\",\"views\":\"1\",\"replies\":\"0\",\"tid\":\"368\",\"fid\":\"52\"},{\"subject\":\"\\u661f\\u5df4\\u514b\\u74f6\\u88c5\\u5496\\u5561\\u5929\\u6d25\\u7f8e\\u98df\\u9500\\u91cf\\u593a\\u51a0\",\"author\":\"\\u624d\\u5b50\",\"dateline\":\"1333635765\",\"views\":\"1\",\"replies\":\"0\",\"tid\":\"367\",\"fid\":\"52\"},{\"subject\":\"2012\\u6700\\u65b0\\u9910\\u996e\\u7f8e\\u98df\\u52a0\\u76df \\u5feb\\u4e50\\u661f\\u6c49\\u5821\\u52a0\\u76df\",\"author\":\"\\u624d\\u5b50\",\"dateline\":\"1333635634\",\"views\":\"1\",\"replies\":\"0\",\"tid\":\"366\",\"fid\":\"52\"},{\"subject\":\"\\u5929\\u6d25\\u4ec0\\u4e48\\u7279\\u8272\\u6700\\u53d7\\u6b22\\u8fce?\",\"author\":\"\\u5929\\u8fb9\\u96e8\",\"dateline\":\"1333598516\",\"views\":\"99\",\"replies\":\"45\",\"tid\":\"332\",\"fid\":\"52\"},{\"subject\":\"\\u56db\\u5ddd\\u9ebb\\u5a46\\u8c46\\u8150\",\"author\":\"Irene\",\"dateline\":\"1330918989\",\"views\":\"5\",\"replies\":\"6\",\"tid\":\"29\",\"fid\":\"52\"},{\"subject\":\"\\u51c9\\u62cc\\u8fa3\\u5473\\u6c34\\u82b9\\u83dc\",\"author\":\"Irene\",\"dateline\":\"1330918912\",\"views\":\"4\",\"replies\":\"1\",\"tid\":\"27\",\"fid\":\"52\"}],\"count\":\"24\"}";
    
    //@"{\"code\":\"200\",\"datas\":[{\"subject\":\"\"\\u6d4b\\u8bd5\\u5e16\\u5b50\\u5217\\u8868\",\"author\":\"shopnc_admin\",\"dateline\":\"1334194030\",\"views\":\"1\",\"replies\":\"0\",\"tid\":\"553\",\"fid\":\"55\"}   ],\"count\":\"1\"}";
    
    
    
    NSString *formatJsonString = [request responseString];
    
    formatJsonString = [formatJsonString stringByReplacingOccurrencesOfString: @"&quot;"withString: @""];      
    formatJsonString = [formatJsonString stringByReplacingOccurrencesOfString: @""withString: @""];      
    
    
    
    NSString *requestString = [formatJsonString stringByConvertingHTMLToPlainText];

    requestString=[requestString stringByReplacingOccurrencesOfString:@"\"\"\\" withString:@"\"\\"] ;
    requestString = [requestString stringByReplacingOccurrencesOfString: @"\\'" withString: @"'"];
    DebugLog (@"--->%@",requestString);
        DebugLog(@"%@",requestString);
    maxPage = ceil([[[requestString JSONValue] valueForKey:@"count"] doubleValue] / 20.0);
	if (maxPage == 0) {
		maxPage = 1;
        DebugLog(@"----maxpage:%d",maxPage);
	}
    DebugLog(@"maxpage:%d",maxPage);
	[pageNumLabel setText:[NSString stringWithFormat:@"%d/%d",pageNum,maxPage]];
	NSArray *tmpArray = [[requestString JSONValue] valueForKey:@"datas"];
    if([tmpArray count] == 0){
        if(isMore == YES){
            moreTip = @"已无更多数据";
        }else{
            moreTip = @"暂无数据";
        }
    }
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
		 a.isReaded = [[NSUserDefaults standardUserDefaults] boolForKey:[[tmpArray objectAtIndex:i] valueForKey:@"tid"]];
		[resultArray addObject: a];
		[ a release];
	}
    
    
  
    
	[tableView reloadData];
    
    //停止加载
    /*
	if (_activityView ) {
		[_activityView removeFromSuperview];
		_activityView = nil;
		[_loadLabel removeFromSuperview];
		_loadLabel = nil;
        
        [_loadingView removeFromSuperview];
        _loadingView=nil;
	}
     */
    
    [myDelegate removeLoadingPatternIfNeed];
	
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    moreTip = @"显示下20条";
    
    //停止加载
    /*
    if (_activityView ) {
        
		[_activityView removeFromSuperview];
		_activityView = nil;
		[_loadLabel removeFromSuperview];
		_loadLabel = nil;
        
        [_loadingView removeFromSuperview];
        _loadingView=nil;
        
	}
     
     */
    
    [myDelegate removeLoadingPatternIfNeed];
    
    //服务器不能连接报错
    /*
    UIAlertView *alert;
    NSError *error = [request error];
    if (error)
        alert = [[UIAlertView alloc] initWithTitle:@"链接错误" 
                                           message:@"暂时不能连接服务器" 
                                          delegate:self cancelButtonTitle:@"知道了" 
                                 otherButtonTitles:nil];
    [alert show];
    [alert release];
     
     */
    
    [myDelegate ShowConnectionFailureAlert];
    
}

- (NSString *)timeStampeToNSDateString:(NSString *)timeStame {
	NSDate *tranData = [NSDate dateWithTimeIntervalSince1970:[timeStame doubleValue]];
	return [tranData formatRelativeTime];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (void)tableView:(UITableView *)_tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == [resultArray count]) {
        
        //加载中
        /*
        _loadingView=[[UIImageView alloc] initWithFrame:CGRectMake(90.0f, 140.0f,140.0f, 70.0f)];
        _loadingView.image=[UIImage imageNamed:@"duqu.png"];
        _loadingView.alpha=0.8;
        [self.view addSubview:_loadingView];
        
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _activityView.frame = CGRectMake(110.0f, 162.0f, 20.0f, 20.0f);
        [self.view addSubview:_activityView];
        [_activityView startAnimating];
        
        //_loadLabel = [ViewTool addUILable:self.view x:140.0 y:158 x1:100 y1:20 fontSize:15 lableText:@"加载中..."];
        _loadLabel = [ViewTool addUILable:self.view x:140.0 y:162 x1:100 y1:20 fontSize:15 lableText:@"加载中..."];
        
        [_loadLabel setTextColor:[UIColor grayColor]];
         
         */
        
        [myDelegate removeLoadingPatternIfNeed];
        
        isMore = YES;
        switch (selectTag) {
            case kListTag:{
                ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@topiclist.php?type=thread_list&fid=%d&pageno=%d&pagesize=20&orderby=%@",myDomainAndPathVeryNC,self.fid,nowpagenum,ordertype]]];
                [request setTag:selectSubTag];
                [request setDownloadCache:[ASIDownloadCache sharedCache]];
                [request setCachePolicy:ASIAskServerIfModifiedCachePolicy | ASIFallbackToCacheIfLoadFailsCachePolicy]; 
                [request setDelegate:self];
                [request setPersistentConnectionTimeoutSeconds:_timeOut];
                
                [request startAsynchronous];
                break;
            }  
            case kTopTag:{
                ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@topiclist.php?type=top_thread&fid=%d&pageno=%d&pagesize=20&orderby=%@",myDomainAndPathVeryNC,self.fid,nowpagenum,ordertype]]];
                [request setTag:selectSubTag];
                [request setDownloadCache:[ASIDownloadCache sharedCache]];
                [request setCachePolicy:ASIAskServerIfModifiedCachePolicy | ASIFallbackToCacheIfLoadFailsCachePolicy]; 
                [request setDelegate:self];
                [request setPersistentConnectionTimeoutSeconds:_timeOut];
                
                [request startAsynchronous];
                break;
            }
            case kBestTag:{
                ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@topiclist.php?type=digest_thread&fid=%d&pageno=%d&pagesize=20&orderby=%@",myDomainAndPathVeryNC,self.fid,nowpagenum,ordertype]]];
                [request setTag:selectSubTag];
                [request setDownloadCache:[ASIDownloadCache sharedCache]];
                [request setCachePolicy:ASIAskServerIfModifiedCachePolicy | ASIFallbackToCacheIfLoadFailsCachePolicy]; 
                [request setDelegate:self];
                [request setPersistentConnectionTimeoutSeconds:_timeOut];
                
                [request startAsynchronous];
                
                break;
            }
        }
        
    }else{
        CommonObject *selectCell = [resultArray objectAtIndex:indexPath.row];
        ReaderController *reader = [[ReaderController alloc] init];
        reader.isFromDetail=true;
        selectCell.isReaded = YES;
        reader.Title = [selectCell title];
        reader.tid = [selectCell tid];
        reader.isclosed = [selectCell isclosed];
        //beta2
        reader.fid=self.fid;
        
        
        
        
        NSUserDefaults *tmpUserDefaults = [NSUserDefaults standardUserDefaults];
        [tmpUserDefaults setBool:YES forKey:[NSString stringWithFormat:@"%d",selectCell.tid]];
        [tmpUserDefaults synchronize];
        [reader setHidesBottomBarWhenPushed:YES];
        loadingReader = TRUE;
        
        [self.navigationController pushViewController:reader animated:YES];
        
        
        
        
        [reader release];
    } 
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	
    return 1; // 分组数
}
- (void)loadmore{
    [myDelegate removeLoadingPatternIfNeed];
    
    isMore = YES;
    switch (selectTag) {
        case kListTag:{
            ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@topiclist.php?type=thread_list&fid=%d&pageno=%d&pagesize=20&orderby=%@",myDomainAndPathVeryNC,self.fid,nowpagenum,ordertype]]];
            [request setTag:selectSubTag];
            [request setDownloadCache:[ASIDownloadCache sharedCache]];
            [request setCachePolicy:ASIAskServerIfModifiedCachePolicy | ASIFallbackToCacheIfLoadFailsCachePolicy]; 
            [request setDelegate:self];
            [request setPersistentConnectionTimeoutSeconds:_timeOut];
            
            [request startAsynchronous];
            break;
        }  
        case kTopTag:{
            ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@topiclist.php?type=top_thread&fid=%d&pageno=%d&pagesize=20&orderby=%@",myDomainAndPathVeryNC,self.fid,nowpagenum,ordertype]]];
            [request setTag:selectSubTag];
            [request setDownloadCache:[ASIDownloadCache sharedCache]];
            [request setCachePolicy:ASIAskServerIfModifiedCachePolicy | ASIFallbackToCacheIfLoadFailsCachePolicy]; 
            [request setDelegate:self];
            [request setPersistentConnectionTimeoutSeconds:_timeOut];
            
            [request startAsynchronous];
            break;
        }
        case kBestTag:{
            ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@topiclist.php?type=digest_thread&fid=%d&pageno=%d&pagesize=20&orderby=%@",myDomainAndPathVeryNC,self.fid,nowpagenum,ordertype]]];
            [request setTag:selectSubTag];
            [request setDownloadCache:[ASIDownloadCache sharedCache]];
            [request setCachePolicy:ASIAskServerIfModifiedCachePolicy | ASIFallbackToCacheIfLoadFailsCachePolicy]; 
            [request setDelegate:self];
            [request setPersistentConnectionTimeoutSeconds:_timeOut];
            
            [request startAsynchronous];
            
            break;
        }
    }
}
//为tableview添加项
- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	
    if (indexPath.row == [resultArray count]) {
        NSString *CellIdentifier = @"TopicListMoreCell";
        UITableViewCell *TopicListMoreCell = [tableView dequeueReusableCellWithIdentifier:nil];
        if(TopicListMoreCell == nil){
            TopicListMoreCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            UIButton *morebtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 310, 35)];
            [morebtn setBackgroundImage:[UIImage imageNamed:@"bigmorebtn.png"] forState:UIControlStateNormal];
            [morebtn addTarget:self action:@selector(loadmore) forControlEvents:UIControlEventTouchUpInside];
            [TopicListMoreCell addSubview:morebtn];
            UILabel *moreTiplabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 13, 200, 20)];
            moreTiplabel.backgroundColor = [UIColor clearColor];
            moreTiplabel.text = moreTip;
            moreTiplabel.textAlignment = UITextAlignmentCenter;
            [TopicListMoreCell addSubview:moreTiplabel];
        }
        return TopicListMoreCell;
    }else{
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:nil];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        
        SSLineView *lineView = [[SSLineView alloc] initWithFrame:CGRectMake(0, 50, 320, 2)];
        [cell addSubview:lineView];
        [lineView release];
        CommonObject *cellObject = [resultArray objectAtIndex:indexPath.row];
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
        
        /*
         if ([indexPath row] == [resultArray count] - 1) {
         //[cell.textLabel setText:@"更多"];
         [cell.textLabel setText:  [resultArray  objectAtIndex:[resultArray count] - 1]];
         
         [cell.textLabel setTextAlignment:UITextAlignmentCenter];
         
         
         }
         else {
         SSLineView *lineView = [[SSLineView alloc] initWithFrame:CGRectMake(0, 50, 320, 2)];
         [cell addSubview:lineView];
         [lineView release];
         CommonObject *cellObject = [resultArray objectAtIndex:indexPath.row];
         UILabel *titleLabel = [ViewTool addUILable:cell x:25 y:7 x1:270 y1:20 fontSize:15 lableText:cellObject.title];//帖子标题
         if (cellObject.isReaded) {
         [titleLabel setTextColor:[UIColor grayColor]];
         }
         else {
         UIImageView *pointView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cycle.png"]];
         [pointView setFrame:CGRectMake(7, 21, 8, 8)];
         [cell addSubview:pointView];
         [pointView release];
         }
         [ViewTool addUILable:cell x:25 y:30 x1:95 y1:13 fontSize:11 lableText:cellObject.author].textColor = [UIColor colorWithRed:0.169 green:0.345 blue:0.839 alpha:1.000];//发帖者昵称
         [ViewTool addUILable:cell x:115 y:30 x1:150 y1:13 fontSize:11 lableText:[NSString stringWithFormat:@"回复/浏览:%d/%d",cellObject.replies,cellObject.views]];//帖子流量回复
         [ViewTool addUILable:cell x:210 y:30 x1:85 y1:13 fontSize:11 lableText:cellObject.postdate].textAlignment = UITextAlignmentRight;//帖子发布时间
         }
         */
        return cell;
    }
    
}

//每组的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [resultArray count]+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 50;
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
	_reloading = YES;
	[self performSelector:@selector(dragUpdateTableView)];
}

- (void)doneLoadingTableViewData{
    DebugLog(@"doneLoadingTableViewData");
	
	//  model should call this when its done loading
	
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:tableView];
	
}

- (void)dragUpdateTableView {
    
	pageNum = 1;
   if ([fidSubArray count]>0) {
       UIButton *tmpBtn = (UIButton *)[self.view viewWithTag:selectSubTag];
       [self pressMenu:tmpBtn More:NO];
    
    
   }else{
       UIButton *tmpBtn = (UIButton *)[self.view viewWithTag:selectTag];
       [self pressMenu:tmpBtn More:NO];
   }

	
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
    DebugLog(@"scrollViewDidScroll");
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
	
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    DebugLog(@"scrollViewDidEndScrollingAnimation");
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    DebugLog(@"scrollViewDidEndDragging");
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self reloadTableViewDataSource];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:1.0];
	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
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
