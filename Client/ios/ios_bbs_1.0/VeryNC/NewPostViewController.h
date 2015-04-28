//
//  NewPostViewController.h
//  化龙巷
//
//  Created by David Suen on 12-3-22.
//  Copyright (c) 2012年 Osugroup. All rights reserved.
//
#import "MyProtocol.h"
#import "AppDelegate.h"

#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>
#import "BSKeyboardControls.h"
#import "FaceScrollView.h"
 #import "Tools.h"
#import "FaceView.h"
//ASI
#import "ASIHTTPRequest.h"
#import "ASIDownloadCache.h"

#import "ASIFormDataRequest.h"
#include "Constants.h"
#import  "DebugLog.h"

#import "MKNumberBadgeView.h"

//extern bool isRunningImagePickerController;
extern int faceAmountGlobal;
@class WEPopoverController;
enum {
    kSendBufferSize = 32768
};
@interface NewPostViewController : UIViewController<UIImagePickerControllerDelegate, UITableViewDelegate ,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate  ,BSKeyboardControlsDelegate,UIImagePickerControllerDelegate,NSStreamDelegate>


 
{
    
    IBOutlet id<MyprotocolDelegate> myDelegate;
    AppDelegate *appDelegate;    
    UIActivityIndicatorView *_activityView;
    UILabel *_loadLabel;
   // UITextField *_textField;
    UITableView *myTableView;
        UIImageView *_loadingView;
    
    
    IBOutlet   UITableView *tableView1;
    IBOutlet   UITextView *  textView1;
    
    IBOutlet   UITextField *  textField1;
 
        IBOutlet   UITextField *  textField2;
    FaceScrollView *myFaceScrollView;
	WEPopoverController *popoverController;
    ASIHTTPRequest *myRequest;
    
   bool isExitFromImagePicker;
 
    uint8_t  buffer[kSendBufferSize];
}
 
 
@property (nonatomic, retain) ASIHTTPRequest *myRequest;
@property (nonatomic, retain) WEPopoverController *popoverController;

//beta2
@property (nonatomic, retain) UIToolbar *imageAndFaceToolbar;
@property (nonatomic, retain) UIButton *imageButton;
@property (nonatomic, retain) UIButton *cameraButton;
@property (nonatomic, retain) UIButton *keyboardButton;
@property (nonatomic, retain)  MKNumberBadgeView *imageBadge; 
@property (nonatomic, retain)  MKNumberBadgeView *cameraBadge; 
@property (nonatomic,assign) NSInteger imageAmount;
@property (nonatomic,assign) NSInteger cameraAmount;
@property (nonatomic, assign)IBOutlet id<MyprotocolDelegate> myDelegate;
@property (retain,nonatomic) AppDelegate *appDelegate;
@property (nonatomic, assign) NSInteger fid;
 
@property (nonatomic, assign) bool hasSubClassification; 
@property (nonatomic,assign) NSInteger selectIndexSubClassification;
@property (nonatomic,assign)bool isRequired;

@property (nonatomic,retain)NSMutableArray *subClassificationArray;
@property (nonatomic,retain)NSMutableArray *subClassificationKeyArray;

@property (nonatomic, retain) FaceScrollView *myFaceScrollView;

@property (nonatomic, retain)  IBOutlet   UITextView *  textView1;
@property (nonatomic, retain)  UITableView *tableView1;
@property (nonatomic, retain)  IBOutlet   UITextField *  textField1;
@property (nonatomic, retain)  IBOutlet   UITextField *  textField2;
@property (nonatomic,strong) NSString *api_url;
@property (nonatomic,retain) NSOutputStream *networkStream;
@property (nonatomic,retain) NSInputStream *fileStream;
@property (nonatomic, assign)   size_t            bufferOffset;
@property (nonatomic, assign)   size_t            bufferLimit; 
@property (nonatomic, retain) NSString *forumtitle;
@property (nonatomic, retain) NSString *imgname;

+(NSString *)trim:(NSString*)str;
@end
