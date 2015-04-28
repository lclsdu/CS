//
//  TapDetectingWindow.h
//  VeryNC
//
//  Created by 吴 津津 on 12-5-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TapDetectingWindowDelegate
- (void)userDidTapWebView:(id)tapPoint;
@end
@interface TapDetectingWindow : UIWindow {
    UIView *viewToObserve;
    id <TapDetectingWindowDelegate> controllerThatObserves;
}
@property (nonatomic, retain) UIView *viewToObserve;
@property (nonatomic, assign) id <TapDetectingWindowDelegate> controllerThatObserves;
@end