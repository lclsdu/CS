//
//  pushViewController.h
//  VeryNC
//
//  Created by  on 12-7-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyProtocol.h"
#import "AppDelegate.h"

@interface pushViewController : UIViewController <MyprotocolDelegate, UINavigationControllerDelegate, UINavigationBarDelegate>
{
    //基本框架
    IBOutlet id<MyprotocolDelegate> myDelegate;
    AppDelegate *appDelegate;
}
- (IBAction)closeViewController:(id)sender;
@property (retain, nonatomic) IBOutlet UIView *readerView;

@end
