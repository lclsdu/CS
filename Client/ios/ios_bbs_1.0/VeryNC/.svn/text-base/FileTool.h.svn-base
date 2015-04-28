//
//  FileTool.h
//  LingNan HD
//
//  Created by osu on 11-1-28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FileTool : NSObject {

}
+(NSString *)getDocumentsPath;
+(NSString *)getDocumentsPath:(NSString *)fileName;
+(NSString *)getBundlePath:(NSString *)fileName type:(NSString *)type;
+(NSData *)createFileAtPath:(NSString *)path oldFileName:(NSString *)name fileType:(NSString *)type;
+(BOOL)isExistAtDocPath:(NSString *)fileName fileManager:(NSFileManager *)fm docPath:(NSString *)docPath ;
+(BOOL)isExistAtBundle:(NSString *)fileName fileManager:(NSFileManager *)fm;
+(BOOL)deleteFileAtDocPath:(NSString *)fileName fileManager:(NSFileManager *)fm docPath:(NSString *)docPath ;
+(BOOL)deleteFileAtBundlePath:(NSString *)fileName fileManager:(NSFileManager *)fm;
+(BOOL)isExistAtTem:(NSString *)fileName fileManager:(NSFileManager *)fm ;
+(NSString *)getTemPath:(NSString *)fileName;
+(void )createDirectoryAtPath:(NSString *)fileName;
+ (NSString *) md5:(NSString *)str;
@end
