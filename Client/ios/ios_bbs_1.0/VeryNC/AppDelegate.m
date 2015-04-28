

#import "AppDelegate.h"
#import "RootController.h"
#import "ReaderController.h"
#import "NewsViewController.h"
#import "RootController.h"
#import "JSONKit.h"

@implementation AppDelegate
@synthesize newsHeaderArray1;
@synthesize newsHeaderMoreArray;

@synthesize window;
@synthesize rootController;
@synthesize userName;
@synthesize myDomainAndPathVeryNC,loginTip,loginURL,tokenKey;

@synthesize quoteImageURL;
//@synthesize indexTitleArray;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{   
    
//    NSURL *url = [NSURL URLWithString:_newsHeaderURL];
//    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
//    [request setDelegate:self];
//    [request startAsynchronous];
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
    
    isPushView = NO;
    quoteImageURL=_quoteImageVeryNC;
    [SqliteSet OpenDataBase];
    [window addSubview:rootController.view];
    [window makeKeyAndVisible]; 

    return YES;
}

- (NSString *)stripDoubleSpaceFrom:(NSString *)str {
    while ([str rangeOfString:@" "].location != NSNotFound) {
        str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    return str;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    tid = [[userInfo objectForKey:@"tid"] intValue];
    
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:@"alert = \"(.*?)\";" options:NSRegularExpressionCaseInsensitive error:NULL];
    NSString *receiveString = [userInfo description];
    NSString *match = [receiveString substringWithRange:[expression rangeOfFirstMatchInString:receiveString options:NSMatchingCompleted range:NSMakeRange(0, [receiveString length])]];
    match = [match substringFromIndex:9];
    match = [match substringToIndex:([match length] - 2)];
    
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d", tid], @"tid", match, @"alert", nil];

    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notifyToPushReaderView" object:dic];

}        

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *token = [self stripDoubleSpaceFrom:[NSString stringWithFormat:@"%@", deviceToken]];
    token = [token substringFromIndex:1];
    token = [token substringToIndex:([token length] - 1)];
    
    tokenKey = token;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"token.plist"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSPropertyListFormat format;
    NSArray *array = [NSPropertyListSerialization propertyListFromData:data mutabilityOption:NSPropertyListImmutable format:&format errorDescription:nil];
    NSString *nowStatus = @"";
    if ([array count] > 0) {
        nowStatus = [array objectAtIndex:0];
    } else {
        nowStatus = @"postFail";
    }
    
    NSArray *isPostToken = [NSArray arrayWithObjects:nowStatus, token, nil];
    [isPostToken writeToFile:filePath atomically:YES];   
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notifyToPostDeviceToken" object:token];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"Error in registration. Error:%@", error);

}

//- (void)requestFinished:(ASIHTTPRequest *)request
//{
////    NSString *responseString = [request responseString];
////    indexTitleArray = [[responseString JSONValue] valueForKey:@"datas"];  
//    
//}
//
//- (void)requestFailed:(ASIHTTPRequest *)request
//{
//    NSError *error = [request error];
//    //NSLog(@"%@", error);
//    
//}

- (void)dealloc {
    [myDomainAndPathVeryNC release];
	[userName release];
 	[newsHeaderArray1 release];
    [newsHeaderMoreArray release];
    [window release];
	[rootController release];
    [super dealloc];
}

- (void)applicationWillResignActive:(UIApplication *)application
{

}

- (void)applicationDidEnterBackground:(UIApplication *)application
{

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{

}

- (void)applicationWillTerminate:(UIApplication *)application
{

}
- (NSURL *)smartURLForString:(NSString *)str
{
    NSURL *     result;
    NSString *  trimmedStr;
    NSRange     schemeMarkerRange;
    NSString *  scheme;
    
    assert(str != nil);
    
    result = nil;
    
    trimmedStr = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ( (trimmedStr != nil) && (trimmedStr.length != 0) ) {
        schemeMarkerRange = [trimmedStr rangeOfString:@"://"];
        
        if (schemeMarkerRange.location == NSNotFound) {
            result = [NSURL URLWithString:[NSString stringWithFormat:@"ftp://%@", trimmedStr]];
        } else {
            scheme = [trimmedStr substringWithRange:NSMakeRange(0, schemeMarkerRange.location)];
            assert(scheme != nil);
            
            if ( ([scheme compare:@"ftp"  options:NSCaseInsensitiveSearch] == NSOrderedSame) ) {
                result = [NSURL URLWithString:trimmedStr];
            } else {
                // It looks like this is some unsupported URL scheme.
            }
        }
    }
    
    return result;
}

- (BOOL)isImageURL:(NSURL *)url
{
    BOOL        result;
    NSString *  path;
    NSString *  extension;
    
    assert(url != nil);
    
    path = [url path];
    result = NO;
    if (path != nil) {
        extension = [path pathExtension];
        if (extension != nil) {
            result = ([extension caseInsensitiveCompare:@"gif"] == NSOrderedSame)
            || ([extension caseInsensitiveCompare:@"png"] == NSOrderedSame)
            || ([extension caseInsensitiveCompare:@"jpg"] == NSOrderedSame);
        }
    }
//    NSLog(@"%@", [path pathExtension]);
    return result;
}

- (void)didStartNetworking
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}
+ (AppDelegate *)sharedAppDelegate
{
    return (AppDelegate *) [UIApplication sharedApplication].delegate;
}
- (void)didStopNetworking
{
}
@end
