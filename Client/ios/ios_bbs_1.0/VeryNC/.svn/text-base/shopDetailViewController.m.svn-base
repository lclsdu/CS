//
//  shopDetailViewController.m
//  化龙巷
//
//  Created by wu jinjin on 12-3-21.
//  Copyright (c) 2012年 Osugroup. All rights reserved.
//

#import "shopDetailViewController.h"
#import "MoreAccountViewController.h"
#import "AppDelegate.h"
#import "ShopMapViewController.h"
#import "PhotoPostViewController.h"
#import "ShowShoppicViewController.h"
#define kSearchShopURLWithPage(x) [NSString stringWithFormat:@"%@zuobiao.php?type=shop_detail&shop_id=%d",api_url,x]


#define kSearchShopEvaluationURLWithPage(x) [NSString stringWithFormat:@"%@zuobiao.php?type=get_post&shop_id=%d&pageno=1&pagesize=1",api_url,x]

@interface shopDetailViewController ()

@end

@implementation shopDetailViewController
@synthesize titleLabel;
@synthesize imageView;
@synthesize score;
@synthesize evaluateButton,photoButton;
@synthesize tableViewForDetail;
@synthesize starOne;
@synthesize starTwo;
@synthesize starThree;
@synthesize starFour;
@synthesize starFive;
@synthesize evaluationLabel;
@synthesize scrollerView;
@synthesize shop_id;
@synthesize api_url;
@synthesize pic_url1,pic_url2,pic_url3;
@synthesize resultShoppicArray;
@synthesize resultArrayOfEvaluator;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"商户详情";
    }
    return self;
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{       
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    api_url = delegate.myDomainAndPathVeryNC;
    
        resultArray=[[NSMutableArray alloc] init];
        [resultArray  removeAllObjects];
        scrollerView.scrollEnabled=YES;
        [evaluateButton setHidden:YES];
        [photoButton setHidden:YES];
        
        countOfRequest=0;
    
    resultShoppicArray = [[NSMutableArray alloc] init];
 
    scrollerView.contentSize = CGSizeMake(320, 500);
    
    
    
    tableViewForDetail = [[UITableView alloc] initWithFrame:CGRectMake(0, 150, 320, 600) style:UITableViewStyleGrouped];
	[tableViewForDetail setDelegate:self];
	[tableViewForDetail setDataSource:self];
	[self.view addSubview:tableViewForDetail];
    [tableViewForDetail release];
    
    

    resultArrayOfEvaluator=[[NSMutableArray alloc]init];
      
   
    

        
//    tableViewForDetail = [[UITableView alloc] initWithFrame:CGRectMake(5, 160, 310, 300) style:UITableViewStyleGrouped];
    [tableViewForDetail  setBackgroundColor:[UIColor clearColor]];
//	[tableViewForDetail setDelegate:self];
//	[tableViewForDetail setDataSource:self];
//	[self.view addSubview:tableViewForDetail];
//	[tableViewForDetail release];
    
    
       
        ASIHTTPRequest *requestDetail = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:kSearchShopURLWithPage([self.shop_id intValue])]]; 
        [requestDetail setTag:0];
        [requestDetail setDownloadCache:[ASIDownloadCache sharedCache]];
    	[requestDetail setCachePolicy:ASIAskServerIfModifiedWhenStaleCachePolicy];
    	[requestDetail setDelegate:self];
    	[requestDetail startAsynchronous]; 
    
   
    
    UIBarButtonItem *map_btn = [[UIBarButtonItem alloc] initWithTitle:@"查看地图" style:UITabBarSystemItemContacts target:self action:@selector(map)];
    self.navigationItem.rightBarButtonItem = map_btn;
    
//    ASIHTTPRequest *requestShoppic = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:kSearchShopPicURLWithPage]];
//    DebugLog(@"%@",kSearchShopPicURLWithPage);
//    [requestShoppic setTag:100];
//    [requestShoppic setDownloadCache:[ASIDownloadCache sharedCache]];
//    [requestShoppic setCachePolicy:ASIAskServerIfModifiedWhenStaleCachePolicy];
//    [requestShoppic setDelegate:self];
//    [requestShoppic startAsynchronous];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated{
    [resultArrayOfEvaluator removeAllObjects];
    [tableViewForDetail reloadData];
    ASIHTTPRequest *requestEvaluation = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:kSearchShopEvaluationURLWithPage([self.shop_id intValue])]];
    DebugLog(@"requestEvaluation---------%@",kSearchShopEvaluationURLWithPage([self.shop_id intValue]));
    
   	[requestEvaluation setTag:1];
    [requestEvaluation setDownloadCache:[ASIDownloadCache sharedCache]];
    [requestEvaluation setCachePolicy:ASIAskServerIfModifiedWhenStaleCachePolicy];
    [requestEvaluation setDelegate:self];
    [requestEvaluation startAsynchronous]; 
    
//    ASIHTTPRequest *requestShoppic = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:kSearchShopPicURLWithPage]];
//    [requestShoppic setTag:100];
//    [requestShoppic setDownloadCache:[ASIDownloadCache sharedCache]];
//    [requestShoppic setCachePolicy:ASIAskServerIfModifiedWhenStaleCachePolicy];
//    [requestShoppic setDelegate:self];
//    [requestShoppic startAsynchronous];
}    

-(void)map{
    ShopObject *cellHLine = [resultArray objectAtIndex:0];
    ShopMapViewController *shopmapview = [[ShopMapViewController alloc] initWithNibName:@"ShopMapViewController" bundle:nil];
    shopmapview.lat = cellHLine.lagitude;
    shopmapview.lng = cellHLine.longitude;
    shopmapview.shopname = cellHLine.name;
    [self.navigationController pushViewController:shopmapview animated:YES];
}


- (void)viewDidUnload
{
    [self setTitle:nil];
    [self setImageView:nil];
    [self setScore:nil];
    [self setStarOne:nil];
    [self setStarTwo:nil];
    [self setStarThree:nil];
    [self setStarFour:nil];
    [self setStarFive:nil];
    [self setEvaluationLabel:nil];
    [tableViewForDetail release];
    tableViewForDetail = nil;
    [self setTableViewForDetail:nil];
    [self setScrollerView:nil];
    [self setEvaluateButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [titleLabel release];
    [imageView release];
//    [descriptionView release];
    [score release];
    [starOne release];
    [starTwo release];
    [starThree release];
    [starFour release];
    [starFive release];
    [evaluationLabel release];
    [tableViewForDetail release];
    [tableViewForDetail release];
    [scrollerView release];
    [evaluateButton release];
    [photoButton release];
    [super dealloc];
}



#pragma mark - ASIHTTPDelegate

- (void)requestStarted:(ASIHTTPRequest *)request {
}

- (void)requestFinished:(ASIHTTPRequest *)request {
    
    if(request.tag==0)
    {
        [resultArray removeAllObjects];
        NSString *requestString = [request responseString];
        requestString = [requestString stringByReplacingOccurrencesOfString:@"\"\"\\" withString:@"\"\\"] ;
        requestString = [requestString stringByReplacingOccurrencesOfString: @"\\'" withString: @"'"];
        NSArray *tmpArray = [[requestString JSONValue] valueForKey:@"datas"];
        
        
        for (int i = 0; i < [tmpArray count]; i++) {        
            ShopObject * shopDetail =  [[ShopObject alloc] init];
            shopDetail.shopid = [[[tmpArray objectAtIndex:i] valueForKey:@"shop_id"] intValue];
            
            shopDetail.distance = [[[tmpArray objectAtIndex:i] valueForKey:@"distance"] doubleValue];
            shopDetail.lagitude = [[[tmpArray objectAtIndex:i] valueForKey:@"shop_lat"] doubleValue];
            shopDetail.longitude = [[[tmpArray objectAtIndex:i] valueForKey:@"shop_lng"] doubleValue];
            //         a.postdate = [self timeStampeToNSDateString:[[tmpArray objectAtIndex:i] valueForKey:@"dateline"]];
            shopDetail.pic = [[tmpArray objectAtIndex:i] valueForKey:@"shop_pic"];
            shopDetail.name = [[tmpArray objectAtIndex:i] valueForKey:@"shop_name"] ;
            shopDetail.phone = [[tmpArray objectAtIndex:i] valueForKey:@"shop_phone"];
            shopDetail.website = [[tmpArray objectAtIndex:i] valueForKey:@"shop_website"];
            shopDetail.address = [[tmpArray objectAtIndex:i] valueForKey:@"shop_address"];
            shopDetail.information = [[tmpArray objectAtIndex:i] valueForKey:@"shop_info"];
            //cause crush when the  value is null
            shopDetail.service = [[[tmpArray objectAtIndex:i] valueForKey:@"fuwu"] doubleValue];
            shopDetail.enviroment = [[[tmpArray objectAtIndex:i] valueForKey:@"huanjing"] doubleValue];
            //end cause crush
            //        shopDetail.isReaded = [[NSUserDefaults standardUserDefaults] boolForKey:[[tmpArray objectAtIndex:i] valueForKey:@"tid"]];
            [resultArray addObject:shopDetail];
            [shopDetail release];

        }
        ShopObject * tmpShopObject=[resultArray objectAtIndex:0];
        self.titleLabel.text=tmpShopObject.name;
        self.evaluationLabel.text=[NSString stringWithFormat:@"%@%.1f   %@%.1f",[NSString stringWithUTF8String:"服务："],tmpShopObject.service/2, [NSString stringWithUTF8String:"环境："],tmpShopObject.enviroment/2];
        float markData=(tmpShopObject.service+tmpShopObject.enviroment)/4;
        if (markData>=5.0) {
            [starOne setImage:[UIImage imageNamed:@"star_yellow.png"]];
            [starTwo setImage:[UIImage imageNamed:@"star_yellow.png"]];
            [starThree setImage:[UIImage imageNamed:@"star_yellow.png"]];
            [starFour setImage:[UIImage imageNamed:@"star_yellow.png"]];
            [starFive setImage:[UIImage imageNamed:@"star_yellow.png"]];
            [score setText:@"5.0 分"];
            
        }else if (markData<5.0 && markData>4.0) {
            [starOne setImage:[UIImage imageNamed:@"star_yellow.png"]];
            [starTwo setImage:[UIImage imageNamed:@"star_yellow.png"]];
            [starThree setImage:[UIImage imageNamed:@"star_yellow.png"]];
            [starFour setImage:[UIImage imageNamed:@"star_yellow.png"]];
            [starFive setImage:[UIImage imageNamed:@"star1-2.png"]];
            [score setText:@"4.5 分"];
            
        }else if (markData==4.0) {
            [starOne setImage:[UIImage imageNamed:@"star_yellow.png"]];
            [starTwo setImage:[UIImage imageNamed:@"star_yellow.png"]];
            [starThree setImage:[UIImage imageNamed:@"star_yellow.png"]];
            [starFour setImage:[UIImage imageNamed:@"star_yellow.png"]];
            [starFive setImage:[UIImage imageNamed:@"star_white.png"]];
            [score setText:@"4.0 分"];
            
        }else if(markData>3.0 && markData <4.0){
            [starOne setImage:[UIImage imageNamed:@"star_yellow.png"]];
            [starTwo setImage:[UIImage imageNamed:@"star_yellow.png"]];
            [starThree setImage:[UIImage imageNamed:@"star_yellow.png"]];
            [starFour setImage:[UIImage imageNamed:@"star1-2.png"]];
            [starFive setImage:[UIImage imageNamed:@"star_white.png"]];
            [score setText:@"3.5 分"];
            
        }else if(markData==3.0){
            [starOne setImage:[UIImage imageNamed:@"star_yellow.png"]];
            [starTwo setImage:[UIImage imageNamed:@"star_yellow.png"]];
            [starThree setImage:[UIImage imageNamed:@"star_yellow.png"]];
            [starFour setImage:[UIImage imageNamed:@"star_white.png"]];
            [starFive setImage:[UIImage imageNamed:@"star_white.png"]];
            [score setText:@"3.0 分"];
        }else if(markData>2.0 && markData <3.0){
            [starOne setImage:[UIImage imageNamed:@"star_yellow.png"]];
            [starTwo setImage:[UIImage imageNamed:@"star_yellow.png"]];
            [starThree setImage:[UIImage imageNamed:@"star1-2.png"]];
            [starFour setImage:[UIImage imageNamed:@"star_white.png"]];
            [starFive setImage:[UIImage imageNamed:@"star_white.png"]];
            [score setText:@"2.5 分"];
        
        
        }else if(markData==2.0){
            [starOne setImage:[UIImage imageNamed:@"star_yellow.png"]];
            [starTwo setImage:[UIImage imageNamed:@"star_yellow.png"]];
            [starThree setImage:[UIImage imageNamed:@"star_white.png"]];
            [starFour setImage:[UIImage imageNamed:@"star_white.png"]];
            [starFive setImage:[UIImage imageNamed:@"star_white.png"]];
            [score setText:@"2.0 分"];
        }else if(markData>1.0 && markData <2.0){
            [starOne setImage:[UIImage imageNamed:@"star_yellow.png"]];
            [starTwo setImage:[UIImage imageNamed:@"star1-2.png"]];
            [starThree setImage:[UIImage imageNamed:@"star_white.png"]];
            [starFour setImage:[UIImage imageNamed:@"star_white.png"]];
            [starFive setImage:[UIImage imageNamed:@"star_white.png"]];
            [score setText:@"1.5 分"];
            
            
        }else if(markData==1.0){
            [starOne setImage:[UIImage imageNamed:@"star_yellow.png"]];
            [starTwo setImage:[UIImage imageNamed:@"star_white.png"]];
            [starThree setImage:[UIImage imageNamed:@"star_white.png"]];
            [starFour setImage:[UIImage imageNamed:@"star_white.png"]];
            [starFive setImage:[UIImage imageNamed:@"star_white.png"]];
            [score setText:@"1.0 分"];
        }else if(markData>0.0 && markData <1.0){
            [starOne setImage:[UIImage imageNamed:@"star1-2.png"]];
            [starTwo setImage:[UIImage imageNamed:@"star_white.png"]];
            [starThree setImage:[UIImage imageNamed:@"star_white.png"]];
            [starFour setImage:[UIImage imageNamed:@"star_white.png"]];
            [starFive setImage:[UIImage imageNamed:@"star_white.png"]];
            [score setText:@"0.5 分"];            
        }else if(markData==0.0){
            [starOne setImage:[UIImage imageNamed:@"star_white.png"]];
            [starTwo setImage:[UIImage imageNamed:@"star_white.png"]];
            [starThree setImage:[UIImage imageNamed:@"star_white.png"]];
            [starFour setImage:[UIImage imageNamed:@"star_white.png"]];
            [starFive setImage:[UIImage imageNamed:@"star_white.png"]];
            [score setText:@"0.0 分"];  
            
            
        }
        
        
        [imageView setImageWithURL:[NSURL URLWithString:tmpShopObject.pic] placeholderImage:[UIImage imageNamed:@"defalut_img_small.png"]];
        [tableViewForDetail reloadData];
    }else if (request.tag == 100) {
        NSString *requestString = [request responseString];
        requestString = [requestString stringByReplacingOccurrencesOfString:@"\"\"\\" withString:@"\"\\"] ;
        requestString = [requestString stringByReplacingOccurrencesOfString: @"\\'" withString: @"'"];
        NSArray *tmpArray = [[requestString JSONValue] valueForKey:@"datas"];
        self.resultShoppicArray = tmpArray;
    }else {
        
        NSString *requestString = [request responseString];
        requestString = [requestString stringByReplacingOccurrencesOfString:@"\"\"\\" withString:@"\"\\"] ;
        requestString = [requestString stringByReplacingOccurrencesOfString: @"\\'" withString: @"'"];
        NSArray *tmpArray = [[requestString JSONValue] valueForKey:@"datas"];
        
        
        for (int i = 0; i < [tmpArray count]; i++) {        
            evaluatorObject * evaluator =  [[evaluatorObject alloc] init];
            evaluator.mark = [[[tmpArray objectAtIndex:i] valueForKey:@"mark"] intValue];        evaluator.avatarstatus = [[tmpArray objectAtIndex:i] valueForKey:@"avatarstatus"];
            evaluator.uid = [[tmpArray objectAtIndex:i] valueForKey:@"uid"] ;
           
            evaluator.message = [[tmpArray objectAtIndex:i] valueForKey:@"message"];
            evaluator.author = [[tmpArray objectAtIndex:i] valueForKey:@"author"] ;
            evaluator.avatar_url = [[tmpArray objectAtIndex:i] valueForKey:@"avatar_url"];
            evaluator.dateline = [[tmpArray objectAtIndex:i] valueForKey:@"dateline"];
            [resultArrayOfEvaluator addObject:evaluator];
        }
        [tableViewForDetail reloadData];
        
    }
    
    
}



- (void)requestFailed:(ASIHTTPRequest *)request {
   
    if (countOfRequest==0) {
    
        UIAlertView *alert;
        NSError *error = [request error];
        if (error)
            alert = [[UIAlertView alloc] initWithTitle:@"链接错误" 
                                           message:@"暂时不能连接服务器" 
                                          delegate:self cancelButtonTitle:@"知道了" 
                                 otherButtonTitles:nil];
        [alert show];
    }    
     countOfRequest++;
}
    
#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    
    if(section==0){
        if ([resultArray count]==0) {
            return 0;
        }else {
            return 4;
        }
    }else{
        if ([resultArrayOfEvaluator count]==0) {
            return 0;
        }else {
            return 1;
        }
        
    }
}





- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    [evaluateButton setHidden:NO];
    [photoButton setHidden:NO];
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell_%d_%d",indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
  
    
    if (indexPath.section==0) {
        
    
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            [cell setBackgroundColor:[UIColor whiteColor]];
            ShopObject *cellHLine = [resultArray objectAtIndex:0];
            if(indexPath.row==0){
                UILabel *titleLabel = [ViewTool addUILable:cell x:20 y:7 x1:65 y1:20 fontSize:14 lableText:[NSString   stringWithUTF8String:"地址："]];
                //[titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
                UILabel *addressLabel = [ViewTool addUILable:cell x:45 y:7 x1:205 y1:20 fontSize:14 lableText:[NSString stringWithFormat:@"      %@",cellHLine.address]];
                CGFloat rm = (CGFloat) 99/255.0;
                CGFloat gm = (CGFloat) 99/255.0;
                CGFloat bm = (CGFloat) 99/255.0;
                addressLabel.textColor = [UIColor colorWithRed:rm green:gm blue:bm alpha:1.0];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            else if(indexPath.row==1) {
                UILabel *titleLabel1 = [ViewTool addUILable:cell x:20 y:7 x1:65 y1:20 fontSize:14 lableText:[NSString stringWithUTF8String:"电话："]];
                //[titleLabel1 setFont:[UIFont boldSystemFontOfSize:13]];
                UILabel *phoneLabel = [ViewTool addUILable:cell x:45 y:7 x1:205 y1:20 fontSize:14 lableText:[NSString stringWithFormat:@"      %@", cellHLine.phone]];
                CGFloat rm = (CGFloat) 99/255.0;
                CGFloat gm = (CGFloat) 99/255.0;
                CGFloat bm = (CGFloat) 99/255.0;
                phoneLabel.textColor = [UIColor colorWithRed:rm green:gm blue:bm alpha:1.0];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            } else if(indexPath.row==2) {
                UILabel *titleLabel = [ViewTool addUILable:cell x:90 y:7 x1:205 y1:20 fontSize:12 lableText:[NSString stringWithUTF8String:"      查看更多信息"]];
                [titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
            
             
            } else if(indexPath.row==3) {
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 5, 20, 20)];
                [cell addSubview:imageView];
                [imageView setImage:[UIImage imageNamed:@"shoppics.png"]];
                [imageView release];
                UILabel *evaLabel = [ViewTool addUILable:cell x:40 y:5 x1:205 y1:20 fontSize:16 lableText:[NSString stringWithFormat:@"商家图片"]];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                /*//放置最多3张图片
                for (int i=0; i<3; i++) {
                    if(i == 0){
                        UIImageView *shoppicimageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 5, 40, 40)];
                        [shoppicimageView setImageWithURL:[NSURL URLWithString:pic_url1]];
                        [cell addSubview:shoppicimageView];
                        [shoppicimageView release];
                    }else if (i == 1) {
                        UIImageView *shoppicimageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 5, 40, 40)];
                        [shoppicimageView setImageWithURL:[NSURL URLWithString:pic_url2]];
                        [cell addSubview:shoppicimageView];
                        [shoppicimageView release];
                    }else{
                        UIImageView *shoppicimageView = [[UIImageView alloc] initWithFrame:CGRectMake(95, 5, 40, 40)];
                        [shoppicimageView setImageWithURL:[NSURL URLWithString:pic_url3]];
                        [cell addSubview:shoppicimageView];
                        [shoppicimageView release];
                    }
                    
                }*/
            }
          
        }
        return cell;
    }else{
        if (cell==nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            [cell setBackgroundColor:[UIColor whiteColor]];
            evaluatorObject * tempEvaluator=[resultArrayOfEvaluator objectAtIndex:0];
            
            UIImageView *authorImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 30, 40, 40)];
            [cell addSubview:authorImageView];  
            [authorImageView setImageWithURL:[NSURL URLWithString:tempEvaluator.avatar_url]];
            [authorImageView release];
            

            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 5, 20, 20)];
            [cell addSubview:imageView];
            [imageView setImage:[UIImage imageNamed:@"eva_icon.png"]];
            [imageView release];
            UILabel *evaLabel = [ViewTool addUILable:cell x:40 y:5 x1:205 y1:20 fontSize:16 lableText:[NSString stringWithFormat:@"评价"]];
            
            UIImageView *markImageView = [[UIImageView alloc] initWithFrame:CGRectMake(65, 50, 50, 20)];
            [cell addSubview:markImageView];

            switch (tempEvaluator.mark) {
                case 1:
                    [markImageView setFrame:CGRectMake(65, 45, 65, 20)];
                    [markImageView setImage:[UIImage imageNamed:@"bad.png"]];
                    break;
                case 2:
                    [markImageView setFrame:CGRectMake(65, 45, 55, 20)];
                    [markImageView setImage:[UIImage imageNamed:@"normal.png"]];
                    break;
                case 3:
                    [markImageView setFrame:CGRectMake(65, 45, 55, 20)];
                    [markImageView setImage:[UIImage imageNamed:@"good.png"]];
                    break;
                    
                default:
                    break;
            }            
            [markImageView release];
            
            UILabel *subtitleLabel = [ViewTool addUILable:cell x:65 y:25 x1:205 y1:20 fontSize:14 lableText:[NSString stringWithFormat:@"%@",tempEvaluator.author]];
            CGFloat r = (CGFloat) 199/255.0;
            CGFloat g = (CGFloat) 166/255.0;
            CGFloat b = (CGFloat) 112/255.0;
            subtitleLabel.textColor=[UIColor colorWithRed:r green:g blue:b alpha:1.0];
            UILabel *contentLabel  = [ViewTool addUILable:cell x:65 y:70 x1:220 y1:20 fontSize:13 lableText:[NSString stringWithFormat:@"%@", tempEvaluator.message]];
            CGFloat rm = (CGFloat) 99/255.0;
            CGFloat gm = (CGFloat) 99/255.0;
            CGFloat bm = (CGFloat) 99/255.0;
            contentLabel.textColor = [UIColor colorWithRed:rm green:gm blue:bm alpha:1.0];
            contentLabel.numberOfLines = 0;
            [contentLabel sizeToFit];
            
            //显示该商家评论发布时间
            NSDateFormatter* formatter =[[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSTimeInterval timecontent=[tempEvaluator.dateline doubleValue];//str是NSString类型
            NSDate *timeDate = [NSDate dateWithTimeIntervalSince1970:timecontent];
            NSString * time = [formatter stringFromDate:timeDate];
            UILabel *dateLabel  = [ViewTool addUILable:cell x:240 y:7 x1:100 y1:20 fontSize:12 lableText:time];
            dateLabel.textColor = [UIColor grayColor];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        }
        return cell;
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0 && indexPath.row==2) {
        CGPoint point = [scrollerView contentOffset];
         moreView=[[UIView alloc]initWithFrame:CGRectMake(0, point.y,320 , 460)];
        [moreView setBackgroundColor:[UIColor blackColor]];
        [moreView setAlpha:0.6];
        [self.view addSubview:moreView];
        moreTextView=[[UITextView alloc]initWithFrame:CGRectMake(30, point.y+50, 260, 235) ];
        moreTextView.backgroundColor=[UIColor whiteColor];
        
        [moreTextView setAlpha:0.85];
        moreTextView.textColor=[UIColor blackColor];
        moreTextView.layer.cornerRadius=5;
        moreTextView.clipsToBounds=YES;
        ShopObject * tmpObject=[resultArray objectAtIndex:0];
        
        moreTextView.textAlignment=UITextAlignmentLeft;
        NSArray *arr = [tmpObject.information componentsSeparatedByString:@";"];
        int x;
        NSString * moreText=[NSString stringWithString:@""];
        for (x=0; x<[arr count]; x++) {
            
            moreText=[moreText stringByAppendingString:[arr  objectAtIndex:x] ];
            moreText=[moreText stringByAppendingString:@"\\n"];
            if (x==0) {
                moreText=[moreText stringByAppendingString:@"\\n"];
            }
            
                        
        }
        
        moreTextView.text=[moreText stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
        [moreTextView setFont:[UIFont boldSystemFontOfSize:14]];
        moreTextView.editable=NO;
        [self.view addSubview:moreTextView];
        
        //create the button
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        //set the position of the button
        button.frame = CGRectMake(275, point.y+40, 30, 30);
        
        //set the button's title
        [button setTitle:@"" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"del.png"] forState:UIControlStateNormal];
        
        //listen for clicks
        [button addTarget:self action:@selector(buttonPressed) 
         forControlEvents:UIControlEventTouchUpInside];
        
        //add the button to the view
        [self.view addSubview:button];
        scrollerView.scrollEnabled=NO;    
    }
    if (indexPath.section==0 && indexPath.row==1) {
        ShopObject *cellHLine = [resultArray objectAtIndex:0];
        NSString *phonetitle  = [NSString stringWithFormat:@"电话:%@",cellHLine.phone];
        UIActionSheet *callphone = [[UIActionSheet alloc] initWithTitle:phonetitle delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拨打电话" otherButtonTitles:nil];
        [callphone setTag:1];
        [callphone showInView:[UIApplication sharedApplication].keyWindow];
        [callphone release];
    }
    if (indexPath.section==0 && indexPath.row==0) {
        ShopObject *cellHLine = [resultArray objectAtIndex:0];
        ShopMapViewController *shopmapview = [[ShopMapViewController alloc] initWithNibName:@"ShopMapViewController" bundle:nil];
        shopmapview.lat = cellHLine.lagitude;
        shopmapview.lng = cellHLine.longitude;
        shopmapview.shopname = cellHLine.name;
        [self.navigationController pushViewController:shopmapview animated:YES];
        [shopmapview release];
    }
    if (indexPath.section==0 && indexPath.row==3) {
        ShowShoppicViewController *shoppicview = [[ShowShoppicViewController alloc] initWithNibName:@"ShowShoppicViewController" bundle:nil];
        shoppicview.shop_id = self.shop_id;
        [self.navigationController pushViewController:shoppicview animated:YES];
        [shoppicview release];
    }
    if (indexPath.section==1) {
        evaluationTableViewController * evaluationTableView=[[evaluationTableViewController alloc]initWithNibName:@"evaluationTableViewController" bundle:nil];
 
//        evaluationTableView.arrayForEvaluation = self.resultArrayOfEvaluator;
        evaluationTableView.shop_id = (NSString *)self.shop_id;
        DebugLog(@"shop_id-------%@",self.shop_id);
        //if(!evaluationTableView)
        //{
        [self.navigationController pushViewController:evaluationTableView animated:YES];
        [evaluationTableView release];
        //} 
         
    }
    [self.tableViewForDetail deselectRowAtIndexPath:indexPath animated:NO];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 40;
    }else {
        evaluatorObject * tempEvaluator=[resultArrayOfEvaluator objectAtIndex:0];
        UIFont *font = [UIFont systemFontOfSize:13.0];
        CGSize size = [tempEvaluator.message sizeWithFont:font constrainedToSize:CGSizeMake(300, 1000) lineBreakMode:UILineBreakModeWordWrap];  
        return size.height+90; // 10即消息上下的空间，可自由调整
    }
}
#pragma mark - actionSheetDelegate
//拨打电话
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(actionSheet.tag == 1){
        if(buttonIndex != [actionSheet cancelButtonIndex]){
            ShopObject *cellHLine = [resultArray objectAtIndex:0];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",cellHLine.phone]]];
        }
    }
    if(actionSheet.tag == 2){
        if(buttonIndex == 0){
            //拍照上传
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
                //isRunningImagePickerController=true;
                UIImagePickerController *picker=[[UIImagePickerController alloc]init];
                picker.delegate = self;
                picker.sourceType=UIImagePickerControllerSourceTypeCamera;
                picker.allowsEditing = NO;
                [self presentModalViewController:picker animated:YES];
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您当前的设备不支持拍照" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
                [alert show];
                [alert release];
            }
        }
        if(buttonIndex == 1){
            //isRunningImagePickerController=true;
            //从相册上传
            UIImagePickerController *picker=[[UIImagePickerController alloc]init];
            picker.delegate = self;
            picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
            picker.allowsEditing = NO;
            [self presentModalViewController:picker animated:YES];
        }
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    if(picker.sourceType==UIImagePickerControllerSourceTypePhotoLibrary)
    {
        UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0]; 
        NSString *s;        
        s=[NSString stringWithFormat:[documentsDirectory stringByAppendingPathComponent:@"img1.png"] ];
        //图片压缩
        int w,h,w0,h0;
        w0=image.size.width;
        h0=image.size.height;
        
        if(image.size.width>image.size.height )
        {
            if(image.size.width>800)
            {
                w=800;
            }
            else {
                w=image.size.width;
            }
            h=(int)(w *image.size.height/image.size.width);
        }
        else 
        {
            if(image.size.height>800)
            {
                h=800;
            }
            else {
                h=image.size.height;
            }
            
            w=(int)(h*image.size.width/image.size.height) ;
        }        
        CGSize itemSize = CGSizeMake(w,h);
        UIGraphicsBeginImageContext(itemSize);
        [image drawInRect:CGRectMake(0,0,w,h)];
        
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        NSData* imageData1 =[NSData dataWithData:UIImagePNGRepresentation (image)];
        [imageData1 writeToFile:s atomically:NO];
        
        //推到发布图片页面
        PhotoPostViewController *photopost = [[PhotoPostViewController alloc] initWithNibName:@"PhotoPostViewController" bundle:nil];
        photopost.photo = image;
        photopost.pic_path = s;
        ShopObject *cellHLine = [resultArray objectAtIndex:0];
        photopost.shop_id = [NSString stringWithFormat:@"%d",cellHLine.shopid];
        photopost.shop_name = cellHLine.name;
        [picker pushViewController:photopost animated:YES];
    }else {
        UIImage* image = [info objectForKey:UIImagePickerControllerEditedImage];
        if (!image){
            image = [info objectForKey:UIImagePickerControllerOriginalImage];             
        }
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0]; 
        NSString *s;
        s=[NSString stringWithFormat:[documentsDirectory stringByAppendingPathComponent:@"img1.png"] ];
        //图片压缩
        int w,h,w0,h0;
        w0=image.size.width;
        h0=image.size.height;
        
        if(image.size.width>image.size.height )
            
        {
            if(image.size.width>800)
            {
                w=800;
            }
            else {
                w=image.size.width;
            }
            h=(int)(w *image.size.height/image.size.width);
        }
        else 
        {
            if(image.size.height>800)
            {
                h=800;
            }
            else {
                h=image.size.height;
            }
            w=(int)(h*image.size.width/image.size.height);
        }
        CGSize itemSize = CGSizeMake(w,h);
        UIGraphicsBeginImageContext(itemSize);
        [image drawInRect:CGRectMake(0, 0,w, h)];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        NSData* imageData1 =[NSData dataWithData:UIImagePNGRepresentation (image)];
        
        [imageData1 writeToFile:s atomically:NO];
        
        //推到发布图片页面
        PhotoPostViewController *photopost = [[PhotoPostViewController alloc] initWithNibName:@"PhotoPostViewController" bundle:nil];
        photopost.photo = image;
        photopost.pic_path = s;
        ShopObject *cellHLine = [resultArray objectAtIndex:0];
        photopost.shop_id = [NSString stringWithFormat:@"%d",cellHLine.shopid];
        photopost.shop_name = cellHLine.name;
        photopost.is_nonav = @"nonav";
        [picker pushViewController:photopost animated:YES];
    }

}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissModalViewControllerAnimated:YES];
}



#pragma mark - button clicked

-(void)buttonPressed{
    [moreView removeFromSuperview];
    [moreTextView removeFromSuperview];
    [button  removeFromSuperview];
    scrollerView.scrollEnabled=YES;
    
}


- (IBAction)evaluateButtonClicked:(id)sender {
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

- (IBAction)photoButtonClicked:(id)sender {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; 
    NSDictionary *now = [NSKeyedUnarchiver unarchiveObjectWithFile:[documentsDirectory stringByAppendingPathComponent:@"nowlogin.plist"]];
    NSString *username    = [now objectForKey:@"username"];
    if(username == nil){
        MoreAccountViewController *account = [[MoreAccountViewController alloc] initWithNibName:@"MoreAccountViewController" bundle:nil];
        [self.navigationController pushViewController:account animated:YES];
    }else{
        UIActionSheet *photooption = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照上传",@"从相册上传",nil];
        [photooption setTag:2];
        [photooption showInView:[UIApplication sharedApplication].keyWindow];
        [photooption release];
    }
}
@end
