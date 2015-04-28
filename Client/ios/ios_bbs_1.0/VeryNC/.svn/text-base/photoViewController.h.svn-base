//
//  photoViewController.h
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
#import "DebugLog.h"

@interface photoViewController : UIViewController<MyprotocolDelegate>
{
    //基本框架
    IBOutlet id<MyprotocolDelegate> myDelegate;
    AppDelegate *appDelegate;
    
//    NSMutableArray 
    
    //
    NSMutableArray *photoPicArray;  
    
    int pagenum;
}

@property (retain,nonatomic) AppDelegate *appDelegate;
@property (nonatomic, assign) id<MyprotocolDelegate> myDelegate;
@property (nonatomic, retain) NSMutableArray *photoPicArray;
//strong?
@property (nonatomic, strong) NSString *api_url;
@property (nonatomic, strong) UILabel *morebtnlabel;
@property (nonatomic, strong) UIButton *morePressButton;
@property (nonatomic, strong) UIScrollView *scrollView;
@end
