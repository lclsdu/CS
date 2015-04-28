//
//  ColumnList.h
//  蒙娜丽莎门户
//
//  Created by Kryhear on 12-2-17.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import  "DebugLog.h"
@interface ColumnList : NSObject {
    int listID;
	NSString *listName;
	NSMutableArray *childArray, *indexPaths;
	NSMutableArray *fidArray;
	int num;
	BOOL isOpened;
    NSMutableArray * nameArray;
    
    
    
}
@property (nonatomic, assign) int listID, num;
@property (assign) BOOL isOpened;
@property (nonatomic, retain) NSString *listName;
@property (nonatomic, retain) NSMutableArray *childArray, *indexPaths;
@property (nonatomic, retain) NSMutableArray *fidArray;
@property (nonatomic, retain) NSMutableArray * nameArray;
@end

