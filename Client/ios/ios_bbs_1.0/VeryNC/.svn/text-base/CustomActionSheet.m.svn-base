//
//  CustomActionSheet.m
//  VeryNC
//
//  Created by mac on 12-5-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CustomActionSheet.h"
#import "AppDelegate.h"
@interface CustomActionSheet ()

@end

@implementation CustomActionSheet
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
        
        UILabel *TipLabel = [ViewTool addUILable:self.view x:10 y:80 x1:100 y1:20 fontSize:15 lableText:@"您的选择是:"];
        TipLabel.textColor = [UIColor grayColor];
        TipLabel.font = [UIFont systemFontOfSize:12];


        //添加按钮
        UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 350, 300, 44)];
        [cancelBtn setImage:[UIImage imageNamed:@"pollcancel.png"] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(docancel) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:cancelBtn];
        
        //请求数据
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@topiclist.php?type=poll_detail&tid=%@",api_url,tid]]];
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
    if(request.tag == 0){
    NSArray *tmpArray = [[requestString JSONValue] valueForKey:@"datas"];
    NSString *totalNum = [[requestString JSONValue] valueForKey:@"count"];
    if(totalNum == NULL){
        totalNum = @"0";
    }
    UILabel *NumLabel = [ViewTool addUILable:self.view x:220 y:80 x1:100 y1:20 fontSize:15 lableText:[NSString stringWithFormat:@"已有投票:%@",totalNum]];
    NumLabel.textColor = [UIColor colorWithRed:158.0/255.0 green:26.0/255.0 blue:36.0/255.0 alpha:1.000];
    NumLabel.font = [UIFont systemFontOfSize:12];
    
    if([tmpArray count] > 0){
        UIButton *pollbtnone = [[UIButton alloc] initWithFrame:CGRectMake(10, 130, 300, 44)];
        [pollbtnone setBackgroundImage:[UIImage imageNamed:@"pollitem.png"] forState:UIControlStateNormal];
        [pollbtnone setTitle:[NSString stringWithFormat:@"1.%@",[[tmpArray objectAtIndex:0] objectForKey:@"polloption"]] forState:UIControlStateNormal];
        [pollbtnone setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        pollbtnone.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        pollbtnone.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        pollbtnone.tag = [[[tmpArray objectAtIndex:0] objectForKey:@"polloptionid"] intValue];
        [pollbtnone addTarget:self action:@selector(polldo:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:pollbtnone];
    }
    if([tmpArray count] > 1){
        UIButton *pollbtntwo = [[UIButton alloc] initWithFrame:CGRectMake(10, 180, 300, 44)];
        [pollbtntwo setBackgroundImage:[UIImage imageNamed:@"pollitem.png"] forState:UIControlStateNormal];
        [pollbtntwo setTitle:[NSString stringWithFormat:@"2.%@",[[tmpArray objectAtIndex:1] objectForKey:@"polloption"]] forState:UIControlStateNormal];
        [pollbtntwo setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        pollbtntwo.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        pollbtntwo.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        pollbtntwo.tag = [[[tmpArray objectAtIndex:1] objectForKey:@"polloptionid"] intValue];
        [pollbtntwo addTarget:self action:@selector(polldo:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:pollbtntwo];
    }
    if([tmpArray count] > 2){
        UIButton *pollbtnthree = [[UIButton alloc] initWithFrame:CGRectMake(10, 230, 300, 44)];
        [pollbtnthree setBackgroundImage:[UIImage imageNamed:@"pollitem.png"] forState:UIControlStateNormal];
        [pollbtnthree setTitle:[NSString stringWithFormat:@"3.%@",[[tmpArray objectAtIndex:2] objectForKey:@"polloption"]] forState:UIControlStateNormal];
        [pollbtnthree setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        pollbtnthree.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        pollbtnthree.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        pollbtnthree.tag = [[[tmpArray objectAtIndex:2] objectForKey:@"polloptionid"] intValue];
        [pollbtnthree addTarget:self action:@selector(polldo:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:pollbtnthree];
    }
    if([tmpArray count] > 3){
        UIButton *pollbtnfour = [[UIButton alloc] initWithFrame:CGRectMake(10, 280, 300, 44)];
        [pollbtnfour setBackgroundImage:[UIImage imageNamed:@"pollitem.png"] forState:UIControlStateNormal];
        [pollbtnfour setTitle:[NSString stringWithFormat:@"4.%@",[[tmpArray objectAtIndex:3] objectForKey:@"polloption"]] forState:UIControlStateNormal];
        [pollbtnfour setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        pollbtnfour.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        pollbtnfour.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        pollbtnfour.tag = [[[tmpArray objectAtIndex:3] objectForKey:@"polloptionid"] intValue];
        [pollbtnfour addTarget:self action:@selector(polldo:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:pollbtnfour];
    }
    }
    //投票操作
    if(request.tag == 1){
        NSArray *tmpArray = [[requestString JSONValue] valueForKey:@"datas"];
        NSString *result  = [[tmpArray objectAtIndex:0] objectForKey:@"result"];
        if([result isEqualToString:@"poll failed"]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil 
                                               message:@"投票失败请重试" 
                                              delegate:self cancelButtonTitle:@"知道了" 
                                     otherButtonTitles:nil];
            [alert show];
            [alert release];
        }else if ([result isEqualToString:@"have voted"]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil 
                                                            message:@"您已参与过该投票活动" 
                                                           delegate:self cancelButtonTitle:@"知道了" 
                                                  otherButtonTitles:nil];
            [alert show];
            [alert release];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"notifyToChangeTipAndButton" object:nil];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil 
                                                            message:@"投票成功感谢您的参与" 
                                                           delegate:self cancelButtonTitle:@"知道了" 
                                                  otherButtonTitles:nil];
            [alert show];
            [alert release];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"notifyToChangeTipAndButton" object:nil];
        }
        [self dismissWithClickedButtonIndex:0 animated:YES];
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

-(void)polldo:(id)sender{
    UIButton *btn = (UIButton *)sender;
    int polloptionid = btn.tag;
    //调取当前用户信息
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *nowlogin_filePath = [documentsDirectory stringByAppendingPathComponent:@"nowlogin.plist"];
    NSDictionary *now = [NSKeyedUnarchiver unarchiveObjectWithFile:nowlogin_filePath];
    NSString *uid  = [now objectForKey:@"uid"];
    //请求数据
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@topicpost.php?type=poll_post&polloptionid=%d&tid=%@&uid=%@",api_url,polloptionid,Tid,uid]]];
    [request setTag:1];
    //[request setDownloadCache:[ASIDownloadCache sharedCache]];
    //[request setCachePolicy:ASIAskServerIfModifiedWhenStaleCachePolicy];
    [request setDelegate:self];
    [request setPersistentConnectionTimeoutSeconds:30];
    [request startAsynchronous];
}
@end
