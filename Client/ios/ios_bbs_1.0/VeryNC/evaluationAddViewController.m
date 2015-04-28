//
//  evaluationAddViewController.m
//  化龙巷
//
//  Created by mac on 12-3-29.
//  Copyright (c) 2012年 Osugroup. All rights reserved.
//

#import "evaluationAddViewController.h"
#import "AppDelegate.h"
#import "shopDetailViewController.h"
@interface evaluationAddViewController ()

@end

@implementation evaluationAddViewController
@synthesize textView;
@synthesize shop_id;
@synthesize mark_value;
@synthesize segbutton;
@synthesize api_url;
@synthesize scrollerView;
- (void)viewWillDisAppear:(BOOL)animated;  
{
    [textView removeFromSuperview];
    
}
- (void)viewWillAppear:(BOOL)animated;  
{
    [[self navigationItem] setTitle: @"提交评价"]; 
    
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)requestStarted:(ASIHTTPRequest *)request {
    
}

- (void)requestFinished:(ASIHTTPRequest *)request {
	NSString *requestString = [request responseString];
    NSArray *tmpArray = [[requestString JSONValue] valueForKey:@"datas"];
    NSString *s = [[tmpArray objectAtIndex:0] valueForKey:@"result"];
    if([s isEqualToString:@"post succ"])
    {
        UIAlertView *alert=[[UIAlertView alloc]
                            initWithTitle:@"评价提交成功"
                            
                            message:@""//\n\n\n\n"
                            delegate:self
                            cancelButtonTitle:@"知道了"
                            otherButtonTitles:nil,nil];
        [alert show];
        [alert release];
        
        shopDetailViewController *shopDetailController =[[shopDetailViewController alloc]initWithNibName:@"shopDetailViewController" bundle:nil];
        shopDetailController.shop_id = self.shop_id;
        [self.navigationController pushViewController:shopDetailController animated:YES];    

    }
    else  if([s isEqualToString:@"post failed"])
    {   
        UIAlertView *alert=[[UIAlertView alloc]
                            initWithTitle:@"评价提交失败"
                            
                            message:@""//\n\n\n\n"
                            delegate:self
                            cancelButtonTitle:@"知道了"
                            otherButtonTitles:nil,nil];
        
        
        //---------------------------------------------------------
        [alert show];
        [alert release];
        
        //[self.navigationController popViewControllerAnimated:true];
        
    }
    
    else if([s isEqualToString:@"unknown error"])
    {        
        UIAlertView *alert=[[UIAlertView alloc]
                            initWithTitle:@"未知错误"
                            
                            message:@""//\n\n\n\n"
                            delegate:self
                            cancelButtonTitle:@"知道了"
                            otherButtonTitles:nil,nil];
        
        
        //---------------------------------------------------------
        [alert show];
        [alert release];
        
    }
}
- (NSString *)removeNewlinesAndTabulation:(NSString *)fromString appending:(BOOL)appending
{
    NSArray *a = [fromString componentsSeparatedByString:@"\n"];
    NSMutableString *res = [NSMutableString stringWithString:appending ? @" " : @""];
    for (NSString *s in a) {
        s = [s stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if (s.length > 0 
            && res.length > (appending ? 1 : 0)) [res appendString:@" "];
        [res appendString:s];
    }
    return res;
}
-(void)tapToSubmit:(id)sender;
{
    NSString *s1=[self removeNewlinesAndTabulation:[textView text] appending:false];
    if([s1 length]<1 )
    {
        
        UIAlertView *alert=[[UIAlertView alloc]
                            initWithTitle:@"评价内容不能为空"
                            
                            message:@""//\n\n\n\n"
                            delegate:self
                            cancelButtonTitle:@"知道了"
                            otherButtonTitles:nil,nil];
        [alert show];
        [alert release];
        return;
    }else{
        if([s1 length]>300 )
        {
            UIAlertView *alert=[[UIAlertView alloc]
                                initWithTitle:@"评价内容太多"
                                
                                message:@""//\n\n\n\n"
                                delegate:self
                                cancelButtonTitle:@"知道了"
                                otherButtonTitles:nil,nil];
            [alert show];
            [alert release];
            return;
        }
        
    }
    //提交商家评价
    NSString *left_url  = [NSString stringWithFormat:@"%@zuobiao.php?type=post&shop_id=",api_url];
    NSString *final_url = [left_url stringByAppendingString:self.shop_id];
    NSURL *url=[NSURL URLWithString:final_url];
    //调取当前登陆用户信息
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"nowlogin.plist"];
    NSDictionary *nowloginuser_info = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    NSString *username = [nowloginuser_info objectForKey:@"username"];
    NSString *sid      = [nowloginuser_info objectForKey:@"sessionid"];
    NSString *uid      = [nowloginuser_info objectForKey:@"uid"];
    //提交表单
    ASIFormDataRequest  *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:s1 forKey:@"message"];
    [request setPostValue:username forKey:@"author"];
    [request setPostValue:uid forKey:@"authorid"];
    [request setPostValue:mark_value forKey:@"mark"];
    [request setPostValue:sid forKey:@"sid"];
    
    
    [request setCachePolicy:ASIAskServerIfModifiedCachePolicy | ASIFallbackToCacheIfLoadFailsCachePolicy]; 
    [request setCachePolicy:ASIOnlyLoadIfNotCachedCachePolicy];
    [request setDelegate:self];
    [request startAsynchronous];
}
- (void)viewDidLoad
{
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    api_url = delegate.myDomainAndPathVeryNC;
    [super viewDidLoad];
    
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithTitle:@"提交"
                                                                  style:UIBarButtonItemStyleBordered
                                                                 target:self
                                                                 action:@selector(tapToSubmit:)];
    self.navigationItem.rightBarButtonItem = barButton;
    [barButton release];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(backtoshopdetail:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    [cancelButton release];
    textView=[[UITextView alloc]initWithFrame:CGRectMake(20.0f,120.0f,280.0f,160.0f)];
    [textView setTextAlignment:UITextAlignmentLeft];	
    [textView setBackgroundColor:[UIColor clearColor]];
    [textView setFont:[UIFont fontWithName:@"ArialMT" size:16]];
    textView.keyboardAppearance=UIKeyboardAppearanceAlert;
    textView.layer.masksToBounds=YES;
    textView.layer.borderWidth=1.0;
    textView.layer.borderColor=[[UIColor lightGrayColor] CGColor];
    textView.layer.cornerRadius = 6;
    [self.view addSubview:textView];
    
    //UISegmentedControl *segButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"推荐",@"一般",@"不推荐",nil]];//一个item
    segbutton =[[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects: [UIImage imageNamed: @"good_a.png"],[UIImage imageNamed: @"average_a.png"],[UIImage imageNamed: @"nogood_a.png"], nil ]];
    segbutton.frame = CGRectMake(20, 45, 280, 30);
    segbutton.segmentedControlStyle = UISegmentedControlStyleBar;
    [segbutton setWidth:94 forSegmentAtIndex:0];
    [segbutton setWidth:92 forSegmentAtIndex:1];
    [segbutton setWidth:94 forSegmentAtIndex:2];
    segbutton.momentary = NO;
    segbutton.tintColor = [UIColor whiteColor];
    [segbutton addTarget:self action:@selector(selectmark:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segbutton];
    [segbutton release];
    
    scrollerView.scrollEnabled=YES;
    scrollerView.contentSize = CGSizeMake(320, 500);
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
-(void)dealloc{
    [textView release];
    [shop_id release];
    [scrollerView release];
	[super dealloc];
}
-(void)selectmark:(id)sender
{
    if([sender selectedSegmentIndex] == 0){
        mark_value = @"3";
        [segbutton setImage:[UIImage imageNamed: @"good_a_hover.png"] forSegmentAtIndex:0];
        [segbutton setImage:[UIImage imageNamed: @"average_a.png"] forSegmentAtIndex:1];
        [segbutton setImage:[UIImage imageNamed: @"nogood_a.png"] forSegmentAtIndex:2];
    }else if ([sender selectedSegmentIndex] == 1) {
        mark_value = @"2";
        [segbutton setImage:[UIImage imageNamed: @"good_a.png"] forSegmentAtIndex:0];
        [segbutton setImage:[UIImage imageNamed: @"average_a_hover.png"] forSegmentAtIndex:1];
        [segbutton setImage:[UIImage imageNamed: @"nogood_a.png"] forSegmentAtIndex:2];
    }else if ([sender selectedSegmentIndex] == 2) {
        mark_value = @"1";
        [segbutton setImage:[UIImage imageNamed: @"good_a.png"] forSegmentAtIndex:0];
        [segbutton setImage:[UIImage imageNamed: @"average_a.png"] forSegmentAtIndex:1];
        [segbutton setImage:[UIImage imageNamed: @"nogood_a_hover.png"] forSegmentAtIndex:2];
    }
}
-(void)backtoshopdetail:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)backgroundTap:(id)sender
{
    [textView resignFirstResponder];
}
@end
