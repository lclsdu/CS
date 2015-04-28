//
//  BBSController.m
//  化龙巷
//
//  Created by Kryhear on 12-2-17.
//  Copyright (c) 2012年 Osugroup. All rights reserved.
//

#import "subBBSViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"

#define kHeatPostRequestURLWithPage(x) [NSString stringWithFormat:@"http://bbs.hualongxiang.com/iphoneapi/gs_android_smalltt.php?id=client_%%CD%%B7%%CC%%F5%%D0%%A1%%CD%%BC&page=%d",x]
#define kHeatColumnRequestURLWithPage(x) [NSString stringWithFormat:@"http://bbs.hualongxiang.com/iphoneapi/gs_android_highlightsubject.php?fid=103&page=%d",x]


#define kForumsRequestURLWithPage(x) [NSString stringWithFormat:@"%@topiclist.php?type=forum_list",api_url];
#define kSearchRequestURLWithPage(x) [NSString stringWithFormat:@"http://bbs.hualongxiang.com/iphoneapi/gs_android_highlightsubject.php?fid=1054&page=%d",x]


#define kForumsTag 200
#define kFavoriteTag 201
#define kRecentTag 202

@implementation subBBSViewController
@synthesize api_url;
@synthesize myRequest;
@synthesize fidArray,childArray;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillDisAppear:(BOOL)animated;  
{
    
    if (myRequest) [myRequest cancel];
    
    
    
    
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
/*
 -(void)viewWillAppear:(BOOL)animated {
 
 [UIView animateWithDuration:0.35 animations:^{
 for (int i = 0; i < [((CustomTabBar *)self.tabBarController).buttons count]; i++) {
 UIButton *btn = [((CustomTabBar *)self.tabBarController).buttons objectAtIndex:i];
 [btn setFrame:CGRectMake(btn.frame.size.width*i, self.tabBarController.tabBar.frame.origin.y, btn.frame.size.width, btn.frame.size.height)];
 }
 UIView *slideView = ((CustomTabBar *)self.tabBarController).slideBg;
 [slideView setAlpha:1.0];
 }];
 
 }
 */
-(void)viewWillAppear:(BOOL)animated {
    
//    [UIView animateWithDuration:0.35 animations:^{
//        for (int i = 0; i < [((CustomTabBar *)self.tabBarController).buttons count]; i++) {
//            UIButton *btn = [((CustomTabBar *)self.tabBarController).buttons objectAtIndex:i];
//            [btn setFrame:CGRectMake(btn.frame.size.width*i, self.tabBarController.tabBar.frame.origin.y, btn.frame.size.width, btn.frame.size.height)];
//            [btn setHidden:false]; }
//        UIView *slideView = ((CustomTabBar *)self.tabBarController).slideBg;
//        [slideView setHidden:false];
//        [slideView setAlpha:1.0];
//    }]; 
    
    
    bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 368, 320, 48)];
    [bottomView setBackgroundColor:[UIColor colorWithRed:0.922 green:0.922 blue:0.922 alpha:1.000]];
    [self.view addSubview:bottomView];
    
    
}


#pragma mark - View lifecycle

-(void)refreshFavoriteNotification:(NSNotification *)notification;
{
    
    if(selectTag==kFavoriteTag)
        
    {
        
        [resultArray removeAllObjects];
        
        [SqliteSet queryFavourite:resultArray];
        
        [tableView reloadData];
        
        
    }
    
    
    
}
- (void)viewDidLoad
{
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:0.267 green:0.490 blue:0.843 alpha:1.000]];
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    api_url = delegate.myDomainAndPathVeryNC;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearHistoryNotification:) name:@"notifyToClearHistoryNotification" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshFavoriteNotification:) name:@"notifyToRefreshFavoriteNotification" object:nil];
    
    
    
	[[self navigationItem] setTitle:@"子板"];
	
	resultArray = [[NSMutableArray alloc] init];
	btnArray = [[NSMutableArray alloc] init];
	pageNum = 1;
	
	UIImageView *menuBack = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menuback.png"]];
	[[self view] addSubview:menuBack];
	[menuBack release];
    
    
	selectView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navi.png"]];
    
    
    
    
    
	[selectView setFrame:CGRectMake(10, 5, 100, 23)];
	[selectView.layer setMasksToBounds:YES];
	[selectView.layer setCornerRadius:4.0];
	[[self view] addSubview:selectView];
	[selectView release];
    
    
	NSArray *btnTitleArray = [NSArray arrayWithObjects:@"",nil];
	for (int i = 0; i < [btnTitleArray count]; i++) {
		UIButton *menuBtn = [[UIButton alloc] initWithFrame:CGRectMake(10 + 100*i, 5, 100, 23)];
		[menuBtn setTitle:[btnTitleArray objectAtIndex:i] forState:UIControlStateNormal];
		[menuBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
		[menuBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
		[menuBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
		[menuBtn setTag:kForumsTag + i];
		[menuBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
		[menuBtn addTarget:self action:@selector(pressMenu:) forControlEvents:64];
		[[self view] addSubview:menuBtn];
		[menuBtn release];
		[btnArray addObject:menuBtn];
		[menuBtn release];
	}
	
    
    
	tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 368) style:UITableViewStylePlain];
	[tableView setDelegate:self];
	[tableView setDataSource:self];
	[self.view addSubview:tableView];
	[tableView setSeparatorColor:[UIColor clearColor]];
	[tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
	[tableView setBackgroundColor:[UIColor colorWithRed:0.922 green:0.922 blue:0.922 alpha:1.000]];
	[tableView release];
    
    
	if (_refreshHeaderView == nil) {
		
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - tableView.bounds.size.height, self.view.frame.size.width, tableView.bounds.size.height)];
		view.delegate = self;
		[tableView addSubview:view];
		_refreshHeaderView = view;
		[view release];
		
	}
    
	
	[self pressMenu:[btnArray objectAtIndex:0]];
    
    

    
    
    
	
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}



- (void)viewDidDisappear:(BOOL)animated{




} 



- (void)pressMenu:(UIButton *)sender {
    DebugLog(@"sender.tag----------%d", sender.tag);
	if (sender.tag != selectTag) {
		pageNum = 1;
		
		[self pressMenu:sender More:NO];
		
	}
	
}
- (void)dealloc {
    
    
    [myRequest release];
    myRequest=nil;
    
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"notifyToClearHistoryNotification" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"notifyToRefreshFavoriteNotification" object:nil];
    
    
    [super dealloc];
    
    
    
    
}

-(void)clearHistoryNotification:(NSNotification *)notification;
{
    
    
    if (isMore) {
        [resultArray removeLastObject];
    }
    else {
        pageNum = 1;
        [resultArray removeAllObjects];
    }
    [tableView reloadData];
    
}
- (void)pressMenu:(UIButton *)sender More:(BOOL)_isMore{
	for (UIButton *tmpBtn in btnArray) {
		[tmpBtn setSelected:NO];
	}
    
	[sender setSelected:YES];
	[UIView animateWithDuration:0.2f animations:^{
		CGRect frame = [sender frame];
		frame.origin.x -= 2;	 
		[selectView setFrame:frame];
	}];
	selectTag = sender.tag;
	isMore = _isMore;
	
	
 
	switch (selectTag) {
		case kForumsTag:{
            [resultArray removeAllObjects];
            ColumnList * object=[[ColumnList alloc]init];
            object.fidArray=fidArray;
            object.childArray=childArray;
            [resultArray addObject:object];
            [object release];
            [tableView reloadData];
            
			break;
		}
		case kFavoriteTag:{
            DebugLog(@"kFavoriteTag----%d",[resultArray count] );
            [resultArray removeAllObjects];
            
            [SqliteSet queryFavourite:resultArray];
            
          
			[tableView reloadData];
            
			break;
		}
		case kRecentTag:{
			if (isMore) {
				[resultArray removeLastObject];
			}
			else {
				pageNum = 1;
				[resultArray removeAllObjects];
			}
            int n=[resultArray count];
			[SqliteSet queryRecentView:pageNum Array:resultArray];
            if(n==[resultArray count])
                
                [resultArray addObject:@"没有更多信息"];
            else
                [resultArray addObject:@"更多"];
            
            
            
			[tableView reloadData];
            
			break;
		}
	}
	
}



#pragma mark -
#pragma mark UITableViewDataSource


- (void)tableView:(UITableView *)_tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
	if (selectTag == kForumsTag) {
		ColumnList *selectList = [resultArray objectAtIndex:indexPath.section];
		DetailController *detail = [[DetailController alloc] init];
		detail.fid = [[selectList.fidArray objectAtIndex:indexPath.row]intValue];
		detail.ftitle = [selectList.childArray objectAtIndex:indexPath.row];
		[detail setHidesBottomBarWhenPushed:YES];
		[self.navigationController pushViewController:detail animated:YES];
		[detail release];

        
		
	}

	else if (selectTag == kRecentTag) {
		if (indexPath.row == [resultArray count] - 1) {
			pageNum++;
			UIButton *moreBtn = (UIButton *)[self.view viewWithTag:selectTag];
			[self pressMenu:moreBtn More:YES];
		}
		else {
			FavouriteObject *recent = [resultArray objectAtIndex:indexPath.row];
			ReaderController *reader = [[ReaderController alloc] init];
                        
            reader.isFromDetail=true;
			reader.Title = recent.Name;
			reader.tid = recent.Fid;
			[self.navigationController pushViewController:reader animated:YES];
			[reader release];
		}
	}
    
    else
    {
 
		DetailController *detail = [[DetailController alloc] init];
        
		detail.fid = [[resultArray objectAtIndex:indexPath.row] Fid]; //[[selectList.fidArray objectAtIndex:indexPath.row] intValue];
		detail.ftitle =[[resultArray objectAtIndex:indexPath.row] Name];  //[selectList.childArray objectAtIndex:indexPath.row];
		[detail setHidesBottomBarWhenPushed:YES];
		[self.navigationController pushViewController:detail animated:YES];
		[detail release];


        
    }
}




    
    
    
    




//为tableview添加项
- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    DebugLog(@"cellForRowAtIndexPath-----%d--------%d",indexPath.section,indexPath.row);
    DebugLog(@"resultArray---count---%d---",[resultArray count]);
	static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:nil];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	[cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
    
	SSLineView *lineView = [[SSLineView alloc] initWithFrame:CGRectMake(0, 49, 320, 2)];
	[cell addSubview:lineView];
    
    
    
	if (selectTag == kForumsTag) {
        
        
		ColumnList *columns = [resultArray objectAtIndex:indexPath.section];
		[ViewTool addUILable:cell x:45 y:15 x1:200 y1:20 fontSize:15 lableText:[columns.childArray objectAtIndex:indexPath.row]];
		UIImageView *pointView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cycle.png"]];
		[pointView setFrame:CGRectMake(32, 21, 8, 8)];
		[cell addSubview:pointView];
		[pointView release];
        
	}
	else if (selectTag == kFavoriteTag){
        
        //robust
        if([[resultArray objectAtIndex:indexPath.row] isKindOfClass:[FavouriteObject class]])
        {
            
            FavouriteObject *cellObject = [resultArray objectAtIndex:indexPath.row];
            //verync crash
            UILabel *titleLabel = [ViewTool addUILable:cell x:25 y:5 x1:270 y1:40 fontSize:15 lableText:cellObject.Name]  ;//帖子标题
            
            
            [titleLabel setHighlightedTextColor:[UIColor whiteColor]];
            //  [titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
            titleLabel.numberOfLines = 2;
            UIImageView *accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow.png"]];
            [cell setAccessoryView:accessoryView];
        }
        
	}
	else if (selectTag == kRecentTag){
		if ([indexPath row] == [resultArray count] - 1 && [resultArray count] != 0) {
            
            //[cell.textLabel setText:@"更多"];
            [cell.textLabel setText:  [resultArray  objectAtIndex:[resultArray count] - 1]];
			[cell.textLabel setTextAlignment:UITextAlignmentCenter];
        }
        else {
            //robust
            if([[resultArray objectAtIndex:indexPath.row] isKindOfClass:[FavouriteObject class]])
            {
                
                
                FavouriteObject *cellObject = [resultArray objectAtIndex:indexPath.row];
                UILabel *titleLabel = [ViewTool addUILable:cell x:25 y:5 x1:270 y1:40 fontSize:15 lableText:cellObject.Name];//帖子标题
                [titleLabel setHighlightedTextColor:[UIColor whiteColor]];
                //[titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
                titleLabel.numberOfLines = 2;
                
            }
        }
	}
	if (selectTag == kForumsTag || [indexPath row] != [resultArray count] - 1) {
		UIImageView *accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow.png"]];
		[cell setAccessoryView:accessoryView];
		[accessoryView release];
	}
	return cell;
}

//每组的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    DebugLog(@"--numberOfRowsInSection----selectTag------%d",selectTag);
	if (selectTag == kForumsTag) {
        DebugLog(@"hello");
		ColumnList *columns = [resultArray objectAtIndex:section];
        
			return [columns.childArray count]; 
		
	}
	DebugLog(@"resultArray---count---%d-section-%d--",[resultArray count],section);
	return [resultArray count];
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
	
	//  model should call this when its done loading
	
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:tableView];
	
}

- (void)dragUpdateTableView {
	pageNum = 1;
	UIButton *tmpBtn = (UIButton *)[self.view viewWithTag:selectTag];
	[self pressMenu:tmpBtn More:NO];
}

#pragma mark -
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
