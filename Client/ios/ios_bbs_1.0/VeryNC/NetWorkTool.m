//
//  NetWorkTool.m
//  LingNan HD
//
//  Created by osu on 11-1-28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NetWorkTool.h"
#import <netinet/in.h>
#import "Reachability.h"
#import <SystemConfiguration/SystemConfiguration.h>
@implementation NetWorkTool
//多线程下载保存图片并显示出来
+ (void)getImageData:(NSString *)URLString imageName:(NSString *)name imageView:(UIImageView *)view
{	 	
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];	
	NSMutableData *data =[NSData dataWithContentsOfURL:[NSURL URLWithString:URLString]]; 	
	[data writeToFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",name]] atomically:NO];
	UIImage *iv =[UIImage imageWithData:data ];
	[view setImage:iv];	
	[pool release];	
}

+(BOOL)isNetworkReachable{
    // Create zero addy
//    struct sockaddr_in zeroAddress;
//    bzero(&zeroAddress, sizeof(zeroAddress));
//    zeroAddress.sin_len = sizeof(zeroAddress);
//    zeroAddress.sin_family = AF_INET;
//    
//    // Recover reachability flags
//    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
//    SCNetworkReachabilityFlags flags;
//    
//    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
//    CFRelease(defaultRouteReachability);
//    if (!didRetrieveFlags)
//    {
//        return NO;
//    }
//    BOOL isReachable = flags & kSCNetworkFlagsReachable;
//    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
//    return (isReachable && !needsConnection) ? YES : NO;
//	
//	NSLog(@"%d   %d ",[ASIHTTPRequest isNetworkReachableViaWIFI],[ASIHTTPRequest isNetworkReachableViaWWAN]);
 
	Reachability *r = [Reachability reachabilityWithHostName:@"www.baidu.com"];
	if (([r currentReachabilityStatus] == kReachableViaWiFi) ||([r currentReachabilityStatus] == kReachableViaWWAN)) {
 
		return YES;
	}
 
	return NO;
	
		//return ([ASIHTTPRequest isNetworkReachableViaWIFI]||[ASIHTTPRequest isNetworkReachableViaWWAN]);
}

+(void)getFileData:(NSString *)URLString fileName:(NSString *)name{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];	
	NSMutableData *data =[NSData dataWithContentsOfURL:[NSURL URLWithString:URLString]]; 	
	[data writeToFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",name]] atomically:NO];
	[pool release];	
}

@end
