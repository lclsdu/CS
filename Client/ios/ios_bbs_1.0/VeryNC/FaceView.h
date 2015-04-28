//
//  FaceView.h
//  FaceDemo
//
//  Created by user on 11-10-20.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IconDownloader.h"
#import "AppRecord.h"
#import  "DebugLog.h"
#define _facePageHeight 320
@protocol expressionDelegate;


@interface FaceView : UIView
{
    id<expressionDelegate> _deletage;
    NSMutableArray *imageURLList;
    NSMutableArray *codeList;
    NSMutableDictionary *imageDownloadsInProgress;  // the set of IconDownloader objects for each app
    NSArray *entries;   // the main data model for our UITableView
    NSMutableArray          *appRecords;
}
@property (nonatomic, retain) NSArray *entries;
@property (nonatomic, assign) id<expressionDelegate> deletage;
@property (nonatomic, retain) NSMutableDictionary *imageDownloadsInProgress;
@property (nonatomic, retain)NSMutableArray *imageURLList;
@property (nonatomic, retain) NSMutableArray *appRecords;
@property (nonatomic, retain) NSMutableArray *codeList;
/**
 方法用于创建表情
 page：参数用于表示的页数
 */
-(void)createExpressionWithPage:(int)page;
-(void)initImageList;

@end

@protocol expressionDelegate <NSObject>

-(void)expressionClickWith:(FaceView *)faceView faceName:(NSString *)name;

@end