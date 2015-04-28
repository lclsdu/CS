//
//  CommonObject.m
//  化龙巷
//
//  Created by Kryhear on 12-2-22.
//  Copyright (c) 2012年 Osugroup. All rights reserved.
//

#import "CommonObject.h"

@implementation CommonObject
@synthesize img, author, descrip, tid, url, title, subject, fid, authorid,isclosed;
@synthesize views, replies, ifupload, postdate, allpushtime;
@synthesize isReaded;
- (void)dealloc {
    self.img = nil;
	self.author = nil;
	self.descrip = nil;
	self.subject = nil;
	self.url = nil;
	self.title = nil;
	self.postdate = nil;
	self.allpushtime = nil;
    [super dealloc];
}
@end
