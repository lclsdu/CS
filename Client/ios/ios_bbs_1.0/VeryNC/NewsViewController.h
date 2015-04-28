

#import <UIKit/UIKit.h>
#import "MyProtocol.h"
#import "AppDelegate.h"
 
#import "Constants.h"
#import "Tools.h"
#import "ReaderController.h"
#import "WEPopoverController.h"
#import "WEPopoverOrderViewController.h"
#import "editTableViewController.h"
#import "ViewMoreSettingController.h"
#import "ViewMoreAboutController.h"
#import "NewsMoreHeaderViewController.h"
#import "newsHeaderObject.h"
#import "collectionViewController.h"
#import "ColumnObject.h"
#import "DetailController.h"
#import "EGORefreshTableHeaderView.h"

#import "KButton.h"
#import "FrameArrayObject.h"
@interface NewsViewController : UIViewController<MyprotocolDelegate, UIScrollViewDelegate,EGORefreshTableHeaderDelegate>{
    //基本框架
    IBOutlet id<MyprotocolDelegate> myDelegate;
	AppDelegate *appDelegate;
    IBOutlet UIScrollView * _scrollView;
    
    UIButton *orderButton;
    UIButton *forumOrderButton;
    UIButton *moreBtn;
    WEPopoverController *popoverOrderController;
    UITableView *tableView;
    UIPageControl * pageController;
    UIScrollView  *scrollview;
    NSString *requestURL;
    int requestTag;
    
    UIImageView *selectView;
    UIImageView *overflowLeftView;
    UIImageView *overflowRightView;
    
	UIActivityIndicatorView *_activityView;
	UILabel *_loadLabel;
    UIImageView *_loadingView;
        
	int hashLoad[200];    
    
    bool _isHead;
    
    BOOL _reloading, isMore;
    int pageNum;
    int countOfRequest;
    int countOfHeader;
    int countOfBigPic;
    int indexOfBigPic;
    
    NSInteger selectTag;
    
//discuz tag
    BOOL discuzTag;
    
//sql tag 
    
    BOOL sqlTag;
    NSMutableArray * sqlArray;
    
//big pic
    CommonObject *cellHLine1;
    CommonObject *cellHLine2;
    CommonObject *cellHLine3;
    UILabel *titleLabel;
        
    NSMutableArray *resultHeadArray;
    NSMutableArray *resultArray;
    NSMutableArray *resultMoreArray;
    NSMutableArray * resultDiscuzArray;
    NSMutableArray *btnArray;
    NSMutableArray * tabBar1Array;
    
    EGORefreshTableHeaderView *_refreshHeaderView;
    
    NSInteger numberPageUnderHeadBigPicture;
    bool isEdit;

}
@property (nonatomic,retain) NSMutableArray * buttonFrameArray;
@property (retain,nonatomic) AppDelegate *appDelegate;
@property (nonatomic, assign)IBOutlet id<MyprotocolDelegate> myDelegate;
@property (nonatomic,retain) NSMutableArray * sqlArray;
@property (nonatomic,retain) NSString *myDomainAndPathVeryNC;
@property (nonatomic, retain) UIButton *orderButton;
@property (nonatomic, retain) WEPopoverController *popoverOrderController;
@property (nonatomic, retain) CommonObject *cellHLine1;
@property (nonatomic, retain) CommonObject *cellHLine2;
@property (nonatomic, retain) CommonObject *cellHLine3;
@property (nonatomic, retain) NSString *requestURL;
@property (nonatomic,retain) NSString *moreTip;

- (void)pressMenu:(UIButton *)sender;
- (void)pressMenu:(UIButton *)sender More:(BOOL) isMore;

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

@end
