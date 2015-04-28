//
//  FaceScrollView.h
//  FaceDemo
//
//  Created by user on 11-10-20.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ASIDownloadCache.h"
#include "Constants.h"
#import "ASIFormDataRequest.h"

extern int faceAmountGlobal;
@interface FaceScrollView : UIScrollView
{
    
    NSInteger faceAmount;
    
}
- (id)initWithFrame:(CGRect)rect target:(id)target;

@property (nonatomic, assign) NSInteger faceAmount;
@property (nonatomic,strong) NSString *api_url;

@end
