//
//  evaluationAddViewController.h
//  化龙巷
//
//  Created by mac on 12-3-29.
//  Copyright (c) 2012年 Osugroup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tools.h"
//ASI
#import "ASIHTTPRequest.h"
#import "ASIDownloadCache.h"
#import "ASIFormDataRequest.h"
#import  "DebugLog.h"
@interface evaluationAddViewController : UIViewController
@property (nonatomic,retain) UITextView *textView;
@property (nonatomic,retain) NSString *shop_id;
@property (nonatomic,retain) NSString *mark_value;
@property (nonatomic,retain) UISegmentedControl *segbutton;
@property (nonatomic,strong) NSString *api_url;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollerView;
-(IBAction)selectmark:(id)sender;
-(IBAction)backgroundTap:(id)sender;
@end
