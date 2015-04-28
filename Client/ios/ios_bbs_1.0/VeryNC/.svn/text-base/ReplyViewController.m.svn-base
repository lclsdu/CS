//
//  ReplyViewController.m
//  化龙巷
//
//  Created by David Suen on 12-3-22.
//  Copyright (c) 2012年 Osugroup. All rights reserved.
//

#import "ReplyViewController.h"
#import "AppDelegate.h"


@implementation ReplyViewController


@synthesize isFromDetail;
//引用回复
@synthesize pid;
@synthesize ptid;
@synthesize authorQuote;
@synthesize messageQuote;
@synthesize datelineQuote;
@synthesize isQuote;

//beta2
@synthesize imageAmount;
@synthesize cameraAmount;
@synthesize  imageButton;
@synthesize  cameraButton;
@synthesize keyboardButton;

@synthesize imageBadge; 
@synthesize cameraBadge; 





@synthesize tableView1;
@synthesize textView;

@synthesize myFaceScrollView=_myFaceScrollView;


@synthesize  ispost;
@synthesize  isreply;
@synthesize  ispostimage;


//@synthesize sessionid;


@synthesize  fid;
@synthesize  tid;
//@synthesize subject;
//@synthesize authorid;
//@synthesize message;
//@synthesize author;

@synthesize  imagePicker0,imgname,fileStream,networkStream,bufferLimit,bufferOffset;

//@synthesize myRequest;

@synthesize imageAndFaceToolbar;
//@synthesize imagePicker=_imgePicker;
@synthesize api_url;
- (void)requestFailed:(ASIHTTPRequest *)request {
    [self.navigationItem.rightBarButtonItem setEnabled:true];
    if (_activityView ) {
		[_activityView removeFromSuperview];
		_activityView = nil;
		[_loadLabel removeFromSuperview];
		_loadLabel = nil;
        [_loadingView removeFromSuperview];
        _loadLabel =nil;
	}
    
    
    //   if( isSubmitSuccess) return;
    
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

#pragma mark - UIActionsheet Delegate method
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            
        {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                UIImagePickerController *imagePicker  = [[UIImagePickerController alloc] init];
                imagePicker.delegate = self;
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                imagePicker.allowsEditing = NO;
                imagePicker.mediaTypes =[UIImagePickerController availableMediaTypesForSourceType: imagePicker.sourceType];
                [self presentModalViewController:imagePicker animated:YES];
                
                imagePicker0=imagePicker;
                [imagePicker release];
                /*
                 
                 self.imagePicker = [[UIImagePickerController alloc] init];
                 self.imagePicker.delegate = self;
                 self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                 self.imagePicker.allowsEditing = NO;
                 self.imagePicker.mediaTypes =[UIImagePickerController availableMediaTypesForSourceType:self.imagePicker.sourceType];
                 [self presentModalViewController:self.imagePicker animated:YES];
                 
                 
                 */
            }
            else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" 
                                                                message:@"Unable to connect camera." 
                                                               delegate:self cancelButtonTitle:@"Ok" 
                                                      otherButtonTitles:nil];
                [alert show];
                [alert release];
            }
            break;
        }
        case 1:
        {
            UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePicker.mediaTypes =[UIImagePickerController availableMediaTypesForSourceType: imagePicker.sourceType];
            [self presentModalViewController: imagePicker animated:YES];
            imagePicker0=imagePicker;
            [imagePicker release];
            
            /*
             self.imagePicker = [[UIImagePickerController alloc] init];
             self.imagePicker.delegate = self;
             self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
             self.imagePicker.mediaTypes =[UIImagePickerController availableMediaTypesForSourceType:self.imagePicker.sourceType];
             [self presentModalViewController:self.imagePicker animated:YES];
             */
            
            break;
        }
        default:
            break;
    }
}




#pragma mark - UIImagePicker Delegate method
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    
    if(picker.sourceType==UIImagePickerControllerSourceTypePhotoLibrary)
    {
        
        // Access the uncropped image from info dictionary
        UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0]; 
        
        //???????????
        NSString *s;        
        
        
        
        NSFileManager* fileManager = [NSFileManager defaultManager];
            s=[NSString stringWithFormat:[documentsDirectory stringByAppendingPathComponent:imgname] ];
        
        
        DebugLog(@"%@",s);
        
        
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
        
        CGSize itemSize = CGSizeMake(w,h);//(100, 100);
        UIGraphicsBeginImageContext(itemSize);
        
        //[image drawInRect:CGRectMake(0, 0,100, 100)];
        [image drawInRect:CGRectMake(0, 0,w, h)];
        
        
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        
        NSData* imageData1 =[NSData dataWithData:UIImageJPEGRepresentation (image,0.6)];//originalImage )];
        
        
        
        
        [imageData1 writeToFile:s atomically:NO]; 
        
        //---------------------------------------------------------
        
        
        
        [picker  dismissModalViewControllerAnimated:YES];
        
        imageAmount=imageAmount+1;
        
        
        imageBadge.value=imageAmount;
        
        //   MKNumberBadgeView *number = [[MKNumberBadgeView alloc] initWithFrame:CGRectMake(60, 00, 30,20)];
        
        
        //UIBarButtonItem *aBarButtonItem=(UIBarButtonItem*)[imageAndFaceToolbar.items objectAtIndex:1];
        
        //     [aBarButtonItem s
        
        
        
        
        
    }
    else {
        // Access the uncropped image from info dictionary
        
        UIImage* image = [info objectForKey:UIImagePickerControllerEditedImage];
        if (!image)
            image = [info objectForKey:UIImagePickerControllerOriginalImage];             
        
        
    	
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0]; 
        
        
        NSString *s;        
        
        
        
        NSFileManager* fileManager = [NSFileManager defaultManager];
            s=[NSString stringWithFormat:[documentsDirectory stringByAppendingPathComponent:imgname] ];
        
        
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
            
            
        }        CGSize itemSize = CGSizeMake(w,h);//(100, 100);
        UIGraphicsBeginImageContext(itemSize);
        
        //[image drawInRect:CGRectMake(0, 0,100, 100)];
        [image drawInRect:CGRectMake(0, 0,w, h)];
        
        
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        
        NSData* imageData1 =[NSData dataWithData:UIImageJPEGRepresentation (image,0.6)];//originalImage )];
        
        
        
        
        [imageData1 writeToFile:s atomically:NO]; 
        
        //---------------------------------------------------------
        
        
        
        
        cameraAmount=cameraAmount+1;
        
        
        cameraBadge.value=cameraAmount;
        
        [picker  dismissModalViewControllerAnimated:YES];
        
    }
    
    
    
    
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    UIAlertView *alert;
    
    // Unable to save the image  
    if (error)
        alert = [[UIAlertView alloc] initWithTitle:@"Error" 
                                           message:@"Unable to save image to Photo Album." 
                                          delegate:self cancelButtonTitle:@"Ok" 
                                 otherButtonTitles:nil];
    else // All is well
        alert = [[UIAlertView alloc] initWithTitle:@"Success" 
                                           message:@"Image saved to Photo Album." 
                                          delegate:self cancelButtonTitle:@"Ok" 
                                 otherButtonTitles:nil];
    [alert show];
    [alert release];
    [self.imagePicker0 dismissModalViewControllerAnimated:YES];
    
}

/*
 
 Alex Lee  14:02:39
 用户登陆后会在app端生成forumlist.plist这个文件，其中存储了各个论坛板块的信息+对当前登陆用户的权限信息 本身是数组 里面每个元素是字典格式 判断权限时的重要字段有：fid（板块ID）、ispost（0不可以发帖1可以发帖）、isreply（0不可以回帖1可以回帖）、ispostimage（0不能带图片1可以带图片）
 Alex Lee  14:27:06
 nowlogin.plist 当前登陆用户的信息存在这个文件中了 是字典格式的 包括username sessionid uid 三个字段；如果用户退出登陆了则里面所有字段都是nil
 */


-(bool)checkIfHasLogIn;
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; 
    
    
    NSFileManager* fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:[documentsDirectory stringByAppendingPathComponent:@"nowlogin.plist"] isDirectory:NULL]) 
        
    {
        
        NSDictionary *now = [NSKeyedUnarchiver unarchiveObjectWithFile:[documentsDirectory stringByAppendingPathComponent:@"nowlogin.plist"]];
        NSString *nowname  = [now objectForKey:@"username"];
        
        if([nowname isEqualToString:nil])
            return NO;
        else  
            
            return YES;
    }
    else {
        
        return NO;
        
    }
    
    
}
-(bool)checkIfHasRightToReply:(NSInteger)temfid;
{
    //  fid（板块ID）、ispost（0不可以发帖1可以发帖）、isreply（0不可以回帖1可以回帖）、ispostimage（0不能带图片1可以带图片）
    
    
    //  fid（板块ID）、ispost（0不可以发帖1可以发帖）、isreply（0不可以回帖1可以回帖）、ispostimage（0不能带图片1可以带图片）
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; 
    
    
    NSArray *forumlist_array;
    
    
    
    NSString *forumlist_filePath = [documentsDirectory stringByAppendingPathComponent:@"forumlist.plist"];
    NSFileManager* fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:[documentsDirectory stringByAppendingPathComponent:@"forumlist.plist"] isDirectory:NULL]) 
    {
        
        return false;
        
    }
    
    
    
    
    forumlist_array =[NSKeyedUnarchiver unarchiveObjectWithFile:forumlist_filePath];
    
    for (int i=0;i<[forumlist_array count]; i++ ) {
        
        NSInteger tfid=[[[forumlist_array objectAtIndex:i] objectForKey:@"fid"] intValue];
        if (temfid==tfid) {
            
            NSInteger tisreply=[[[forumlist_array objectAtIndex:i] objectForKey:@"isreply"] intValue];
            if(isreply==0)
                return false;
            else
                return true;
            
            
            
        };
        DebugLog(@":::     %d ",tfid );
        
        
    }
    
    return false;
    
}

-(bool)checkIfHasRightToAttachImage:(NSInteger)temfid;
{
    //  fid（板块ID）、ispost（0不可以发帖1可以发帖）、isreply（0不可以回帖1可以回帖）、ispostimage（0不能带图片1可以带图片）
    
    
    //  fid（板块ID）、ispost（0不可以发帖1可以发帖）、isreply（0不可以回帖1可以回帖）、ispostimage（0不能带图片1可以带图片）
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; 
    
    
    NSArray *forumlist_array;
    
    
    
    NSString *forumlist_filePath = [documentsDirectory stringByAppendingPathComponent:@"forumlist.plist"];
    NSFileManager* fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:[documentsDirectory stringByAppendingPathComponent:@"forumlist.plist"] isDirectory:NULL]) 
    {
        
        return false;
        
    }
    forumlist_array =[NSKeyedUnarchiver unarchiveObjectWithFile:forumlist_filePath];
    
    for (int i=0;i<[forumlist_array count]; i++ ) {
        
        NSInteger tfid=[[[forumlist_array objectAtIndex:i] objectForKey:@"fid"] intValue];
        if (temfid==tfid) {
            
            NSInteger tisreply=[[[forumlist_array objectAtIndex:i] objectForKey:@"ispostimage"] intValue];
            if(tisreply==0)
                return false;
            else
                return true;
        };
        DebugLog(@":::     %d ",tfid );
        
        
    }
    
    return false;
    
}
-(bool)loadPlist;
{
    
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; 
    
    
    NSArray *forumlist_array;
    
    
    
    NSString *forumlist_filePath = [documentsDirectory stringByAppendingPathComponent:@"forumlist.plist"];
    
    
    
    
    //NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:forumlist_filePath];
    
    
    
    forumlist_array =[NSKeyedUnarchiver unarchiveObjectWithFile:forumlist_filePath];
    
    
    // NSDictionary *forum = [NSKeyedUnarchiver unarchiveObjectWithFile:forumlist_filePath    ];
    
    DebugLog(@"%d",[forumlist_array count]);//
    int i=0;
}   /*
     
     
     
     用户登陆后会在app端生成forumlist.plist这个文件，其中存储了各个论坛板块的信息+对当前登陆用户的权限信息 本身是数组 里面每个元素是字典格式 判断权限时的重要字段有：fid（板块ID）、ispost（0不可以发帖1可以发帖）、isreply（0不可以回帖1可以回帖）、ispostimage（0不能带图片1可以带图片）
     Alex Lee  14:27:06
     nowlogin.plist 当前登陆用户的信息存在这个文件中了 是字典格式的 包括username sessionid uid 三个字段；如果用户退出登陆了则里面所有字段都是nil
     
     
     
     bool  ispost;
     bool isreply;
     bool ispostimage;   
     
     }
     */

/*
 -(bool)loadPlist;
 {
 
 
 
 NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
 NSString *documentsDirectory = [paths objectAtIndex:0]; 
 
 
 
 NSDictionary *now = [NSKeyedUnarchiver unarchiveObjectWithFile:[documentsDirectory stringByAppendingPathComponent:@"nowlogin.plist"]];
 
 NSString* author  = [now objectForKey:@"username"];
 NSString* sessionid  = [now objectForKey:@"sessionid"];
 NSString* authorid  = [now objectForKey:@"uid"];
 
 
 NSArray *forumlist_array;
 
 
 
 
 
 
 
 
 
 NSString *forumlist_filePath = [documentsDirectory stringByAppendingPathComponent:@"forumlist.plist"];
 
 
 
 
 NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:forumlist_filePath];
 
 
 
 forumlist_array =[NSKeyedUnarchiver unarchiveObjectWithFile:forumlist_filePath];
 
 
 NSDictionary *forum = [NSKeyedUnarchiver unarchiveObjectWithFile:forumlist_filePath    ];
 
 
 NSString *temfid  = [dict  objectForKey:@"fid"];
 
 
 NSString *ispost  = [dict objectForKey:@"ispost"];
 NSString *isreply  = [dict objectForKey:@"isreply"];
 NSString *ispostimage=[dict objectForKey:@"ispostimage"];
 
 
 
 用户登陆后会在app端生成forumlist.plist这个文件，其中存储了各个论坛板块的信息+对当前登陆用户的权限信息 本身是数组 里面每个元素是字典格式 判断权限时的重要字段有：fid（板块ID）、ispost（0不可以发帖1可以发帖）、isreply（0不可以回帖1可以回帖）、ispostimage（0不能带图片1可以带图片）
 Alex Lee  14:27:06
 nowlogin.plist 当前登陆用户的信息存在这个文件中了 是字典格式的 包括username sessionid uid 三个字段；如果用户退出登陆了则里面所有字段都是nil
 
 
 
 bool  ispost;
 bool isreply;
 bool ispostimage;   
 
 }
 */
-(void)setValue_fid:(NSInteger)v;
{
    
    
    
    fid=v;
}
-(void)setValue_tid:(NSInteger)v;
{
    
    
    
    tid=v;
}

- (void)viewWillAppear:(BOOL)animated;  
{
    bool b=   [self  checkIfHasRightToReply:fid];
    [self.navigationItem.rightBarButtonItem setEnabled:true];
    // [self loadPlist];
    //   [[self navigationItem] setTitle: @""]; 
    
    
    
    
    
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
/*
 
 advice.php?type=submit
 POST传参三个字段，message(建议内容), uid（用户id，可省略）, username（用户名，可省略）
 用户已通过登陆验证后，可以把uid和username添上；若没有账号信息可以省略这两个字段。
 200 send succ
 500 send failed
 404 unknown error
 */
//------------------------------------------------------------------------------------------------
-(void)launchCamera:(id)sender;
{
    if(imageAmount+cameraAmount>=1)
    {
        
        
        UIAlertView *alert;
        
        alert = [[UIAlertView alloc] initWithTitle:@"最多只能发一张图片" 
                                           message:@"" 
                                          delegate:self cancelButtonTitle:@"知道了" 
                                 otherButtonTitles:nil];
        [alert show];
        
        [alert release];
        
        return;
        
        
        
    }
    
    if(_myFaceScrollView)[_myFaceScrollView setHidden:true];
    
    
    [keyboardButton setEnabled:false];
    
    
    
    isRunningImagePickerController=true;
    
    
    /*
     self.imagePicker = [[UIImagePickerController alloc] init];
     self.imagePicker.delegate = self;
     self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
     self.imagePicker.allowsEditing = YES;
     //   self.imagePicker.mediaTypes =[UIImagePickerController availableMediaTypesForSourceType:self.imagePicker.sourceType];
     [self presentModalViewController:self.imagePicker animated:YES];
     
     */
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    ipc.delegate = self;
    
    ipc.allowsEditing = YES;
    
    [self presentModalViewController:ipc animated:YES];
    
}

//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;
//{

//}

-(void)imagePickerControllerDidCancel:(UIImagePickerController*)picker{
    
    
    
    [picker dismissModalViewControllerAnimated:YES];
    
    //   picker=nil;
    //   [picker release];
	
    //  [picker dismissModalViewControllerAnimated:YES];
	
}
-(void)addImage:(id)sender;
{
    
    if(imageAmount+cameraAmount>=1)
    {
        
        
        UIAlertView *alert;
        
        
        alert = [[UIAlertView alloc] initWithTitle:@"最多只能发一张图片" 
                                           message:@"" 
                                          delegate:self cancelButtonTitle:@"知道了" 
                                 otherButtonTitles:nil];
        [alert show];
        
        [alert release];
        
        return;
        
        
        
    }
    if(_myFaceScrollView)[_myFaceScrollView setHidden:true];
    
    [keyboardButton setEnabled:false];
    isRunningImagePickerController=true;
    
    UIImagePickerController *picker=[[UIImagePickerController alloc]init];
    
    picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    picker.allowsEditing = YES;
    
    imagePicker0=picker;
    
    [picker setDelegate:self];
    [self presentModalViewController: picker animated:YES];
    
    
    [picker release];
    // Sedning 'BViewController' to parameter of imcompatible type 'id<UINavigationControllerDelegate, UIImagePickerControllerDelegate>'
    
    
}
-(void)launchFace:(id)sender;
{
    
    
    UIWindow * tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1]; 
    UIView* keyboard; 
    
    
    
    
    
    // if(_myFaceScrollView==nil)
    //  {
    
    
    
    for(int i=0; i<[tempWindow.subviews count]; i++) 
    { keyboard = [tempWindow.subviews objectAtIndex:i]; // keyboard view found; add the custom button to it 
        if([[keyboard description] hasPrefix:@"UIKeyboard"] == YES);// [keyboard addSubview:doneButton]; }
        
        {
            
            faceAmountGlobal=0;
            FaceScrollView *faceScrollView = [[FaceScrollView alloc] initWithFrame:CGRectMake(0, 31, 320, _facePageHeight)  target:self];
            if(faceScrollView)
            {
                
                //DebugLog(@"%d",faceScrollView.faceAmount);
                //if (faceScrollView.faceAmount  ==0) {
                
                if (faceAmountGlobal  ==0) {
                    
                    UIAlertView *error_alert = [[UIAlertView alloc] initWithTitle:nil message:@"请求表情失败,请重试" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil];
                    [error_alert show];
                    [error_alert release];
                    return;
                }
                //}
                //faceScrollView.faceAmount=39;
                faceScrollView.pagingEnabled = YES;
                faceScrollView.backgroundColor = [UIColor clearColor];
                //faceScrollView.contentSize = CGSizeMake(320*4, _facePageHeight);
                [keyboard addSubview:faceScrollView];
                _myFaceScrollView=faceScrollView;
                faceScrollView.hidden=false;
            }
            break;
            
        }
        
    }        
    
    
    
    [keyboardButton setEnabled:true];
    if(_myFaceScrollView)[_myFaceScrollView setHidden:false];
    
    
}
-(void)displayKeyboard:(id)sender;
{
    [keyboardButton setEnabled:false];
    
    if(_myFaceScrollView)[_myFaceScrollView setHidden:true];
    
    // [textView1 becomeFirstResponder];
} 
/*
 
 
 - (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_NA,__MAC_NA,__IPHONE_2_0,__IPHONE_3_0);
 - (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;
 - (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker;
 */

- (void)requestStarted:(ASIHTTPRequest *)request {
    
    
    /*
     if (_activityView ) {
     [_activityView removeFromSuperview];
     _activityView = nil;
     [_loadLabel removeFromSuperview];
     _loadLabel = nil;
     }
     _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
     _activityView.frame = CGRectMake(110.0f, 120.0f, 20.0f, 20.0f);
     [self.view addSubview:_activityView];
     [_activityView startAnimating];
     
     
     _loadLabel = [ViewTool addUILable:self.view x:135.0 y:118 x1:100 y1:20 fontSize:15 lableText:@"提交中..."];//158
     [_loadLabel setTextColor:[UIColor grayColor]];
     
     */
    //beta2
    if (_activityView ) {
        
        [_activityView removeFromSuperview];
        _activityView = nil;
        [_loadLabel removeFromSuperview];
        _loadLabel = nil;
        
        [_loadingView removeFromSuperview];
        _loadingView=nil;
        
    }
    
    _loadingView=[[UIImageView alloc] initWithFrame:CGRectMake(90.0f, 70.0f,140.0f, 70.0f)];
    _loadingView.image=[UIImage imageNamed:@"duqu.png"];
    _loadingView.alpha=0.8;
    [self.view addSubview:_loadingView];
    
    _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    _activityView.frame = CGRectMake(110.0f, 92.0f, 20.0f, 20.0f);
    [self.view addSubview:_activityView];
    [_activityView startAnimating];
    
    //_loadLabel = [ViewTool addUILable:self.view x:140.0 y:158 x1:100 y1:20 fontSize:15 lableText:@"加载中..."];
    _loadLabel = [ViewTool addUILable:self.view x:140.0 y:92 x1:100 y1:20 fontSize:15 lableText:@"提交中..."];
    
    [_loadLabel setTextColor:[UIColor grayColor]];
    
}



-(void)expressionClickWith:(FaceView *)faceView faceName:(NSString *)name
{
    
    //NSMutableString *s=[
    textView.text =[NSString stringWithFormat:@"%@%@",[textView text],name];
    
    
    
}


- (void)requestFinished:(ASIHTTPRequest *)request {
    /*
     
     发帖成功 code:200, result:post succ
     发帖失败 code:500, result:post failed
     回复成功 code:200, result:reply succ
     回复失败 code:200, result:reply failed
     错误 code:404
     
     */
    [self.navigationItem.rightBarButtonItem setEnabled:true];
    
    if (_activityView ) {
		[_activityView removeFromSuperview];
		_activityView = nil;
		[_loadLabel removeFromSuperview];
		_loadLabel = nil;
        [_loadingView removeFromSuperview];
        _loadLabel =nil;
        [_loadingView removeFromSuperview];
        _loadingView=nil;
	}
    NSString *requestString = [[request responseString] stringByConvertingHTMLToPlainText];
    
    
    
    
    
    
    //---------------------------------------------------------
    
    NSArray *tmpArray = [[requestString JSONValue] valueForKey:@"datas"];
    
    
    NSString *s = [[tmpArray objectAtIndex:0] valueForKey:@"result"];
    if([s isEqualToString:@"reply succ"])
    {
        UIAlertView *alert=[[UIAlertView alloc]
                            initWithTitle:@"回帖成功"
                            
                            message:@""//\n\n\n\n"
                            delegate:self
                            cancelButtonTitle:@"知道了"
                            otherButtonTitles:nil,nil];
        
        
        //---------------------------------------------------------
        [alert show];
        [alert release];
        //  isSubmitSuccess=true;
        
        [self.navigationController popViewControllerAnimated:true];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"notifyToReloadPageNotification" object:nil];
        
        
        
        //fix bug
        if(isFromDetail)
        {
            [[NSNotificationCenter defaultCenter] postNotificationName: @"notifyToReloadDetailNotification"
                                                                object: nil];
        }
    }
    else  if([s isEqualToString:@"reply failed"])
    {   
        UIAlertView *alert=[[UIAlertView alloc]
                            initWithTitle:@"回帖失败"
                            
                            message:@""//\n\n\n\n"
                            delegate:self
                            cancelButtonTitle:@"知道了"
                            otherButtonTitles:nil,nil];
        
        
        //---------------------------------------------------------
        [alert show];
        [alert release];
        
        //[self.navigationController popViewControllerAnimated:true];
        
    }
    else  if([s isEqualToString:@"dangerous word"])
    {   
        UIAlertView *alert=[[UIAlertView alloc]
                            initWithTitle:@"请不要包含敏感字符"
                            
                            message:@""//\n\n\n\n"
                            delegate:self
                            cancelButtonTitle:@"知道了"
                            otherButtonTitles:nil,nil];
        
        
        //---------------------------------------------------------
        [alert show];
        [alert release];
        
        //[self.navigationController popViewControllerAnimated:true];
        
    }
    else  if([s isEqualToString:@"forbidden_time"])
    {   
        UIAlertView *alert=[[UIAlertView alloc]
                            initWithTitle:@"当前时间段不允许发帖"
                            
                            message:@""//\n\n\n\n"
                            delegate:self
                            cancelButtonTitle:@"知道了"
                            otherButtonTitles:nil,nil];
        
        
        //---------------------------------------------------------
        [alert show];
        [alert release];
        
        //[self.navigationController popViewControllerAnimated:true];
        
    }
    else       {    
        
        UIAlertView *alert=[[UIAlertView alloc]
                            initWithTitle:@"回帖失败"
                            
                            message:@""//\n\n\n\n"
                            delegate:self
                            cancelButtonTitle:@"知道了"
                            otherButtonTitles:nil,nil];
        
        
        //---------------------------------------------------------
        [alert show];
        [alert release];
        
        
        //[self.navigationController popViewControllerAnimated:true];
        
        
        
    }
    
    
}
- (NSString *)removeNewlinesAndTabulation:(NSString *)fromString appending:(BOOL)appending
{
    NSArray *a = [fromString componentsSeparatedByString:@"\n"];
    NSMutableString *res = [NSMutableString stringWithString:appending ? @" " : @""];
    for (NSString *s in a) {
        s = [s stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if (s.length > 0 
            && res.length > (appending ? 1 : 0)) [res appendString:@" "];
        [res appendString:s];
    }
    return res;
}
/*
 
 请求URL: topicpost.php?type=reply&fid=板块id
 GET参数：type=reply,fid=板块ID,tid=帖子ID,img=1（发图片时添加此参数，可选）
 POST参数：subject(标题),author(发帖用户名),authorid(发帖用户ID),message(帖子主体信息),img[](上传图片信息，可上传多图)
 
 */

- (void) copy:(id) sender {
    // called when copy clicked in menu
}
//- (void) menuItemClicked:(id) sender {
// called when Item clicked in menu
//}
- (void) onCustom1: (UIMenuController*) sender
{
}

- (void) onCustom2: (UIMenuController*) sender
{
}
- (BOOL) canPerformAction:(SEL)selector withSender:(id) sender {
    if (selector == @selector(menuItemClicked:) /*|| selector == @selector(copy:)*/ /*<--enable that if you want the copy item */) {
        return YES;
    }
    return NO;
}
- (BOOL) canBecomeFirstResponder {
    return YES;
}

-(void)replyPost:(id)sender;
{
    /*
     
     UIBarButtonItem *a=(UIBarButtonItem*)sender;
     
     [self becomeFirstResponder];
     
     //get the view from the UIBarButtonItem 
     //UIEvent *event;
     //   UIView *buttonView=[[event.allTouches anyObject] view];
     //  CGRect buttonFrame=[buttonView convertRect:CGRectMake(150,60,200,50) toView:self.view];
     
     UIMenuController *menuController = [UIMenuController sharedMenuController];
     //UIMenuItem *resetMenuItem = [[UIMenuItem alloc] initWithTitle:@"Menu Item" action:@selector(menuItemClicked:)];
     UIMenuItem* miCustom1 = [[[UIMenuItem alloc] initWithTitle: @"Custom 1" action:@selector( onCustom1: )] autorelease];
     UIMenuItem* miCustom2 = [[[UIMenuItem alloc] initWithTitle: @"Custom 2" action:@selector( onCustom2: )] autorelease];
     // UIMenuController* mc = [UIMenuController sharedMenuController];
     menuController.menuItems = [NSArray arrayWithObjects: miCustom1, miCustom2, nil];
     
     
     
     
     
     //  NSAssert([self becomeFirstResponder], @"Sorry, UIMenuController will not work with %@ since it cannot //become first responder", self);
     [menuController setMenuItems:[NSArray arrayWithObject:menuController.menuItems]] ;//]resetMenuItem]];
     [menuController setTargetRect: CGRectMake(0,0,200,50)
     inView:self.view];
     [menuController setMenuVisible:YES animated:YES];
     //   
     //   [resetMenuItem release];
     
     return;
     */
    
    NSString *s1=[self removeNewlinesAndTabulation:[textView text] appending:false];
    
    
    if([s1 length]<1 )
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0]; 
        NSFileManager* fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:[documentsDirectory stringByAppendingPathComponent:imgname] isDirectory:NULL]) 
        {
            
            
        }
        else
        {
            
            UIAlertView *alert=[[UIAlertView alloc]
                                initWithTitle:@"帖子内容不能为空"
                                
                                message:@""//\n\n\n\n"
                                delegate:self
                                cancelButtonTitle:@"知道了"
                                otherButtonTitles:nil,nil];
            
            
            //---------------------------------------------------------
            [alert show];
            [alert release];
            
            
            return;
        }
    }
    
    else {
        if([s1 length]>300 )
        {
            
            UIAlertView *alert=[[UIAlertView alloc]
                                initWithTitle:@"帖子内容太多"
                                
                                message:@""//\n\n\n\n"
                                delegate:self
                                cancelButtonTitle:@"知道了"
                                otherButtonTitles:nil,nil];
            
            
            //---------------------------------------------------------
            [alert show];
            [alert release];
            
            
            return;
        }
        
    }
    
    [self.navigationItem.rightBarButtonItem setEnabled:false];
    
    
    NSURL *url;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; 
    NSFileManager* fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:[documentsDirectory stringByAppendingPathComponent:imgname] isDirectory:NULL]) 
    {   
        if (isQuote) {
            url=[NSURL URLWithString:[NSString stringWithFormat: @"%@topicpost.php?type=reply&fid=%d&tid=%d&img=1&quote=1",api_url,fid,tid ]]; 
            
        }else {
            url=[NSURL URLWithString:[NSString stringWithFormat: @"%@topicpost.php?type=reply&fid=%d&tid=%d&img=1",api_url,fid,tid ]];   
        }
        
        
    }
    else {
        if (isQuote) {
            url=[NSURL URLWithString:[NSString stringWithFormat: @"%@topicpost.php?type=reply&fid=%d&tid=%d&quote=1",api_url,fid,tid ]];
            
        }else {
            url=[NSURL URLWithString:[NSString stringWithFormat: @"%@topicpost.php?type=reply&fid=%d&tid=%d",api_url,fid,tid ]];
        }
        
    }
    
    
    /*
     请求URL: topicpost.php?type=reply&fid=板块id
     GET参数：type=reply,fid=板块ID,tid=帖子ID,img=1（发图片时添加此参数，可选）
     POST参数：subject(标题),author(发帖用户名),authorid(发帖用户ID),message(帖子主体信息),img[](上传图片信息，可上传多图)
     */
    
    DebugLog(@"%@",[NSString stringWithFormat: @"%@topicpost.php?type=reply&fid=%d&tid=%d",api_url,fid,tid ]);
    
    
    
    ASIFormDataRequest  *request = [ASIFormDataRequest requestWithURL:url];
    
    
    
    
    
    
    
    
    NSDictionary *now = [NSKeyedUnarchiver unarchiveObjectWithFile:[documentsDirectory stringByAppendingPathComponent:@"nowlogin.plist"]];
    
    NSString* author  = [now objectForKey:@"username"];
    NSString* sessionid  = [now objectForKey:@"sessionid"];
    NSString* authorid  = [now objectForKey:@"uid"];
    
    
    //[request setPostValue:text forKey:@"subject"];
    [request setPostValue:author forKey:@"author"];
    [request setPostValue:authorid forKey:@"authorid"];  
    
    
    [request setPostValue:sessionid forKey:@"sid"];
    
    
    if (isQuote) {
        NSDateFormatter* formatter =[[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd hh:mm"];
        NSTimeInterval timecontent=[self.datelineQuote doubleValue];//str是NSString类型
        NSDate *timeDate = [NSDate dateWithTimeIntervalSince1970:timecontent];
        NSString * time = [formatter stringFromDate:timeDate];
        
        
        //不会出现字符串了
        //\r\n\r\n来自iPhone客户端
        NSString * message=[NSString stringWithFormat:@"[quote][size=2][color=#999999]%@发表于%@[/color] [url=forum.php?mod=redirect&goto=findpost&pid=%d&ptid=%d][img]static/image/common/back.gif[/img][/url][/size]%@[/quote]%@"
                            ,self.authorQuote,time,self.pid,self.ptid,self.messageQuote,[textView text]] ;
        [request setPostValue:message  forKey:@"message"]; 
        DebugLog(@"message+ messageQutoe:%@",message);
        
    }
    else {
        //\r\n\r\n来自iPhone客户端
        NSString * message=[NSString stringWithFormat:@"%@",[textView text]];
        [request setPostValue:message  forKey:@"message"];  
    }
    
    [request setPostValue:@"i" forKey:@"status"];
    
    if([_useftppic isEqualToString:@"yes"]){
        [request setPostValue:imgname  forKey:@"ftpimgname"];
    }
    
    
    if ([fileManager fileExistsAtPath:[documentsDirectory stringByAppendingPathComponent:imgname] isDirectory:NULL]) 
    {
        if([_useftppic isEqualToString:@"yes"]){
            [self _startSend:[documentsDirectory stringByAppendingPathComponent:imgname]];
        }else{
            [request setFile:[documentsDirectory stringByAppendingPathComponent:imgname] forKey:@"img1"];
        }
    }
    
    
    DebugLog(@"1-%@ 2-%@  3-%@ 4-%@ ",author,authorid,sessionid, [textView text]); 
    
//    [request setCachePolicy:ASIAskServerIfModifiedCachePolicy | ASIFallbackToCacheIfLoadFailsCachePolicy]; 
//    [request setCachePolicy:ASIOnlyLoadIfNotCachedCachePolicy];
    
    
    [request setDelegate:self];
    [request setPersistentConnectionTimeoutSeconds:120];//_timeOut
    
    //   isSubmitSuccess=false;
    //myRequest= [request retain];
    [request startAsynchronous];
    
    //[request setFile:@"/Users/ben/Desktop/ben.jpg" forKey:@"photo"];
    
    
    //[self.navigationController popViewControllerAnimated:true];
    
}

- (void)viewDidLoad
{
    NSLog(@"%@",imgname);
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    api_url = delegate.myDomainAndPathVeryNC;
    
    [super viewDidLoad];
    
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithTitle:@"提交"
                                                                  style:UIBarButtonItemStyleDone
                                                                 target:self
                                                                 action:@selector(replyPost:)];
    self.navigationItem.rightBarButtonItem = barButton;
    [barButton release];
    
    //---------removr thumbnail img-----------------------------------------------------------------------------------------
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; 
    imageAmount=0;
    cameraAmount=0;
    
    NSFileManager* fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:[documentsDirectory stringByAppendingPathComponent:imgname] isDirectory:NULL]) 
    {
        
        NSError *error = nil;
        [fileManager removeItemAtPath:[documentsDirectory stringByAppendingPathComponent:imgname] error:&error];
    }
    
}
- (void)viewWillDisAppear:(BOOL)animated;  
{
    
    
    for (ASIHTTPRequest *request in ASIHTTPRequest.sharedQueue.operations)
    {
        [request cancel];
        [request setDelegate:nil];
    }
    
    
    
    
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
-(void)dealloc{
    
    /*
     [imagePicker0 release];
     
     [subject release];
     [authorid release];
     [author release];
     [sessionid release];
     [message release];
     
     
     [myFaceScrollView release];
     [textView release];
     [tableView1 release]; */
    
    
    
	[super dealloc];
}

#pragma mark -
#pragma mark Table View Data Source Methods

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView 

{
	return 1;
} 


- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section
{
	
    
	return 1;
}





- (CGFloat)tableView:(UITableView *)tableView 
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	
	return 180.0f;//cell height
	
	
	
}
//------------------------------------------------------------------------------------------------



- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{	
    
    
    
    static NSString *SimpleTableIdentifier1 = @"CellTableIdentifier";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier: SimpleTableIdentifier1 ];
    
    if  (cell == nil) 
    {
        
        //CGRect cellframe=CGRectMake(0, 0, 280, 60);
        cell=[[[UITableViewCell alloc] initWithFrame: CGRectZero//SimpleTableIdentifier1
               
                                     reuseIdentifier:SimpleTableIdentifier1] autorelease];
        
        
        
        
        
        
        UITextView *a=[[UITextView alloc]initWithFrame:CGRectMake(10.0f,10.0f,280.0f,160.0f)];
        
        textView=a;
        //-------------------
        UIToolbar * myToolbar = [[UIToolbar alloc]  initWithFrame:CGRectMake(60.0f,20.0f,220.0f,30.0f)];
        // Add button to toolbar here
        
        
        imageAndFaceToolbar=myToolbar;
        
        
        NSMutableArray *barItems = [[NSMutableArray alloc] init];
        
        /*
         UIBarButtonItem *cameraBtn =[[UIBarButtonItem alloc] initWithTitle:@""
         style:UIBarButtonItemStylePlain
         target:self
         action:@selector(launchCamera:)];
         
         cameraBtn.image =[UIImage imageNamed:@"camera.png"];
         
         */
        
        
        
        // configure barButton
        UIButton * button = [UIButton buttonWithType : UIButtonTypeCustom];
        UIImage * image = [UIImage imageNamed:@ "camera.png"];
        [button setImage :image forState: UIControlStateNormal];
        button.frame = CGRectMake(0, 0, image.size.width, image.size.width);
        [button addTarget: self 
                   action: @selector(launchCamera:) 
         forControlEvents: UIControlEventTouchUpInside];
        
        UIBarButtonItem *cameraBtn = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        
        
        cameraButton=button;
        
        
        MKNumberBadgeView *badge = [[MKNumberBadgeView alloc] initWithFrame:CGRectMake(18, -3, 30,30)];
        badge.value = 0;
        badge.layer.cornerRadius = 3;
        badge.layer.masksToBounds = YES;
        badge.fillColor = [UIColor blueColor];
        badge.hideWhenZero = YES;
        
        badge.hidden=true;
        badge.tag = 41;
        [cameraButton addSubview:badge];
        cameraBadge =badge;
        
        [barItems addObject:cameraBtn];
        DebugLog(@"%d",fid);
        if([self checkIfHasRightToAttachImage:fid])
        {
            
            
            if( [UIImagePickerController isCameraDeviceAvailable: UIImagePickerControllerCameraDeviceRear ])
            {
                [cameraBtn setEnabled:true];
            }
            else {
                
                [cameraBtn setEnabled:false];
            }
            
            
            
            
        }
        else
        {
            
            [cameraBtn setEnabled:false];
        }
        
        
        
        
        
        [cameraBtn release];
        //--------------------------------------------------------------------------------------------------
        
        
        
        
        
        
        UIBarButtonItem *fixedSpace1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
        [barItems addObject:fixedSpace1 ];
        
        fixedSpace1.width = 20;
        [fixedSpace1 release];
        //----------------------
        
        // configure barButton
        button = [UIButton buttonWithType : UIButtonTypeCustom];
        image = [UIImage imageNamed:@ "photoReply.png"];
        [button setImage :image forState: UIControlStateNormal];
        button.frame = CGRectMake(0, 0, image.size.width, image.size.width);
        [button addTarget: self 
                   action: @selector(addImage:) 
         forControlEvents: UIControlEventTouchUpInside];
        
        UIBarButtonItem *addImageBtn = [[UIBarButtonItem alloc] initWithCustomView:button];
        imageButton=button;
        
        MKNumberBadgeView *badge1 = [[MKNumberBadgeView alloc] initWithFrame:CGRectMake(18, -3, 30,30)];
        
        badge1.value = 0;
        badge1.layer.cornerRadius = 3;
        badge1.layer.masksToBounds = YES;
        badge1.fillColor = [UIColor blueColor];
        badge1.hideWhenZero =YES;
        badge1.hidden=true;
        badge.tag = 42;
        [imageButton addSubview:badge1];
        imageBadge =badge1;
        
        
        if([self checkIfHasRightToAttachImage:fid])
        {
            
            
            [addImageBtn setEnabled:true];
            
            
            
        }
        else
        {
            
            [addImageBtn setEnabled:false];
        }
        
        [barItems addObject:addImageBtn];
        [addImageBtn release];
        
        
        
        //----------------------------------
        UIBarButtonItem *fixedSpace2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
        [barItems addObject:fixedSpace2 ];
        
        fixedSpace2.width = 20;
        [fixedSpace2 release];
        
        //-------------------------------------
        
        
        /*
         UIBarButtonItem *faceBtn =[[UIBarButtonItem alloc] initWithTitle:@""
         style:UIBarButtonItemStylePlain
         target:self
         action:@selector(launchFace:)];
         
         faceBtn.image =[UIImage imageNamed:@"face.png"];
         
         
         
         */
        // configure barButton
        button = [UIButton buttonWithType : UIButtonTypeCustom];
        image = [UIImage imageNamed:@ "face.png"];
        [button setImage :image forState: UIControlStateNormal];
        button.frame = CGRectMake(0, 0, image.size.width, image.size.width);
        [button addTarget: self 
                   action: @selector(launchFace:) 
         forControlEvents: UIControlEventTouchUpInside];
        
        UIBarButtonItem *faceBtn = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        
        
        
        
        [barItems addObject:faceBtn];
        [faceBtn release];
        //---------------------------------------------------------
        
        UIBarButtonItem *fixedSpace3 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
        [barItems addObject:fixedSpace3 ];
        
        fixedSpace3.width = 20;
        [fixedSpace3 release];
        
        
        
        //---------------------------------------------------------
        
        
        
        /*
         
         UIBarButtonItem *keyboardBtn =[[UIBarButtonItem alloc] initWithTitle:@""
         style:UIBarButtonItemStylePlain
         target:self
         action:@selector(displayKeyboard:)];
         
         keyboardBtn.image =[UIImage imageNamed:@"keyboard.png"];
         
         */
        
        // configure barButton
        button = [UIButton buttonWithType : UIButtonTypeCustom];
        image = [UIImage imageNamed:@ "keyboard.png"];
        [button setImage :image forState: UIControlStateNormal];
        button.frame = CGRectMake(0, 0, image.size.width, image.size.width);
        [button addTarget: self 
                   action: @selector(displayKeyboard:) 
         forControlEvents: UIControlEventTouchUpInside];
        
        UIBarButtonItem *keyboardBtn = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        
        keyboardButton=keyboardBtn;
        
        [barItems addObject:keyboardBtn];
        [keyboardBtn setEnabled:false];
        [keyboardBtn release];
        
        
        
        
        UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        [barItems addObject:flexSpace];
        
        [flexSpace release];
        
        
        [myToolbar setItems:barItems animated:YES];
        
        
        
        
        a.inputAccessoryView = myToolbar;
        
        
        
        
        
        
        
        
        
        
        [myToolbar release];
        
        
        
        //-------------------
        
        [textView 	setTextAlignment:UITextAlignmentLeft];	
        
        textView.keyboardAppearance=UIKeyboardAppearanceAlert; 
        [textView setBackgroundColor:[UIColor clearColor]];
        [textView  setFont:[UIFont fontWithName:@"ArialMT" size:16]];
        
        [cell.contentView addSubview:textView];
        [textView becomeFirstResponder];
        
        [a release];
        
    }
	
	
    
    [cell  setBackgroundColor:[UIColor whiteColor]];
    
    cell.textLabel.text= @"" ;
    
    
    return cell;
    
    
	
 	
}
//#pragma mark -
//#pragma mark Table Delegate Methods1 

- (void)tableView:(UITableView *)tableView 
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
	[tableView1 deselectRowAtIndexPath:indexPath animated:YES];
    [textView becomeFirstResponder];
}

- (void)_startSend:(NSString *)filePath
{
    BOOL                    success;
    NSURL *                 url;
    CFWriteStreamRef        ftpStream;
    
    assert(filePath != nil);
    assert([[NSFileManager defaultManager] fileExistsAtPath:filePath]);
    assert( [filePath.pathExtension isEqual:@"png"] || [filePath.pathExtension isEqual:@"jpg"] );
    
    assert(self.networkStream == nil);      // don't tap send twice in a row!
    assert(self.fileStream == nil);         // ditto
    
    // First get and check the URL.
    AppDelegate *delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    NSString *ym;
    NSString *day;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYYMM"];
    ym = [formatter stringFromDate:[NSDate date]];
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc]init];
    [formatter2 setDateFormat:@"dd"];
    day = [formatter2 stringFromDate:[NSDate date]];
    NSString *final_ftpurl = [NSString stringWithFormat:@"%@/forum/%@/%@",_ftpurl,ym,day];
    NSLog(@"%@",final_ftpurl);
    url = [delegate smartURLForString:final_ftpurl];
    success = (url != nil);
    
    if (success) {
        // Add the last part of the file name to the end of the URL to form the final 
        // URL that we're going to put to.
        
        url = [NSMakeCollectable(
                                 CFURLCreateCopyAppendingPathComponent(NULL, (CFURLRef) url, (CFStringRef) [filePath lastPathComponent], false)
                                 ) autorelease];
        success = (url != nil);
    }
    
    // If the URL is bogus, let the user know.  Otherwise kick off the connection.
    
    if ( ! success) {
        NSLog(@"wrong url");
    } else {
        
        // Open a stream for the file we're going to send.  We do not open this stream; 
        // NSURLConnection will do it for us.
        self.fileStream = [NSInputStream inputStreamWithFileAtPath:filePath];
        assert(self.fileStream != nil);
        
        [self.fileStream open];
        
        // Open a CFFTPStream for the URL.
        
        ftpStream = CFWriteStreamCreateWithFTPURL(NULL, (CFURLRef) url);
        assert(ftpStream != NULL);
        
        self.networkStream = (NSOutputStream *) ftpStream;
        
        if (_ftpusername.length != 0) {
#pragma unused (success) //Adding this to appease the static analyzer.
            success = [self.networkStream setProperty:_ftpusername forKey:(id)kCFStreamPropertyFTPUserName];
            assert(success);
            success = [self.networkStream setProperty:_ftppassword forKey:(id)kCFStreamPropertyFTPPassword];
            assert(success);
        }
        
        self.networkStream.delegate = self;
        [self.networkStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [self.networkStream open];
        
        // Have to release ftpStream to balance out the create.  self.networkStream 
        // has retained this for our persistent use.
        
        CFRelease(ftpStream);
        
        // Tell the UI we're sending.
        
        //[self _sendDidStart];
        //        
//                if (self.networkStream != nil) {
//                    [self.networkStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
//                    self.networkStream.delegate = nil;
//                    [self.networkStream close];
//                    self.networkStream = nil;
//                }
//                if (self.fileStream != nil) {
//                    [self.fileStream close];
//                    self.fileStream = nil;
//                }
    }
}
- (uint8_t *)buffer
{
    return buffer;
}
- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode
// An NSStream delegate callback that's called when events happen on our 
// network stream.
{
#pragma unused(aStream)
    assert(aStream == self.networkStream);
    
    switch (eventCode) {
        case NSStreamEventOpenCompleted: {
            NSLog(@"Opened connection");
            //[self _updateStatus:@"Opened connection"];
        } break;
        case NSStreamEventHasBytesAvailable: {
            assert(NO);     // should never happen for the output stream
        } break;
        case NSStreamEventHasSpaceAvailable: {
            NSLog(@"Sending");
            //[self _updateStatus:@"Sending"];
            
            // If we don't have any data buffered, go read the next chunk of data.
            
            if (self.bufferOffset == self.bufferLimit) {
                NSInteger   bytesRead;
                bytesRead = [self.fileStream read:buffer maxLength:kSendBufferSize2];
                if (bytesRead == -1) {
                    NSLog(@"File read error");
                    //[self _stopSendWithStatus:@"File read error"];
                } else if (bytesRead == 0) {
                    [self _stopSendWithStatus:nil];
                } else {
                    self.bufferOffset = 0;
                    self.bufferLimit  = bytesRead;
                }
            }
            
            // If we're not out of data completely, send the next chunk.
            
            if (self.bufferOffset != self.bufferLimit) {
                NSInteger   bytesWritten;
                bytesWritten = [self.networkStream write:&self.buffer[self.bufferOffset] maxLength:self.bufferLimit - self.bufferOffset];
                assert(bytesWritten != 0);
                if (bytesWritten == -1) {
                    [self _stopSendWithStatus:@"Network write error"];
                } else {
                    self.bufferOffset += bytesWritten;
                }
            }
        } break;
        case NSStreamEventErrorOccurred: {
            [self _stopSendWithStatus:@"Stream open error"];
        } break;
        case NSStreamEventEndEncountered: {
            // ignore
        } break;
        default: {
            assert(NO);
        } break;
    }
}

- (void)_stopSendWithStatus:(NSString *)statusString
{
    if (self.networkStream != nil) {
        [self.networkStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        self.networkStream.delegate = nil;
        [self.networkStream close];
        self.networkStream = nil;
    }
    if (self.fileStream != nil) {
        [self.fileStream close];
        self.fileStream = nil;
    }
    [self _sendDidStopWithStatus:statusString];
}

- (void)_sendDidStopWithStatus:(NSString *)statusString
{
    NSLog(@"%@",statusString);
    [[AppDelegate sharedAppDelegate] didStopNetworking];
}
//- (uint8_t *)buffer
//{
//    return self.buffer;
//}

- (BOOL)isSending
{
    return (self.networkStream != nil);
}

@end
