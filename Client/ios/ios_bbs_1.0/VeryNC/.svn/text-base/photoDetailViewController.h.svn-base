//
//  photoDetailViewController.h
//  VeryNC
//
//  Created by mac on 12-5-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyProtocol.h"
#import "AppDelegate.h"
#import "Constants.h"
#import "Tools.h"
@interface photoDetailViewController : UIViewController<UIScrollViewDelegate>
{
    IBOutlet id<MyprotocolDelegate> myDelegate;
    int hiddennavbar;
}
@property (nonatomic,strong) NSString *api_url;
@property (nonatomic,strong) NSString *picshow_id;
@property (nonatomic,retain) UIScrollView *scrollview;
@property (nonatomic,strong) NSArray *tmparray;
@property (nonatomic,strong) NSString *picshow_title;
@property (nonatomic,strong) NSString *tid;
@property (nonatomic,strong) NSString *fid;
@property (nonatomic,strong) NSString *picshow_coverpic;
@property (nonatomic,retain) UIImage *shareimage;
@end
