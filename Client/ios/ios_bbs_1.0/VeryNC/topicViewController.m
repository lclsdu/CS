//
//  topicViewController.m
//  VeryNC
//
//  Created by wu jinjin on 12-4-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "topicViewController.h"
#import "ReaderController.h"
#define TopicPicRequestURL [NSString stringWithFormat:@"%@topiclist.php?type=topic_pic&pageno=1&pagesize=1",api_url]
#define TopicListRequestURLWithPage(x) [NSString stringWithFormat:@"%@topiclist.php?type=topic&pageno=%d&pagesize=20",api_url,x]
@interface topicViewController ()

@end

@implementation topicViewController
@synthesize appDelegate;
@synthesize myDelegate,api_url;
@synthesize TopicArray,TopicPicArray;
@synthesize mytableview;
@synthesize morebtn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [myDelegate showImage];



}


- (void)viewDidLoad
{
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    api_url = delegate.myDomainAndPathVeryNC;
    TopicPicArray = [[NSMutableArray alloc] init];
    TopicArray = [[NSMutableArray alloc] init];
    //请求数据
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:TopicPicRequestURL]];
	[request setTag:0];
	//[request setDownloadCache:[ASIDownloadCache sharedCache]];
	//[request setCachePolicy:ASIAskServerIfModifiedWhenStaleCachePolicy];
	[request setDelegate:self];
    [request setPersistentConnectionTimeoutSeconds:30];
	[request startAsynchronous];
    
    ASIHTTPRequest *request2 = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:TopicListRequestURLWithPage(1)]];
	[request2 setTag:1];
	//[request2 setDownloadCache:[ASIDownloadCache sharedCache]];
	//[request2 setCachePolicy:ASIAskServerIfModifiedWhenStaleCachePolicy];
	[request2 setDelegate:self];
    [request2 setPersistentConnectionTimeoutSeconds:30];
	[request2 startAsynchronous];
    
    if (_refreshHeaderView == nil) {
		
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - mytableview.bounds.size.height, self.view.frame.size.width, mytableview.bounds.size.height)];
		view.delegate = self;
		[mytableview addSubview:view];
		_refreshHeaderView = view;
		[view release];
		
	}
    
    pagenum = 1;
    loadmore_Tip = @"显示下20条";
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[self navigationItem] setTitle: @"话题"]; 
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:158.0/255.0 green:26.0/255.0 blue:36.0/255.0 alpha:1.000]];
    
    showalert = YES;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)viewWillDisAppear:(BOOL)animated;  
{
    for (ASIHTTPRequest *request in ASIHTTPRequest.sharedQueue.operations)
    {
        [request cancel];
        [request setDelegate:nil];
    }
}
- (void)dealloc
{
    [api_url release];
    [TopicArray release];
    [TopicPicArray release];
    [mytableview release];
    [_loadingView release];
    [_loadLabel release];
    [_activityView release];
    [super dealloc];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - ASIHTTPDelegate
- (void)requestStarted:(ASIHTTPRequest *)request {
	[myDelegate removeLoadingPatternIfNeed];
    [myDelegate drawLoadingPattern:@"加载中..." isWithAnimation:NO];
}
- (void)requestFinished:(ASIHTTPRequest *)request {
    NSString *requestString = [request responseString];
    requestString = [requestString stringByReplacingOccurrencesOfString:@"\"\"\\" withString:@"\"\\"] ;
    requestString = [requestString stringByReplacingOccurrencesOfString: @"\\'" withString: @"'"];
    if (request.tag == 0) {
        NSArray *tmpArray = [[requestString JSONValue] valueForKey:@"datas"];
        if([tmpArray count] != 0){
            [TopicPicArray removeAllObjects];
            [TopicPicArray addObject:[tmpArray objectAtIndex:0]];
            loadmore_Tip =  @"显示下20条";
        }
    }
    if (request.tag == 1) {
        NSArray *tmpArray = [[requestString JSONValue] valueForKey:@"datas"];
        if([tmpArray count] != 0){
            if(isMore == NO){
                [TopicArray removeAllObjects];
            }
            for(int i=0;i<[tmpArray count];i++){
                [TopicArray addObject:[tmpArray objectAtIndex:i]];
            }
                
        }else{
            if(isMore == YES){
                loadmore_Tip = @"已无更多内容";
            }
        }
    }
    [mytableview reloadData];
    [myDelegate removeLoadingPatternIfNeed];
}
- (void)requestFailed:(ASIHTTPRequest *)request {
    [myDelegate removeLoadingPatternIfNeed];
    
    if(showalert == YES){
        showalert = NO;
    [myDelegate  ShowConnectionFailureAlert];
    }
}

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        NSString *CellIdentifier = @"TopicPicCell";
        UITableViewCell *TopicPicCell = [tableView dequeueReusableCellWithIdentifier:nil];
        if(TopicPicCell == nil){
            TopicPicCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 170)];
            [TopicPicCell addSubview:imageView];
            [imageView release];
            NSString *top_pic_url = nil;
            NSString *top_title = nil;
            if([TopicPicArray count] != 0){
                top_pic_url = [[TopicPicArray objectAtIndex:0] objectForKey:@"pic"];
                top_title   = [[TopicPicArray objectAtIndex:0] objectForKey:@"title"];
            }
            [imageView setImageWithURL:[NSURL URLWithString:top_pic_url] placeholderImage:[UIImage imageNamed:@"defalut_img_big.png"]];
            [ViewTool addUIImageView:TopicPicCell imageName:@"bigblack.png" type:@"" x:0 y:142 x1:320 y1:28].alpha = 0.7;
            UILabel *titleLabel = [ViewTool addUILable:TopicPicCell x:10 y:145 x1:320 y1:20 fontSize:15 lableText:top_title];
            titleLabel.textColor = [UIColor whiteColor];
            titleLabel.font = [UIFont boldSystemFontOfSize:15];
            [ViewTool addUIImageView:TopicPicCell imageName:@"whiteline.png" type:@"" x:0 y:142 x1:320 y1:.5];
        }
        return TopicPicCell;
    }else if (indexPath.row == [TopicArray count]+1) {
        NSString *CellIdentifier = @"TopicListMoreCell";
        UITableViewCell *TopicListMoreCell = [tableView dequeueReusableCellWithIdentifier:nil];
        if(TopicListMoreCell == nil){
            TopicListMoreCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            morebtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 310, 35)];
            [morebtn setBackgroundImage:[UIImage imageNamed:@"bigmorebtn.png"] forState:UIControlStateNormal];
            [morebtn addTarget:self action:@selector(loadmore) forControlEvents:UIControlEventTouchUpInside];
            [TopicListMoreCell addSubview:morebtn];
            UILabel *moreTip = [[UILabel alloc] initWithFrame:CGRectMake(60, 13, 200, 20)];
            moreTip.backgroundColor = [UIColor clearColor];
            moreTip.text = loadmore_Tip;
            moreTip.textAlignment = UITextAlignmentCenter;
            [TopicListMoreCell addSubview:moreTip];
        }
        return TopicListMoreCell;
    }else{
        NSString *CellIdentifier = @"TopicListCell";
        UITableViewCell *TopicListCell = [tableView dequeueReusableCellWithIdentifier:nil];
        if(TopicListCell == nil){
            TopicListCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            UILabel *titleLabel = [ViewTool addUILable:TopicListCell x:20 y:7 x1:260 y1:20 fontSize:14 lableText:[[TopicArray objectAtIndex:indexPath.row-1] objectForKey:@"title"]];
            titleLabel.textColor = [UIColor blackColor];
            titleLabel.font = [UIFont systemFontOfSize:16];
            
            UILabel *subtitleLabel = [ViewTool addUILable:TopicListCell x:20 y:30 x1:100 y1:20 fontSize:14 lableText:[[TopicArray objectAtIndex:indexPath.row-1] objectForKey:@"name"]];
            subtitleLabel.textColor = [UIColor grayColor];
            subtitleLabel.font = [UIFont systemFontOfSize:14];
            NSString *time = [self timeStampeToNSDateString:[[TopicArray objectAtIndex:indexPath.row-1] objectForKey:@"dateline"]];
            UILabel *timetitleLabel = [ViewTool addUILable:TopicListCell x:220 y:30 x1:100 y1:20 fontSize:14 lableText:time];
            timetitleLabel.textColor = [UIColor grayColor];
            timetitleLabel.font = [UIFont systemFontOfSize:14];
            
            UIImageView *pointView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cycle.png"]];
            [pointView setFrame:CGRectMake(7, 21, 8, 8)];
            [TopicListCell addSubview:pointView];
            [pointView release];
            
            TopicListCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        return TopicListCell;
    }
}
- (void)loadmore
{
    showalert = YES;
    isMore = YES;
    pagenum += 1;
    ASIHTTPRequest *request2 = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:TopicListRequestURLWithPage(pagenum)]];
    [request2 setTag:1];
    //[request2 setDownloadCache:[ASIDownloadCache sharedCache]];
    //[request2 setCachePolicy:ASIAskServerIfModifiedWhenStaleCachePolicy];
    [request2 setDelegate:self];
    [request2 setPersistentConnectionTimeoutSeconds:30];
    [request2 startAsynchronous];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [TopicArray count]+2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath row] == 0) {
        return 170;
    }
    else return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        ReaderController *reader = [[ReaderController alloc] init];
        if(indexPath.row == 0){
            reader.Title = [[TopicPicArray objectAtIndex:0] objectForKey:@"title"];
            reader.tid = [[[TopicPicArray objectAtIndex:0] objectForKey:@"id"] intValue];
        }else{
            reader.Title = [[TopicArray objectAtIndex:indexPath.row-1] objectForKey:@"title"];
            reader.tid = [[[TopicArray objectAtIndex:indexPath.row-1] objectForKey:@"id"] intValue];
        }
        [reader setHidesBottomBarWhenPushed:YES];
        [myDelegate hideImage];
        [self.navigationController pushViewController:reader animated:YES];
    [mytableview deselectRowAtIndexPath:indexPath animated:NO];
}

- (NSString *)timeStampeToNSDateString:(NSString *)timeStame {
	NSDate *tranData = [NSDate dateWithTimeIntervalSince1970:[timeStame doubleValue]];
	return [tranData formatRelativeTime];
}

#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
	
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
	_reloading = YES;
	[self performSelector:@selector(dragUpdateTableView)];
}

- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
	
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:mytableview];
	
}

- (void)dragUpdateTableView {
    showalert = YES;
    //请求数据
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:TopicPicRequestURL]];
	[request setTag:0];
	//[request setDownloadCache:[ASIDownloadCache sharedCache]];
	//[request setCachePolicy:ASIAskServerIfModifiedWhenStaleCachePolicy];
	[request setDelegate:self];
    [request setPersistentConnectionTimeoutSeconds:30];
	[request startAsynchronous];
    
    ASIHTTPRequest *request2 = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:TopicListRequestURLWithPage(1)]];
	[request2 setTag:1];
	//[request2 setDownloadCache:[ASIDownloadCache sharedCache]];
	//[request2 setCachePolicy:ASIAskServerIfModifiedWhenStaleCachePolicy];
	[request2 setDelegate:self];
    [request2 setPersistentConnectionTimeoutSeconds:30];
	[request2 startAsynchronous];
    
    isMore = NO;
}

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
@end
