//
//  CommonObject.h
//  化龙巷
//
//  Created by Kryhear on 12-2-22.
//  Copyright (c) 2012年 Osugroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonObject : NSObject{
	
}

@property (nonatomic, retain) NSString *img, *author, *url, *descrip, *title, *allpushtime, *postdate, *subject;
@property (nonatomic, assign) int ifupload, views, replies, tid, fid, authorid,isclosed;
@property (nonatomic, assign) BOOL isReaded;

@end
