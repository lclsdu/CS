//
//  CustomActionSheetPollReview.h
//  VeryNC
//
//  Created by mac on 12-5-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tools.h"
@interface CustomActionSheetPollReview : UIActionSheet{
    UIView *view;
    NSString *Tid;
}
@property(nonatomic,retain)UIView* view;
@property (nonatomic,strong) NSString *api_url;
-(id)initWithHeight:(float)height Title:(NSString *)polltitle withtid:(NSString *)tid;
@end