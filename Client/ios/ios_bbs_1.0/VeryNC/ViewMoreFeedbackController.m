//
//  MoreFeedbackViewController.m
//  化龙巷
//
//  Created by David Suen on 12-3-22.
//  Copyright (c) 2012年 Osugroup. All rights reserved.
//

#import "ViewMoreFeedbackController.h"
#import "AppDelegate.h"


@implementation ViewMoreFeedbackController
@synthesize myDelegate;
@synthesize tableView1;
@synthesize textView;
@synthesize api_url;

- (void)requestFailed:(ASIHTTPRequest *)request {
    [self.navigationItem.rightBarButtonItem setEnabled:true];
	/*if (_activityView ) {
     [_activityView stopAnimating];
     [_activityView removeFromSuperview];
     _activityView = nil;
     [_loadLabel removeFromSuperview];
     _loadLabel = nil;
     }
     */
    if (_activityView ) {
        [_activityView removeFromSuperview];
        _activityView = nil;
        [_loadLabel removeFromSuperview];
        _loadLabel = nil;
    }
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
- (void)viewWillDisAppear:(BOOL)animated;  
{
    [textView removeFromSuperview];
    for (ASIHTTPRequest *request in ASIHTTPRequest.sharedQueue.operations)
    {
        [request cancel];
        [request setDelegate:nil];
    }
}
- (void)viewWillAppear:(BOOL)animated;  
{
    
    
    [[self navigationItem] setTitle: @"意见反馈"]; 
    
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
    /*
     if (_activityView ) {
     [_activityView removeFromSuperview];
     _activityView = nil;
     [_loadLabel removeFromSuperview];
     _loadLabel = nil;
     }
     _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
     _activityView.frame = CGRectMake(110.0f, 120.0f, 20.0f, 20.0f);
     [self.view addSubview:_activityView];
     [_activityView startAnimating];
     
     
     _loadLabel = [ViewTool addUILable:self.view x:135.0 y:118 x1:100 y1:20 fontSize:15 lableText:@"提交中..."];
     [_loadLabel setTextColor:[UIColor grayColor]];
     
     */
    
    //beta2
    if (_activityView ) {
        
		[_activityView removeFromSuperview];
		_activityView = nil;
		[_loadLabel removeFromSuperview];
		_loadLabel = nil;
        
        [_loadingView removeFromSuperview];
        _loadingView=nil;
        
	}
    
    _loadingView=[[UIImageView alloc] initWithFrame:CGRectMake(90.0f, 100.0f,140.0f, 70.0f)];
    _loadingView.image=[UIImage imageNamed:@"duqu.png"];
    _loadingView.alpha=0.8;
    [self.view addSubview:_loadingView];
    
    _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
	_activityView.frame = CGRectMake(110.0f, 122.0f, 20.0f, 20.0f);
	[self.view addSubview:_activityView];
	[_activityView startAnimating];
	
	//_loadLabel = [ViewTool addUILable:self.view x:140.0 y:158 x1:100 y1:20 fontSize:15 lableText:@"加载中..."];
	_loadLabel = [ViewTool addUILable:self.view x:140.0 y:122 x1:100 y1:20 fontSize:15 lableText:@"提交中..."];
	
    [_loadLabel setTextColor:[UIColor grayColor]];
    
}

- (void)requestFinished:(ASIHTTPRequest *)request {
    [self.navigationItem.rightBarButtonItem setEnabled:false];
    if (_activityView ) {
        [_activityView removeFromSuperview];
        _activityView = nil;
        [_loadLabel removeFromSuperview];
        _loadLabel = nil;
    }
	NSString *requestString = [[request responseString] stringByConvertingHTMLToPlainText];
    
    
    
    NSArray *tmpArray = [[requestString JSONValue] valueForKey:@"datas"];
    
    
    NSString *s = [[tmpArray objectAtIndex:0] valueForKey:@"result"];
    if([s isEqualToString:@"send succ"])
    {
        UIAlertView *alert=[[UIAlertView alloc]
                            initWithTitle:@"反馈提交成功"
                            
                            message:@""//\n\n\n\n"
                            delegate:self
                            cancelButtonTitle:@"知道了"
                            otherButtonTitles:nil,nil];
        
        
        //---------------------------------------------------------
        [alert show];
        [alert release];
        
        [self.navigationController popViewControllerAnimated:true];
    }
    else  if([s isEqualToString:@"send failed"])
    {   
        UIAlertView *alert=[[UIAlertView alloc]
                            initWithTitle:@"反馈提交失败"
                            
                            message:@""//\n\n\n\n"
                            delegate:self
                            cancelButtonTitle:@"知道了"
                            otherButtonTitles:nil,nil];
        
        
        //---------------------------------------------------------
        [alert show];
        [alert release];
        
        //[self.navigationController popViewControllerAnimated:true];
        
    }
    
    else  if([s isEqualToString:@"unknown error"])
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
        
        //[self.navigationController popViewControllerAnimated:true];
        
        
        
    }
    
    
    
    /*
     
     200 send succ
     500 send failed
     404 unknown error
     
     
     UIAlertView *alert=[[UIAlertView alloc]
     initWithTitle:requestString
     
     message:s//\n\n\n\n"
     delegate:self
     cancelButtonTitle:@"好"
     otherButtonTitles:nil,nil];
     
     
     //---------------------------------------------------------
     [alert show];
     [alert release];
     */
	[self.navigationController popViewControllerAnimated:true];
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
                            initWithTitle:@"反馈内容不能为空"
                            
                            message:@""//\n\n\n\n"
                            delegate:self
                            cancelButtonTitle:@"知道了"
                            otherButtonTitles:nil,nil];
        
        
        //---------------------------------------------------------
        [alert show];
        [alert release];
        
        
        return;
    }
    
    else {
        if([s1 length]>300 )
        {
            
            UIAlertView *alert=[[UIAlertView alloc]
                                initWithTitle:@"帖子内容太多"
                                
                                message:@""//\n\n\n\n"
                                delegate:self
                                cancelButtonTitle:@"知道了"
                                otherButtonTitles:nil,nil];
            
            
            //---------------------------------------------------------
            [alert show];
            [alert release];
            
            
            return;
        }
        
    }
    
    [self.navigationItem.rightBarButtonItem setEnabled:false];
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@advice.php?type=submit",api_url]];
    ASIFormDataRequest  *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:[textView text] forKey:@"message"];
    [request setPostValue:@"" forKey:@"uid"];
    [request setPostValue:@"" forKey:@"username"];  
    
    
    [request setCachePolicy:ASIAskServerIfModifiedCachePolicy | ASIFallbackToCacheIfLoadFailsCachePolicy]; 
    [request setCachePolicy:ASIOnlyLoadIfNotCachedCachePolicy];
    
    
    [request setDelegate:self];
    [request setPersistentConnectionTimeoutSeconds:_timeOut];
    [request startAsynchronous];
    
    //[request setFile:@"/Users/ben/Desktop/ben.jpg" forKey:@"photo"];
    
    
    //[self.navigationController popViewControllerAnimated:true];
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
    [tableView1 release];
	[super dealloc];
}

#pragma mark -
#pragma mark Table View Data Source Methods

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView 

{
	return 1;
} 


- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section
{
	
    
	return 1;
}





- (CGFloat)tableView:(UITableView *)tableView 
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	
	return 180.0f;//cell height
	
	
	
}
//------------------------------------------------------------------------------------------------



- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{	
    
    
    
    static NSString *SimpleTableIdentifier1 = @"CellTableIdentifier";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier: SimpleTableIdentifier1 ];
    
    if  (cell == nil) 
    {
        
        //CGRect cellframe=CGRectMake(0, 0, 280, 60);
        cell=[[[UITableViewCell alloc] initWithFrame: CGRectZero//SimpleTableIdentifier1
               
                                     reuseIdentifier:SimpleTableIdentifier1] autorelease];
        
        
        
        
        
        
        UITextView *a=[[UITextView alloc]initWithFrame:CGRectMake(10.0f,10.0f,280.0f,160.0f)];
        
        textView=a;
        
        
        [textView 	setTextAlignment:UITextAlignmentLeft];	
        
        textView.keyboardAppearance=UIKeyboardAppearanceAlert; 
        [textView setBackgroundColor:[UIColor clearColor]];
        [textView  setFont:[UIFont fontWithName:@"ArialMT" size:16]];
        
        [cell.contentView addSubview:textView];
        [textView becomeFirstResponder];
        // [a release]; 
        
        
        
    }
	
	
    
    [cell  setBackgroundColor:[UIColor whiteColor]];
    
    cell.textLabel.text= @"" ;
    
    
    return cell;
    
    
	
 	
}
//#pragma mark -
//#pragma mark Table Delegate Methods1 

- (void)tableView:(UITableView *)tableView 
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
	[tableView1 deselectRowAtIndexPath:indexPath animated:YES];
    [textView becomeFirstResponder];
}



@end
