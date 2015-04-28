//
//  postViewController.m
//  VeryNC
//
//  Created by Rhythm on 5/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//



#import "postViewController.h"
#import "ReaderController.h"

#define postListRequestURLWithUid(x) [NSString stringWithFormat:@"%@topiclist.php?type=forum_list&uid=%@",api_url,x]

@interface postViewController ()

@end

@implementation postViewController

@synthesize appDelegate;
@synthesize myDelegate,api_url;
@synthesize postArray;
@synthesize mytableview;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



-(bool)checkIfHasLogIn;
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; 
    
    
    NSFileManager* fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:[documentsDirectory stringByAppendingPathComponent:@"nowlogin.plist"] isDirectory:NULL]) 
        
    {
        
        NSDictionary *now = [NSKeyedUnarchiver unarchiveObjectWithFile:[documentsDirectory stringByAppendingPathComponent:@"nowlogin.plist"]];
        NSString *nowname  = [now objectForKey:@"username"];
        
        if(nowname==nil)
            return NO;
        else  
            
            return YES;
    }
    else {
        
        return NO;
        
    }
    
    
}

-(void)loadPostListNotification:(NSNotification *)notification;
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *nowlogin_filePath = [documentsDirectory stringByAppendingPathComponent:@"nowlogin.plist"];
    NSDictionary *now = [NSKeyedUnarchiver unarchiveObjectWithFile:nowlogin_filePath];
    NSString *uid  = [now objectForKey:@"uid"];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:postListRequestURLWithUid(uid)]];
    [request setTag:111];
    [request setDownloadCache:[ASIDownloadCache sharedCache]];
    [request setCachePolicy:ASIAskServerIfModifiedWhenStaleCachePolicy];
    [request setDelegate:self];
    [request setPersistentConnectionTimeoutSeconds:30];
    [request startAsynchronous];     
    
}


- (void)viewWillAppear:(BOOL)animated
{
    if (!([self checkIfHasLogIn])) {
        [self alertLogin];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"notifyToPushAccountView" object:nil];
    }
}


- (void)viewDidLoad
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadPostListNotification:) name:@"notifyToloadPostListNotification" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushtoaccountview) name:@"notifyToPushAccountView" object:nil];
    
    [[self navigationItem] setTitle: @"选择发帖板块"]; 
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:158.0/255.0 green:26.0/255.0 blue:36.0/255.0 alpha:1.000]];    
    
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    api_url = delegate.myDomainAndPathVeryNC;
    postArray = [[NSMutableArray alloc] init];  
    
    resultArray = [[NSMutableArray alloc] init];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *nowlogin_filePath = [documentsDirectory stringByAppendingPathComponent:@"nowlogin.plist"];      
    
    if ([self checkIfHasLogIn]) {
        
        NSDictionary *now = [NSKeyedUnarchiver unarchiveObjectWithFile:nowlogin_filePath];
        NSString *uid  = [now objectForKey:@"uid"];
        
//        NSLog(@"-------%@", uid);
        //NSLog(@"%@", postListRequestURLWithUid(uid));        
        
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:postListRequestURLWithUid(uid)]];
        [request setTag:111];
        [request setDownloadCache:[ASIDownloadCache sharedCache]];
        [request setCachePolicy:ASIAskServerIfModifiedWhenStaleCachePolicy];
        [request setDelegate:self];
        [request setPersistentConnectionTimeoutSeconds:30];
        [request startAsynchronous];   
        


        
    } else {
        
      //登陆有个引导流程
        
        
        
        [self alertLogin];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"notifyToPushAccountView" object:nil];
        
    }   
    



  
    
 
    
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}



- (void)pushtoaccountview
{
    MoreAccountViewController *accountview = [[MoreAccountViewController alloc] initWithNibName:@"MoreAccountViewController" bundle:nil];
    [self.navigationController pushViewController:accountview animated:YES];
}

- (void)requestStarted:(ASIHTTPRequest *)request {
    
    //取消加载
//	[self removeLoadingPatternIfNeed];
    
    [myDelegate removeLoadingPatternIfNeed];
    
    //加载
//    [self drawLoadingPattern:@"加载中"];
    
    [myDelegate drawLoadingPattern:@"加载中" isWithAnimation:NO];
}
//-(void)drawLoadingPattern:(NSString*)text;
//{
//    _loadingView=[[UIImageView alloc] initWithFrame:CGRectMake(90.0f, 140.0f,140.0f, 70.0f)];
//    _loadingView.image=[UIImage imageNamed:@"duqu.png"];
//    _loadingView.alpha=0.8;
//    [self.view addSubview:_loadingView];
//    
//    _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
//	_activityView.frame = CGRectMake(110.0f, 162.0f, 20.0f, 20.0f);
//	[self.view addSubview:_activityView];
//	[_activityView startAnimating];
//	
//	//_loadLabel = [ViewTool addUILable:self.view x:140.0 y:158 x1:100 y1:20 fontSize:15 lableText:@"加载中..."];
//	_loadLabel = [ViewTool addUILable:self.view x:140.0 y:162 x1:100 y1:20 fontSize:15 lableText:text];//@"加载中..."];
//	
//    [_loadLabel setTextColor:[UIColor grayColor]];
//}

//-(void)removeLoadingPatternIfNeed;
//{
//    
//    
//    if (_activityView ) {
//		[_activityView setHidden:YES];
//		_activityView = nil;
//		[_loadLabel setHidden:YES];
//		_loadLabel = nil;
//        [_loadingView setHidden:YES];
//        _loadingView=nil;
//	}
//}

- (void)requestFinished:(ASIHTTPRequest *)request {
    [resultArray removeAllObjects];    
    
    
    NSString *formatJsonString = [request responseString];
    
    formatJsonString = [formatJsonString stringByReplacingOccurrencesOfString: @"&quot;"withString: @""];      
    
    formatJsonString = [formatJsonString stringByReplacingOccurrencesOfString: @""withString: @""];      
    
    NSString *requestString = [formatJsonString stringByConvertingHTMLToPlainText];
    
    
    
    
	//if ([request tag] == kForumsTag) {
        
        
        
        requestString=[requestString stringByReplacingOccurrencesOfString:@"\"\"\\" withString:@"\"\\"] ;
        
        
        
        NSArray *array = [[requestString JSONValue] valueForKey:@"datas"];
        
//    NSLog(@"%@",array);
//    NSLog(@"%d",[array count]);
        
        NSMutableArray *temArray=[[NSMutableArray alloc]init];
        NSMutableArray *subtemArray =[[NSMutableArray alloc]init];
    
        for (int i = 0; i < [array count]; i++) {
            
            
            //不是分组，copy object 到temArray
            if(![[[array objectAtIndex:i] valueForKey:@"fup"] isEqualToString:@"0"])
            {
                
                [temArray addObject:[array objectAtIndex:i]];
                
            }
            
            
        };
    
    for (int i = 0; i < [array count]; i++) {
        
        
        //不是分组，copy object 到temArray
        if([[[array objectAtIndex:i] valueForKey:@"type"] isEqualToString:@"sub"])
        {
            
            [subtemArray addObject:[array objectAtIndex:i]];
            
        }
        
        
    };
    //NSLog(@"%@",subtemArray);
        //[temArray release];
        
        
        int v=0;
        
        
        for (int i = 0; i < [array count]; i++) {
            
            //分组
            if([[[array objectAtIndex:i] valueForKey:@"fup"] isEqualToString:@"0"])
            {
                
                
                ColumnList *column = [[ColumnList alloc] init];
                column.listID = v;
                
                column.listName = [[array objectAtIndex:i] valueForKey:@"name"];
                column.isOpened = NO;
                
                NSMutableArray *childArray = [[NSMutableArray alloc] init];
                NSMutableArray *nameArray = [[NSMutableArray alloc] init];
                NSMutableArray *fidArray = [[NSMutableArray alloc] init];
                NSString *fidString=[[array objectAtIndex:i] valueForKey:@"fid"];
                
                
                
                int temK=0;
                for (int j = 0; j < [temArray count]; j++) {
                    
                    NSString *temString=[[temArray objectAtIndex:j] valueForKey:@"fup"];
                    NSString *fidtemString=[[temArray objectAtIndex:j] valueForKey:@"fid"];
                    
                    if([temString isEqualToString:fidString])
                    {
                        temK=temK+1;
                        
                        NSMutableArray * nameContainArray=[[NSMutableArray alloc]init];
                        [nameContainArray addObject:[[temArray objectAtIndex:j ] valueForKey:@"name"]];                        
                        [nameArray addObject:nameContainArray];
                        [childArray addObject:[[temArray objectAtIndex:j ] valueForKey:@"name"]];
                        
                        NSMutableArray * fidContainArray=[[NSMutableArray alloc]init];
                        [fidContainArray addObject:[[temArray objectAtIndex:j ] valueForKey:@"fid"]];
                        
                        [fidArray addObject:fidContainArray];
                        
                        [nameContainArray release];
                        
                        [fidContainArray release];
                        
                        //子版块
                        for (int k = 0; k < [subtemArray count]; k++) {
                            NSString *sub_temString=[[subtemArray objectAtIndex:k] valueForKey:@"fup"];
                            
                            
                            if([fidtemString isEqualToString:sub_temString])
                            {
                                //NSLog(@"a sub!");
                                NSMutableArray * subnameContainArray=[[NSMutableArray alloc]init];
                                [subnameContainArray addObject:[[subtemArray objectAtIndex:k ] valueForKey:@"name"]];                        
                                [nameArray addObject:subnameContainArray];
                                [childArray addObject:[NSString stringWithFormat:@"(子版块)%@",[[subtemArray objectAtIndex:k ] valueForKey:@"name"]]];
                                NSMutableArray * subfidContainArray=[[NSMutableArray alloc]init];
                                [subfidContainArray addObject:[[subtemArray objectAtIndex:k ] valueForKey:@"fid"]];
                                [fidArray addObject:subfidContainArray];
                                
                                [subnameContainArray release];
                                [subfidContainArray release];
                                
                            }
                        }
                    }
                    
                    
                }
                
                
                
                column.nameArray=nameArray;
                
                
                
                column.childArray = childArray;		
                //NSLog(@"%@",column.childArray);
                column.fidArray = fidArray;		
                
                
                [resultArray addObject:column];
                v=v+1;
                
                
                
                [fidArray release];
                [nameArray release];
                [childArray release];
                
                
                [column release];
                
            }
            
		}
        [temArray release];
        
        for (int j=0; j<[resultArray count]; j++) {
            
            ColumnList * second_column=[resultArray objectAtIndex:j];
            for (int x=0; x<[second_column.fidArray count]; x++) {
                
                NSMutableArray * subFidArray=[[NSMutableArray alloc]init];
                NSMutableArray * subNameArray=[[NSMutableArray alloc]init];
                
                for (int i = 0; i < [array count]; i++) {
                    
                    if([[[array objectAtIndex:i] valueForKey:@"fup"] isEqualToString:(NSString *)[[second_column.fidArray objectAtIndex:x]objectAtIndex:0]])
                        
                    {   
                        [subNameArray addObject:[[array objectAtIndex:i]valueForKey:@"name"]];
                        [subFidArray addObject:[[array objectAtIndex:i]valueForKey:@"fid"]];
                        
                    }
                    
                    
                }   
                
                [[second_column.fidArray objectAtIndex:x]addObject:subFidArray];               
                
                [[second_column.nameArray objectAtIndex:x]addObject:subNameArray];
                [subFidArray release];
                [subNameArray release];
            }
        } 
    //}
    [mytableview reloadData];
    [self.view addSubview:mytableview];
    
    
    
    [myDelegate removeLoadingPatternIfNeed];
    
    /*
    if (_activityView ) {
        
		[_activityView removeFromSuperview];
		_activityView = nil;
		[_loadLabel removeFromSuperview];
		_loadLabel = nil;
        
        [_loadingView removeFromSuperview];
        _loadingView=nil;
        
	}
     
     */
}

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

- (void)alertLogin {
    UIAlertView *alert2;
        alert2 = [[UIAlertView alloc] initWithTitle:@"账号没有登陆" 
                                           message:@"请登陆后进行操作" 
                                          delegate:self cancelButtonTitle:@"确定" 
                                 otherButtonTitles:nil];
    [alert2 show];
    [alert2 release];
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


#pragma mark - UITableViewDelegate


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	[cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
    
	SSLineView *lineView = [[SSLineView alloc] initWithFrame:CGRectMake(0, 49, 320, 2)];
	[cell addSubview:lineView];
    ColumnList *columns = [resultArray objectAtIndex:indexPath.section];
    [ViewTool addUILable:cell x:45 y:15 x1:200 y1:20 fontSize:15 lableText:[columns.childArray objectAtIndex:indexPath.row]];
    UIImageView *pointView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cycle.png"]];
    [pointView setFrame:CGRectMake(32, 21, 8, 8)];
    [cell addSubview:pointView];
    [pointView release];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    [cell setBackgroundColor:[UIColor whiteColor]];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [resultArray count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
		ColumnList *columns = [resultArray objectAtIndex:section];
		if ([columns isOpened]) {
			return [columns.childArray count]; 
		}
		return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
     /*   
    NSUInteger row = [indexPath row];
    NSString *rowValue = [[self.postArray objectAtIndex:row] valueForKey:@"fid"];
    NSString *message = [[NSString alloc] initWithFormat: @"You selected %@", rowValue];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Row Selected!"
                                                    message:message
                                                   delegate:nil cancelButtonTitle:@"Yes I Did"
                                          otherButtonTitles:nil]; [alert show];
    [message release];
    [alert release];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];    
    
     */
    
    //NSLog(@"aaaa=====%@", indexPath);
    
    NewPostViewController	*temController= [[NewPostViewController	 alloc]initWithNibName:@"NewPostViewController" bundle:nil]  ;
    
    
    ColumnList *selectList = [resultArray objectAtIndex:indexPath.section];
    temController.fid = [[[selectList.fidArray objectAtIndex:indexPath.row] objectAtIndex:0]intValue];
    temController.forumtitle = [[selectList.nameArray objectAtIndex:indexPath.row] objectAtIndex:0];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *nowlogin_filePath = [documentsDirectory stringByAppendingPathComponent:@"nowlogin.plist"];
    NSDictionary *now = [NSKeyedUnarchiver unarchiveObjectWithFile:nowlogin_filePath];
    NSString *uid  = [now objectForKey:@"uid"];
    
    NSString *timestamp = [NSString stringWithFormat:@"%d%@",time(NULL),uid];
    temController.imgname = [NSString stringWithFormat:@"m%@.jpg",[self encode:timestamp]];
    [self.navigationController pushViewController:temController animated:YES];    
    
     [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

- (UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section {
    if ([resultArray count] == 0) {
		return nil;
	}
    
    
		ColumnList *tmpList = [resultArray objectAtIndex:section];
		SectionHeaderView *sectionHeadView = [[SectionHeaderView alloc] initWithTitle:[NSString stringWithFormat:@"%@",tmpList.listName] frame:CGRectMake(0.0, 0.0, 320, 50)  section:section opened:tmpList.isOpened delegate:self];
		return [sectionHeadView autorelease];
    
    
    
	return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	
	return 50;
	
}

-(void)sectionHeaderView:(SectionHeaderView*)sectionHeaderView sectionAllCloseExcept:(NSInteger)section{
	for (int i = 0; i < [resultArray count]; i++) {
		if (i != section) {
			ColumnList *columns = [resultArray objectAtIndex:i];
			if (columns.isOpened) {
				[self sectionHeaderView:(SectionHeaderView*)[self tableView:mytableview viewForHeaderInSection:i] sectionClosed:i];
			}
		}
	}
}

-(void)sectionHeaderView:(SectionHeaderView*)sectionHeaderView sectionClosed:(NSInteger)section
{
    
	ColumnList *columns = [resultArray objectAtIndex:section];
	columns.isOpened = !columns.isOpened;
	
	// 收缩+动画 (如果不需要动画直接reloaddata)
	NSInteger countOfRowsToDelete = [mytableview numberOfRowsInSection:section];
    if (countOfRowsToDelete > 0) {
        
        
        NSMutableArray *array = [[NSMutableArray alloc] init];
		for (int i = 0; i < countOfRowsToDelete; i++) {
			[array addObject:[NSIndexPath indexPathForRow:i inSection:section]];
		}
		columns.indexPaths = array;
        
        [array release];
        
        /*
         columns.indexPaths = [[NSMutableArray alloc] init];
         for (NSInteger i = 0; i < countOfRowsToDelete; i++) {
         [columns.indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:section]];
         }
         */
		[mytableview deleteRowsAtIndexPaths:columns.indexPaths withRowAnimation:UITableViewRowAnimationTop];
    }
    
}

-(void)sectionHeaderView:(SectionHeaderView*)sectionHeaderView sectionOpened:(NSInteger)section
{
    
	ColumnList *columns = [resultArray objectAtIndex:section];
	columns.isOpened = !columns.isOpened;
	
	// 展开+动画 (如果不需要动画直接reloaddata)
	if(!columns.indexPaths){
		NSMutableArray *array = [[NSMutableArray alloc] init];
		for (int i = 0; i < [columns.childArray count]; i++) {
			[array addObject:[NSIndexPath indexPathForRow:i inSection:section]];
		}
		columns.indexPaths = array;
		[array release];
	}
	[mytableview insertRowsAtIndexPaths:columns.indexPaths withRowAnimation:UITableViewRowAnimationFade];
	columns.indexPaths = nil;
    
}



- (NSString *)timeStampeToNSDateString:(NSString *)timeStame {
	NSDate *tranData = [NSDate dateWithTimeIntervalSince1970:[timeStame doubleValue]];
	return [tranData formatRelativeTime];
}

-(NSString *)encode:(NSString *)value{
	[value retain];
	const char *cStr = [value UTF8String];
	[value release];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result ); // This is the md5 call
    return [NSString stringWithFormat:
			@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
			result[0], result[1], result[2], result[3], 
			result[4], result[5], result[6], result[7],
			result[8], result[9], result[10], result[11],
			result[12], result[13], result[14], result[15]
			];  
}

@end
