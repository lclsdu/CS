//
//  businessViewController.m
//  VeryNC
//
//  Created by wu jinjin on 12-4-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "businessViewController.h"
#import "MoreAccountViewController.h"
@interface businessViewController ()

@end

@implementation businessViewController
@synthesize appDelegate;
@synthesize myDelegate,locationManager,api_url;;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{   
    
   
 
    
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    lng=0.0;
    lat=0.0;
    requestURLOfShopPercent= [api_url stringByAppendingString:@"zuobiao.php?type=shop_list&lat=39.1178&lng=117.15&r=2000&pageno=1&pagesize=20&class=%@&cid=%d"];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateCellAccordingToDistance:) name:@"updateInfoAccordingToDistance" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateCellForClassOff:) name:@"classToBeOff" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateCellAccordingToClass:) name:@"updateInfoAccordingToComponentTwoCategory" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateCellAccordingToClass:) name:@"updateInfoAccordingToComponentOneCategory" object:nil];
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    api_url = delegate.myDomainAndPathVeryNC;
    
    
    
    classOnOrOff=@"off";
    dynamicCid=1;
    countOfRequest=0;
    pageNum=1;
    distanceForUrl=2000;
    distanceOK=YES;
    
    
    
    
    locationManager = [[CLLocationManager alloc] init];
	locationManager.delegate = self;
	locationManager.distanceFilter = 100;
	locationManager.desiredAccuracy = kCLLocationAccuracyBest;
	// Start updating location changes.
	[locationManager startUpdatingLocation];
	// Do any additional setup after loading the view, typically from a nib.
    
    /*
     if (_activityView ) {
     [_activityView removeFromSuperview];
     _activityView = nil;
     [_loadLabel removeFromSuperview];
     _loadLabel = nil;
     }
     _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
     _activityView.frame = CGRectMake(110.0f, 160.0f, 20.0f, 20.0f);
     [self.view addSubview:_activityView];
     [_activityView startAnimating];
     
     _loadLabel = [ViewTool addUILable:self.view x:135.0 y:158 x1:100 y1:20 fontSize:15 lableText:@"定位中..."];
     [_loadLabel setTextColor:[UIColor grayColor]];
     DebugLog(@"startUpdatingLocation---");
     
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
    
    _loadingView=[[UIImageView alloc] initWithFrame:CGRectMake(90.0f, 140.0f,140.0f, 70.0f)];
    _loadingView.image=[UIImage imageNamed:@"duqu.png"];
    _loadingView.alpha=0.8;
    [self.view addSubview:_loadingView];
    
    _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
	_activityView.frame = CGRectMake(110.0f, 162.0f, 20.0f, 20.0f);
	[self.view addSubview:_activityView];
	[_activityView startAnimating];
	
	//_loadLabel = [ViewTool addUILable:self.view x:140.0 y:158 x1:100 y1:20 fontSize:15 lableText:@"加载中..."];
	_loadLabel = [ViewTool addUILable:self.view x:140.0 y:162 x1:100 y1:20 fontSize:15 lableText:@"加载中..."];
	
    [_loadLabel setTextColor:[UIColor grayColor]];
    
    
    //	[[self navigationItem] setTitle:@"信息"];
    //	[[self view] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"navi.png"]]];
    //UIImageView *banner = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hlx.png"]];
	//[banner setFrame:CGRectMake(96, 10, 128, 28)];
	//banner.tag = 999;
	//[self.navigationController.navigationBar addSubview:banner];
	//[banner release];
    [self.navigationItem setTitle:@"商圈"];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:158.0/255.0 green:26.0/255.0 blue:36.0/255.0 alpha:1.000]];
    //调取当前登陆用户信息
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"nowlogin.plist"];
    NSDictionary *nowloginuser_info = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    NSString *username = [nowloginuser_info objectForKey:@"username"];
    if(username == nil){
        UIBarButtonItem * rightButton=[[UIBarButtonItem alloc] initWithTitle:[NSString stringWithUTF8String:"登录"] style:UIBarButtonItemStylePlain target:self action:@selector(gotologin:)];   
        self.navigationItem.rightBarButtonItem=rightButton;
        [rightButton release];
    }
    
    resultArray=[[NSMutableArray alloc]init];
    specificDistanceResultArray=[[NSMutableArray alloc]init];
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated
{ 
    //调取当前登陆用户信息
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"nowlogin.plist"];
    NSDictionary *nowloginuser_info = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    NSString *username = [nowloginuser_info objectForKey:@"username"];
    if(username == nil){
        UIBarButtonItem * rightButton=[[UIBarButtonItem alloc] initWithTitle:[NSString stringWithUTF8String:"登录"] style:UIBarButtonItemStylePlain target:self action:@selector(gotologin:)];   
        self.navigationItem.rightBarButtonItem=rightButton;
        [rightButton release];
    }else{
        self.navigationItem.rightBarButtonItem=nil;
    }
    [myDelegate showImage];
}
- (void)viewDidAppear:(BOOL)animated{
    
}
- (void)viewWillDisappear:(BOOL)animated{
    
} 

- (void)viewDidUnload
{
    [requestURLOfShop release];
    [tableview release];
    tableview = nil;
    [allCategoryButton release];
    allCategoryButton = nil;
    [distanceButton release];
    distanceButton = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [tableview release];
    [resultArray release];
    [specificDistanceResultArray release];
    [locationManager release];
    [_activityView release];
    [allCategoryButton release];
    [distanceButton release];
    [super dealloc];
}


#pragma mark - CLLocationManagerDelegate




- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	DebugLog(@"didFailWithError: %@", error);
}


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    //    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"location" 
    //                                       message:@"location changed" 
    //                                      delegate:self cancelButtonTitle:@"OK" 
    //                             otherButtonTitles:nil];
    //    [alert show];
    //    
    
    if (_activityView ) {
        
		[_activityView removeFromSuperview];
		_activityView = nil;
		[_loadLabel removeFromSuperview];
		_loadLabel = nil;
        
        [_loadingView removeFromSuperview];
        _loadingView=nil;
        
	}
    lat=newLocation.coordinate.latitude;
    lng=newLocation.coordinate.longitude;
    NSString * locationUrl;
    if (distanceOK) {
        locationUrl=[NSString stringWithFormat:@"%@zuobiao.php?type=shop_list&lat=%lf&lng=%lf&r=%lf&pageno=1&pagesize=20&class=%@&cid=%d&limit=max",api_url,lat,lng,distanceForUrl,classOnOrOff,dynamicCid]; 
        
        
    }else{
        
        locationUrl=[NSString stringWithFormat:@"%@zuobiao.php?type=shop_list&lat=%lf&lng=%lf&r=%lf&pageno=1&pagesize=20&class=%@&cid=%d",api_url,lat,lng,distanceForUrl,classOnOrOff,dynamicCid]; 
        
    }
    DebugLog(@"locationUrl --------%@",locationUrl);
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:locationUrl]];
    [request setTag:4];
	[request setDownloadCache:[ASIDownloadCache sharedCache]];
	[request setCachePolicy:ASIAskServerIfModifiedWhenStaleCachePolicy];
	[request setDelegate:self];
	[request startAsynchronous];
}



#pragma mark - ASIHTTPDelegate
- (void)requestStarted:(ASIHTTPRequest *)request {
    
    
}

- (void)requestFinished:(ASIHTTPRequest *)request {
    
    
    if (request.tag!=3) {
        [resultArray removeAllObjects];
        [specificDistanceResultArray removeAllObjects];
    }else {
        [resultArray removeLastObject];
        [specificDistanceResultArray removeLastObject];
    }
    NSString *requestString = [request responseString];
    NSArray *tmpArray = [[requestString JSONValue] valueForKey:@"datas"];
    if([tmpArray count]>0)
    {
    
    
        for (int i = 0; i < [tmpArray count]; i++) {
            ShopObject * shopDetail =  [[ShopObject alloc] init];
            
            shopDetail.shopid = [[[tmpArray objectAtIndex:i] valueForKey:@"shop_id"] intValue];
            
            shopDetail.distance = [[[tmpArray objectAtIndex:i] valueForKey:@"distance"] doubleValue];
            shopDetail.lagitude = [[[tmpArray objectAtIndex:i] valueForKey:@"shop_lat"] doubleValue];
            shopDetail.longitude = [[[tmpArray objectAtIndex:i] valueForKey:@"shop_lng"] doubleValue];
            shopDetail.pic = [[tmpArray objectAtIndex:i] valueForKey:@"shop_pic"];
            shopDetail.name = [[tmpArray objectAtIndex:i] valueForKey:@"shop_name"] ;
            shopDetail.phone = [[tmpArray objectAtIndex:i] valueForKey:@"shop_phone"];
            shopDetail.website = [[tmpArray objectAtIndex:i] valueForKey:@"shop_website"];
            shopDetail.address = [[tmpArray objectAtIndex:i] valueForKey:@"shop_address"];
            shopDetail.service=[[[tmpArray objectAtIndex:i] valueForKey:@"fuwu"]doubleValue ];
            shopDetail.enviroment=[[[tmpArray objectAtIndex:i] valueForKey:@"huangjing"] doubleValue];
            
            [resultArray addObject:shopDetail];
            [specificDistanceResultArray addObject:shopDetail];
            [ShopObject release];
        }  
    }
    
    if([tmpArray count]>0){
        
        [resultArray addObject:@"更多"];
        [specificDistanceResultArray addObject:@"更多"];
    }
    
    else  {
        [resultArray addObject:@"没有更多信息"];
        [specificDistanceResultArray addObject:@"没有更多信息"];
    }
    
    
    [tableview reloadData];
    
    
    
    
}


- (void)requestFailed:(ASIHTTPRequest *)request {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notifyToReadDynamicIPNotification" object:nil];
    if (request.tag==4) {   
        if (countOfRequest==0) { 
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
        countOfRequest++;
    }else{
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
    
    
}


#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{    
    return [specificDistanceResultArray count];    
}



- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell_%d_%d",indexPath.row];
    
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:nil];
    if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        if ([indexPath row] == [specificDistanceResultArray count] - 1 && [specificDistanceResultArray count] != 0) {
            //[cell.textLabel setText:@"更多"];
            [cell.textLabel setText:  [resultArray  objectAtIndex:[resultArray count] - 1]];
            
            [cell.textLabel setTextAlignment:UITextAlignmentCenter];
        }else{
            
			
            ShopObject *cellHLine = [specificDistanceResultArray objectAtIndex:indexPath.row];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 75, 55)];
            [cell addSubview:imageView];
            [imageView setContentMode:UIViewContentModeScaleToFill];
            [imageView release];
            [imageView.layer setBorderColor:[UIColor whiteColor].CGColor];
            [imageView.layer setBorderWidth:1.0f];
            [imageView.layer setShadowColor:[UIColor blackColor].CGColor];
            [imageView.layer setShadowOffset:CGSizeMake(1.5, 1.5)];
            [imageView.layer setShadowOpacity:0.6];
            [imageView setImageWithURL:[NSURL URLWithString:cellHLine.pic] placeholderImage:[UIImage imageNamed:@"defalut_img_small.png"]];
            
            if (cellHLine.distance>=1000) {
                float tmpDistance=cellHLine.distance/1000.0;
                UILabel *distanceLabel = [ViewTool addUILable:cell x:255 y:38 x1:100 y1:32 fontSize:12 lableText:[NSString stringWithFormat:@"%.1fkm", tmpDistance]];
                [distanceLabel setHighlightedTextColor:[UIColor whiteColor]];
                distanceLabel.textColor = [UIColor grayColor];
                distanceLabel.numberOfLines = 1;
            }else{
                UILabel *distanceLabel = [ViewTool addUILable:cell x:255 y:38 x1:100 y1:32 fontSize:12 lableText:[NSString stringWithFormat:@"%dm", cellHLine.distance]];
                [distanceLabel setHighlightedTextColor:[UIColor whiteColor]];
                distanceLabel.textColor = [UIColor grayColor];
                distanceLabel.numberOfLines = 1;
                
            }
            
            
            
            
            UILabel *titleLabel = [ViewTool addUILable:cell x:90 y:7 x1:205 y1:20 fontSize:15 lableText:cellHLine.name];
            [titleLabel setHighlightedTextColor:[UIColor whiteColor]];
            // lbs bug   
            titleLabel.textColor=[UIColor colorWithPatternImage:[UIImage  imageNamed:@"blueblue.png"]];
            
            
            //				UILabel *subTitleLabel = [ViewTool addUILable:cell x:90 y:28 x1:155 y1:20 fontSize:13 lableText:cellHLine.phone];
            //				[subTitleLabel setHighlightedTextColor:[UIColor whiteColor]];
            //				subTitleLabel.textColor = [UIColor grayColor];
            //				subTitleLabel.numberOfLines = 1;
            
            
            
            UILabel *subTitleLabel = [ViewTool addUILable:cell x:90 y:28 x1:155 y1:20 fontSize:12 lableText:[NSString stringWithFormat:@"%@%.1f %@%.1f",[NSString stringWithUTF8String:"服务:"],cellHLine.service/2, [NSString stringWithUTF8String:"环境:"],cellHLine.enviroment/2]];
            [subTitleLabel setHighlightedTextColor:[UIColor whiteColor]];
            subTitleLabel.textColor = [UIColor grayColor];
            subTitleLabel.numberOfLines = 1;
            
            
            
            
			
            
            UILabel *adddressTitleLabel = [ViewTool addUILable:cell x:90 y:45 x1:165 y1:20 fontSize:12 lableText:cellHLine.address];
            [adddressTitleLabel setHighlightedTextColor:[UIColor whiteColor]];
            adddressTitleLabel.textColor=[UIColor grayColor];
            adddressTitleLabel.numberOfLines=1;
            
            
            
            
            //                    [cell setAccessoryView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow.png"]]];
            
        }
        
        
	}
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([indexPath row] == [resultArray count] - 1) {
        
        
        if([[resultArray objectAtIndex:[resultArray count] - 1] isEqualToString:@"没有更多信息"]) 
            return;            
        
        pageNum++;
        [self performSelector:@selector(pressMenu)];
    }else { 
        
        ShopObject * tempShopObject=[specificDistanceResultArray objectAtIndex:indexPath.row];
        shopDetailViewController * shopDetailController =[[shopDetailViewController alloc]initWithNibName:@"shopDetailViewController" bundle:nil];
        shopDetailController.shop_id=[NSString stringWithFormat:@"%d",tempShopObject.shopid];
        [shopDetailController setHidesBottomBarWhenPushed:YES];
        [myDelegate hideImage];
        [self.navigationController pushViewController:shopDetailController animated:YES];
        /*
        [UIView animateWithDuration:0.35 animations:^{
            for (int i = 0; i < [((CustomTabBar *)self.tabBarController).buttons count]; i++) {
                UIButton *btn = [((CustomTabBar *)self.tabBarController).buttons objectAtIndex:i];
                [btn setFrame:CGRectMake(btn.frame.size.width*i, self.tabBarController.tabBar.frame.origin.y, btn.frame.size.width, btn.frame.size.height)];
            }
            UIView *slideView = ((CustomTabBar *)self.tabBarController).slideBg;
            [slideView setAlpha:0.0];
            
        }];*/
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - recieve Notification

-(void)updateCellForClassOff:(NSNotification *)note{
    pageNum=1;
    NSString * classOff=[note object];
    if ([classOff compare:@"classOff"]==0) {
        
        [allCategoryButton setTitle:[NSString stringWithUTF8String:"   全部分类"] forState:UIControlStateNormal];
        classOnOrOff=@"off";
        NSString * classToBeOffUrl;
        if (distanceOK) {
            classToBeOffUrl=[NSString stringWithFormat:@"%@zuobiao.php?type=shop_list&lat=%lf&lng=%lf&r=%lf&pageno=1&pagesize=20&class=%@&cid=%d&limit=max",api_url,lat,lng,distanceForUrl,classOnOrOff,dynamicCid];
            
        }else {
            
            
            classToBeOffUrl=[NSString stringWithFormat:@"%@zuobiao.php?type=shop_list&lat=%lf&lng=%lf&r=%lf&pageno=1&pagesize=20&class=%@&cid=%d",api_url,lat,lng,distanceForUrl,classOnOrOff,dynamicCid]; 
        }
        DebugLog(@"classToBeOffUrl --------%@",classToBeOffUrl);
        
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:classToBeOffUrl]];
        [request setDownloadCache:[ASIDownloadCache sharedCache]];
        [request setCachePolicy:ASIAskServerIfModifiedWhenStaleCachePolicy];
        [request setDelegate:self];
        [request startAsynchronous];
        
    }
    
}

-(void)updateCellAccordingToClass:(NSNotification *)note{
    pageNum=1;
    dynamicCid=[[[note object]valueForKey:@"cid"]intValue];
    [allCategoryButton setTitle:[NSString stringWithFormat:@"   %@",[[note object]valueForKey:@"name"]] forState:UIControlStateNormal];
    classOnOrOff=@"on";
    NSString * accordingToclassUrl;
    if (distanceOK) {
        accordingToclassUrl=[NSString stringWithFormat:@"%@zuobiao.php?type=shop_list&lat=%lf&lng=%lf&r=%lf&pageno=1&pagesize=20&class=%@&cid=%d&limit=max",api_url,lat,lng,distanceForUrl,classOnOrOff,dynamicCid]; 
        
    }else { 
        accordingToclassUrl=[NSString stringWithFormat:@"%@zuobiao.php?type=shop_list&lat=%lf&lng=%lf&r=%lf&pageno=1&pagesize=20&class=%@&cid=%d",api_url,lat,lng,distanceForUrl,classOnOrOff,dynamicCid]; 
    }
    DebugLog(@"accordingToclassUrl --------%@",accordingToclassUrl);
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:accordingToclassUrl]];
    [request setDownloadCache:[ASIDownloadCache sharedCache]];
    [request setCachePolicy:ASIAskServerIfModifiedWhenStaleCachePolicy];
    [request setDelegate:self];
    [request startAsynchronous];
    
    
}



-(void)updateCellAccordingToDistance:(NSNotification *)note
{
    //    [specificDistanceResultArray removeAllObjects];
    //    for (ShopObject * tmp in resultArray) {
    //        
    //            [specificDistanceResultArray addObject:tmp];
    //        
    //    }
    pageNum=1;
    NSString * accordingTodistance1Url;
    int distanceTag=[[note object]intValue];
    switch (distanceTag) {
        case 0:
            distanceOK=YES;
            
            [distanceButton setTitle:[NSString stringWithUTF8String:"   不限距离"] forState:UIControlStateNormal];
            //            [tableview reloadData];
            accordingTodistance1Url=[NSString stringWithFormat:@"%@zuobiao.php?type=shop_list&lat=%lf&lng=%lf&r=%lf&pageno=1&pagesize=20&class=%@&cid=%d&limit=max",api_url,lat,lng,distanceForUrl,classOnOrOff,dynamicCid];            
            DebugLog(@"accordingTodistance1Url --------%@",accordingTodistance1Url);
            
            ASIHTTPRequest *request0 = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:accordingTodistance1Url]];
            [request0 setDownloadCache:[ASIDownloadCache sharedCache]];
            [request0 setCachePolicy:ASIAskServerIfModifiedWhenStaleCachePolicy];
            [request0 setDelegate:self];
            [request0 startAsynchronous];
            
            
            
            break;
        case 1:
            distanceOK=NO;
            distanceForUrl=2000;
            [distanceButton setTitle:[NSString stringWithUTF8String:"   附近两千米"] forState:UIControlStateNormal];
            //            [tableview reloadData];
            accordingTodistance1Url=[NSString stringWithFormat:@"%@zuobiao.php?type=shop_list&lat=%lf&lng=%lf&r=%lf&pageno=1&pagesize=20&class=%@&cid=%d",api_url,lat,lng,distanceForUrl,classOnOrOff,dynamicCid];            
            DebugLog(@"accordingTodistance1Url --------%@",accordingTodistance1Url);
            
            ASIHTTPRequest *request1 = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:accordingTodistance1Url]];
            [request1 setDownloadCache:[ASIDownloadCache sharedCache]];
            [request1 setCachePolicy:ASIAskServerIfModifiedWhenStaleCachePolicy];
            [request1 setDelegate:self];
            [request1 startAsynchronous];
            break;
        case 2:
            distanceOK=NO;
            distanceForUrl=1000;
            [distanceButton setTitle:[NSString stringWithUTF8String:"   附近一千米"] forState:UIControlStateNormal];
            //            for (ShopObject * tmp in resultArray) {
            //                if (tmp.distance>1000) {
            //                    [specificDistanceResultArray removeObject:tmp];
            //                }
            //            }
            //            [tableview reloadData];
            accordingTodistance1Url=[NSString stringWithFormat:@"%@zuobiao.php?type=shop_list&lat=%lf&lng=%lf&r=%lf&pageno=1&pagesize=20&class=%@&cid=%d",api_url,lat,lng,distanceForUrl,classOnOrOff,dynamicCid];            
            DebugLog(@"accordingTodistance1Url --------%@",accordingTodistance1Url);
            
            ASIHTTPRequest *request2 = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:accordingTodistance1Url]];
            [request2 setDownloadCache:[ASIDownloadCache sharedCache]];
            [request2 setCachePolicy:ASIAskServerIfModifiedWhenStaleCachePolicy];
            [request2 setDelegate:self];
            [request2 startAsynchronous];
            break;
        case 3:
            distanceOK=NO;
            distanceForUrl=500;
            [distanceButton setTitle:[NSString stringWithUTF8String:"   附近五百米"] forState:UIControlStateNormal];
            
            accordingTodistance1Url=[NSString stringWithFormat:@"%@zuobiao.php?type=shop_list&lat=%lf&lng=%lf&r=%lf&pageno=1&pagesize=20&class=%@&cid=%d",api_url,lat,lng,distanceForUrl,classOnOrOff,dynamicCid];            
            DebugLog(@"accordingTodistance1Url --------%@",accordingTodistance1Url);
            
            ASIHTTPRequest *request3 = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:accordingTodistance1Url]];
            [request3 setDownloadCache:[ASIDownloadCache sharedCache]];
            [request3 setCachePolicy:ASIAskServerIfModifiedWhenStaleCachePolicy];
            [request3 setDelegate:self];
            [request3 startAsynchronous];
            break;
        default:
            break;
    }
    
}

#pragma mark - recieve buttonClicked
- (IBAction)allCategoryButtonClicked:(id)sender {
    
    pickerView * pickView1=[[pickerView alloc]initWithNibName:@"pickerView" bundle:nil];
    pickView1.TAG=[NSString stringWithString:@"category"];
    //    [pickView1 selectRow:0 inComponent:0 animated:YES];
    [self.view addSubview:pickView1.view];
    
}

- (IBAction)distanceButtonClicked:(id)sender {
    
    //    use code to generate the pickerView    
    //    UIView *subView=[[UIView alloc] init];
    //    subView.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    //    pickerView1 = [[UIPickerView alloc] init];
    //
    //    pickerView1.showsSelectionIndicator = YES;
    //    pickerView1.hidden=NO;
    //    pickerView1.dataSource = self;
    //    pickerView1.delegate = self;
    //    pickerView1.frame=CGRectMake(10, 200, 300, 200);    
    //  
    //    subView.backgroundColor=[UIColor clearColor];
    //    [subView  addSubview:pickerView1];
    //    [self.view addSubview:subView];
    //    [pickerView release];
    
    
    
    pickerView * pickView1=[[pickerView alloc]initWithNibName:@"pickerView" bundle:nil];
    pickView1.TAG=[NSString stringWithString:@"distance"];
    //    [pickView1 selectRow:0 inComponent:0 animated:YES];
    [self.view addSubview:pickView1.view];
    
    
}


-(void)pressMenu{
    NSString * accordingToPageNumUrl;
    
    if (distanceOK) {
        
        accordingToPageNumUrl=[NSString stringWithFormat:@"%@zuobiao.php?type=shop_list&lat=%lf&lng=%lf&r=%lf&pageno=%d&pagesize=20&class=%@&cid=%d&limit=max",api_url,lat,lng,distanceForUrl,pageNum,classOnOrOff,dynamicCid]; 
    }else {
        accordingToPageNumUrl=[NSString stringWithFormat:@"%@zuobiao.php?type=shop_list&lat=%lf&lng=%lf&r=%lf&pageno=%d&pagesize=20&class=%@&cid=%d",api_url,lat,lng,distanceForUrl,pageNum,classOnOrOff,dynamicCid]; 
        
    }
    DebugLog(@"accordingToPageNumUrl --------%@",accordingToPageNumUrl);
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:accordingToPageNumUrl]];
    [request setTag:3];
    [request setDownloadCache:[ASIDownloadCache sharedCache]];
    [request setCachePolicy:ASIAskServerIfModifiedWhenStaleCachePolicy];
    [request setDelegate:self];
    [request startAsynchronous];
    
    
    
    
}

-(void)gotologin:(id)sender
{
    MoreAccountViewController *account = [[MoreAccountViewController alloc] initWithNibName:@"MoreAccountViewController" bundle:nil];
    [self.navigationController pushViewController:account animated:YES];
}
@end