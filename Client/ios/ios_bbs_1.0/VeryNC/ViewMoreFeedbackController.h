//
//  ViewMoreFeedbackController.h
//   
//
//  Created by David Suen on 12-3-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyProtocol.h"
#import "AppDelegate.h"
#import "Constants.h"
#import "Tools.h"
#include "DebugLog.h" 
#import "ASIFormDataRequest.h"
@interface ViewMoreFeedbackController : UIViewController<MyprotocolDelegate>
 
{

        
    id<MyprotocolDelegate> myDelegate;

    IBOutlet   UITableView *tableView1;
    UITextView *textView;
    UIActivityIndicatorView *_activityView;
    UILabel *_loadLabel;
    UIImageView *_loadingView;

}
@property (nonatomic, retain)  UITextView *  textView;
@property (nonatomic, retain)  IBOutlet UITableView *tableView1;
@property (nonatomic, retain)UILabel *_loadLabel;
@property (nonatomic, retain)UIImageView *_loadingView;
@property (nonatomic, retain)  UIActivityIndicatorView *_activityView;
@property (nonatomic, assign) id<MyprotocolDelegate> myDelegate;
@property (nonatomic,strong) NSString *api_url;
@end
