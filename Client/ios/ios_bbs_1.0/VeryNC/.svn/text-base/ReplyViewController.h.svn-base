//
//  ReplyViewController.h
//  化龙巷
//
//  Created by David Suen on 12-3-22.
//  Copyright (c) 2012年 Osugroup. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import "FaceScrollView.h"
#import "Tools.h"
#import "FaceView.h"
//ASI                  
#import "ASIHTTPRequest.h"
#import "ASIDownloadCache.h"
 
#import "ASIFormDataRequest.h"
#include "Constants.h"

#import "MKNumberBadgeView.h"
#import  "DebugLog.h"
enum {
    kSendBufferSize2 = 32768
};
extern int faceAmountGlobal;
@interface ReplyViewController : UIViewController<      UITableViewDelegate ,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate ,UIImagePickerControllerDelegate,NSStreamDelegate >
{
    
    UIActivityIndicatorView *_activityView;
    UILabel *_loadLabel;
        UIImageView *_loadingView;
    IBOutlet   UITableView *tableView1;
    IBOutlet   UITextView *  textView;

 
    
//    NSString *subject;
//    NSString *authorid;
//    NSString *author;
//    NSString *message;
//    NSString *sessionid;
    
 
    FaceScrollView *myFaceScrollView;
 uint8_t  buffer[kSendBufferSize2];
}

@property (nonatomic,assign) bool isFromDetail;
 
 
//beta2
@property (nonatomic, retain) UIToolbar *imageAndFaceToolbar;
@property (nonatomic, retain) UIButton *imageButton;
@property (nonatomic, retain) UIButton *cameraButton;
@property (nonatomic, retain) UIButton *keyboardButton;
@property (nonatomic, retain)  MKNumberBadgeView *imageBadge; 
@property (nonatomic, retain)  MKNumberBadgeView *cameraBadge; 
@property (nonatomic,assign) NSInteger imageAmount;
@property (nonatomic,assign) NSInteger cameraAmount;


@property (nonatomic,assign) bool  ispost;
@property (nonatomic,assign) bool  isreply;
@property (nonatomic,assign) bool  ispostimage;

 


@property (nonatomic, assign) NSInteger fid;
@property (nonatomic, assign) NSInteger tid;
//引用回复
@property (nonatomic, assign) NSInteger pid;
@property (nonatomic, assign) NSInteger ptid;
@property (nonatomic, retain) NSString *authorQuote;
@property (nonatomic, retain) NSString *messageQuote;
@property (nonatomic, retain) NSString *datelineQuote;
@property (nonatomic,assign) bool  isQuote;


 
//@property (nonatomic, retain) NSString *sessionid;
//@property (nonatomic, retain) NSString *author; 
// 
//@property (nonatomic, retain) NSString *subject;
//@property (nonatomic, retain) NSString *authorid;
//@property (nonatomic, retain) NSString *message;
 
 @property (nonatomic,  retain)UIImagePickerController *imagePicker0;

//-------------------------------------------------

@property (nonatomic, retain) FaceScrollView *myFaceScrollView;
 
@property (nonatomic, retain)  IBOutlet   UITextView *  textView;
@property (nonatomic, retain)  UITableView *tableView1;
@property (nonatomic, retain) NSString *imgname;
@property (nonatomic,retain) NSOutputStream *networkStream;
@property (nonatomic,retain) NSInputStream *fileStream;
@property (nonatomic, assign)   size_t            bufferOffset;
@property (nonatomic, assign)   size_t            bufferLimit;

@property (nonatomic,strong) NSString *api_url;
-(void)setValue_fid:(NSInteger)v;
-(void)setValue_tid:(NSInteger)v;
 

@end
