//
//  VoteOneViewController.h
//  VeryNC
//
//  Created by mac on 12-4-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyProtocol.h"
#import "AppDelegate.h"
#import "Constants.h"
#import "Tools.h"
@interface VoteOneViewController : UIViewController
{
    UIButton *menuBtn;
    UILabel *tipLabel;
}
@property (nonatomic,strong) NSString *api_url;
@property (nonatomic,strong) NSString *polltitle;
@property (nonatomic,strong) NSString *ttitle;
@property (nonatomic,strong) NSString *tid;
@property (nonatomic,strong) NSString *num;
@end
