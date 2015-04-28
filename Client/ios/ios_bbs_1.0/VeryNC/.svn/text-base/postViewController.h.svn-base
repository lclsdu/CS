//
//  postViewController.h
//  VeryNC
//
//  Created by Rhythm on 5/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyProtocol.h"
#import "AppDelegate.h"
#import "CommonObject.h"
#import "Constants.h"
#import "Tools.h"
#include "DebugLog.h" 
#import "NewPostViewController.h"
#import "SectionHeaderView.h"

@interface postViewController : UIViewController<MyprotocolDelegate,UITableViewDataSource,UITableViewDelegate,SectionHeaderViewDelegate>
{
    //基本框架
    IBOutlet id<MyprotocolDelegate> myDelegate;
    AppDelegate *appDelegate;
    
    NSMutableArray *postArray;
    UIActivityIndicatorView *_activityView;
	UILabel *_loadLabel;
    UIImageView *_loadingView;
    
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading,isMore;
    int pagenum;
    NSString *loadmore_Tip;
    
    NSMutableArray *resultArray;
}

@property (retain,nonatomic) AppDelegate *appDelegate;
@property (nonatomic, assign) id<MyprotocolDelegate> myDelegate;
@property (nonatomic,strong) NSString *api_url;
@property (nonatomic,retain) NSMutableArray *postArray;
@property (nonatomic,retain) IBOutlet UITableView *mytableview;

@end
