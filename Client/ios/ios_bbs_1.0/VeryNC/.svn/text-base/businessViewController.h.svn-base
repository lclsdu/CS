//
//  businessViewController.h
//  VeryNC
//
//  Created by wu jinjin on 12-4-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MyProtocol.h"
#import "AppDelegate.h"
#import "Constants.h"
#import "Tools.h"
#import "ShopObject.h"
#import "shopDetailViewController.h"
#import "pickerView.h"

@interface businessViewController : UIViewController<CLLocationManagerDelegate, UITableViewDataSource,UITableViewDelegate>
{
    //基本框架
    IBOutlet id<MyprotocolDelegate> myDelegate;
    AppDelegate *appDelegate;
    
    IBOutlet UIButton *distanceButton;
    IBOutlet UIButton *allCategoryButton;
    IBOutlet UITableView *tableview;
    NSString * requestURLOfShop;
    NSString * requestURLOfShopPercent;
    NSString * classOnOrOff;
    NSString * cidString;
    
    int countOfRequest;
    int pageNum;
    UIActivityIndicatorView *_activityView;
    UILabel *_loadLabel;
    UIImageView *_loadingView;
    NSMutableArray *resultArray;
    NSMutableArray * specificDistanceResultArray;    
    int dynamicCid;
    double lng;
    double lat;
    double distanceForUrl;
    BOOL distanceOK;
    
    
}

@property (retain,nonatomic) AppDelegate *appDelegate;
@property (nonatomic, assign) id<MyprotocolDelegate> myDelegate;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic,strong) NSString *api_url;
- (IBAction)allCategoryButtonClicked:(id)sender;

- (IBAction)distanceButtonClicked:(id)sender;
@end
