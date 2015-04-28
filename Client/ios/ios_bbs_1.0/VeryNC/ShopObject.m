//
//  ShopObject.m
//  化龙巷
//
//  Created by wu jinjin on 12-3-20.
//  Copyright (c) 2012年 Osugroup. All rights reserved.
//

#import "ShopObject.h"

@implementation ShopObject

@synthesize pic, name, phone, website,address, information,service,enviroment;
@synthesize ifupload, shopid, distance,cid,pid;
@synthesize lagitude, longitude;
@synthesize isReaded;
- (void)dealloc {
    self.pic = nil;
	self.name = nil;
	self.phone = nil;
	self.website = nil;
    [super dealloc];
}


@end
