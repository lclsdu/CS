//
//  BBSController.h
//  化龙巷
//
//  Created by Kryhear on 12-2-17.
//  Copyright (c) 2012年 Osugroup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tools.h"
#import "CommonObject.h"
#import "ReaderController.h"
#import "ColumnObject.h"
#import "FavouriteObject.h"
#import "DetailController.h"
#import "Constants.h"
#import  "DebugLog.h"
extern bool isInReader;

@interface subBBSViewController : UIViewController <UITableViewDelegate ,UITableViewDataSource, EGORefreshTableHeaderDelegate > {
	UITableView *tableView;
	NSMutableArray *resultArray;
	NSMutableArray *btnArray;
    
	UIImageView *selectView;
	int pageNum, selectTag;
	EGORefreshTableHeaderView *_refreshHeaderView;
	BOOL _reloading, isMore;
	UIActivityIndicatorView *_activityView;
	UILabel *_loadLabel;
    UIImageView *_loadingView;
    UIView * bottomView;
    
    
	int hashLoad[200];
    ASIHTTPRequest *myRequest;
	
}
@property (nonatomic, retain)  NSMutableArray * fidArray;
@property (nonatomic, retain)  NSMutableArray * childArray;
@property (nonatomic, retain) ASIHTTPRequest *myRequest;
@property (nonatomic,strong) NSString *api_url;
- (void)pressMenu:(UIButton *)sender;
- (void)pressMenu:(UIButton *)sender More:(BOOL) isMore;
- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;
@end

