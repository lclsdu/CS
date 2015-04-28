//
//  FaceView.m
//  FaceDemo
//
//  Created by user on 11-10-20.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "FaceView.h"

@implementation FaceView
@synthesize imageDownloadsInProgress;
@synthesize entries;
@synthesize imageURLList;
@synthesize codeList;
@synthesize deletage = _deletage;

@synthesize appRecords;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    // Initialize the array of app records and pass a reference to that list to our root view controller
    self.appRecords = [NSMutableArray array];
    entries = self.appRecords;
    
    //   NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:TopPaidAppsFeed]];
    //   self.appListFeedConnection = [[[NSURLConnection alloc] initWithRequest:urlRequest delegate:self] autorelease];
    
    // Test the validity of the connection object. The most likely reason for the connection object
    // to be nil is a malformed URL, which is a programmatic error easily detected during development
    // If the URL is more dynamic, then you should implement a more flexible validation technique, and
    // be able to both recover from errors and communicate problems to the user in an unobtrusive manner.
    //
    //   NSAssert(self.appListFeedConnection != nil, @"Failure to create URL connection.");
    
    // show in the status bar that network activity is starting
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    
    
    self.imageDownloadsInProgress = [NSMutableDictionary dictionary];
    return self;
}

-(void)dealloc
{
    if (_deletage) {
        _deletage = nil;
    }
    [codeList release];
    [imageDownloadsInProgress release];
    [imageURLList release];
    [entries release];
    [super dealloc];
    
    
    
    
    
}
- (void)startIconDownload:(AppRecord *)appRecord tag:(NSInteger)tag;// forIndexPath:(NSIndexPath *)indexPath
{
    IconDownloader *iconDownloader = [imageDownloadsInProgress objectForKey:[NSString stringWithFormat: @"%d",tag]];
    if (iconDownloader == nil) 
    {
        iconDownloader = [[IconDownloader alloc] init];
        iconDownloader.appRecord = appRecord;
        //iconDownloader.indexPathInTableView = indexPath;
        iconDownloader.myTag=tag;
        iconDownloader.delegate = self;
        [imageDownloadsInProgress setObject:iconDownloader forKey:[NSString stringWithFormat: @"%d",tag]];
        [iconDownloader startDownload];
        [iconDownloader release];   
    }
}

// this method is used in case the user scrolled into a set of cells that don't have their app icons yet
- (void)loadImagesForOnscreenRows
{
    DebugLog(@"---kk--%d",[appRecords count] );
    for(int i=0;i<[appRecords count];i++)
    {
        
        AppRecord *appRecord = [self.appRecords objectAtIndex:i];
        [self startIconDownload:appRecord tag:i ];
        
        
    }
    
}

// called by our ImageDownloader when an icon is ready to be displayed
- (void)appImageDidLoad:(NSInteger)tag {
    IconDownloader *iconDownloader = [imageDownloadsInProgress objectForKey:[NSString stringWithFormat: @"%d",tag]];
    if (iconDownloader != nil)
    {
        //UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:iconDownloader.indexPathInTableView];
        
        // Display the newly loaded image
        //cell.imageView.image = iconDownloader.appRecord.appIcon;
        
        
        UIButton *b= (UIButton*)[self viewWithTag:tag+5000]; 
        
        //[b setImage:<#(UIImage *)#> forState:<#(UIControlState)#>     
        if([b isKindOfClass:[UIButton class] ])
        {
            [b setImage:iconDownloader.appRecord.appIcon forState:UIControlStateNormal];
            b.enabled=true;
            int i=0;
        }
    }
}
-(void)initImageList;
{
    
    NSMutableArray *a=[[NSMutableArray alloc]init ];
    imageURLList=a;
    NSMutableArray *b=[[NSMutableArray alloc]init ];
    codeList=b;
    //  [a release];
}
-(void)createExpressionWithPage:(int)page
{
    
    NSInteger v=[imageURLList count]%8;
    NSInteger n=[imageURLList count]/8;
    DebugLog(@"%d %d %d",[imageURLList count],v,n );
    
    if(v!=0) n=n+1;
    for (int i = 0; i < n; i++)
    {
        
        
        
        if(i==n-1)
        {
            NSInteger m;
            if (v==0) m=8;
            else m=v;
            for (int j = 0; j < m; j++) 
            {
                
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.tag = [[NSString stringWithFormat:@"%02d",i*8 + j + page*32] intValue];
                button.tag = i*8+j+page*32+5000;
                
                AppRecord *a=[[AppRecord alloc]init];
                a.newTag=button.tag ;
                a.imageURLString=[imageURLList objectAtIndex: ( i*8 + j)];
                a.appName=[codeList objectAtIndex: ( i*8 + j)];
                [self.appRecords addObject:a ];
                
                DebugLog(@" %@",[a  appName]);
                //DebugLog(@"button.tag %d",button.tag);
                //DebugLog(@"tag %@",[NSString stringWithFormat:@"%03d",i*8 + j + page*32]);
                [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
                // button.frame = CGRectMake(j*40, i*40, 40, 40);
                
                button.frame = CGRectMake(j*40+8, i*40+8, 24, 24);
                [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%03d",0]] forState:UIControlStateNormal];
                
                if (button.imageView.image == nil) 
                {
                    [button setEnabled:NO];
                }
                
                [self addSubview:button];
                
                
            }
            
        }
        else {
            
            
            for (int j = 0; j < 8; j++) 
            {
                
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.tag = [[NSString stringWithFormat:@"%02d",i*8 + j + page*32] intValue];
                button.tag = i*8+j+page*32+5000;
                
                
                
                AppRecord *a=[[AppRecord alloc]init];
                a.newTag=button.tag;
                a.imageURLString=[imageURLList objectAtIndex: ( i*8 + j)];
                a.appName=[codeList objectAtIndex: ( i*8 + j)];
                
                DebugLog(@" %@",[a  appName]);
                [self.appRecords addObject:a ];
                //DebugLog(@"button.tag %d",button.tag);
                //DebugLog(@"tag %@",[NSString stringWithFormat:@"%03d",i*8 + j + page*32]);
                [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
                //button.frame = CGRectMake(j*40, i*40, 40, 40);
                
                button.frame = CGRectMake(j*40+8, i*40+8, 24, 24);
                
                
                [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%03d",0]] forState:UIControlStateNormal];
                
                if (button.imageView.image == nil) 
                {
                    [button setEnabled:NO];
                } 
                [self addSubview:button];
                
            }
            
            
            
        }
        
        // [self.appRecords addObjectsFromArray:imageURLList];
        
        
        /*
         for (int j = 0; j <8; j++)
         {
         UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
         button.tag = [[NSString stringWithFormat:@"%02d",i*8 + j + page*32] intValue];
         button.tag = i*8+j+page*32;
         //DebugLog(@"button.tag %d",button.tag);
         //DebugLog(@"tag %@",[NSString stringWithFormat:@"%03d",i*8 + j + page*32]);
         [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
         button.frame = CGRectMake(j*40, i*40, 40, 40);
         [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%03d",i*8 + j + page*32]] forState:UIControlStateNormal];
         if (button.imageView.image == nil) 
         {
         [button setEnabled:NO];
         }
         [self addSubview:button];
         }
         */
        
        
        
    }
    
    [self loadImagesForOnscreenRows];
    
}
/*
 // Load images for all onscreen rows when scrolling is finished
 - (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
 {
 if (!decelerate)
 {
 [self loadImagesForOnscreenRows];
 }
 }
 - (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
 {
 [self loadImagesForOnscreenRows];
 }
 */
-(void)buttonClick:(UIButton *)button
{
    //NSString *name = [NSString stringWithFormat:@"[%03d]",button.tag];
    
    int i;
    for(i=0;i<[appRecords count];i++)
    {
        DebugLog(@"===%@",[[appRecords objectAtIndex:i] appName]);
        
    }
    for(i=0;i<[appRecords count];i++)
    {
        
        
        if([[appRecords objectAtIndex:i] newTag]==button.tag)
            
        {
            
            break;
        }
    }
    
    DebugLog(@"%d %@",i,[[appRecords objectAtIndex:i] appName]);
    if (self.deletage) 
    {
        [self.deletage expressionClickWith:self faceName:[[appRecords objectAtIndex:i] appName] ];
    }
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */


@end
