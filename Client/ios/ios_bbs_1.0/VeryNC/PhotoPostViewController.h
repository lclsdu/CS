//
//  PhotoPostViewController.h
//  化龙巷
//
//  Created by mac on 12-4-11.
//  Copyright (c) 2012年 Osugroup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tools.h"
//ASI
#import "ASIHTTPRequest.h"
#import "ASIDownloadCache.h"
#import "ASIFormDataRequest.h"
#import  "DebugLog.h"
@interface PhotoPostViewController : UIViewController
@property (nonatomic,retain) UIImage *photo;
@property (nonatomic,retain) NSString *shop_id,*author,*author_id,*shop_name,*pic_path,*api_url,*is_nonav;
@property (nonatomic,retain) UITextView *textView;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollerView;
@property (nonatomic,retain)IBOutlet UINavigationBar *navbar;
@property (nonatomic,retain)IBOutlet UIActivityIndicatorView *aci;
@property (nonatomic,retain)IBOutlet UILabel *sendtip;
-(IBAction)goback:(id)sender;
-(IBAction)submit:(id)sender;
@end
