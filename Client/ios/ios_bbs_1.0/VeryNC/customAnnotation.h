//
//  customAnnotation.h
//  化龙巷
//
//  Created by mac on 12-4-11.
//  Copyright (c) 2012年 Osugroup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import  "DebugLog.h"
@interface customAnnotation : NSObject<MKAnnotation>
{
    CLLocationCoordinate2D coordinate;
    NSString *title;
}
@property (nonatomic,readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic,retain) NSString *title;
@end
