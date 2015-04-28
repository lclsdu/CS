//
//  SqlitSet.h
//  化龙巷
//
//  Created by Kryhear on 12-3-9.
//  Copyright (c) 2012年 Osugroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SqliteSet : NSObject {
	
}
+ (BOOL)OpenDataBase;
+ (BOOL)CloseDataBase;
+ (NSMutableArray *)queryFavouriteItem;


+ (NSMutableArray *)queryNewsheaderItem;
+ (BOOL)InsertNewsHeader:(NSString *)sql;
+ (bool)clearNewsHeader ;
+ (BOOL)queryNewsHeaderItem :(NSString*)s;
+ (BOOL)deleteNewsHeaderItem:(NSString *)sql ;


+ (NSMutableArray *)queryNewsheaderMoreItem;
+ (BOOL)InsertNewsHeaderMore:(NSString *)sql;
+ (bool)clearNewsHeaderMore ;
+ (BOOL)queryNewsHeaderMoreItem :(NSString*)s;
+ (BOOL)deleteNewsHeaderMoreItem:(NSString *)sql;


+ (BOOL)queryRecentView:(int)Page Array:(NSMutableArray *)res;
+ (NSMutableArray *)queryUserData;
+ (BOOL)InsertFavouriteItem:(NSString *)sql;
+ (BOOL)InsertRecentView:(NSString *)sql;
+ (BOOL)InsertUserData:(NSString *)sql;


+ (bool)clearFavorite ;
+ (bool)clearRecentView;
+ (BOOL)queryFavourite :(NSMutableArray *)res;
+ (BOOL)queryFavouriteAItem :(NSString*)s;
+ (BOOL)queryFavouritePicAItem :(NSString *)s;
+ (NSMutableArray *)queryFavouritePicItem;

+ (BOOL)deleteFavouriteItem:(NSString *)sql ;
@end
