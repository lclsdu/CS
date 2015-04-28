//
//  MoreAccountAddViewController.h
//  化龙巷
//
//  Created by mac on 12-3-22.
//  Copyright (c) 2012年 Osugroup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tools.h"
#import <CommonCrypto/CommonDigest.h>
#import "Constants.h"
#import  "DebugLog.h"
@interface MoreAccountAddViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain) UITextField *username;
@property(nonatomic,retain) UITextField *password;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *aiv;
@property (nonatomic,strong) NSString *api_url;
@property (nonatomic,strong) NSString *loginTip;
@property (nonatomic,strong) NSString *loginURL;
-(void)logindo:(id)sender;
@end
