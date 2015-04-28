#import <UIKit/UIKit.h>
#import "MyProtocol.h"
#import "AppDelegate.h"
#import "Constants.h"
#import "Tools.h"



#include "DebugLog.h" 


@interface topicViewController : UIViewController<MyprotocolDelegate,UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate>
{
    //基本框架
    IBOutlet id<MyprotocolDelegate> myDelegate;
    AppDelegate *appDelegate;
    
    NSMutableArray *TopicPicArray;
    NSMutableArray *TopicArray;
    UIActivityIndicatorView *_activityView;
	UILabel *_loadLabel;
    UIImageView *_loadingView;
    
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading,isMore;
    int pagenum;
    NSString *loadmore_Tip;
    
    BOOL showalert;
}

@property (retain,nonatomic) AppDelegate *appDelegate;
@property (nonatomic, assign) id<MyprotocolDelegate> myDelegate;
@property (nonatomic,strong) NSString *api_url;
@property (nonatomic,retain) NSMutableArray *TopicPicArray;
@property (nonatomic,retain) NSMutableArray *TopicArray;
@property (nonatomic,retain) IBOutlet UITableView *mytableview;
@property (nonatomic,retain) UIButton *morebtn;
@end