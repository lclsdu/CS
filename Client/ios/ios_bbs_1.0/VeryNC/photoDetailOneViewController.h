//
//  photoDetailOneViewController.h
//  VeryNC
//
//  Created by mac on 12-5-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tools.h"
#import "SqliteSet.h"
#import "DebugLog.h"
#import "EGOImageView.h"

#define kpublishTag 400
@interface photoDetailOneViewController : UIViewController<UITextViewDelegate,UIScrollViewDelegate,UIActionSheetDelegate>
{
    int hidemessage;
    int hideall;
    UIImageView *bbimgview;
    UIImageView *arrowview;
    UILabel *titleLabel;
    UILabel *pagenumLabel;
    UITextView *textview;
    UITextView * textView;
    UIView *writeView;
    UIView *removeView;
    UIButton * publishButton;
    UIButton *collectionButton;
    
    UIScrollView *imageScroll;
    EGOImageView *imageview;
    
    UIImageView *imageView;
    UIButton *writeComment;
    UIButton *saveButton;
    UIButton *shareButton;
}
@property (nonatomic,strong) NSString *pic_url;
@property (nonatomic,strong) NSString *picshow_coverpic;
@property (nonatomic,strong) NSString *pic_title;
@property (nonatomic,strong) NSString *pic_message;
@property (nonatomic,strong) NSString *pageshow;
@property (nonatomic,strong) NSString *api_url;
@property (nonatomic,strong) NSString *tid;
@property (nonatomic,strong) NSString *fid;
@property (nonatomic,strong) NSString *picshow_id;
@property (nonatomic,strong) UIScrollView *imageScroll;
@end
