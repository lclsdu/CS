//
//  DetailObject.h
//  化龙巷
//
//  Created by Kryhear on 12-2-25.
//  Copyright (c) 2012年 Osugroup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonObject.h"
@interface DetailObject : CommonObject {
	
}
@property (nonatomic, assign) int attention, number, contentHeight;
@property (nonatomic, retain) NSString *micon, *content;
@end
