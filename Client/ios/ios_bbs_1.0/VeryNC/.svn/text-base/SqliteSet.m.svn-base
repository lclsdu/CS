//
//  SqlitSet.m
//  化龙巷
//
//  Created by Kryhear on 12-3-9.
//  Copyright (c) 2012年 Osugroup. All rights reserved.
//

#import "SqliteSet.h"
#import "Tools.h"
#import "FavouriteObject.h"
#import "UserObject.h"
#import "newsHeaderObject.h"
@implementation SqliteSet

+ (BOOL)OpenDataBase {
	if (![FileTool isExistAtDocPath:@"" fileManager:[NSFileManager defaultManager] docPath:@"zxzy.db"]) {
		[[NSFileManager defaultManager] createFileAtPath:[FileTool getDocumentsPath] contents:nil attributes:nil];
		if (sqlite3_open([[FileTool getDocumentsPath:@"zxzy.db"] UTF8String], &_database) == SQLITE_OK) {
			NSString *createFavouriteTable = @"CREATE TABLE IF NOT EXISTS \"Favourite\" (\"Fid\" INTEGER PRIMARY KEY,\"Name\" TEXT)";
			sqlite3_exec(_database, [createFavouriteTable UTF8String], NULL, NULL, NULL);
            
            NSString *createFavouritePicTable = @"CREATE TABLE IF NOT EXISTS \"FavouritePic\" (\"Picshow_id\" TEXT,\"Name\" TEXT,\"Tid\" TEXT,\"Fid\" TEXT,\"Picshow_coverpic\" TEXT)";
			sqlite3_exec(_database, [createFavouritePicTable UTF8String], NULL, NULL, NULL);
            
            NSString *createNewsHeaderTable = @"CREATE TABLE IF NOT EXISTS \"Newsheader\" (\"primaryId\" INTEGER PRIMARY KEY,\"Tag\" TEXT, \"Name\" TEXT)";
			sqlite3_exec(_database, [createNewsHeaderTable UTF8String], NULL, NULL, NULL);
            
            
            NSString *createNewsHeaderMoreTable = @"CREATE TABLE IF NOT EXISTS \"Newsheadermore\" (\"primaryId\" INTEGER PRIMARY KEY,\"Tag\" TEXT,\"Name\" TEXT)";
			sqlite3_exec(_database, [createNewsHeaderMoreTable UTF8String], NULL, NULL, NULL);
            

			NSString *createRecentViewTable = @"CREATE TABLE IF NOT EXISTS \"RecentView\" (\"Tid\" INTEGER PRIMARY KEY,\"Title\" TEXT,\"Time\" TEXT)";
			sqlite3_exec(_database, [createRecentViewTable UTF8String], NULL, NULL, NULL);
			NSString *createUserDataTable = @"CREATE TABLE IF NOT EXISTS \"UserData\" ( \"ID\" INTEGER PRIMARY KEY, \"UserName\" TEXT, \"PassWord\" TEXT, \"UID\" INTEGER, \"Email\" TEXT , \"Use\" INTEGER)";
            
			sqlite3_exec(_database, [createUserDataTable UTF8String], NULL, NULL, NULL);
			return YES;
		}
	}
	else if (sqlite3_open([[FileTool getDocumentsPath:@"zxzy.db"] UTF8String], &_database) == SQLITE_OK)
        return YES;
	sqlite3_close(_database);
	return NO;
}

+ (BOOL)CloseDataBase {
	return YES;
}


+ (bool)clearRecentView {
    
 
	sqlite3_stmt *statement = nil;
    
	if (sqlite3_prepare_v2(_database, [@"DELETE FROM RecentView" UTF8String], -1, &statement, NULL) != SQLITE_OK) {
        
        
        //    DROP table tablename
        //if (sqlite3_prepare_v2(_database, [@"DROP table Favourite" UTF8String], -1, &statement, NULL) != SQLITE_OK) {
        
        
        NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(_database));
		
		sqlite3_finalize(statement);
        
        return false;
        
	}
    
    sqlite3_step(statement);
    sqlite3_finalize(statement);
    // [result autorelease];
    return true;
    
    /*
     else{
     
     NSAssert1(0,@"Error: Failed to prepare statement with message %s '.", sqlite3_errmsg(_database));
     return false;
     }
     
     */
    
    
}

+ (bool)clearFavorite {
    
  
	sqlite3_stmt *statement = nil;
    
	if (sqlite3_prepare_v2(_database, [@"DELETE FROM Favourite" UTF8String], -1, &statement, NULL) != SQLITE_OK) {
        
        
        //    DROP table tablename
        //if (sqlite3_prepare_v2(_database, [@"DROP table Favourite" UTF8String], -1, &statement, NULL) != SQLITE_OK) {
        
        
        NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(_database));
		
		sqlite3_finalize(statement);
        
        return false;
        
	}
    
    sqlite3_step(statement);
    sqlite3_finalize(statement);
 
    return true;
    
    /*
     else{
     
     NSAssert1(0,@"Error: Failed to prepare statement with message %s '.", sqlite3_errmsg(_database));
     return false;
     }
     
     */
    
    
}

+ (NSMutableArray *)queryFavouriteItem {
    
	NSMutableArray *result = [[NSMutableArray alloc] init];
	sqlite3_stmt *statement = nil;
	if (sqlite3_prepare_v2(_database, [@"select * from Favourite" UTF8String], -1, &statement, NULL) != SQLITE_OK) {
		return [result autorelease];
	}
	//查询结果集中一条一条的遍历所有的记录，这里的数字对应的是列值。
    while (sqlite3_step(statement) == SQLITE_ROW) {
		FavouriteObject *tmpFavourite = [[FavouriteObject alloc] init];
		int Fid = sqlite3_column_int(statement, 0);
		char *Name = (char*)sqlite3_column_text(statement, 1);
		tmpFavourite.Fid = Fid;
		tmpFavourite.Name = [NSString stringWithUTF8String:Name];
		[result addObject:tmpFavourite];
        
	}
    sqlite3_finalize(statement);
	return [result autorelease];
}

+ (NSMutableArray *)queryFavouritePicItem {
    
	NSMutableArray *result = [[NSMutableArray alloc] init];
	sqlite3_stmt *statement = nil;
	if (sqlite3_prepare_v2(_database, [@"select * from FavouritePic" UTF8String], -1, &statement, NULL) != SQLITE_OK) {
		return [result autorelease];
	}
	//查询结果集中一条一条的遍历所有的记录，这里的数字对应的是列值。
    while (sqlite3_step(statement) == SQLITE_ROW) {
		char *_picshow_id = (char *)sqlite3_column_text(statement, 0);
        NSString *picshow_id = [NSString stringWithUTF8String:_picshow_id];
        
        char *Name = (char *)sqlite3_column_text(statement, 1);
        NSString *picshow_title = [NSString stringWithUTF8String:Name];
        
        char *_Tid = (char *)sqlite3_column_text(statement, 2);
        NSString *Tid = [NSString stringWithUTF8String:_Tid];
        
        char *_Fid = (char *)sqlite3_column_text(statement, 3);
        NSString *Fid = [NSString stringWithUTF8String:_Fid];
        
        char *_Picshow_coverpic = (char *)sqlite3_column_text(statement, 4);
        NSString *Picshow_coverpic = [NSString stringWithUTF8String:_Picshow_coverpic];
        
        NSDictionary *tmpFavPic = [[NSDictionary alloc] initWithObjectsAndKeys:picshow_id,@"picshow_id",picshow_title,@"picshow_title",Tid,@"tid",Fid,@"fid",Picshow_coverpic,@"picshow_coverpic",nil];
		[result addObject:tmpFavPic];
	}
    sqlite3_finalize(statement);
	return [result autorelease];
}

+ (BOOL)queryFavouriteAItem :(NSString *)s ;
{
    sqlite3_stmt *statement = nil;//@"select * from Favourite where fid='%@',s"
	if (sqlite3_prepare_v2(_database, [ [NSString stringWithFormat: @"select * from Favourite where Fid=%@",s] UTF8String], -1, &statement, NULL) != SQLITE_OK) {
        
        NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(_database));
        sqlite3_finalize(statement);
	}
    DebugLog(@"%@",[NSString stringWithFormat: @"select * from Favourite where Fid=%@",s] );
	//查询结果集中一条一条的遍历所有的记录，这里的数字对应的是列值。
    while (sqlite3_step(statement) == SQLITE_ROW) {
        
        
        //  char *fid1 = (char*)sqlite3_column_text(statement, 0);
        // char *title  = (char*)sqlite3_column_text(statement,0);
        //  char *title1 = (char*)sqlite3_column_text(statement, 1);
        //   NSAssert1(0,   @"%@ ",title1  );
        return true;
	}
    sqlite3_finalize(statement);
	return false;
    
    
    
}
+ (BOOL)queryFavourite :(NSMutableArray *)res{
    
 
	sqlite3_stmt *statement = nil;
	if (sqlite3_prepare_v2(_database, [@"select * from Favourite" UTF8String], -1, &statement, NULL) != SQLITE_OK) {
		return NO;
	}
	//查询结果集中一条一条的遍历所有的记录，这里的数字对应的是列值。
    while (sqlite3_step(statement) == SQLITE_ROW) {
		//FavouriteObject *tmpFavourite = [[FavouriteObject alloc] init];
        FavouriteObject *tmpFavourite = [[FavouriteObject alloc] init];
		int Fid = sqlite3_column_int(statement, 0);
		char *Name = (char*)sqlite3_column_text(statement, 1);
		tmpFavourite.Fid = Fid;
		tmpFavourite.Name = [NSString stringWithUTF8String:Name];
		[res addObject:tmpFavourite];
		[tmpFavourite release];
        
	}
    sqlite3_finalize(statement);
	return YES;
}


+ (BOOL)queryRecentView:(int)Page Array:(NSMutableArray *)res{
    
	sqlite3_stmt *statement = nil;
	NSString *sql = [NSString stringWithFormat:@"SELECT * from RecentView ORDER BY Time DESC LIMIT %d,10",(Page-1)*10];
	if (sqlite3_prepare_v2(_database, [sql UTF8String], -1, &statement, NULL) != SQLITE_OK) {
		return NO;
	}
	//查询结果集中一条一条的遍历所有的记录，这里的数字对应的是列值。
    while (sqlite3_step(statement) == SQLITE_ROW) {
		FavouriteObject *tmpFavourite = [[FavouriteObject alloc] init];
		int Fid = sqlite3_column_int(statement, 0);
		char *Name = (char*)sqlite3_column_text(statement, 1);
		tmpFavourite.Fid = Fid;
		tmpFavourite.Name = [NSString stringWithUTF8String:Name];
		[res addObject:tmpFavourite];
		[tmpFavourite release];
	}
    sqlite3_finalize(statement);
	return YES;
}

+ (NSMutableArray *)queryUserData {
	NSMutableArray *result = [[NSMutableArray alloc] init];
	sqlite3_stmt *statement = nil;
	if (sqlite3_prepare_v2(_database, [@"select * from UserData" UTF8String], -1, &statement, NULL) != SQLITE_OK) {
		return [result autorelease];
	}
	//查询结果集中一条一条的遍历所有的记录，这里的数字对应的是列值。
    while (sqlite3_step(statement) == SQLITE_ROW) {
		UserObject *tmpUser = [[UserObject alloc] init];
		int ID = sqlite3_column_int(statement, 0);
		char *UserName = (char*)sqlite3_column_text(statement, 1);
		char *PassWord = (char*)sqlite3_column_text(statement, 2);
		int UID = sqlite3_column_int(statement, 3);
		tmpUser.ID = ID;
		tmpUser.UID = UID;
		tmpUser.userName = [NSString stringWithFormat:@"%s",UserName];
		tmpUser.passWord = [NSString stringWithFormat:@"%s",PassWord];
		[result addObject:tmpUser];
		[tmpUser release];
	}
    sqlite3_finalize(statement);
	return [result autorelease];
}
+ (BOOL)deleteFavouriteItem:(NSString *)sql {
	sqlite3_stmt *statement = nil;
    
	if (sqlite3_prepare_v2(_database, [sql UTF8String], -1, &statement, NULL) != SQLITE_OK) {
        
        
        //    DROP table tablename
        //if (sqlite3_prepare_v2(_database, [@"DROP table Favourite" UTF8String], -1, &statement, NULL) != SQLITE_OK) {
        
        
        NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(_database));
		
		sqlite3_finalize(statement);
        
        return false;
        
	}
    
    sqlite3_step(statement);
    sqlite3_finalize(statement);
    
    return true;
    
    /*
     else{
     
     NSAssert1(0,@"Error: Failed to prepare statement with message %s '.", sqlite3_errmsg(_database));
     return false;
     }
     
     */

}
+ (BOOL)InsertFavouriteItem:(NSString *)sql {
	if (sqlite3_exec(_database, [sql UTF8String], NULL, NULL, NULL) != SQLITE_OK) {
		return NO;
	}
	return YES;
}
+ (BOOL)InsertRecentView:(NSString *)sql {
	if (sqlite3_exec(_database, [sql UTF8String], NULL, NULL, NULL) != SQLITE_OK) {
		return NO;
	}
	return YES;
}
+ (BOOL)InsertUserData:(NSString *)sql {
	if (sqlite3_exec(_database, [sql UTF8String], NULL, NULL, NULL) != SQLITE_OK) {
		return NO;
	}
	return YES;
}

+ (BOOL)queryFavouritePicAItem :(NSString *)s
{
    sqlite3_stmt *statement = nil;//@"select * from Favourite where fid='%@',s"
	if (sqlite3_prepare_v2(_database, [ [NSString stringWithFormat: @"select * from FavouritePic where Picshow_id=%@",s] UTF8String], -1, &statement, NULL) != SQLITE_OK) {
        
        NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(_database));
        sqlite3_finalize(statement);
	}
	//查询结果集中一条一条的遍历所有的记录，这里的数字对应的是列值。
    while (sqlite3_step(statement) == SQLITE_ROW) {
        
        
        //  char *fid1 = (char*)sqlite3_column_text(statement, 0);
        // char *title  = (char*)sqlite3_column_text(statement,0);
        //  char *title1 = (char*)sqlite3_column_text(statement, 1);
        //   NSAssert1(0,   @"%@ ",title1  );
        return true;
	}
    sqlite3_finalize(statement);
	return false;
    
    
    
}
#pragma -mark Newsheader 

+ (NSMutableArray *)queryNewsheaderItem{
    
    
	NSMutableArray *result = [[NSMutableArray alloc] init];
	sqlite3_stmt *statement = nil;
	if (sqlite3_prepare_v2(_database, [@"select * from Newsheader" UTF8String], -1, &statement, NULL) != SQLITE_OK) {
		return [result autorelease];
	}
	//查询结果集中一条一条的遍历所有的记录，这里的数字对应的是列值。
    while (sqlite3_step(statement) == SQLITE_ROW) {
		newsHeaderObject *tmpHeader = [[newsHeaderObject alloc] init];
		int Fid = sqlite3_column_int(statement, 0);
        char *Tag = (char*)sqlite3_column_text(statement, 1);
		char *Name = (char*)sqlite3_column_text(statement, 2);
        tmpHeader.primaryId=Fid;
		tmpHeader.tag = [NSString stringWithUTF8String:Tag];
		tmpHeader.Name = [NSString stringWithUTF8String:Name];
		[result addObject:tmpHeader];
		[tmpHeader release];
        
	}
    sqlite3_finalize(statement);
	return [result autorelease];
 
    
}
+ (BOOL)InsertNewsHeader:(NSString *)sql{
    
    
    if (sqlite3_exec(_database, [sql UTF8String], NULL, NULL, NULL) != SQLITE_OK) {
		return NO;
	}
	return YES;



}
+ (bool)clearNewsHeader{



}
+ (BOOL)queryNewsHeaderItem :(NSString*)s{



}
+ (BOOL)deleteNewsHeaderItem:(NSString *)sql{
    
    
    sqlite3_stmt *statement = nil;
    
	if (sqlite3_prepare_v2(_database, [sql UTF8String], -1, &statement, NULL) != SQLITE_OK) {
        
        
        //    DROP table tablename
        //if (sqlite3_prepare_v2(_database, [@"DROP table Favourite" UTF8String], -1, &statement, NULL) != SQLITE_OK) {
        
        
        NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(_database));
		
		sqlite3_finalize(statement);
        
        return false;
        
	}
    
    sqlite3_step(statement);
    sqlite3_finalize(statement);
    
    return true;
    



}


#pragma -mark Newsheadermore 


+ (NSMutableArray *)queryNewsheaderMoreItem{
    
	NSMutableArray *result = [[NSMutableArray alloc] init];
	sqlite3_stmt *statement = nil;
	if (sqlite3_prepare_v2(_database, [@"select * from Newsheadermore" UTF8String], -1, &statement, NULL) != SQLITE_OK) {
		return [result autorelease];
	}
	//查询结果集中一条一条的遍历所有的记录，这里的数字对应的是列值。
    while (sqlite3_step(statement) == SQLITE_ROW) {
		newsHeaderObject *tmpHeader = [[newsHeaderObject alloc] init];
        int Fid = sqlite3_column_int(statement, 0);
        char *Tag = (char*)sqlite3_column_text(statement, 1);
		char *Name = (char*)sqlite3_column_text(statement, 2);
        tmpHeader.primaryId=Fid;
		tmpHeader.tag = [NSString stringWithUTF8String:Tag];
		tmpHeader.Name = [NSString stringWithUTF8String:Name];
		[result addObject:tmpHeader];
		[tmpHeader release];
        
	}
    sqlite3_finalize(statement);
	return [result autorelease];

}


+ (BOOL)InsertNewsHeaderMore:(NSString *)sql{
    
    
    if (sqlite3_exec(_database, [sql UTF8String], NULL, NULL, NULL) != SQLITE_OK) {
		return NO;
	}
	return YES;


}
+ (bool)clearNewsHeaderMore{


}
+ (BOOL)queryNewsHeaderMoreItem :(NSString*)s{


}
+ (BOOL)deleteNewsHeaderMoreItem:(NSString *)sql{
    
    
    sqlite3_stmt *statement = nil;
    
	if (sqlite3_prepare_v2(_database, [sql UTF8String], -1, &statement, NULL) != SQLITE_OK) {
        
        
        //    DROP table tablename
        //if (sqlite3_prepare_v2(_database, [@"DROP table Favourite" UTF8String], -1, &statement, NULL) != SQLITE_OK) {
        
        
        NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(_database));
		
		sqlite3_finalize(statement);
        
        return false;
        
	}
    
    sqlite3_step(statement);
    sqlite3_finalize(statement);
    
    return true;
    

}




@end
