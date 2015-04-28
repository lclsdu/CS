
 
#import <UIKit/UIKit.h>
#import "MyProtocol.h"
#import "AppDelegate.h"
#import "Constants.h"
#include "DebugLog.h" 
#import "LoadingView.h"

#import "ASIHTTPRequest.h"
#import "ASIDownloadCache.h"

#import "ViewTool.h"

@class NewsViewController;
@class topicViewController;
@class photoViewController;
@class businessViewController;
@class voteViewController;
@class postViewController;

@interface RootController : UITabBarController <MyprotocolDelegate, UITabBarControllerDelegate>
{
    //基本框架
    id<MyprotocolDelegate> myDelegate;
	AppDelegate *appDelegate;
    
    //controllers
    IBOutlet NewsViewController * vNewsViewController;
    IBOutlet topicViewController * vtopicViewController;
    IBOutlet businessViewController * vbusinessViewController;
    IBOutlet photoViewController * vphotoViewController;
    IBOutlet voteViewController * vvoteViewController;
    IBOutlet postViewController * vpostViewController;
    
    IBOutlet UIImageView *homeImageView;
    IBOutlet UIImageView *classificationImageView;
    IBOutlet UIImageView *shoppingcartImageView;
    IBOutlet UIImageView *myshopImageView;
    IBOutlet UIImageView *moreImageView;
    IBOutlet UIImageView *postImageView;
    
    LoadingView *_loadView;
    UIAlertView *aAlert;
    
    UIActivityIndicatorView *_activityView;
	UILabel *_loadLabel;
    UIImageView *_loadingView;
    
}
 
@property (retain,nonatomic) AppDelegate *appDelegate;
@property (nonatomic, assign) id<MyprotocolDelegate> myDelegate;
@property (nonatomic, retain) NSString *api_url;

@property (retain,nonatomic)IBOutlet UIImageView *homeImageView;
@property (retain,nonatomic)IBOutlet UIImageView *classificationImageView;
@property (retain,nonatomic)IBOutlet UIImageView *shoppingcartImageView;
@property (retain,nonatomic)IBOutlet UIImageView *myshopImageView;
@property (retain,nonatomic)IBOutlet UIImageView *moreImageView;
@property (retain,nonatomic)IBOutlet UIImageView *postImageView;

@property (retain,nonatomic)IBOutlet NewsViewController * vNewsViewController;
@property (retain,nonatomic)IBOutlet topicViewController * vtopicViewController;
@property (retain,nonatomic)IBOutlet businessViewController * vbusinessViewController;
@property (retain,nonatomic)IBOutlet photoViewController * vphotoViewController;
@property (retain,nonatomic)IBOutlet voteViewController * vvoteViewController;
@property (retain,nonatomic)IBOutlet postViewController * vpostViewController;

@end
