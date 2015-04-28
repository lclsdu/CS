

#import "RootController.h"

#define _connectionFailureID 997
#import "pushViewController.h"
#import "ReaderController.h"
#import "NewsViewController.h"
#import "Constants.h"

@implementation RootController

//基本框架
@synthesize appDelegate;
@synthesize myDelegate;
@synthesize api_url;

@synthesize  homeImageView;
@synthesize  classificationImageView;
@synthesize  shoppingcartImageView;
@synthesize  myshopImageView;
@synthesize  moreImageView;
@synthesize postImageView;

//controllers
@synthesize vNewsViewController;
@synthesize vtopicViewController;
@synthesize vphotoViewController;
@synthesize vbusinessViewController;
@synthesize vvoteViewController;
@synthesize vpostViewController;



- (void)requestStarted:(ASIHTTPRequest *)request
{
	[self removeLoadingPatternIfNeed];
    [self drawLoadingPattern:@"加载中" isWithAnimation:NO];
}

- (void)drawLoadingPattern:(NSString*)text isWithAnimation:(bool)isWithAnimation
{
    if (!_loadView) {
        _loadView=[[LoadingView alloc] initWithFrame:CGRectMake(0, 0, 130, 100) LoadingViewStyle:LoadingViewStyleStandard];
    } else {
        return;
    }
    
    if (isWithAnimation) { 
        _loadView.titleLabel.font=[UIFont boldSystemFontOfSize:13];
        _loadView.title=text;
        _loadView.alpha=0;
        _loadView.transform=CGAffineTransformMakeScale(1.7f, 1.7f);
        [_loadView showInView:self.view];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3f];
        _loadView.alpha=1;
        _loadView.transform=CGAffineTransformMakeScale(1, 1);
        [UIView commitAnimations];
    } else {
        _loadView.titleLabel.font=[UIFont boldSystemFontOfSize:13];
        _loadView.title=text;
        _loadView.alpha=1;
        [_loadView showInView:self.view];
    }
}

-(void)removeLoadingPatternIfNeed
{
    [_loadView dismiss];
    _loadView=nil;
}

- (void)requestFinished:(ASIHTTPRequest *)request
{    

    if (request.tag == 10011) {
        NSString *requestString = [request responseString];
        NSArray *response_info = [[requestString JSONValue] valueForKey:@"datas"];
        NSDictionary *device_info = [response_info objectAtIndex:0];
        NSString *deviceStatus = [device_info objectForKey:@"result"];
        
        NSLog(@"status - %@", deviceStatus);
        
        if ([deviceStatus isEqualToString:@"token save succ"]) {

            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"token.plist"];
            NSArray *isPostToken = [NSArray arrayWithObjects:@"postFinish", nil];
            [isPostToken writeToFile:filePath atomically:YES];
        } else if ([deviceStatus isEqualToString:@"token save failed"]) {
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"token.plist"];
            NSArray *isPostToken = [NSArray arrayWithObjects:@"postFail", nil];
            [isPostToken writeToFile:filePath atomically:YES];            
        }
    }
    
    [self removeLoadingPatternIfNeed];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{    
    if (request.tag == 10011) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"token.plist"];
        NSArray *isPostToken = [NSArray arrayWithObjects:@"postFail", nil];
        [isPostToken writeToFile:filePath atomically:YES];
        NSLog(@"fail");
    }
    
	[self removeLoadingPatternIfNeed];
    [self ShowConnectionFailureAlert];    
}

-(void)ShowConnectionFailureAlert
{
    if (!aAlert) {
        aAlert = [[UIAlertView alloc] initWithTitle:@"链接错误" message:@"暂时不能连接服务器" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        aAlert.tag=_connectionFailureID;
        [aAlert show];
    }
}

-(void)cancelASIHTTPRequest
{
    for (ASIHTTPRequest *request in ASIHTTPRequest.sharedQueue.operations)
    {
        [request cancel];
        [request setDelegate:nil];
    }
}

-(void)startASIRequest:(NSString *)urlString tag:(NSInteger)tag
{
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlString]];
    [request setTag:tag];
    [request setDownloadCache:[ASIDownloadCache sharedCache]];
    [request setCachePolicy:ASIAskServerIfModifiedCachePolicy | ASIFallbackToCacheIfLoadFailsCachePolicy]; 
    [request setDelegate:self];
    [request startAsynchronous];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{   
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [super viewDidLoad];
    
    NSString *s = [[NSString alloc] init];
    appDelegate.userName = s;
    [s release];
    

    

    
    appDelegate.userName = @"";
    
    //----------------------------------------
    
    s= [[NSString alloc] init];
    appDelegate.myDomainAndPathVeryNC = s;
    [s release];
    
    appDelegate.myDomainAndPathVeryNC = _customDomainandPathVeryNC;
    appDelegate.loginTip = _loginTip;
    appDelegate.loginURL = _loginURL;
    appDelegate.newsHeaderArray1 = [[NSMutableArray alloc] init];
    api_url = appDelegate.myDomainAndPathVeryNC;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"token.plist"];
    //    NSString *filePath = [@"~/Document/token.plist" stringByStandardizingPath];    
    
    //    NSArray *isPostToken = [NSArray arrayWithObjects:@"postFinish", nil];
    //    NSArray *isPostToken = [NSArray arrayWithObjects:@"postFail", nil];
    //    [isPostToken writeToFile:filePath atomically:YES];
    
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSPropertyListFormat format;
    NSArray *array = [NSPropertyListSerialization propertyListFromData:data mutabilityOption:NSPropertyListImmutable format:&format errorDescription:nil];
    if ([array count] > 0) {
        NSString *isPostFinish = [array objectAtIndex:0];
        NSString *token = [array objectAtIndex:1];  
        
        if ([isPostFinish isEqualToString:@"postFinish"]) {
            //不执行操作
        } else {
            NSURL *login_url = [NSURL URLWithString:[api_url stringByAppendingString:@"devicetoken.php"]];
            ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:login_url];
            [request setTag:10011];
            [request setPostValue:token forKey:@"token"];
            [request setDelegate:self];
            [request setTimeOutSeconds:30];
            [request startAsynchronous];
        }        
    }

    [self setTabbar:0 selected:true];
    [self setTabbar:1 selected:false];
    [self setTabbar:2 selected:false];
    [self setTabbar:3 selected:false];
    [self setTabbar:4 selected:false];
    [self setDelegate:self];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushReaderView:) name:@"notifyToPushReaderView" object:nil];  
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(postDeviceToken:) name:@"notifyToPostDeviceToken" object:nil];

}

-(NSString*) unescapeUnicodeString:(NSString*)string
{
    NSString* unescapedString = [string stringByReplacingOccurrencesOfString:@"\\\"" withString:@"\""];
    unescapedString = [unescapedString stringByReplacingOccurrencesOfString:@"\\\\" withString:@"\\"];

    NSMutableString* tokenizedString = [NSMutableString string];
    NSScanner* scanner = [NSScanner scannerWithString:unescapedString];
    while ([scanner isAtEnd] == NO)
    {
        NSString* token = @"";
        [scanner scanUpToString:@"\\u" intoString:&token];
        if (token != nil && token.length > 0)
        {
            [tokenizedString appendString:token];
            continue;
        }
        
        NSUInteger location = [scanner scanLocation];
        NSInteger extra = scanner.string.length - location - 4 - 2;
        if (extra < 0)
        {
            NSRange range = {location, -extra};
            [tokenizedString appendString:[scanner.string substringWithRange:range]];
            [scanner setScanLocation:location - extra];
            continue;
        }
        
        // move the location pas the unicode marker
        // then read in the next 4 characters
        location += 2;
        NSRange range = {location, 4};
        token = [scanner.string substringWithRange:range];
        unichar codeValue = (unichar) strtol([token UTF8String], NULL, 16);
        [tokenizedString appendString:[NSString stringWithFormat:@"%C", codeValue]];
        
        // move the scanner past the 4 characters
        // then keep scanning
        location += 4;
        [scanner setScanLocation:location];
    };
    return tokenizedString;
}

- (void)postDeviceToken:(NSNotification *)notification
{
    NSString *token = [notification object];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"token.plist"];
//    NSString *filePath = [@"~/Document/token.plist" stringByStandardizingPath];    
    
//    NSArray *isPostToken = [NSArray arrayWithObjects:@"postFinish", nil];
//    NSArray *isPostToken = [NSArray arrayWithObjects:@"postFail", nil];
//    [isPostToken writeToFile:filePath atomically:YES];

    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSPropertyListFormat format;
    NSArray *array = [NSPropertyListSerialization propertyListFromData:data mutabilityOption:NSPropertyListImmutable format:&format errorDescription:nil];
    NSString *isPostFinish = [array objectAtIndex:0];
    
//    if ([isPostFinish isEqualToString:@"postFinish"]) {
//        NSLog(@"yes");
//        //不执行操作
//    } else {
//        NSLog(@"no");
//        
//        NSURL *login_url = [NSURL URLWithString:[api_url stringByAppendingString:@"devicetoken.php"]];
//        
//        NSLog(@"%@", login_url);
//        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:login_url];
//        [request setTag:10011];
//        [request setPostValue:@"d4fe9fbc3e4f7ce375c0b770bbb1b59d95631ae94c1e95681f7006b71f55203f" forKey:@"token"];
//        [request setDelegate:self];
//        [request setTimeOutSeconds:30];
//        [request startAsynchronous];
//        NSLog(@"no start");
//    }

}

- (void)pushReaderView:(NSNotification *)notification
{   
    NSDictionary *dic = [notification object];
    NSString *alert = [dic objectForKey:@"alert"];
    NSString *readernum = [dic objectForKey:@"tid"];
    
    ReaderController *reader = [[ReaderController alloc] init];
    reader.tid = [readernum intValue];
    reader.Title = [self unescapeUnicodeString:alert];
    reader.fid=-1;    
    [reader setHidesBottomBarWhenPushed:YES];
    [self hideImage];  
    [self.tabBar setHidden:YES];
    [self.vNewsViewController.orderButton setHidden:YES];
    
    [self.vNewsViewController.navigationController pushViewController:reader animated:YES];
    [reader release];
}


- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController ;
{
    [self setTabbar:self.selectedIndex selected:false];    
    return true;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController;
{
    [self setTabbar:self.selectedIndex selected:true];   
}

-(void) setTabbar :(NSInteger)n  selected:(bool)selected
{        
    switch (n) {
        case 0:
            if (selected) {
                [homeImageView setImage:[UIImage imageNamed:@"news_red.png"]];
                [homeImageView setFrame:CGRectMake(0,428, 64, 52)]; 
                [self.view addSubview:homeImageView]; 
            } else {
                [homeImageView setImage:[UIImage imageNamed:@"news.png"]];
                [homeImageView setFrame:CGRectMake(0,428, 64, 52)]; 
                [self.view addSubview:homeImageView]; 
            }
            break;
        case 1:
            if (selected) {
                [classificationImageView setImage:[UIImage imageNamed:@"post_red.png"]];
                [classificationImageView setFrame:CGRectMake(64,428, 64, 52)]; 
                [self.view addSubview:classificationImageView]; 
            } else {
                [classificationImageView setImage:[UIImage imageNamed:@"post.png"]];
                [classificationImageView setFrame:CGRectMake(64,428, 64, 52)]; 
                [self.view addSubview:classificationImageView]; 
            }
            break;
        case 2:
            if (selected) {
                [shoppingcartImageView setImage:[UIImage imageNamed:@"topic_red.png"]];
                [shoppingcartImageView setFrame:CGRectMake(128,428, 64, 52)]; 
                [self.view addSubview:shoppingcartImageView]; 
            } else {
                [shoppingcartImageView setImage:[UIImage imageNamed:@"topic.png"]];
                [shoppingcartImageView setFrame:CGRectMake(128,428, 64, 52)]; 
                [self.view addSubview:shoppingcartImageView]; 
            }
            break;
        case 3:
            if(selected) {
                //商圈备用
//                [myshopImageView setImage:[UIImage imageNamed:@"business_red.png"]];
//                [myshopImageView setFrame:CGRectMake(192,428, 64, 52)]; 
//                [self.view addSubview:myshopImageView]; 
                [postImageView setImage:[UIImage imageNamed:@"photo_red.png"]];
                [postImageView setFrame:CGRectMake(192, 428, 64, 52)];
                [self.view addSubview:postImageView];                
            } else {  
                //商圈备用
//                [myshopImageView setImage:[UIImage imageNamed:@"business.png"]];
//                [myshopImageView setFrame:CGRectMake(192,428, 64, 52)]; 
//                [self.view addSubview:myshopImageView]; 
                [postImageView setImage:[UIImage imageNamed:@"photo.png"]];
                [postImageView setFrame:CGRectMake(192, 428, 64, 52)];
                [self.view addSubview:postImageView];
            }
            break;
        case 4:
            if (selected) { 
                [moreImageView setImage:[UIImage imageNamed:@"vote_red.png"]];
                [moreImageView setFrame:CGRectMake(256,428, 64, 52)]; 
                [self.view addSubview:moreImageView]; 
            } else {
                [moreImageView setImage:[UIImage imageNamed:@"vote.png"]];
                [moreImageView setFrame:CGRectMake(256,428, 64, 52)]; 
                [self.view addSubview:moreImageView]; 
            }
            break;
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {	
    [homeImageView release];
    [classificationImageView release];
    [shoppingcartImageView release];
    [myshopImageView release];
    [moreImageView release];
    [postImageView release];
	[appDelegate release];
	//[navController release];
    [vNewsViewController release];
    [vtopicViewController release];
    [vphotoViewController release];
    [vbusinessViewController release];
    [vvoteViewController release];
//    [vpostViewController release];
    [super dealloc];
}

#pragma -mark MyprotocolDelegate

-(void)hideImage{
    [homeImageView setHidden:YES];
    [classificationImageView setHidden:YES];
    [shoppingcartImageView setHidden:YES];
    [myshopImageView setHidden:YES];
    [moreImageView setHidden:YES];
    [postImageView setHidden:YES];
}

-(void)showImage{
    [homeImageView setHidden:NO];
    [classificationImageView setHidden:NO];
    [shoppingcartImageView setHidden:NO];
    [myshopImageView setHidden:NO];
    [moreImageView setHidden:NO];
    [postImageView setHidden:NO];
}
@end