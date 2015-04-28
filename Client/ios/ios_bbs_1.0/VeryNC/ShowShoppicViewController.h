//
//  ShowShoppicViewController.h
//  化龙巷
//
//  Created by mac on 12-4-12.
//  Copyright (c) 2012年 Osugroup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tools.h"
#import  "DebugLog.h"
@interface ShowShoppicViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    NSArray *arrayForShoppic;
    int countOfRequest;
    long maxPage;
}
@property (nonatomic, retain) NSString *htmlString;
@property (nonatomic, retain) UIWebView *htmlWebView;
@property(nonatomic,retain)NSArray * arrayForShoppic;
@property(nonatomic,strong)NSString *shop_id;
@property(nonatomic,strong)NSString *api_url;
@property(nonatomic,retain)IBOutlet UITableView *tableview;
- (NSString *)timeStampeToNSDateString:(NSString *)timeStame;
@end
