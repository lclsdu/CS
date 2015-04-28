//
//  FileTool.m
//  LingNan HD
//
//  Created by osu on 11-1-28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FileTool.h"


@implementation FileTool

//获取document目录
+(NSString *)getDocumentsPath{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return documentsDirectory;
}
//获取document路径下的file
+(NSString *)getDocumentsPath:(NSString *)fileName{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *path = [documentsDirectory stringByAppendingPathComponent:fileName];
	return path;
}
//获取Bundle目录下的文件
+(NSString *)getBundlePath:(NSString *)fileName type:(NSString *)type{
	NSString *path = [[NSBundle mainBundle]pathForResource:fileName ofType:type];
	return path;
}

	//获取tempath目录下的文件
+(NSString *)getTemPath:(NSString *)fileName{
	NSString *tempPath = NSTemporaryDirectory();
	NSString *path = [tempPath stringByAppendingPathComponent:fileName];
	return path;
}

//创建文件夹
+(void )createDirectoryAtPath:(NSString *)fileName{
	[[NSFileManager defaultManager] createDirectoryAtPath:fileName withIntermediateDirectories:YES attributes:nil error:nil];
}
 
//判断docment是否存在此file
+(BOOL)isExistAtDocPath:(NSString *)fileName fileManager:(NSFileManager *)fm docPath:(NSString *)docPath {
	return [fm fileExistsAtPath:[docPath stringByAppendingPathComponent:fileName]];
}
//判断bundle是否存在此file
+(BOOL)isExistAtBundle:(NSString *)fileName fileManager:(NSFileManager *)fm  {
	return [fm fileExistsAtPath:[FileTool getBundlePath:fileName type:@""]];
}

//判断tempaht是否存在此file
+(BOOL)isExistAtTem:(NSString *)fileName fileManager:(NSFileManager *)fm  {
	return [fm fileExistsAtPath:[FileTool getTemPath:fileName]];
}
+(BOOL)deleteFileAtDocPath:(NSString *)fileName fileManager:(NSFileManager *)fm docPath:(NSString *)docPath  {
	NSString *path=[docPath stringByAppendingPathComponent:fileName];
	if ([fm fileExistsAtPath:path]) {
		[fm removeItemAtPath:path error:nil];
	}
}


+(BOOL)deleteFileAtBundlePath:(NSString *)fileName fileManager:(NSFileManager *)fm {
	NSString *path=[FileTool getBundlePath:fileName type:@""];
	if ([fm fileExistsAtPath:path]) {
		[fm removeItemAtPath:path error:nil];
	}
}
+ (NSString *) md5:(NSString *)str {
	const char *cStr = [str UTF8String];
	unsigned char result[32];
	CC_MD5( cStr, strlen(cStr), result );
	return [NSString 
			stringWithFormat: @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
			result[0], result[1],
			result[2], result[3],
			result[4], result[5],
			result[6], result[7],
			result[8], result[9],
			result[10], result[11],
			result[12], result[13],
			result[14], result[15],
			result[16], result[17],
			result[18], result[19],
			result[20], result[21],
			result[22], result[23],
			result[24], result[25],
			result[26], result[27],
			result[28], result[29],
			result[30], result[31]
			];
}

@end
