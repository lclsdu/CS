//
//  ShopMapViewController.h
//  化龙巷
//
//  Created by mac on 12-4-10.
//  Copyright (c) 2012年 Osugroup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import  "DebugLog.h"
@interface ShopMapViewController : UIViewController<MKMapViewDelegate>{
    MKMapView *map;
}
@property (nonatomic,assign) double lat;
@property (nonatomic,assign) double lng;
@property (nonatomic,retain) NSString *shopname;
@end
