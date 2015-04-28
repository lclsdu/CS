//
//  ShopObject.h
//  化龙巷
//
//  Created by wu jinjin on 12-3-20.
//  Copyright (c) 2012年 Osugroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopObject : NSObject


@property (nonatomic, retain) NSString *pic, *name, *phone, *website, *address, *information;
@property (nonatomic, assign) int ifupload, shopid,distance,cid,pid;
@property (nonatomic, assign) double lagitude, longitude,service,enviroment;
@property (nonatomic, assign) BOOL isReaded;

@end
