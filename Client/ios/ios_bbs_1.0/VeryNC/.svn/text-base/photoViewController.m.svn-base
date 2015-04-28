//
//  photoViewController.m
//  VeryNC
//
//  Created by wu jinjin on 12-4-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#define photoPicRequestURL [NSString stringWithFormat:@"%@topiclist.php?type=picshow_info&pageno=1&pagesize=1",api_url]
#define photoListRequestURLWithPage(x) [NSString stringWithFormat:@"%@topiclist.php?type=picshow_info&pageno=%d&pagesize=10",api_url,x]

//请求详细
//http://192.168.1.50/dx2app2/app2/topiclist.php?type=picshow_pic_info&picshow_id=1

#import "photoViewController.h"
#import "ReaderController.h"
#import "photoDetailViewController.h"
#import "EGOImageView.h"

@interface photoViewController ()

@end

@implementation photoViewController
@synthesize appDelegate;
@synthesize myDelegate;

@synthesize photoPicArray; 
@synthesize api_url;
@synthesize morebtnlabel;
@synthesize morePressButton;
@synthesize scrollView;

- (void)dealloc
{
    [appDelegate release];
    [myDelegate release];
    [photoPicArray release];
    [api_url release];
    [morebtnlabel release];
    [morePressButton release];
    [scrollView release];
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:158.0/255.0 green:26.0/255.0 blue:36.0/255.0 alpha:1.000]];
    [myDelegate showImage];
}
- (void)viewDidLoad
{
    
    [super viewDidLoad];   
    // Do any additional setup after loading the view from its nib.
    [[self navigationItem] setTitle: @"图片"]; 
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:158.0/255.0 green:26.0/255.0 blue:36.0/255.0 alpha:1.000]];
    
    //
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];    
    api_url = delegate.myDomainAndPathVeryNC;    
    
    //
    photoPicArray = [[NSMutableArray alloc] init];

    // photoViewBackgroundImage

    UIImageView *photoViewBackgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"imageset_background.png"]];
    [[self view] addSubview:photoViewBackgroundImage];
    [photoViewBackgroundImage release];   
    
    // NSURLConnection
   
    
    pagenum = 1;
    
//    NSLog(@"============ %@", photoPicRequestURL);
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:photoListRequestURLWithPage(pagenum)]];
	[request setTag:0];
	//[request setDownloadCache:[ASIDownloadCache sharedCache]];
	//[request setCachePolicy:ASIAskServerIfModifiedWhenStaleCachePolicy];
	[request setDelegate:self];
    [request setPersistentConnectionTimeoutSeconds:30];
	[request startAsynchronous];
    
    UIBarButtonItem *refresh_btn = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UITabBarSystemItemContacts target:self action:@selector(refresh)];
    self.navigationItem.leftBarButtonItem = refresh_btn;
}


#pragma mark - ASIHTTPDelegate
- (void)requestStarted:(ASIHTTPRequest *)request {
    morebtnlabel.text = @"正在载入...";
}

- (void)requestFinished:(ASIHTTPRequest *)request {
    
    
    NSString *requestString = [request responseString];
    
    if (request.tag == 0) {
        pagenum += 1;
        
        NSMutableArray *tmpArray = [[requestString JSONValue] valueForKey:@"datas"];
        
        int tmpArrayCount = [tmpArray count];
        BOOL loadmore = NO;
        int prephotocount = [photoPicArray count];
        int prejiou = prephotocount%2;
        int prelouceng = prephotocount/2;
        int prebtnlouceng;
        if(prejiou == 1){
            prebtnlouceng = prelouceng + 1;
        }else{
            prebtnlouceng = prelouceng;
        }
        if([photoPicArray count] != 0){
            loadmore = YES;
        }
        if(tmpArrayCount != 0){
            for(int i=0;i<tmpArrayCount;i++){
                [self.photoPicArray addObject:[tmpArray objectAtIndex:i]];
            }
        }
        
        int picarraycount = [photoPicArray count];
        int jiou = picarraycount % 2;
        int louceng = picarraycount / 2;
        
        //NSLog(@"%@",photoPicArray);
        
        if(picarraycount > 0){
            if(tmpArrayCount != 0){
                [morePressButton removeFromSuperview];
                [morebtnlabel removeFromSuperview];
                [scrollView removeFromSuperview];
                
                CGRect wholeWindow = [[self view] bounds];
                scrollView = [[UIScrollView alloc] initWithFrame:wholeWindow];
                [[self view] addSubview:scrollView];
                CGRect reallyBigRect;
                reallyBigRect.origin = CGPointZero;
                reallyBigRect.size.width = 320;
                if (jiou == 1) {
                    reallyBigRect.size.height = 100 + (135 * (louceng + 1));                
                } else {
                    reallyBigRect.size.height = 100 + (145 * (louceng));                
                }
                [scrollView setContentSize:reallyBigRect.size];  
                
                int btnlouceng;
                if(jiou == 1){
                    btnlouceng = louceng + 1;
                }else{
                    btnlouceng = louceng;
                }
                
                morePressButton = [[UIButton alloc] initWithFrame:CGRectMake(6, 15 + (144 * (btnlouceng + 0)), 305, 33)];
                [morePressButton setBackgroundImage:[UIImage imageNamed:@"buttonbg01.png"] forState:UIControlStateNormal];
                [morePressButton addTarget:self action:@selector(loadmore) forControlEvents:UIControlEventTouchUpInside];
                [scrollView addSubview:morePressButton];
                
                morebtnlabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 15 + (144 * (btnlouceng + 0)), 120, 33)];
                //            if(tmpArrayCount == 0){
                //                morebtnlabel.text = @"已无更多内容";
                //            }else{
                morebtnlabel.text = @"显示下10条";
                //}
                morebtnlabel.backgroundColor = [UIColor clearColor];
                morebtnlabel.textAlignment = UITextAlignmentCenter;
                morebtnlabel.textColor = [UIColor whiteColor];
                [scrollView addSubview:morebtnlabel];
                //            NSLog(@"btnlouceng = %d and prebtnlouceng = %d",btnlouceng,prebtnlouceng);
                if(loadmore == YES){
                    [scrollView setContentOffset:CGPointMake(0, 15 + (100 * (prebtnlouceng + 0))) animated:NO];
                }
                if ( jiou == 1) {
                    [morePressButton setFrame:CGRectMake(6, 0 + (143 * (btnlouceng + 0)), 305, 33)];
                    [morebtnlabel setFrame:CGRectMake(100, 0 + (143 * (btnlouceng + 0)), 120, 33)];
                }
                
                if ( jiou == 1) {//奇数
                    
                    //左+1
                    for (int i = 0; i < (louceng + 1); i++) {
                        UIImageView *photobgView1;
                        photobgView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photobg.png"]];
                        [photobgView1 setFrame:CGRectMake(10, (10 + (144 * i)), 151, 133)];
                        [photobgView1.layer setMasksToBounds:YES];
                        [photobgView1.layer setCornerRadius:4.0];
                        [scrollView addSubview:photobgView1];
                        [photobgView1 release];
                        
                        NSString *imageString1 = [[photoPicArray objectAtIndex:0 + (i * 2 )] valueForKey:@"picshow_coverpic"];
                        NSURL *imageURL1 = [NSURL URLWithString:imageString1];
                        //NSData *imageData1 = [NSData dataWithContentsOfURL:imageURL1];
                        //UIButton *pollbtnone1 = [[UIButton alloc] initWithFrame:CGRectMake(35, 23 + (144 * i), 103, 103)];
                        //[pollbtnone1 addTarget:self action:@selector(onClickImage:) forControlEvents:UIControlEventTouchUpInside];
                        //pollbtnone1.tag = 0 + (i * 2 );
                        //[pollbtnone1 setBackgroundImage:[UIImage imageWithData:imageData1] forState:UIControlStateNormal];
                        //[scrollView addSubview:pollbtnone1];    
                        EGOImageView *imageView = [[EGOImageView alloc] initWithPlaceholderImage:nil];
                        imageView.frame = CGRectMake(35, 17 + (144 * i), 103, 103);
                        imageView.imageURL = imageURL1;
                        imageView.userInteractionEnabled = YES;
                        UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage:)];
                        [imageView addGestureRecognizer:singleTap];
                        [singleTap setAccessibilityValue:[NSString stringWithFormat:@"%d",0 + (i * 2 )]];
                        imageView.tag = 0 + (i * 2 );
                        [scrollView addSubview:imageView];
                        
                        NSString *titleString1 = [[photoPicArray objectAtIndex:0 + (i * 2)] valueForKey:@"picshow_title"];
                        UILabel *titleLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(30, 100 + (144 * i), 116, 60)];
                        titleLabel1.text = titleString1;
                        titleLabel1.backgroundColor = [UIColor clearColor];
                        titleLabel1.textColor = [UIColor whiteColor];                   
                        [scrollView addSubview:titleLabel1];            
                        titleLabel1.font = [UIFont boldSystemFontOfSize:11];                    
                    }
                    
                    
                    if (picarraycount != 1) {
                        //右                    
                        for (int y = 0; y < louceng; y++) {
                            UIImageView *photobgView2;
                            photobgView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photobg.png"]];
                            [photobgView2 setFrame:CGRectMake(161, (10 + (144 * y)), 151, 133)];
                            [photobgView2.layer setMasksToBounds:YES];
                            [photobgView2.layer setCornerRadius:4.0];
                            [scrollView addSubview:photobgView2];
                            [photobgView2 release]; 
                            
                            NSString *imageString2 = [[photoPicArray objectAtIndex:1 + (y * 2)] valueForKey:@"picshow_coverpic"];
                            NSURL *imageURL2 = [NSURL URLWithString:imageString2];
                            //NSData *imageData2 = [NSData dataWithContentsOfURL:imageURL2];
                            //UIButton *pollbtnone2 = [[UIButton alloc] initWithFrame:CGRectMake(186, 23 + (144 * y), 103, 103)];
                            //[pollbtnone2 addTarget:self action:@selector(onClickImage:) forControlEvents:UIControlEventTouchUpInside];
                            //pollbtnone2.tag = 1 + (y * 2);
                            //[pollbtnone2 setBackgroundImage:[UIImage imageWithData:imageData2] forState:UIControlStateNormal];
                            //[scrollView addSubview:pollbtnone2];
                            EGOImageView *imageView = [[EGOImageView alloc] initWithPlaceholderImage:nil];
                            imageView.frame = CGRectMake(186, 17 + (144 * y), 103, 103);
                            imageView.imageURL = imageURL2;
                            imageView.userInteractionEnabled = YES;
                            UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage:)];
                            [imageView addGestureRecognizer:singleTap];
                            [singleTap setAccessibilityValue:[NSString stringWithFormat:@"%d",1 + (y * 2 )]];
                            imageView.tag = 1 + (y * 2);
                            [scrollView addSubview:imageView];
                            
                            NSString *titleString2 = [[photoPicArray objectAtIndex:1 + (y * 2)] valueForKey:@"picshow_title"];
                            UILabel *titleLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(180, 100 + (144 * y), 116, 60)];
                            titleLabel2.text = titleString2;
                            titleLabel2.backgroundColor = [UIColor clearColor];
                            titleLabel2.textColor = [UIColor whiteColor];                   
                            [scrollView addSubview:titleLabel2];            
                            titleLabel2.font = [UIFont boldSystemFontOfSize:11];                           
                        }                    
                    }
                    
                } else if ( jiou == 0) {//偶数
                    //左右相等
                    
                    for (int z = 0; z < louceng; z++) {
                        UIImageView *photobgView1;
                        photobgView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photobg.png"]];
                        [photobgView1 setFrame:CGRectMake(10, (16 + (144 * z)), 151, 133)];
                        [photobgView1.layer setMasksToBounds:YES];
                        [photobgView1.layer setCornerRadius:4.0];
                        [scrollView addSubview:photobgView1];
                        [photobgView1 release];         
                        
                        
                        NSString *imageString1 = [[photoPicArray objectAtIndex:0 + (z * 2 )] valueForKey:@"picshow_coverpic"];
                        NSURL *imageURL1 = [NSURL URLWithString:imageString1];
                        //NSData *imageData1 = [NSData dataWithContentsOfURL:imageURL1];
                        //UIButton *pollbtnone1 = [[UIButton alloc] initWithFrame:CGRectMake(35, 23 + (144 * z), 103, 103)];
                        //[pollbtnone1 addTarget:self action:@selector(onClickImage:) forControlEvents:UIControlEventTouchUpInside];
                        //pollbtnone1.tag = 0 + (z * 2 );
                        //[pollbtnone1 setBackgroundImage:[UIImage imageWithData:imageData1] forState:UIControlStateNormal];
                        //[scrollView addSubview:pollbtnone1];    
                        EGOImageView *imageView = [[EGOImageView alloc] initWithPlaceholderImage:nil];
                        imageView.frame = CGRectMake(35, 23 + (144 * z), 103, 103);
                        imageView.imageURL = imageURL1;
                        imageView.userInteractionEnabled = YES;
                        UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage:)];
                        [imageView addGestureRecognizer:singleTap];
                        [singleTap setAccessibilityValue:[NSString stringWithFormat:@"%d",0 + (z * 2 )]];
                        imageView.tag = 0 + (z * 2 );
                        [scrollView addSubview:imageView];
                        
                        
                        NSString *titleString1 = [[photoPicArray objectAtIndex:0 + (z * 2)] valueForKey:@"picshow_title"];
                        UILabel *titleLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(30, 106 + (144 * z), 116, 60)];
                        titleLabel1.text = titleString1;
                        titleLabel1.backgroundColor = [UIColor clearColor];
                        titleLabel1.textColor = [UIColor whiteColor];                   
                        [scrollView addSubview:titleLabel1];            
                        titleLabel1.font = [UIFont boldSystemFontOfSize:11];                    
                        
                        
                        
                    }
                    
                    for (int x = 0; x < louceng; x++) {
                        UIImageView *photobgView2;
                        photobgView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photobg.png"]];
                        [photobgView2 setFrame:CGRectMake(161, (16 + (144 * x)), 151, 133)];
                        [photobgView2.layer setMasksToBounds:YES];
                        [photobgView2.layer setCornerRadius:4.0];
                        [scrollView addSubview:photobgView2];
                        [photobgView2 release];     
                        
                        NSString *imageString2 = [[photoPicArray objectAtIndex:1 + (x * 2)] valueForKey:@"picshow_coverpic"];
                        NSURL *imageURL2 = [NSURL URLWithString:imageString2];
                        //NSData *imageData2 = [NSData dataWithContentsOfURL:imageURL2];
                        //UIButton *pollbtnone2 = [[UIButton alloc] initWithFrame:CGRectMake(186, 23 + (144 * x), 103, 103)];
                        //[pollbtnone2 setBackgroundImage:[UIImage imageWithData:imageData2] forState:UIControlStateNormal];
                        //[pollbtnone2 addTarget:self action:@selector(onClickImage:) forControlEvents:UIControlEventTouchUpInside];
                        //pollbtnone2.tag = 1 + (x * 2);
                        //[scrollView addSubview:pollbtnone2];   
                        EGOImageView *imageView = [[EGOImageView alloc] initWithPlaceholderImage:nil];
                        imageView.frame = CGRectMake(186, 23 + (144 * x), 103, 103);
                        imageView.imageURL = imageURL2;
                        imageView.userInteractionEnabled = YES;
                        UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage:)];
                        [imageView addGestureRecognizer:singleTap];
                        [singleTap setAccessibilityValue:[NSString stringWithFormat:@"%d",1 + (x * 2)]];
                        imageView.tag = 1 + (x * 2);
                        [scrollView addSubview:imageView];
                        
                        NSString *titleString2 = [[photoPicArray objectAtIndex:1 + (x * 2)] valueForKey:@"picshow_title"];
                        UILabel *titleLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(180, 106 + (144 * x), 116, 60)];
                        titleLabel2.text = titleString2;
                        titleLabel2.backgroundColor = [UIColor clearColor];
                        titleLabel2.textColor = [UIColor whiteColor];                   
                        [scrollView addSubview:titleLabel2];            
                        titleLabel2.font = [UIFont boldSystemFontOfSize:11];                      
                    }
                    
                    
                } 
            }else{
                morebtnlabel.text = @"已无更多内容";
            }
                 
 
        } else {
            UIAlertView *alert;
            NSError *error = [request error];
            if (error){
                alert = [[UIAlertView alloc] initWithTitle:@"暂无数据" 
                                                   message:@"" 
                                                  delegate:self cancelButtonTitle:@"确定" 
                                         otherButtonTitles:nil];
            [alert show];
            [alert release];
            }
        }
    }

}
- (void)requestFailed:(ASIHTTPRequest *)request {
    morebtnlabel.text = @"显示下10条";
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

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
//点击切换到图片详细页面
- (void)onClickImage:(UITapGestureRecognizer *)sender
{
    //UIImageView *btn = sender;
    NSString *num = sender.accessibilityValue;
    photoDetailViewController *photodetail = [[photoDetailViewController alloc] initWithNibName:@"photoDetailViewController" bundle:nil];
    photodetail.picshow_id    = [[photoPicArray objectAtIndex:[num intValue]] objectForKey:@"picshow_id"];
    photodetail.picshow_title = [[photoPicArray objectAtIndex:[num intValue]] objectForKey:@"picshow_title"];
    photodetail.tid           = [[photoPicArray objectAtIndex:[num intValue]] objectForKey:@"tid"];
    photodetail.fid           = [[photoPicArray objectAtIndex:[num intValue]] objectForKey:@"fid"];
    photodetail.picshow_coverpic = [[photoPicArray objectAtIndex:[num intValue]] objectForKey:@"picshow_coverpic"];
    [photodetail setHidesBottomBarWhenPushed:YES];
    [myDelegate hideImage];
    [self.navigationController pushViewController:photodetail animated:YES];
}
- (void)loadmore
{
    //pagenum += 1;
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:photoListRequestURLWithPage(pagenum)]];
	[request setTag:0];
	//[request setDownloadCache:[ASIDownloadCache sharedCache]];
	//[request setCachePolicy:ASIAskServerIfModifiedWhenStaleCachePolicy];
	[request setDelegate:self];
    [request setPersistentConnectionTimeoutSeconds:30];
	[request startAsynchronous];
}
- (void)refresh
{
    [photoPicArray removeAllObjects];
    pagenum = 1;
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:photoListRequestURLWithPage(pagenum)]];
	[request setTag:0];
	//[request setDownloadCache:[ASIDownloadCache sharedCache]];
	//[request setCachePolicy:ASIAskServerIfModifiedWhenStaleCachePolicy];
	[request setDelegate:self];
    [request setPersistentConnectionTimeoutSeconds:30];
	[request startAsynchronous];
}
@end
