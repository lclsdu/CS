//
//  FaceScrollView.m
//  FaceDemo
//
//  Created by user on 11-10-20.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "FaceScrollView.h"
#import "FaceView.h"
#import "AppDelegate.h"
@implementation FaceScrollView

@synthesize   faceAmount ,api_url;
- (void)requestFailed:(ASIHTTPRequest *)request {
    
    UIAlertView *alert;
    NSError *error = [request error];
    if (error)
        alert = [[UIAlertView alloc] initWithTitle:@"链接错误" 
                                           message:@"暂时不能连接服务器" 
                                          delegate:self cancelButtonTitle:@"知道了" 
                                 otherButtonTitles:nil];
    [alert show];
    [alert release];
}


- (id)initWithFrame:(CGRect)rect target:(id)target
{
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    api_url = delegate.myDomainAndPathVeryNC;
    NSArray *smilelist_array;
    
    
    NSString *url_final = [NSString stringWithFormat:@"%@topicpost.php?type=smiley",api_url];
    
    ASIHTTPRequest *head = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url_final]];
    [head setDownloadCache:[ASIDownloadCache sharedCache]];
    [head setCachePolicy:ASIAskServerIfModifiedCachePolicy | ASIFallbackToCacheIfLoadFailsCachePolicy]; 
    [head setCachePolicy:ASIOnlyLoadIfNotCachedCachePolicy];
    [head setTimeOutSeconds:10];//_timeOut
    [head startSynchronous];
    
    NSError *error = [head error];
    if (!error) {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *requestString =  [head responseString];
        
        requestString=[requestString stringByReplacingOccurrencesOfString:@"\\'" withString:@""] ;
        
        
        
        
        DebugLog(@"%@",requestString);
        
        
        
        smilelist_array = [[requestString JSONValue] valueForKey:@"datas"];
        
        DebugLog(@"---------------------------------" );
        
        DebugLog(@"%d",[smilelist_array count]);
        
        
    }else{
        faceAmount=0;
        faceAmountGlobal=0;
        
        return 0;
    }
    
    
    
    
    
    
    if ([smilelist_array count]==0)
        
    {
        faceAmount=0;
        
        faceAmountGlobal=0;
        
        return 0;
    }
    
    
    faceAmount=[smilelist_array count];
    
    
    
    faceAmountGlobal=faceAmount;
    
    DebugLog(@"%d",faceAmount);
    NSInteger n=faceAmount /40;
    NSInteger v=faceAmount % 40;
    if(v!=0) n=n+1;
    
    self.contentSize = CGSizeMake(320*n, _facePageHeight);
    self = [super initWithFrame:CGRectMake(rect.origin.x,rect.origin.y,rect.size.width,rect.size.height) ];
    if (self) {
        // Initialization code here.
        
        
        
        
        
        
        
        
        
        for (int i = 0; i < n; i++) 
        {
            int j=0;
            FaceView *faceView = [[FaceView alloc] initWithFrame:CGRectMake(i*320,0,rect.size.width,rect.size.height) ];;//320,220)];
            faceView.deletage = target;
            faceView.tag = i;
            [faceView initImageList];
            
            faceView.backgroundColor = [UIColor grayColor];
            NSString *s,*s1 ;
            if(i==n-1)
            {
                NSInteger m;
                if (v==0) m=40;
                else m=v;
                
                
                
                for (int j = 0; j < m; j++) 
                {
                    
                    
                    s = [[smilelist_array objectAtIndex:i*40+j] valueForKey:@"url"];
                    [[faceView imageURLList] addObject:s];
                    
                    
                    s1 = [[smilelist_array objectAtIndex:i*40+j] valueForKey:@"code"];
                    DebugLog(@" %@", s1);
                    [[faceView codeList] addObject:s1];
                    
                }
                //[[faceView imageURLList] addObject:s];
            }
            else {
                
                
                for (int j = 0; j < 40; j++) 
                {
                    
                    
                    s = [[smilelist_array objectAtIndex:i*40+j] valueForKey:@"url"];
                    [[faceView imageURLList] addObject:s];
                    
                    s1 = [[smilelist_array objectAtIndex:i*40+j] valueForKey:@"code"];
                    DebugLog(@" %@", s1);
                    [[faceView codeList] addObject:s1];
                    
                }
                
                
            }
            
            [faceView createExpressionWithPage:i];
            [self addSubview:faceView];
            [faceView release];
        }
        
        
        
        
    }
    
    
    
    return self;
}

-(void)setPages;
{
    
    
    NSInteger n=faceAmount /40;
    if((faceAmount % 40)!=0) n=n+1;
    
    
}
- (void)viewWillDisAppear:(BOOL)animated;  
{
    for (ASIHTTPRequest *request in ASIHTTPRequest.sharedQueue.operations)
    {
        [request cancel];
        [request setDelegate:nil];
    }
}
@end
