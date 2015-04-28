//
//  voteViewController.h
//  VeryNC
//
//  Created by wu jinjin on 12-4-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyProtocol.h"
#import "AppDelegate.h"
#import "Constants.h"
#import "Tools.h"
@class VoteOneViewController;
@class VoteTwoViewController;
@interface voteViewController : UIViewController<UIScrollViewDelegate>
{
    //基本框架
    id<MyprotocolDelegate> myDelegate;
    AppDelegate *appDelegate;
    
    UIScrollView  *scrollview;
    UIPageControl *pagecontrol;
    
    BOOL pageControlUsed;
    
}

@property (retain,nonatomic) AppDelegate *appDelegate;
@property (nonatomic, assign) id<MyprotocolDelegate> myDelegate;
@property(nonatomic,retain) UIScrollView *scrollview;
@property(nonatomic,retain) UIPageControl *pagecontrol;
@property (nonatomic,strong) NSString *api_url;
@end
