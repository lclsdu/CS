//
//  DetailController.h
//  化龙巷
//
//  Created by Kryhear on 12-3-8.
//  Copyright (c) 2012年 Osugroup. All rights reserved.
//
#import "MyProtocol.h"
#import "AppDelegate.h"

#import <UIKit/UIKit.h>
#import "Tools.h"
#import "CommonObject.h"
#import "ReaderController.h"
#include "Constants.h"
#import  "DebugLog.h"
#import "ColumnObject.h"
#import "NewPostViewController.h"
@class WEPopoverController;
extern bool isInReader;
@interface DetailController : UIViewController<MyprotocolDelegate,UIApplicationDelegate, UITableViewDelegate ,UITableViewDataSource, EGORefreshTableHeaderDelegate,UIImagePickerControllerDelegate> {
    IBOutlet id<MyprotocolDelegate> myDelegate;
    AppDelegate *appDelegate;
	UITableView *tableView;
	NSMutableArray *resultArray;
	NSMutableArray *btnArray, *btnSubArray;
	UIImageView *selectView;
	int pageNum, selectTag, maxPage, selectBeforeSub, nowpagenum;
	EGORefreshTableHeaderView *_refreshHeaderView;
	BOOL _reloading, isMore, exceptionTag;
    
	UIActivityIndicatorView *_activityView;
	UILabel *_loadLabel;
    UIImageView *_loadingView;
    ColumnList *selectList;
    
    
	int hashLoad[200];
    UILabel *pageNumLabel;
    
 
    BOOL loadingReader;    
	NSString *moreTip;
}

@property (nonatomic, retain)NSMutableArray * fidSubArray;
@property (nonatomic, retain)NSMutableArray * namesSubArray;
 
@property (nonatomic, assign) int fid;

@property (nonatomic, assign)IBOutlet id<MyprotocolDelegate> myDelegate;
@property (retain,nonatomic) AppDelegate *appDelegate;
@property (nonatomic, retain) UIButton *favoriteButton;

@property (nonatomic,retain) NSString *myDomainAndPathVeryNC;
@property (nonatomic,retain) NSString *ordertype;

@property (nonatomic, retain) NSString *ftitle;
@property (nonatomic, retain) UIButton *orderButton;
@property (nonatomic, retain) WEPopoverController *popoverOrderController;
@property (nonatomic,assign) int selectSubTag;

- (void)pressMenu:(UIButton *)sender;
- (void)pressMenu:(UIButton *)sender More:(BOOL) isMore;
- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;
@end
