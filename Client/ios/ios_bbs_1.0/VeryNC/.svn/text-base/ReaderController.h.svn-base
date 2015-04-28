//
//  ReaderController.h
//  化龙巷
//
//  Created by Kryhear on 12-2-24.
//  Copyright (c) 2012年 Osugroup. All rights reserved.
//

#import "MyProtocol.h"
#import "AppDelegate.h"

#import <UIKit/UIKit.h>
#import "Tools.h"
#import "DetailObject.h"
#import "NSString+DecodingEntities.h"
#import "NSVeryDateAdditions.h"
#import "SqliteSet.h"
#import  "DebugLog.h"
#import "ReplyViewController.h"
#import "MoreAccountViewController.h"
#import "ViewMoreFeedbackController.h"
#import "WebViewController.h"
#import "ColumnObject.h"
#import "ShareViewController.h"
#import "CommonObject.h"
#import "Constants.h"
//#import "ShareService/UI/SHSShareViewController.h"

#import "TemMessageArrayObject.h"


#import "Reachability.h"


@interface ReaderController : UIViewController <UIWebViewDelegate, UITableViewDelegate ,UITableViewDataSource, EGORefreshTableHeaderDelegate, UIWebViewDelegate,UIGestureRecognizerDelegate,UIActionSheetDelegate,UITextViewDelegate> {
    
    IBOutlet id<MyprotocolDelegate> myDelegate;
    AppDelegate *appDelegate;    
    
    
	UITableView *tableView;
	NSMutableArray *resultArray, *btnArray;
	UIImageView *selectView;
	int pageNum, selectTag, maxPage;
	BOOL _reloading;
	UIActivityIndicatorView *_activityView;
	UILabel *_loadLabel;
    UIImageView *_loadingView;
    BOOL _viewLou;
    bool isInReader;
    UIButton * collectionButton;
    
    BOOL quoteTag;
    
    
    
	int hashLoad[200];
 
	UIToolbar *toolBar;
	UILabel *pageNumLabel;
	int authorid;
    
    
    // quickly comment
    UIView * writeView;
    BOOL writeViewTag;
    UIView * removeView;
    UITextView * textView;
    UIButton * publishButton;
 
   // ASIHTTPRequest *myRequest;
	
}
//@property (nonatomic, retain) ASIHTTPRequest *myRequest;


@property (nonatomic, assign) bool isWorkingASI;
@property (nonatomic,assign) bool isFromDetail;
 
 

 
 
@property (nonatomic, retain) NSString *htmlString;
@property (nonatomic, retain) UIWebView *htmlWebView;



@property (nonatomic, assign) int fid;
@property (nonatomic, assign) int tid;
@property (nonatomic, retain) NSString *Title;
@property (nonatomic,retain) NSString *api_url;
@property (nonatomic,assign) int isclosed;

- (void)pressMenu:(UIButton *)sender;
- (void)pressMenu:(UIButton *)sender More:(BOOL) isMore;
- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;
- (NSString *)formatContent:(NSString *)string;
//- (int)HeihtWithContent:(NSString *)string;
- (NSString *)timeStampeToNSDateString:(NSString *)timeStame;


//引用回复
@property (nonatomic, assign) NSInteger pid;
@property (nonatomic, assign) NSInteger ptid;
@property (nonatomic, retain) NSString *authorQuote;
@property (nonatomic, retain) NSString *messageQuote;
@property (nonatomic, retain) NSString *datelineQuote;

@property (nonatomic, assign)IBOutlet id<MyprotocolDelegate> myDelegate;
@property (retain,nonatomic) AppDelegate *appDelegate;

@property (nonatomic,strong) NSString *quoteImage_url;

-(NSString *)formatMessageAndAuthor:(NSString *)string;

@end
