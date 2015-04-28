//
//  ShowShoppicViewController.m
//  化龙巷
//
//  Created by mac on 12-4-12.
//  Copyright (c) 2012年 Osugroup. All rights reserved.
//

#import "ShowShoppicViewController.h"
#import "AppDelegate.h"
//#define kSearchShopPicURLWithPage(x) [NSString stringWithFormat:@"%@zuobiao.php?type=get_image&shop_id=%@&pageno=%d&pagesize=20",api_url,shop_id,x]
#define kSearchShopPicURLWithPage [NSString stringWithFormat:@"%@zuobiao.php?type=get_image&shop_id=%@&pageno=1&pagesize=20",api_url,shop_id]

@interface ShowShoppicViewController ()

@end

@implementation ShowShoppicViewController
@synthesize arrayForShoppic,shop_id,api_url,tableview,htmlWebView,htmlString;
int pagenum = 1;
bool no_more = NO;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"商家图片";
    }
    return self;
}

- (void)viewDidLoad
{
    AppDelegate *delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    api_url = delegate.myDomainAndPathVeryNC;
    countOfRequest=0;
    
    
    UIWebView *temWebView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, 360)];
    htmlWebView=temWebView;
    [htmlWebView setDelegate:self];
    [self.view addSubview :htmlWebView];
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated{
    
        ASIHTTPRequest *requestShoppic = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:kSearchShopPicURLWithPage]];
    DebugLog(@"viewWillAppear------kSearchShopPicURLWithPage: %@",kSearchShopPicURLWithPage);
        [requestShoppic setTag:100];
        [requestShoppic setDownloadCache:[ASIDownloadCache sharedCache]];
        [requestShoppic setCachePolicy:ASIAskServerIfModifiedWhenStaleCachePolicy];
        [requestShoppic setDelegate:self];
        [requestShoppic startAsynchronous];

}


- (void)dealloc
{
    [arrayForShoppic release];
    [shop_id release];
    [tableview release];
    [super dealloc];
}

- (void)viewDidUnload
{
    arrayForShoppic = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



#pragma mark - UITableViewDelegate dataSource
/*构建tableview*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayForShoppic count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell_%d_%d",indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
    if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
//        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[arrayForShoppic objectAtIndex:indexPath.row] objectForKey:@"shop_com_pic"]]]];
//        DebugLog(@"dataWithContentsOfURL=========%@",[NSData dataWithContentsOfURL:[NSURL URLWithString:[[arrayForShoppic objectAtIndex:indexPath.row] objectForKey:@"shop_com_pic"]]]);
//        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(50,10,image.size.width/2.0,image.size.height/2.0)];
//        
//        [imageView setImage:image];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 10, 220, 180)];

        [imageView setImageWithURL:[NSURL URLWithString:[[arrayForShoppic objectAtIndex:indexPath.row] objectForKey:@"shop_com_pic"]]];
                
        [cell addSubview:imageView];
        [imageView setContentMode:UIViewContentModeScaleToFill];
        //显示该商家图片发布时间
        NSDateFormatter* formatter =[[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSTimeInterval timecontent=[[[arrayForShoppic objectAtIndex:indexPath.row] objectForKey:@"dateline"] doubleValue];//str是NSString类型
        NSDate *timeDate = [NSDate dateWithTimeIntervalSince1970:timecontent];
        NSString * time = [formatter stringFromDate:timeDate];
        UILabel *dateLabel  = [ViewTool addUILable:cell x:250 y:210 x1:100 y1:20 fontSize:12 lableText:time];
        dateLabel.textColor = [UIColor grayColor];
        //添加用户名称
        UILabel *titleLabel = [ViewTool addUILable:cell x:65 y:210 x1:205 y1:20 fontSize:14 lableText:[[arrayForShoppic objectAtIndex:indexPath.row] objectForKey:@"author"]];
        CGFloat r = (CGFloat) 199/255.0;
        CGFloat g = (CGFloat) 166/255.0;
        CGFloat b = (CGFloat) 112/255.0;
        titleLabel.textColor=[UIColor colorWithRed:r green:g blue:b alpha:1.0];
        //添加评论内容
        UILabel *contentLabel = [ViewTool addUILable:cell x:65 y:230 x1:250 y1:20 fontSize:13 lableText:[[arrayForShoppic objectAtIndex:indexPath.row] objectForKey:@"message"]];
        CGFloat rm = (CGFloat) 99/255.0;
        CGFloat gm = (CGFloat) 99/255.0;
        CGFloat bm = (CGFloat) 99/255.0;
        contentLabel.textColor = [UIColor colorWithRed:rm green:gm blue:bm alpha:1.0];
        contentLabel.numberOfLines = 0;
        [contentLabel sizeToFit];
        //添加用户头像
        UIImageView *headimageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 215, 40, 40)];
        [cell addSubview:headimageView];
        [headimageView setContentMode:UIViewContentModeScaleToFill];
        [headimageView setImageWithURL:[NSURL URLWithString:[[arrayForShoppic objectAtIndex:indexPath.row] objectForKey:@"avatar_url"]] placeholderImage:[UIImage imageNamed:@"defalut_img_small.png"]];
        [headimageView release];
	}
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == [arrayForShoppic count]){
        return 40;
    }
    NSDictionary *eachpic = [arrayForShoppic objectAtIndex:indexPath.row];
    UIFont *font = [UIFont systemFontOfSize:13.0];
    CGSize size = [[eachpic objectForKey:@"message"] sizeWithFont:font constrainedToSize:CGSizeMake(300, 1000) lineBreakMode:UILineBreakModeWordWrap];  
    return size.height+260; // 10即消息上下的空间，可自由调整
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}





#pragma mark - ASIHTTPDelegate

- (void)requestStarted:(ASIHTTPRequest *)request {
}

- (void)requestFinished:(ASIHTTPRequest *)request {
//    DebugLog(@"request.tag---------=========100:%d",request.tag);
//    if (request.tag == 100) {
//        NSString *requestString = [[request responseString] stringByConvertingHTMLToPlainText];
//        NSArray *tmpArray = [[requestString JSONValue] valueForKey:@"datas"];
//        self.arrayForShoppic = tmpArray;
//        [tableview reloadData];
//    }
    


    
    
	[arrayForShoppic removeAllObjects];
	NSString *requestString = [request responseString];
    
    
	maxPage = ceil([[[requestString JSONValue] valueForKey:@"count"] doubleValue] / 20.0);
	if (maxPage == 0) {
		maxPage = 1;
	}
    
    //verync crash 3
    //robust
    
    
    DebugLog(@"%@",requestString);
    
    
	NSArray *tmpArray = [[requestString JSONValue] valueForKey:@"datas"];
    
    
    
    DebugLog(@"%d",[tmpArray count]);
    
    //beta2
    htmlString = [NSString stringWithFormat:@"<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\"><html xmlns=\"http://www.w3.org/1999/xhtml\"><head><meta name=\"format-detection\" content=\"telephone=no\"><style type=\"text/css\">body {background-color:f7f7f7; padding: 0; margin:0; font:14px / 1.5 \"Lucida Grande\",\"Lucida Sans Unicode\",Helvetica,Arial,Verdana,sans-serif;} img { border: 0;}table{border-collapse:collapse;border-spacing:0}.app{ width:300px; padding:4px;}.app1{ width:61px;}.app1 img{ width:48px; height:48px;}.app1_h1{color: #888; font-size: 12px;}.app1_h1 span{ color:#1D5796; display:block; font-size: 16px; line-height: 24px;}.app_con{ padding:4px 0;}.zoom{ padding:4px 0;}.app_con3{border-bottom:1px solid #F1F1F1;}.app1 img{border:1px solid #888; padding:2px;}</style></head><body>"];
    htmlString = [NSString stringWithFormat:@"%@<div class=\"app\"><table border=0 width=\"100%%\">", htmlString]; 
    
    if([tmpArray count]!=0) //robust
    {    
        
        //---------------------------------------------------------------
        
        NSString *strLou = [[NSString alloc] init];
        for (int i = 0 ; i < [tmpArray count]; i++)
        {   
           
            
            htmlString = [NSString stringWithFormat:@"%@<tr><td style=\"padding-top:8px;\" class=\"app1\"><img src=\"%@\"></td> <td class=\"app1_h1\"> <span><font  style=\"color:#c7a670\">%@</font></span>上传日期: %@</td><td align=\"right\">%@</td></tr>", htmlString,[[tmpArray objectAtIndex:i] valueForKey:@"avatar_url"],[[tmpArray objectAtIndex:i] valueForKey:@"author"],[self timeStampeToNSDateString:[[tmpArray objectAtIndex:i] valueForKey:@"dateline"]], strLou]; 
            
            NSString *messageString = [self formatContent:[[tmpArray objectAtIndex:i] valueForKey:@"message"]];
            
            htmlString = [NSString stringWithFormat:@"%@<tr><td colspan=\"3\" class=\"app_con\">%@</td></tr>", htmlString, messageString]; 
            
            
            NSString *attachmentString = [[tmpArray objectAtIndex:i] valueForKey:@"shop_com_pic"];
            
            if (![attachmentString isKindOfClass:[NSNull class]] && ![self defaultLoadAppSetting_forbiddisplaypic]) {
                
                NSArray *arr = [attachmentString componentsSeparatedByString:@","];  
                for(NSString* str in arr) htmlString = [NSString stringWithFormat:@"%@<tr><td colspan=\"3\" class=\"app_con\"><center><img width=\"200\" src=\"%@\" /></center></td></tr>", htmlString, str];         
            }
            
            htmlString = [NSString stringWithFormat:@"%@<tr class=\"app_con3\"><td style=\"padding-top:3px\" colspan=\"3\"></td></tr>", htmlString];
            
            
            // htmlString=[NSString stringWithFormat:@" %@<p>%d:", htmlString,i ];      
            
            // htmlString=[NSString stringWithFormat:@"%@</p>",htmlString];
            //--------------------------------------------------------------
            
            
        }   
        
        //beta2
        
        
    }
    else //robust
    {
        
        htmlString = [NSString stringWithFormat:@"帖子内容有非法字符", htmlString];
        
    }        
    
    
    
    
    
    htmlString=[NSString stringWithFormat:@"%@</table></div>", htmlString];             
    htmlString=[NSString stringWithFormat:@"%@</body></html>",htmlString];
    
    //    DebugLog(@"%@", htmlString);
    
    //    [htmlWebView sizeToFit];         
    
    [htmlWebView loadHTMLString:htmlString baseURL:nil];
    
    
    
    
    
    
    
    
    
    

    
    
    
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

#pragma mark - html delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request 
 navigationType:(UIWebViewNavigationType)navigationType
{
    if (navigationType == UIWebViewNavigationTypeLinkClicked)
    {
        
        if ([[UIApplication sharedApplication] openURL:[request URL]])
            
            
            return NO;
    }
    else
    {
        return YES;
    }
}


- (NSString *)timeStampeToNSDateString:(NSString *)timeStame {
	

    NSDateFormatter* formatter =[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSTimeInterval timecontent=[timeStame doubleValue];//str是NSString类型
    NSDate *timeDate = [NSDate dateWithTimeIntervalSince1970:timecontent];
    NSString * time = [formatter stringFromDate:timeDate];
    return time;
    
    
}


- (NSString *)formatContent:(NSString *)string
{
	NSScanner *theScanner;
    NSString *text = nil;
    
    
    
    //    DebugLog(@"%@", string);
    
    //处理BBCode
    
    //过滤[attach]
	theScanner = [NSScanner scannerWithString:string];
    while ([theScanner isAtEnd] == NO) {
        [theScanner scanUpToString:@"[attach]" intoString:NULL];
        [theScanner scanUpToString:@"[/attach]" intoString:&text];
        string = [string stringByReplacingOccurrencesOfString:[ NSString stringWithFormat:@"%@[/attach]", text] withString:@""];
    }   
    
    //过滤[ncsmiley] 暂时先都过滤了
    /*
     theScanner = [NSScanner scannerWithString:string];
     while ([theScanner isAtEnd] == NO) {
     [theScanner scanUpToString:@"[ncsmiley]" intoString:NULL];
     [theScanner scanUpToString:@"[/ncsmiley]" intoString:&text];
     string = [string stringByReplacingOccurrencesOfString:[ NSString stringWithFormat:@"%@[/ncsmiley]", text] withString:@""];
     } 
     */
    string = [string stringByReplacingOccurrencesOfString:@"[ncsmiley]" withString:@"<img src=\""];
    string = [string stringByReplacingOccurrencesOfString:@"[/ncsmiley]" withString:@"\" />"];   
    
    //替换干扰字符
    NSRegularExpression *regex2 = [NSRegularExpression regularExpressionWithPattern:@"(\\[img(.*?)\\])" options:0 error:nil];
    NSString *template = @"[img]";
    string = [regex2 stringByReplacingMatchesInString:string options:0 range:NSMakeRange(0, string.length) withTemplate:template];    
    
    if (![self defaultLoadAppSetting_forbiddisplaypic]) {
        string = [string stringByReplacingOccurrencesOfString:@"[img]" withString:@"<div class=\"zoom\"><img style=\"max-width: 100%; width: auto; height: auto;\" src=\""];
        string = [string stringByReplacingOccurrencesOfString:@"[/img]" withString:@"\" /></div>"];               
    } else {
        theScanner = [NSScanner scannerWithString:string];
        while ([theScanner isAtEnd] == NO) {
            [theScanner scanUpToString:@"[img]" intoString:NULL];
            [theScanner scanUpToString:@"[/img]" intoString:&text];
            string = [string stringByReplacingOccurrencesOfString:[ NSString stringWithFormat:@"%@[/img]", text] withString:@""];
        }         
    }
    
    
    string = [string stringByReplacingOccurrencesOfString:@"　　" withString:@"<br />　　"];       
    string = [string stringByReplacingOccurrencesOfString:@"来自iPhone客户端" withString:@"<br /><br />来自iPhone客户端"];    
    string = [string stringByReplacingOccurrencesOfString:@"来自Android客户端" withString:@"<br /><br />来自Android客户端"];        
    
    
    //过滤[quote]
	theScanner = [NSScanner scannerWithString:string];
    while ([theScanner isAtEnd] == NO) {
        [theScanner scanUpToString:@"[quote]" intoString:NULL];
        [theScanner scanUpToString:@"[/quote]" intoString:&text];
        string = [string stringByReplacingOccurrencesOfString:[ NSString stringWithFormat:@"%@[/quote]", text] withString:@""];
    }  
    
    //过滤[code]
	theScanner = [NSScanner scannerWithString:string];
    while ([theScanner isAtEnd] == NO) {
        [theScanner scanUpToString:@"[code]" intoString:NULL];
        [theScanner scanUpToString:@"[/code]" intoString:&text];
        string = [string stringByReplacingOccurrencesOfString:[ NSString stringWithFormat:@"%@[/code]", text] withString:@""];
    }       
    
    //过滤[code]
	theScanner = [NSScanner scannerWithString:string];
    while ([theScanner isAtEnd] == NO) {
        [theScanner scanUpToString:@"[indent]" intoString:NULL];
        [theScanner scanUpToString:@"[/indent]" intoString:&text];
        string = [string stringByReplacingOccurrencesOfString:[ NSString stringWithFormat:@"%@[/indent]", text] withString:@""];
    }     
    
    //处理常用标签
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(\\[i(.*?)\\]|\\[/i\\]|\\[/u\\]|\\[font(.*?)\\]|\\[/font\\]|\\[backcolor(.*?)\\]|\\[/backcolor\\]|\\[color(.*?)\\]|\\[/color\\]|\\[b(.*?)\\]|\\[/b\\]|\\[p(.*?)\\]|\\[/p\\]|\\[align(.*?)\\]|\\[/align\\]|\\[size(.*?)\\]|\\[/size\\]|\\[media(.*?)\\]|\\[/media\\]|\\[audio(.*?)\\]|\\[/audio\\]|\\[list(.*?)\\]|\\[\\*\\]|\\[/list\\]|\\[table(.*?)\\]|\\[/table\\]|\\[td(.*?)\\]|\\[/td\\]|\\[tr(.*?)\\]|\\[/tr\\]|\\[float(.*?)\\]|\\[/float\\])" options:0 error:nil];
    string = [regex stringByReplacingMatchesInString:string options:0 range:NSMakeRange(0, string.length) withTemplate:@""];
    
    //
    
    //    cell.contentView addSubView:imageView;
    
    
    
    //media和audio可能需要单独处理
    
    //附件也要处理
    
    //表情标签需要单独处理
    
    
    //过滤<br>
    //    string = [string stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
    //    string = [string stringByReplacingOccurrencesOfString:@"<BR>" withString:@"\n"];
    //    string = [string stringByReplacingOccurrencesOfString:@"<BR />" withString:@"\n"];
    //    string = [string stringByReplacingOccurrencesOfString:@"<br />" withString:@"\n"];
    
    
    //[url=http://www.sina.com.cn/]aaaa[/url]
    //\\[url(.*?)\\]|\\[/url\\]    
    
    //<a target="_blank" href="http://www.phpbb.com/">aaaa</a>
    
    //处理url
    string = [string stringByReplacingOccurrencesOfString:@"[url=" withString:@"<a target=\"_blank\" href=\""];
    string = [string stringByReplacingOccurrencesOfString:@"[/url]" withString:@"</a>"];  
    NSRegularExpression *regex3 = [NSRegularExpression regularExpressionWithPattern:@"(\\[u(.*?)\\])" options:0 error:nil];
    string = [regex3 stringByReplacingMatchesInString:string options:0 range:NSMakeRange(0, string.length) withTemplate:@""];        
    string = [string stringByReplacingOccurrencesOfString:@"]" withString:@"\">"];     
    
    //    DebugLog(@"%@", string);
    
    return string;
}
-(bool)defaultLoadAppSetting_forbiddisplaypic;
{
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:@"forbiddisplaypic"];
    
    
    
}






@end
