//
//  PhotoPostViewController.m
//  化龙巷
//
//  Created by mac on 12-4-11.
//  Copyright (c) 2012年 Osugroup. All rights reserved.
//

#import "PhotoPostViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
//#import "MoreAccountViewController.h"
#import "shopDetailViewController.h"
@interface PhotoPostViewController ()

@end

@implementation PhotoPostViewController
@synthesize photo,shop_id,shop_name,author,author_id,pic_path,textView,scrollerView,api_url,is_nonav,navbar,aci,sendtip;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"发布图片";
    }
    return self;
}

- (void)viewDidLoad
{
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    api_url = delegate.myDomainAndPathVeryNC;
    
    aci.hidden = YES;
    sendtip.hidden = YES;
    
    if([is_nonav isEqualToString:@"nonav"]){
        navbar.hidden = NO;
        
        UIImageView *photoview = [[UIImageView alloc] initWithFrame:CGRectMake(20, 70,100, 100)];
        photoview.image = photo;
        [self.view addSubview:photoview];
        [photoview release];
        
        UIBarButtonItem *submit_btn = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UITabBarSystemItemContacts target:self action:@selector(submit)];
        self.navigationItem.rightBarButtonItem = submit_btn;
        [submit_btn release];
        
        
        UILabel *tipslable = [[UILabel alloc] initWithFrame:CGRectMake(130, 90,100, 20)];
        tipslable.text = @"商家:";
        tipslable.textColor = [UIColor grayColor];
        tipslable.font = [UIFont systemFontOfSize:14];
        [self.view addSubview:tipslable];
        
        UILabel *shopnamelable = [[UILabel alloc] initWithFrame:CGRectMake(130, 110,150, 20)];
        shopnamelable.text = shop_name;
        CGFloat r = (CGFloat) 199/255.0;
        CGFloat g = (CGFloat) 166/255.0;
        CGFloat b = (CGFloat) 112/255.0;
        shopnamelable.textColor=[UIColor colorWithRed:r green:g blue:b alpha:1.0];
        shopnamelable.font = [UIFont boldSystemFontOfSize:16];
        [self.view addSubview:shopnamelable];
        
        UILabel *tipslable_2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 170,100, 20)];
        tipslable_2.text = @"再说点什么吧:";
        tipslable_2.textColor = [UIColor grayColor];
        tipslable_2.font = [UIFont systemFontOfSize:14];
        [self.view addSubview:tipslable_2];
        
        textView=[[UITextView alloc]initWithFrame:CGRectMake(20.0f,190.0f,280.0f,160.0f)];
        [textView setTextAlignment:UITextAlignmentLeft];	
        [textView setBackgroundColor:[UIColor clearColor]];
        [textView setFont:[UIFont fontWithName:@"ArialMT" size:16]];
        textView.keyboardAppearance=UIKeyboardAppearanceAlert;
        textView.layer.masksToBounds=YES;
        textView.layer.borderWidth=1.0;
        textView.layer.borderColor=[[UIColor lightGrayColor] CGColor];
        textView.layer.cornerRadius = 6;
        [self.view addSubview:textView];
    }else{
        UIImageView *photoview = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20,100, 100)];
        photoview.image = photo;
        [self.view addSubview:photoview];
        [photoview release];
        
        UIBarButtonItem *submit_btn = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UITabBarSystemItemContacts target:self action:@selector(submit)];
        self.navigationItem.rightBarButtonItem = submit_btn;
        [submit_btn release];
        
        
        UILabel *tipslable = [[UILabel alloc] initWithFrame:CGRectMake(130, 40,100, 20)];
        tipslable.text = @"商家:";
        tipslable.textColor = [UIColor grayColor];
        tipslable.font = [UIFont systemFontOfSize:14];
        [self.view addSubview:tipslable];
        
        UILabel *shopnamelable = [[UILabel alloc] initWithFrame:CGRectMake(130, 60,150, 20)];
        shopnamelable.text = shop_name;
        CGFloat r = (CGFloat) 199/255.0;
        CGFloat g = (CGFloat) 166/255.0;
        CGFloat b = (CGFloat) 112/255.0;
        shopnamelable.textColor=[UIColor colorWithRed:r green:g blue:b alpha:1.0];
        shopnamelable.font = [UIFont boldSystemFontOfSize:16];
        [self.view addSubview:shopnamelable];
        
        UILabel *tipslable_2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 120,100, 20)];
        tipslable_2.text = @"再说点什么吧:";
        tipslable_2.textColor = [UIColor grayColor];
        tipslable_2.font = [UIFont systemFontOfSize:14];
        [self.view addSubview:tipslable_2];
        
        textView=[[UITextView alloc]initWithFrame:CGRectMake(20.0f,140.0f,280.0f,160.0f)];
        [textView setTextAlignment:UITextAlignmentLeft];	
        [textView setBackgroundColor:[UIColor clearColor]];
        [textView setFont:[UIFont fontWithName:@"ArialMT" size:16]];
        textView.keyboardAppearance=UIKeyboardAppearanceAlert;
        textView.layer.masksToBounds=YES;
        textView.layer.borderWidth=1.0;
        textView.layer.borderColor=[[UIColor lightGrayColor] CGColor];
        textView.layer.cornerRadius = 6;
        [self.view addSubview:textView];
    }
    
    
    
    scrollerView.scrollEnabled=YES;
    scrollerView.contentSize = CGSizeMake(320, 600);
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (void)submit
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; 
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@zuobiao.php?type=post_image&shop_id=%@",api_url,shop_id]]];
    DebugLog(@"%@",[NSString stringWithFormat:@"%@zuobiao.php?type=post_image&shop_id=%@",api_url,shop_id]);
    NSDictionary *now = [NSKeyedUnarchiver unarchiveObjectWithFile:[documentsDirectory stringByAppendingPathComponent:@"nowlogin.plist"]];
    NSString *username    = [now objectForKey:@"username"];
    NSString *authorid  = [now objectForKey:@"uid"];
    
        aci.hidden = NO;
        sendtip.hidden = NO;
        [request setPostValue:username forKey:@"author"];
        [request setPostValue:authorid forKey:@"authorid"];
        [request setPostValue:textView.text forKey:@"message"];
        [request setFile:pic_path forKey:@"img1"];
        
        [request setCachePolicy:ASIAskServerIfModifiedCachePolicy | ASIFallbackToCacheIfLoadFailsCachePolicy]; 
        [request setCachePolicy:ASIOnlyLoadIfNotCachedCachePolicy];
        [request setDelegate:self];
        [request setPersistentConnectionTimeoutSeconds:30];
        [request startAsynchronous];
   
    
}
- (IBAction)goback:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)submit:(id)sender
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; 
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@zuobiao.php?type=post_image&shop_id=%@",api_url,shop_id]]];
    DebugLog(@"%@",[NSString stringWithFormat:@"%@zuobiao.php?type=post_image&shop_id=%@",api_url,shop_id]);
    NSDictionary *now = [NSKeyedUnarchiver unarchiveObjectWithFile:[documentsDirectory stringByAppendingPathComponent:@"nowlogin.plist"]];
    NSString *username    = [now objectForKey:@"username"];
    NSString *authorid  = [now objectForKey:@"uid"];
    
        aci.hidden = NO;
        sendtip.hidden = NO;
        [request setPostValue:username forKey:@"author"];
        [request setPostValue:authorid forKey:@"authorid"];
        [request setPostValue:textView.text forKey:@"message"];
        [request setFile:pic_path forKey:@"img1"];
        
        [request setCachePolicy:ASIAskServerIfModifiedCachePolicy | ASIFallbackToCacheIfLoadFailsCachePolicy]; 
        [request setCachePolicy:ASIOnlyLoadIfNotCachedCachePolicy];
        [request setDelegate:self];
        [request setPersistentConnectionTimeoutSeconds:30];
        [request startAsynchronous];
    
}
- (void)requestFinished:(ASIHTTPRequest *)request {
    NSString *requestString = [request responseString];
    NSArray *tmpArray = [[requestString JSONValue] valueForKey:@"datas"];
    
    NSString *s = [[tmpArray objectAtIndex:0] valueForKey:@"result"];
    if([s isEqualToString:@"post succ"])
    {
        UIAlertView *alert=[[UIAlertView alloc]
                            initWithTitle:@"提交成功"
                            
                            message:@""//\n\n\n\n"
                            delegate:self
                            cancelButtonTitle:@"知道了"
                            otherButtonTitles:nil,nil];
        
        [alert show];
        [alert release];
//        [self.navigationController popViewControllerAnimated:YES];
        [[[self.navigationController viewControllers] objectAtIndex:1]dismissModalViewControllerAnimated:YES];

        
        
        
        
    }
    else if([s isEqualToString:@"post failed"])
    {   
        UIAlertView *alert=[[UIAlertView alloc]
                            initWithTitle:@"提交失败"
                            
                            message:@""//\n\n\n\n"
                            delegate:self
                            cancelButtonTitle:@"知道了"
                            otherButtonTitles:nil,nil];
        [alert show];
        [alert release];
        
    }else {    
        UIAlertView *alert=[[UIAlertView alloc]
                            initWithTitle:@"404错误"
                            
                            message:@""//\n\n\n\n"
                            delegate:self
                            cancelButtonTitle:@"知道了"
                            otherButtonTitles:nil,nil];
        [alert show];
        [alert release];
    }

}
- (void)requestFailed:(ASIHTTPRequest *)request {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"提交失败，请重试" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
    [alert show];
    [alert release];
}
- (void)viewDidUnload
{
    photo = nil;
    shop_id = nil;
    shop_name = nil;
    author = nil;
    author_id = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)dealloc
{
    [photo release];
    [shop_id release];
    [shop_name release];
    [author release];
    [author_id release];
    [textView release];
    [scrollerView release];
    [aci release];
    [sendtip release];
    [super dealloc];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
