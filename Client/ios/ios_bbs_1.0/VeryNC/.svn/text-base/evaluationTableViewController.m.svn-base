//
//  evaluationTableViewController.m
//  化龙巷
//
//  Created by wu jinjin on 12-3-31.
//  Copyright (c) 2012年 Osugroup. All rights reserved.
//

#import "evaluationTableViewController.h"
#import "MoreAccountViewController.h"
#import "evaluationAddViewController.h"
#import "AppDelegate.h"
#import "ShopObject.h"
#define kSearchShopEvaluationURLWithPage(x) [NSString stringWithFormat:@"%@zuobiao.php?type=get_post&shop_id=%@&pageno=%d&pagesize=20",api_url,shop_id,x]


@interface evaluationTableViewController ()

@end

@implementation evaluationTableViewController
 @synthesize arrayForEvaluation,shop_id,api_url;
 @synthesize tableview_self;
 int pageno = 1;
 bool nomore = NO;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       self.navigationItem.title = @"商户评价";
    }
    return self;
    
 
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
//    return;
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    api_url = delegate.myDomainAndPathVeryNC;
    
    UIBarButtonItem *eva_btn = [[UIBarButtonItem alloc] initWithTitle:@"写评价" style:UITabBarSystemItemContacts target:self action:@selector(toevapost)];
    self.navigationItem.rightBarButtonItem = eva_btn;

    NSString *evaFirstPage_url = kSearchShopEvaluationURLWithPage(pageno);
    DebugLog(@"evaFirstPage_url ----------%@",evaFirstPage_url);
    ASIHTTPRequest *requestFirstPage = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:evaFirstPage_url]];
    [requestFirstPage setDownloadCache:[ASIDownloadCache sharedCache]];
    [requestFirstPage setCachePolicy:ASIAskServerIfModifiedWhenStaleCachePolicy];
    [requestFirstPage setDelegate:self];
    [requestFirstPage startAsynchronous]; 
    
    
    arrayForEvaluation=[[NSMutableArray alloc]init];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     
}
 
- (void)dealloc
{
    [tableview_self release];
    [arrayForEvaluation release];
    [shop_id release];
    [super dealloc];
}
- (void)toevapost
{
    //调取当前登陆用户信息
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"nowlogin.plist"];
    NSDictionary *nowloginuser_info = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    NSString *username = [nowloginuser_info objectForKey:@"username"];
    if(username == nil){
        MoreAccountViewController *account = [[MoreAccountViewController alloc] initWithNibName:@"MoreAccountViewController" bundle:nil];
        [self.navigationController pushViewController:account animated:YES];
    }else{
        evaluationAddViewController	*temController=[[evaluationAddViewController alloc]initWithNibName:@"evaluationAddViewController" bundle:nil];
        temController.shop_id = self.shop_id;
        [self.navigationController  pushViewController:temController animated:YES];
        [temController release];
    }
}
- (void)viewDidUnload
{
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)viewWillDisappear:(BOOL)animated
{
    pageno = 1;
    nomore = NO;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    DebugLog(@"numberOfRowsInSection--------%d",[arrayForEvaluation count]);
    return [arrayForEvaluation count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell_%d_%d",indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
    if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
        if ([indexPath row] == [arrayForEvaluation count] - 1 && [arrayForEvaluation count] != 0) {
            //[cell.textLabel setText:@"更多"];
            [cell.textLabel setText:  [arrayForEvaluation  objectAtIndex:[arrayForEvaluation count] - 1]];
            
            [cell.textLabel setTextAlignment:UITextAlignmentCenter];
        }else{
        evaluatorObject *cellHLine = [arrayForEvaluation objectAtIndex:indexPath.row];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        [cell addSubview:imageView];
        [imageView setContentMode:UIViewContentModeScaleToFill];
        
        //[imageView.layer setBorderColor:[UIColor whiteColor].CGColor];
        //[imageView.layer setBorderWidth:1.0f];
        //[imageView.layer setShadowColor:[UIColor blackColor].CGColor];
        //[imageView.layer setShadowOffset:CGSizeMake(1.5, 1.5)];
        //[imageView.layer setShadowOpacity:0.6];
        [imageView setImageWithURL:[NSURL URLWithString:cellHLine.avatar_url] placeholderImage:[UIImage imageNamed:@"defalut_img_small.png"]];
        [imageView release];
        
        UILabel *titleLabel = [ViewTool addUILable:cell x:65 y:7 x1:205 y1:20 fontSize:14 lableText:[NSString stringWithFormat:@"%@",cellHLine.author]];
        CGFloat r = (CGFloat) 199/255.0;
        CGFloat g = (CGFloat) 166/255.0;
        CGFloat b = (CGFloat) 112/255.0;
        titleLabel.textColor=[UIColor colorWithRed:r green:g blue:b alpha:1.0];
        
        
        UIImageView * markImageView = [[UIImageView alloc] init];
        [cell addSubview:markImageView];
        [markImageView setContentMode:UIViewContentModeScaleToFill];
        //[markImageView.layer setBorderColor:[UIColor whiteColor].CGColor];
        //[markImageView.layer setBorderWidth:1.0f];
        //[markImageView.layer setShadowColor:[UIColor blackColor].CGColor];
        //[markImageView.layer setShadowOffset:CGSizeMake(1.5, 1.5)];
        //[markImageView.layer setShadowOpacity:0.6];
        switch (cellHLine.mark) {
            case 1:
                [markImageView setFrame:CGRectMake(65, 30, 65, 20)];
                [markImageView setImage:[UIImage imageNamed:@"bad.png"]];
                break;
            case 2:
                [markImageView setFrame:CGRectMake(65, 30, 55, 20)];
                [markImageView setImage:[UIImage imageNamed:@"normal.png"]];
                break;
            case 3:
                [markImageView setFrame:CGRectMake(65, 30, 55, 20)];
                [markImageView setImage:[UIImage imageNamed:@"good.png"]];
                break;
                
            default:
                break;
        }
        
        
        [markImageView release]; 
        
        UILabel *contentLabel = [ViewTool addUILable:cell x:10 y:55 x1:300 y1:20 fontSize:13 lableText:cellHLine.message];
        CGFloat rm = (CGFloat) 99/255.0;
        CGFloat gm = (CGFloat) 99/255.0;
        CGFloat bm = (CGFloat) 99/255.0;
        contentLabel.textColor = [UIColor colorWithRed:rm green:gm blue:bm alpha:1.0];
        contentLabel.numberOfLines = 0;
        [contentLabel sizeToFit];
        
        //显示该商家评论发布时间
        NSDateFormatter* formatter =[[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSTimeInterval timecontent=[cellHLine.dateline doubleValue];//str是NSString类型
        NSDate *timeDate = [NSDate dateWithTimeIntervalSince1970:timecontent];
        NSString * time = [formatter stringFromDate:timeDate];
        UILabel *dateLabel  = [ViewTool addUILable:cell x:250 y:7 x1:100 y1:20 fontSize:12 lableText:time];
        dateLabel.textColor = [UIColor grayColor]; 
	}
    }
    return cell;
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == [arrayForEvaluation count]-1){
        return 80;
    }
    evaluatorObject *cellHLine = [arrayForEvaluation objectAtIndex:indexPath.row];
    UIFont *font = [UIFont systemFontOfSize:13.0];
    CGSize size = [cellHLine.message sizeWithFont:font constrainedToSize:CGSizeMake(300, 1000) lineBreakMode:UILineBreakModeWordWrap];  
    return size.height+60; // 10即消息上下的空间，可自由调整
    
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if ([self numberOfSectionsInTableView:tableView] == (section+1)){
        return [[UIView new] autorelease];
    }       
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] == [arrayForEvaluation count] - 1) {

        if([[arrayForEvaluation objectAtIndex:[arrayForEvaluation count] - 1] isEqualToString:@"没有更多评论"]) 
            return; 
        pageno++;
        [self performSelector:@selector(loadMorewithmorecell)];
    }else { 
        eachEvaluationViewController *detailEvaluationViewController = [[eachEvaluationViewController alloc] initWithNibName:@"eachEvaluationViewController" bundle:nil];
        detailEvaluationViewController.oneOfTheEvaluation=[arrayForEvaluation objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:detailEvaluationViewController animated:YES];
        [detailEvaluationViewController release];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - ASIHTTPDelegate

- (void)loadMorewithmorecell
{

    NSString *moreeva_url = kSearchShopEvaluationURLWithPage(pageno);
    ASIHTTPRequest *requestDetail = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:moreeva_url]];
    [requestDetail setDownloadCache:[ASIDownloadCache sharedCache]];
    [requestDetail setCachePolicy:ASIAskServerIfModifiedWhenStaleCachePolicy];
    [requestDetail setDelegate:self];
    [requestDetail startAsynchronous]; 
}
- (void)requestFinished:(ASIHTTPRequest *)request {
    [arrayForEvaluation removeLastObject];
    NSString *requestString = [request responseString];
    NSArray  *tmpArray = [[requestString JSONValue] valueForKey:@"datas"];
    DebugLog(@"tmpArray  count--------%d",[tmpArray  count]);

    if([tmpArray count] == 0){
        nomore = YES;
    }else{
        for (int i = 0; i < [tmpArray count]; i++) {        
            evaluatorObject * evaluator =  [[evaluatorObject alloc] init];
            evaluator.mark = [[[tmpArray objectAtIndex:i] valueForKey:@"mark"] intValue];     
            evaluator.avatarstatus = [[tmpArray objectAtIndex:i] valueForKey:@"avatarstatus"];
            evaluator.uid = [[tmpArray objectAtIndex:i] valueForKey:@"uid"] ;
                
            evaluator.message = [[tmpArray objectAtIndex:i] valueForKey:@"message"];
            evaluator.author = [[tmpArray objectAtIndex:i] valueForKey:@"author"] ;
            evaluator.avatar_url = [[tmpArray objectAtIndex:i] valueForKey:@"avatar_url"];
            evaluator.dateline = [[tmpArray objectAtIndex:i] valueForKey:@"dateline"];
            [arrayForEvaluation addObject:evaluator];
            [evaluator release];
            
        }
  
    }
 
    if([tmpArray count]>0){        
        [arrayForEvaluation addObject:@"更多"];
    }
    else  {
        [arrayForEvaluation addObject:@"没有更多评论"];    
    }
    DebugLog(@"tableview_self----requestFinished");
    [tableview_self reloadData];
}
- (void)requestFailed:(ASIHTTPRequest *)request {
    [tableview_self reloadData];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"获取更多评论失败" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
    [alert show];
    [alert release];
}
 
@end
