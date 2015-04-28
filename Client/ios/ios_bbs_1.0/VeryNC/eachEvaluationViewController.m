//
//  eachEvaluationViewController.m
//  化龙巷
//
//  Created by wu jinjin on 12-3-31.
//  Copyright (c) 2012年 Osugroup. All rights reserved.
//

#import "eachEvaluationViewController.h"

@interface eachEvaluationViewController ()

@end

@implementation eachEvaluationViewController
@synthesize tableView;
@synthesize oneOfTheEvaluation;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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



#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell_%d_%d",indexPath.row];UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 40, 40)];
        [cell addSubview:imageView];
        [imageView setContentMode:UIViewContentModeScaleToFill];
        
        [imageView.layer setBorderColor:[UIColor whiteColor].CGColor];
        [imageView.layer setBorderWidth:1.0f];
        [imageView.layer setShadowColor:[UIColor blackColor].CGColor];
        [imageView.layer setShadowOffset:CGSizeMake(1.5, 1.5)];
        [imageView.layer setShadowOpacity:0.6];
        [imageView setImageWithURL:[NSURL URLWithString:oneOfTheEvaluation.avatar_url] placeholderImage:[UIImage imageNamed:@"defalut_img_small.png"]];
        [imageView release];
        
        UILabel *titleLabel = [ViewTool addUILable:cell x:75 y:7 x1:205 y1:20 fontSize:13 lableText:[NSString stringWithFormat:@"%@" ,oneOfTheEvaluation.author]];
        CGFloat r = (CGFloat) 199/255.0;
        CGFloat g = (CGFloat) 166/255.0;
        CGFloat b = (CGFloat) 112/255.0;
        titleLabel.textColor=[UIColor colorWithRed:r green:g blue:b alpha:1.0];
                
        [titleLabel setHighlightedTextColor:[UIColor whiteColor]];
        
        UIImageView * markImageView = [[UIImageView alloc] initWithFrame:CGRectMake(75, 30, 60, 20)];
        [cell addSubview:markImageView];
        [markImageView setContentMode:UIViewContentModeScaleToFill];
        //[markImageView.layer setBorderColor:[UIColor whiteColor].CGColor];
        //[markImageView.layer setBorderWidth:1.0f];
        //[markImageView.layer setShadowColor:[UIColor blackColor].CGColor];
        //[markImageView.layer setShadowOffset:CGSizeMake(1.5, 1.5)];
        //[markImageView.layer setShadowOpacity:0.6];
        switch (oneOfTheEvaluation.mark) {
            case 1:
                [markImageView setFrame:CGRectMake(75, 30, 65, 20)];
                [markImageView setImage:[UIImage imageNamed:@"bad.png"]];              
                break;
            case 2:
                [markImageView setFrame:CGRectMake(75, 30, 55, 20)];
                [markImageView setImage:[UIImage imageNamed:@"normal.png"]];
                break;
            case 3:
                [markImageView setFrame:CGRectMake(75, 30, 55, 20)];
                [markImageView setImage:[UIImage imageNamed:@"good.png"]];              
                break;
                
            default:
                break;
        }
        
        
        [markImageView release]; 
        
        
        
        UILabel *contentLabel = [ViewTool addUILable:cell x:20 y:70 x1:280 y1:20 fontSize:13 lableText:oneOfTheEvaluation.message];
        CGFloat rm = (CGFloat) 99/255.0;
        CGFloat gm = (CGFloat) 99/255.0;
        CGFloat bm = (CGFloat) 99/255.0;
        contentLabel.textColor = [UIColor colorWithRed:rm green:gm blue:bm alpha:1.0];
        contentLabel.numberOfLines = 0;
        [contentLabel sizeToFit];        
        
        
        //显示该商家评论发布时间
        NSDateFormatter* formatter =[[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSTimeInterval timecontent=[oneOfTheEvaluation.dateline doubleValue];//str是NSString类型
        NSDate *timeDate = [NSDate dateWithTimeIntervalSince1970:timecontent];
        NSString * time = [formatter stringFromDate:timeDate];
        UILabel *dateLabel  = [ViewTool addUILable:cell x:240 y:7 x1:100 y1:20 fontSize:12 lableText:time];
        dateLabel.textColor = [UIColor grayColor];
        
        [cell setBackgroundColor:[UIColor whiteColor]];
    }
    
    return cell;
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    UIFont *font = [UIFont systemFontOfSize:13.0];
    CGSize size = [oneOfTheEvaluation.message sizeWithFont:font constrainedToSize:CGSizeMake(280,1000) lineBreakMode:UILineBreakModeWordWrap];  
    return size.height+75; // 10即消息上下的空间，可自由调整
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
    
}
@end
