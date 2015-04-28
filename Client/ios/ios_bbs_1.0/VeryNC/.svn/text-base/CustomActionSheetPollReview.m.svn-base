//
//  CustomActionSheetPollReview.m
//  VeryNC
//
//  Created by mac on 12-5-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CustomActionSheetPollReview.h"
#import "AppDelegate.h"
@interface CustomActionSheetPollReview ()

@end

@implementation CustomActionSheetPollReview
@synthesize view,api_url;
-(id)initWithHeight:(float)height Title:(NSString *)polltitle withtid:(NSString *)tid{
    
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    api_url = delegate.myDomainAndPathVeryNC;
    
    self = [super init];
    if (self) 
    {
        int theight = height;
        int btnnum = theight/50;
        for(int i=0; i<btnnum; i++)
        {
            [self addButtonWithTitle:@" "];
        }
        
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320,height+60)];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        
        [ViewTool addUIImageView:self.view imageName:@"ico5.png" type:@"" x:10 y:25 x1:14 y1:14];
        UILabel *titleLabel = [ViewTool addUILable:self.view x:25 y:22 x1:50 y1:20 fontSize:15 lableText:@"投票问题"];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont systemFontOfSize:12];
        
        UILabel *PollTitleLabel = [ViewTool addUILable:self.view x:10 y:50 x1:280 y1:20 fontSize:15 lableText:polltitle];
        titleLabel.textColor = [UIColor blackColor];
        PollTitleLabel.font = [UIFont boldSystemFontOfSize:16];
        
        UILabel *TipLabel = [ViewTool addUILable:self.view x:10 y:80 x1:100 y1:20 fontSize:15 lableText:@"看看大家的态度!"];
        TipLabel.textColor = [UIColor grayColor];
        TipLabel.font = [UIFont systemFontOfSize:12];
        
        
        //添加按钮
        UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 350, 300, 44)];
        [cancelBtn setImage:[UIImage imageNamed:@"viewpollclose.png"] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(docancel) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:cancelBtn];
        
        //请求数据
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@topiclist.php?type=poll_result&tid=%@",api_url,tid]]];
        [request setTag:0];
        //[request setDownloadCache:[ASIDownloadCache sharedCache]];
        //[request setCachePolicy:ASIAskServerIfModifiedWhenStaleCachePolicy];
        [request setDelegate:self];
        [request setPersistentConnectionTimeoutSeconds:30];
        [request startAsynchronous];
        
        //赋值
        Tid = tid;
    }
    return self;
}
-(void)docancel
{
    [self dismissWithClickedButtonIndex:0 animated:YES];
}
-(void)dealloc
{
    //[Tid release];
    //[api_url release];
    [view release];
    [super dealloc];
}
- (void)requestFinished:(ASIHTTPRequest *)request {
    NSString *requestString = [request responseString];
    requestString = [requestString stringByReplacingOccurrencesOfString:@"\"\"\\" withString:@"\"\\"] ;
    requestString = [requestString stringByReplacingOccurrencesOfString: @"\\'" withString: @"'"];
    //调取投票详情信息
    NSArray *tmpArray = [[requestString JSONValue] valueForKey:@"datas"];
    NSString *totalNum = [[tmpArray objectAtIndex:0] objectForKey:@"voters"];
    UILabel *NumLabel = [ViewTool addUILable:self.view x:220 y:80 x1:100 y1:20 fontSize:15 lableText:[NSString stringWithFormat:@"已有投票:%@",totalNum]];
    NumLabel.textColor = [UIColor colorWithRed:158.0/255.0 green:26.0/255.0 blue:36.0/255.0 alpha:1.000];
    NumLabel.font = [UIFont systemFontOfSize:12];
        
    if([tmpArray count] > 0){
        UILabel *TitleLabel1 = [ViewTool addUILable:self.view x:10 y:110 x1:200 y1:20 fontSize:15 lableText:[NSString stringWithFormat:@"1.%@",[[tmpArray objectAtIndex:0] objectForKey:@"polloption"]]];
        TitleLabel1.textColor = [UIColor grayColor];
        TitleLabel1.font = [UIFont systemFontOfSize:14];
        
        int lineone = [[[tmpArray objectAtIndex:0] objectForKey:@"line"] intValue];
        if(lineone == 0){
            lineone = 5;
        }
        UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 130, lineone, 20)];
        [line1 setBackgroundColor:[UIColor colorWithRed:139.0/255.0 green:159.0/255.0 blue:185.0/255.0 alpha:1.000]];
        [self.view addSubview:line1];
        
        UILabel *Percent1 = [ViewTool addUILable:self.view x:lineone+20 y:130 x1:50 y1:20 fontSize:15 lableText:[[tmpArray objectAtIndex:0] objectForKey:@"percent"]];
        Percent1.textColor = [UIColor blackColor];
        Percent1.font = [UIFont systemFontOfSize:16];
    }
    if([tmpArray count] > 1){
        UILabel *TitleLabel2 = [ViewTool addUILable:self.view x:10 y:160 x1:200 y1:20 fontSize:15 lableText:[NSString stringWithFormat:@"2.%@",[[tmpArray objectAtIndex:1] objectForKey:@"polloption"]]];
        TitleLabel2.textColor = [UIColor grayColor];
        TitleLabel2.font = [UIFont systemFontOfSize:14];
        
        int linetwo = [[[tmpArray objectAtIndex:1] objectForKey:@"line"] intValue];
        if(linetwo == 0){
            linetwo = 5;
        }
        UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 180, linetwo, 20)];
        [line2 setBackgroundColor:[UIColor colorWithRed:99.0/255.0 green:144.0/255.0 blue:75.0/255.0 alpha:1.000]];
        [self.view addSubview:line2];
        
        UILabel *Percent2 = [ViewTool addUILable:self.view x:linetwo+20 y:180 x1:50 y1:20 fontSize:15 lableText:[[tmpArray objectAtIndex:1] objectForKey:@"percent"]];
        Percent2.textColor = [UIColor blackColor];
        Percent2.font = [UIFont systemFontOfSize:16];
    }
    if([tmpArray count] > 2){
        UILabel *TitleLabel3 = [ViewTool addUILable:self.view x:10 y:210 x1:200 y1:20 fontSize:15 lableText:[NSString stringWithFormat:@"3.%@",[[tmpArray objectAtIndex:2] objectForKey:@"polloption"]]];
        TitleLabel3.textColor = [UIColor grayColor];
        TitleLabel3.font = [UIFont systemFontOfSize:14];
        
        int linethree = [[[tmpArray objectAtIndex:2] objectForKey:@"line"] intValue];
        if(linethree == 0){
            linethree = 5;
        }
        UIImageView *line3 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 230, linethree, 20)];
        [line3 setBackgroundColor:[UIColor colorWithRed:167.0/255.0 green:35.0/255.0 blue:45.0/255.0 alpha:1.000]];
        [self.view addSubview:line3];
        
        UILabel *Percent3 = [ViewTool addUILable:self.view x:linethree+20 y:230 x1:50 y1:20 fontSize:15 lableText:[[tmpArray objectAtIndex:2] objectForKey:@"percent"]];
        Percent3.textColor = [UIColor blackColor];
        Percent3.font = [UIFont systemFontOfSize:16];
    }
    if([tmpArray count] > 3){
        UILabel *TitleLabel4 = [ViewTool addUILable:self.view x:10 y:260 x1:300 y1:20 fontSize:15 lableText:[NSString stringWithFormat:@"4.%@",[[tmpArray objectAtIndex:3] objectForKey:@"polloption"]]];
        TitleLabel4.textColor = [UIColor grayColor];
        TitleLabel4.font = [UIFont systemFontOfSize:14];
        
        int linefour = [[[tmpArray objectAtIndex:3] objectForKey:@"line"] intValue];
        if(linefour == 0){
            linefour = 5;
        }
        UIImageView *line4 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 280, linefour, 20)];
        [line4 setBackgroundColor:[UIColor colorWithRed:230.0/255.0 green:222.0/255.0 blue:7.0/255.0 alpha:1.000]];
        [self.view addSubview:line4];
        
        UILabel *Percent4 = [ViewTool addUILable:self.view x:linefour+20 y:280 x1:50 y1:20 fontSize:15 lableText:[[tmpArray objectAtIndex:3] objectForKey:@"percent"]];
        Percent4.textColor = [UIColor blackColor];
        Percent4.font = [UIFont systemFontOfSize:16];
    }
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
@end
