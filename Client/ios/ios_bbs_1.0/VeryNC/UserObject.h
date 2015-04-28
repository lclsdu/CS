//
//  UserObject.h
//  化龙巷
//
//  Created by Kryhear on 12-3-10.
//  Copyright (c) 2012年 Osugroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserObject : NSObject {
	int ID, UID;
	NSString *userName, *passWord, *email, *sessionId;
	BOOL Use;
}

@property (nonatomic, assign) int ID, UID;
@property (nonatomic, assign) BOOL Use;
@property (nonatomic, retain) NSString *userName, *passWord, *email, *sessionId;
@end
