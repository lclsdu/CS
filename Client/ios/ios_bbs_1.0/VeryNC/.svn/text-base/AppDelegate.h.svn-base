

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "SqliteSet.h" 
#import "DebugLog.h" 
#import "ASIHTTPRequest.h"
#import "ASIDownloadCache.h"
#import "Tools.h"
 

@class RootController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>{

    IBOutlet UIWindow *window;
    IBOutlet RootController *rootController;
    
    //如果需要全程变量放在这 通过 appDelegate 访问
    NSString *myDomainAndPathVeryNC;
	NSString *userName;
    
	NSMutableArray *newsHeaderArray1;
	NSMutableArray *newsHeaderMoreArray;
    
    int tid;
    
    BOOL isPushView;
    
    NSString *tokenKey;
    
//    NSArray *indexTitleArray;
    
    
}

@property (nonatomic, retain)NSString *myDomainAndPathVeryNC;
@property (nonatomic, retain)NSString *userName;
@property (nonatomic, retain) NSString *tokenKey;

@property (nonatomic,strong) NSString *loginTip;
@property (nonatomic,strong) NSString *loginURL;

@property (retain,nonatomic) NSMutableArray *newsHeaderArray1;
@property (retain,nonatomic) NSMutableArray *newsHeaderMoreArray;

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet RootController *rootController;

@property (nonatomic,strong) NSString *quoteImageURL;
//@property (nonatomic, retain) NSArray *indexTitleArray;

@end
