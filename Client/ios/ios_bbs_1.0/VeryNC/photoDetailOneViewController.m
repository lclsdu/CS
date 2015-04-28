//
//  photoDetailOneViewController.m
//  VeryNC
//
//  Created by mac on 12-5-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "photoDetailOneViewController.h"
#import "ASIFormDataRequest.h"
#import "AppDelegate.h"
#import "MoreAccountViewController.h"

#define ZOOMSCALE 3.0
@interface photoDetailOneViewController ()

@end
@implementation photoDetailOneViewController
@synthesize pic_url,pic_message,pageshow,pic_title,api_url,tid,fid,picshow_id,picshow_coverpic,imageScroll;
- (void)dealloc
{
    [imageScroll release];
    [picshow_coverpic release];
    [picshow_id release];
    [fid release];
    [tid release];
    [api_url release];
    [pic_title release];
    [pageshow release];
    [pic_message release];
    [pic_url release];
    [super dealloc];
}
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
    
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    api_url = delegate.myDomainAndPathVeryNC;
    hidemessage = 0;
    hideall = 0;
    
    self.view.backgroundColor = [UIColor blackColor];
    NSURL *imageURL1 = [NSURL URLWithString:pic_url];
    //imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 30, 350, 300)];
    imageview = [[EGOImageView alloc] initWithPlaceholderImage:nil];
    imageview.frame = CGRectMake(0, 30, 350, 300);
    imageview.imageURL = imageURL1;
    
    //NSData *imageData1 = [NSData dataWithContentsOfURL:imageURL1];
    //imageview.image = [UIImage imageWithData:imageData1];
    [imageview setContentMode:UIViewContentModeScaleAspectFit];
    imageview.userInteractionEnabled = YES;
    UITapGestureRecognizer *BigPicTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage:)];
    [imageview addGestureRecognizer:BigPicTap];
    
    imageScroll=[[UIScrollView alloc] init];
    imageScroll.delegate=self;
    imageScroll.showsHorizontalScrollIndicator=NO;
    imageScroll.showsVerticalScrollIndicator=NO;
    imageScroll.frame=CGRectMake(0, 0, 320, 480);
    imageScroll.contentSize=[imageview frame].size;
    
    imageview.userInteractionEnabled=YES;
    UITapGestureRecognizer *doubleTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    [doubleTap setNumberOfTapsRequired:2];
    [imageview addGestureRecognizer:doubleTap];
    [doubleTap release];
    
    [BigPicTap requireGestureRecognizerToFail:doubleTap];
    
    float minimumScale = [imageScroll frame].size.width  / [imageview frame].size.width; 
    imageScroll.scrollEnabled=YES;
    imageScroll.maximumZoomScale=3.0;
    imageScroll.minimumZoomScale=minimumScale;
    imageScroll.zoomScale=minimumScale;
    [self.imageScroll addSubview:imageview];
    [self.view addSubview:imageScroll];
    
    //文字描述
    bbimgview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 289, 320, 85)];
    bbimgview.image = [UIImage imageNamed:@"bigblack.png"];
    bbimgview.alpha = 0.7;
    bbimgview.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickBlackBanner_notify)];
    [bbimgview addGestureRecognizer:singleTap];
    [self.view addSubview:bbimgview];
    
    titleLabel = [ViewTool addUILable:self.view x:10 y:291 x1:250 y1:20 fontSize:15 lableText:pic_title];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:14];
    
    pagenumLabel = [ViewTool addUILable:self.view x:265 y:291 x1:200 y1:20 fontSize:15 lableText:pageshow];
    pagenumLabel.textColor = [UIColor whiteColor];
    pagenumLabel.font = [UIFont systemFontOfSize:14];
    
    arrowview = [[UIImageView alloc] initWithFrame:CGRectMake(290, 291, 20, 20)];
    arrowview.image = [UIImage imageNamed:@"photo_downarrow.png"];
    [self.view addSubview:arrowview];
    
    textview = [[UITextView alloc] initWithFrame:CGRectMake(10, 309, 300, 65)];
    textview.text = pic_message;
    textview.font = [UIFont systemFontOfSize:12];
    textview.backgroundColor = [UIColor clearColor];
    textview.textColor = [UIColor whiteColor];
    textview.editable = NO;
    textview.contentInset = UIEdgeInsetsMake(-4,-8,0,0);
    [self.view addSubview:textview];
    
    //底部button
    imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 372, 320, 44)];
    [imageView  setImage:[UIImage imageNamed:@"bg1.png"]];
    imageView.alpha = 0.7;
    [self.view addSubview:imageView];
    
    
    writeComment = [[UIButton alloc]initWithFrame:CGRectMake(10, 381, 152, 26)];
    [writeComment setBackgroundImage:[UIImage imageNamed:@"bbtn.png"] forState:UIControlStateNormal];
    [writeComment addTarget:self action:@selector(writeCommentButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:writeComment];
    [writeComment release];
    
    saveButton = [[UIButton alloc]initWithFrame:CGRectMake(180, 382, 19, 23)];
    [saveButton setBackgroundImage:[UIImage imageNamed:@"ico6.png"] forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(savepicButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveButton];
    [saveButton release];
    
    shareButton = [[UIButton alloc]initWithFrame:CGRectMake(232, 382, 19, 23)];
    [shareButton setBackgroundImage:[UIImage imageNamed:@"ico7.png"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(shareButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareButton];
    [shareButton release];
    
    
    collectionButton = [[UIButton alloc]initWithFrame:CGRectMake(281, 382, 24, 24)];
    if ([self isFavoritePic:self.picshow_id]) {
        [collectionButton setImage:[UIImage imageNamed:@"ico10.png"] forState:UIControlStateNormal];
    }else{
        [collectionButton setImage:[UIImage imageNamed:@"ico8.png"] forState:UIControlStateNormal];
    }
    //[collectionButton setBackgroundImage:[UIImage imageNamed:@"ico8.png"] forState:UIControlStateNormal];
    [collectionButton addTarget:self action:@selector(collectionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:collectionButton];
    [collectionButton release];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onClickBlackBanner) name:@"notifytochangeblackbar" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ToHideorShowAll) name:@"notifytohideorshowall" object:nil];
    // Do any additional setup after loading the view from its nib.
}
- (void)shareButtonClicked:(id)sender
{
    UIActionSheet *callphone = [[UIActionSheet alloc] initWithTitle:@"分享到" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"新浪微博",@"腾讯微博",nil];
    [callphone setTag:1];
    [callphone showInView:[UIApplication sharedApplication].keyWindow];
}
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"notifytoshowshareview" object:@"新浪微博分享"];
    }
    if(buttonIndex == 1){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"notifytoshowshareview" object:@"腾讯微博分享"];
    }

}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {  
	return imageview;  
}  

- (void)handleDoubleTap:(UITapGestureRecognizer *)gestureRecognizer{
    float newScale=[imageScroll zoomScale]*ZOOMSCALE;
    if (newScale>3.0) {
        newScale=1.0;
    }
    CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];  
    [imageScroll zoomToRect:zoomRect animated:YES];
    //双击图片时应禁止执行通知隐藏所有元素
    
}

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center {  
	
	CGRect zoomRect;  
	
	// the zoom rect is in the content view's coordinates.   
	//    At a zoom scale of 1.0, it would be the size of the imageScrollView's bounds.  
	//    As the zoom scale decreases, so more content is visible, the size of the rect grows.  
	zoomRect.size.height = [imageScroll frame].size.height / scale;  
	zoomRect.size.width  = [imageScroll frame].size.width  / scale;  
	
	// choose an origin so as to get the right center.  
	zoomRect.origin.x    = center.x - (zoomRect.size.width  / 2.0);  
	zoomRect.origin.y    = center.y - (zoomRect.size.height / 2.0);  
    
	return zoomRect;  
}
- (void)ToHideorShowAll
{
    if(hideall == 0){
        [bbimgview removeFromSuperview];
        [titleLabel removeFromSuperview];
        [pagenumLabel removeFromSuperview];
        [arrowview removeFromSuperview];
        [textview removeFromSuperview];
        
        [imageView removeFromSuperview];
        [writeComment removeFromSuperview];
        [shareButton removeFromSuperview];
        [saveButton removeFromSuperview];
        [collectionButton removeFromSuperview];
        
        hidemessage = 1;
        hideall = 1;
    }else{
        bbimgview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 289, 320, 85)];
        bbimgview.image = [UIImage imageNamed:@"bigblack.png"];
        bbimgview.alpha = 0.7;
        bbimgview.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickBlackBanner_notify)];
        [bbimgview addGestureRecognizer:singleTap];
        [self.view addSubview:bbimgview];
        
        titleLabel = [ViewTool addUILable:self.view x:10 y:291 x1:250 y1:20 fontSize:15 lableText:pic_title];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont systemFontOfSize:14];
        
        pagenumLabel = [ViewTool addUILable:self.view x:265 y:291 x1:200 y1:20 fontSize:15 lableText:pageshow];
        pagenumLabel.textColor = [UIColor whiteColor];
        pagenumLabel.font = [UIFont systemFontOfSize:14];
        
        arrowview = [[UIImageView alloc] initWithFrame:CGRectMake(295, 291, 20, 20)];
        arrowview.image = [UIImage imageNamed:@"photo_downarrow.png"];
        [self.view addSubview:arrowview];
        
        textview = [[UITextView alloc] initWithFrame:CGRectMake(10, 309, 300, 65)];
        textview.text = pic_message;
        textview.font = [UIFont systemFontOfSize:12];
        textview.backgroundColor = [UIColor clearColor];
        textview.textColor = [UIColor whiteColor];
        textview.editable = NO;
        textview.contentInset = UIEdgeInsetsMake(-4,-8,0,0);
        [self.view addSubview:textview];
        
        //底部button
        imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 372, 320, 44)];
        [imageView  setImage:[UIImage imageNamed:@"bg1.png"]];
        imageView.alpha = 0.7;
        [self.view addSubview:imageView];
        
        
        writeComment = [[UIButton alloc]initWithFrame:CGRectMake(10, 381, 152, 26)];
        [writeComment setBackgroundImage:[UIImage imageNamed:@"bbtn.png"] forState:UIControlStateNormal];
        [writeComment addTarget:self action:@selector(writeCommentButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:writeComment];
        [writeComment release];
        
        saveButton = [[UIButton alloc]initWithFrame:CGRectMake(180, 382, 19, 23)];
        [saveButton setBackgroundImage:[UIImage imageNamed:@"ico6.png"] forState:UIControlStateNormal];
        [saveButton addTarget:self action:@selector(savepicButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:saveButton];
        [saveButton release];
        
        shareButton = [[UIButton alloc]initWithFrame:CGRectMake(232, 382, 19, 23)];
        [shareButton setBackgroundImage:[UIImage imageNamed:@"ico7.png"] forState:UIControlStateNormal];
        [shareButton addTarget:self action:@selector(shareButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:shareButton];
        [shareButton release];
        
        
        collectionButton = [[UIButton alloc]initWithFrame:CGRectMake(281, 382, 24, 24)];
        if ([self isFavoritePic:self.picshow_id]) {
            [collectionButton setImage:[UIImage imageNamed:@"ico10.png"] forState:UIControlStateNormal];
        }else{
            [collectionButton setImage:[UIImage imageNamed:@"ico8.png"] forState:UIControlStateNormal];
        }
        //[collectionButton setBackgroundImage:[UIImage imageNamed:@"ico8.png"] forState:UIControlStateNormal];
        [collectionButton addTarget:self action:@selector(collectionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:collectionButton];
        [collectionButton release];
        
        hideall = 0;
        hidemessage = 0;
    }
}
- (void)onClickBlackBanner_notify
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notifytochangeblackbar" object:nil];
}
- (void)onClickBlackBanner
{
    if(hidemessage == 0){//隐藏message信息
        [bbimgview removeFromSuperview];
        [arrowview removeFromSuperview];
        [titleLabel removeFromSuperview];
        [pagenumLabel removeFromSuperview];
        [textview removeFromSuperview];
        
        bbimgview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 344, 320, 30)];
        bbimgview.image = [UIImage imageNamed:@"bigblack.png"];
        bbimgview.alpha = 0.7;
        bbimgview.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickBlackBanner_notify)];
        [bbimgview addGestureRecognizer:singleTap];
        [self.view addSubview:bbimgview];
        
        titleLabel = [ViewTool addUILable:self.view x:10 y:346 x1:250 y1:20 fontSize:15 lableText:pic_title];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont systemFontOfSize:14];
        
        pagenumLabel = [ViewTool addUILable:self.view x:265 y:346 x1:200 y1:20 fontSize:15 lableText:pageshow];
        pagenumLabel.textColor = [UIColor whiteColor];
        pagenumLabel.font = [UIFont systemFontOfSize:14];
        
        arrowview = [[UIImageView alloc] initWithFrame:CGRectMake(290, 346, 20, 20)];
        arrowview.image = [UIImage imageNamed:@"photo_uparrow.png"];
        [self.view addSubview:arrowview];
        
        hidemessage = 1;
    }else{//展示message信息
        [bbimgview removeFromSuperview];
        [arrowview removeFromSuperview];
        [titleLabel removeFromSuperview];
        [pagenumLabel removeFromSuperview];
        
        bbimgview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 289, 320, 85)];
        bbimgview.image = [UIImage imageNamed:@"bigblack.png"];
        bbimgview.alpha = 0.7;
        bbimgview.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickBlackBanner_notify)];
        [bbimgview addGestureRecognizer:singleTap];
        [self.view addSubview:bbimgview];
        
        titleLabel = [ViewTool addUILable:self.view x:10 y:291 x1:250 y1:20 fontSize:15 lableText:pic_title];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont systemFontOfSize:14];
        
        pagenumLabel = [ViewTool addUILable:self.view x:265 y:291 x1:200 y1:20 fontSize:15 lableText:pageshow];
        pagenumLabel.textColor = [UIColor whiteColor];
        pagenumLabel.font = [UIFont systemFontOfSize:14];
        
        arrowview = [[UIImageView alloc] initWithFrame:CGRectMake(295, 291, 20, 20)];
        arrowview.image = [UIImage imageNamed:@"photo_downarrow.png"];
        [self.view addSubview:arrowview];
        
        textview = [[UITextView alloc] initWithFrame:CGRectMake(10, 309, 300, 65)];
        textview.text = pic_message;
        textview.font = [UIFont systemFontOfSize:12];
        textview.backgroundColor = [UIColor clearColor];
        textview.textColor = [UIColor whiteColor];
        textview.editable = NO;
        textview.contentInset = UIEdgeInsetsMake(-4,-8,0,0);
        [self.view addSubview:textview];
        
        hidemessage = 0;
    }
}
- (void)savepicButtonClicked:(UIButton *)sender
{
    NSURL *imageURL1 = [NSURL URLWithString:pic_url];
    NSData *imageData1 = [NSData dataWithContentsOfURL:imageURL1];
    UIImageWriteToSavedPhotosAlbum([UIImage imageWithData:imageData1], self, @selector(imageSavedToPhotosAlbum: didFinishSavingWithError: contextInfo:), nil);
}
- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *) contextInfo {  
    NSString *message;  
    NSString *title;  
    if (!error) {  
        title = @"成功提示";  
        message = @"成功保存到相册";  
    } else {  
        title = @"失败提示";  
        message = [error description];  
    }  
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title  
                                                    message:message  
                                                   delegate:nil  
                                          cancelButtonTitle:@"知道了"  
                                          otherButtonTitles:nil];  
    [alert show];  
    [alert release];  
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

//快速发帖
-(void)writeCommentButtonClicked:(id)sender{
    
    if (![self checkIfHasLogIn]) {
        
        //UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"您尚未登录" delegate:self cancelButtonTitle:@"好" otherButtonTitles: nil];
        //[alert show];
        //[alert release];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"notifytopushtoaccountview" object:nil];
        
    }else {
        if (![self checkIfHasRightToReply:[fid intValue]]) {
            UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"您没有发帖权限" delegate:self cancelButtonTitle:@"好" otherButtonTitles: nil];
            [alert show];
            [alert release];
            
        }else {
            
            
            writeView=[[UIView alloc]initWithFrame:CGRectMake( 0.0f, 448.0f, 320.0f, 292.0f)];
            [writeView setBackgroundColor:[UIColor whiteColor]];
            [self.view addSubview:writeView];
            
            
            removeView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 157)];
            [removeView setBackgroundColor:[UIColor clearColor]];
            UITapGestureRecognizer * removeGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleRemoveComment:)];
            [removeView addGestureRecognizer:removeGesture];
            [self.view addSubview:removeView];
            
            
            
            
            
            UIImageView * imageBg=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
            [imageBg setImage:[UIImage imageNamed:@"navi_key.png"]];
            [writeView addSubview:imageBg];
            [imageBg release];
            
            textView=[[UITextView alloc]initWithFrame:CGRectMake(5, 8, 250, 28)];
            textView.font=[UIFont fontWithName:@"Helvetica" size:13];
            //    textView.keyboardAppearance=UIKeyboardAppearanceAlert; 
            textView.delegate = self;
            [writeView addSubview:textView];
            [textView becomeFirstResponder];
            
            
            
            publishButton=[[UIButton alloc]initWithFrame:CGRectMake(262, 8, 50, 28)];
            [publishButton setBackgroundImage:[UIImage imageNamed:@"but_key.png"] forState:UIControlStateNormal];
            [publishButton setTitle:@"发表" forState:UIControlStateNormal];
            publishButton.titleLabel.font=[UIFont fontWithName:@"Helvetica" size:13];
            publishButton.titleLabel.textColor=[UIColor blackColor];
            [publishButton addTarget:self action:@selector(publishButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            [writeView addSubview:publishButton];
            
            
            
            
            [writeView setFrame:CGRectMake( 0.0f, 448.0f, 320.0f, 292.0f)]; //notice this is OFF screen!
            
            
            
            
            
            [UIView beginAnimations:@"animateTableView" context:nil];
            [UIView setAnimationDuration:0.25];
            [writeView setFrame:CGRectMake( 0.0f, 157.0f, 320.0f, 292.0f)]; //notice this is ON screen!
            [UIView commitAnimations];
        }
    }
    
    
}
- (void)textViewDidChangeSelection:(UITextView *)textView
{
    if ([[[UITextInputMode currentInputMode] primaryLanguage] isEqualToString:@"en-US"]) { 
        [writeView setFrame:CGRectMake( 0.0f, 157.0f, 320.0f, 292.0f)];
    } 
    else 
    { 
        if([[[UITextInputMode currentInputMode] performSelector:NSSelectorFromString(@"identifier")] isEqualToString:@"zh_Hans-HWR@sw=HWR"]){
            [writeView setFrame:CGRectMake( 0.0f, 157.0f, 320.0f, 292.0f)];
        }else{
            [writeView setFrame:CGRectMake( 0.0f, 122.0f, 320.0f, 292.0f)];
            [removeView setFrame:CGRectMake(0, 0, 320, 127)];
        }
    }
}

-(void)publishButtonClicked:(id)sender{
    
    NSString *s1=[self removeNewlinesAndTabulation:[textView text] appending:false];
    
    if([s1 length]<1 )
    {
        
        
        UIAlertView *alert=[[UIAlertView alloc]
                            initWithTitle:@"帖子内容不能为空"
                            
                            message:@""//\n\n\n\n"
                            delegate:self
                            cancelButtonTitle:@"知道了"
                            otherButtonTitles:nil,nil];
        
        [alert show];
        [alert release];
        
        
        return;
        
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
    [publishButton  setEnabled:NO];
    NSURL *url;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; 
    
    url=[NSURL URLWithString:[NSString stringWithFormat: @"%@topicpost.php?type=reply&fid=%d&tid=%d",api_url,[self.fid intValue],[self.tid intValue]]];
    
    ASIFormDataRequest  *request = [ASIFormDataRequest requestWithURL:url];
    
    
    NSDictionary *now = [NSKeyedUnarchiver unarchiveObjectWithFile:[documentsDirectory stringByAppendingPathComponent:@"nowlogin.plist"]];
    
    NSString* author  = [now objectForKey:@"username"];
    NSString* sessionid  = [now objectForKey:@"sessionid"];
    NSString* authorid  = [now objectForKey:@"uid"];
    
    
    //[request setPostValue:text forKey:@"subject"];
    [request setPostValue:author forKey:@"author"];
    [request setPostValue:authorid forKey:@"authorid"];  
    
    
    [request setPostValue:sessionid forKey:@"sid"];
    
    
    NSString * message=[NSString stringWithFormat:@"%@",[textView text]];
    [request setPostValue:message  forKey:@"message"];  
    
    
    [request setPostValue:@"i" forKey:@"status"];
    
    
    [request setTag:kpublishTag];
    //[request setCachePolicy:ASIAskServerIfModifiedCachePolicy | ASIFallbackToCacheIfLoadFailsCachePolicy]; 
    //[request setCachePolicy:ASIOnlyLoadIfNotCachedCachePolicy];
    
    [request setDelegate:self];
    [request setPersistentConnectionTimeoutSeconds:120];//_timeOut
    
    //   isSubmitSuccess=false;
    //myRequest= [request retain];
    [request startAsynchronous];
    
    
}

-(void)handleRemoveComment:(UITapGestureRecognizer *)gesture{
    [removeView removeFromSuperview];
    [writeView removeFromSuperview];
}
-(bool)checkIfHasLogIn;
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; 
    
    
    NSFileManager* fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:[documentsDirectory stringByAppendingPathComponent:@"nowlogin.plist"] isDirectory:NULL]) 
        
    {
        
        NSDictionary *now = [NSKeyedUnarchiver unarchiveObjectWithFile:[documentsDirectory stringByAppendingPathComponent:@"nowlogin.plist"]];
        NSString *nowname  = [now objectForKey:@"username"];
        
        if(nowname==nil)
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
    
    forumlist_array =[NSKeyedUnarchiver unarchiveObjectWithFile:forumlist_filePath];
    
    for (int i=0;i<[forumlist_array count]; i++ ) {
        
        NSInteger tfid=[[[forumlist_array objectAtIndex:i] objectForKey:@"fid"] intValue];
        if (temfid==tfid) {
            
            NSInteger tisreply=[[[forumlist_array objectAtIndex:i] objectForKey:@"isreply"] intValue];
            if(tisreply==0)
                return false;
            else
                return true;
        };
        
        
    }
    
    return false;
    
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
- (void)requestFinished:(ASIHTTPRequest *)request {
    
    NSString *requestString = [request responseString];
    
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
        [removeView removeFromSuperview];
        [writeView removeFromSuperview];
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
- (void)requestFailed:(ASIHTTPRequest *)request {
    
    UIAlertView *alert;
    NSError *error = [request error];
    if (error)
        alert = [[UIAlertView alloc] initWithTitle:@"链接错误" 
                                           message:@"暂时不能连接服务器" 
                                          delegate:self cancelButtonTitle:@"知道了" 
                                 otherButtonTitles:nil];
    [alert show];
    
}
-(void)collectionButtonClicked:(id)sender{
    
    if(![self isFavoritePic:self.picshow_id])
    {
        
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO FavouritePic VALUES('%@','%@','%@','%@','%@')",self.picshow_id,self.pic_title,self.tid,self.fid,self.picshow_coverpic];
        
        [SqliteSet InsertFavouriteItem:sql];
        
        
        [collectionButton setImage:[UIImage imageNamed:@"ico10.png"] forState:UIControlStateNormal];
        
        
    }
    else
    {
        
        
        
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM FavouritePic where Picshow_id=%@  ",self.picshow_id ];
        
        [SqliteSet deleteFavouriteItem:sql];
        
        [collectionButton setImage:[UIImage imageNamed:@"ico8.png"] forState:UIControlStateNormal];
        
        
        
    }    
    
    [[NSNotificationCenter defaultCenter] postNotificationName: @"notifyToRefreshFavoriteNotification"
                                                        object: nil];
    
}
-(bool)isFavoritePic:(NSString *)picshow_id;
{
    
    return [SqliteSet queryFavouritePicAItem:[NSString stringWithFormat:@"%@",self.picshow_id]];
    
}
- (void)onClickImage:(UITapGestureRecognizer *)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notifytohideorshowall" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notifytohidenavbar" object:nil];
}
@end
