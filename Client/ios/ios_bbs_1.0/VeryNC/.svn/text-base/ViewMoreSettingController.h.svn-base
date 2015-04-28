//
//  ViewMoreSettingController.h
//   
//
//  Created by David Suen on 12-3-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyProtocol.h"
#import "AppDelegate.h"
#import "Constants.h"
#include "DebugLog.h" 

@interface ViewMoreSettingController : UIViewController<MyprotocolDelegate>
{
    id<MyprotocolDelegate> myDelegate;
    IBOutlet   UITableView *tableView;
    AppDelegate *appDelegate;
    
}
@property (nonatomic, retain)  UITableView *tableView;
@property (nonatomic, assign) id<MyprotocolDelegate > myDelegate;
@property (retain,nonatomic) AppDelegate *appDelegate;
 
@end
