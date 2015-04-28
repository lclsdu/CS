//
//  collectionViewController.h
//  VeryNC
//
//  Created by 吴 津津 on 12-5-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tools.h"
#import "CommonObject.h"
#import "ReaderController.h"
#import "FavouriteObject.h"
#import "Constants.h"
#import  "DebugLog.h"
#import "ReaderController.h"

@interface collectionViewController : UIViewController {
    //基本框架
    IBOutlet id<MyprotocolDelegate> myDelegate;
    
	UITableView *tableView;
	NSMutableArray *resultArray;
	NSMutableArray *btnArray;
    
	UIImageView *selectView;
	int pageNum, selectTag;
    //	EGORefreshTableHeaderView *_refreshHeaderView;
	BOOL _reloading, isMore;
	UIActivityIndicatorView *_activityView;
	UILabel *_loadLabel;
    UIImageView *_loadingView;
    
    
	int hashLoad[200];
    
	UIImageView *photoViewBackgroundImage;
    
    NSMutableArray *picarray;
    
    UIScrollView *scrollView;
}

@property (nonatomic,strong) NSString *api_url;
@property (nonatomic,strong) NSMutableArray *picarray;
- (void)pressMenu:(UIButton *)sender;
- (void)pressMenu:(UIButton *)sender More:(BOOL) isMore;
//- (void)reloadTableViewDataSource;
//- (void)doneLoadingTableViewData;

@end
