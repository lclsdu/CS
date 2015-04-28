//
//  NewPostViewController.m
//  化龙巷
//
//  Created by David Suen on 12-3-22.
//  Copyright (c) 2012年 Osugroup. All rights reserved.
//

#import "NewPostViewController.h"
#import "AppDelegate.h"
 
//#import "FaceScrollView.h"
#import "WEPopoverController.h"
#import "WEPopoverContentViewController.h"
#import "SubClassification.h"
@implementation NewPostViewController


 
//beta2

@synthesize selectIndexSubClassification;
@synthesize isRequired;
@synthesize imageAmount;
@synthesize cameraAmount;
@synthesize  imageButton;
@synthesize  cameraButton;
@synthesize keyboardButton;

@synthesize imageBadge; 
@synthesize cameraBadge; 

@synthesize popoverController;

@synthesize myFaceScrollView=_myFaceScrollView;

@synthesize tableView1;
@synthesize textView1;
@synthesize textField1;
@synthesize textField2;
@synthesize fid;
@synthesize api_url;

@synthesize subClassificationArray;
@synthesize subClassificationKeyArray;

@synthesize myDelegate, appDelegate;

@synthesize hasSubClassification;
@synthesize myRequest;
@synthesize networkStream;
@synthesize fileStream;
@synthesize bufferLimit,bufferOffset,forumtitle,imgname;

-(bool)checkIfHasRightToPost:(NSInteger)temfid;
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
            
            NSInteger tisreply=[[[forumlist_array objectAtIndex:i] objectForKey:@"ispost"] intValue];
            if(tisreply==0)
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

- (void)requestFailed:(ASIHTTPRequest *)request {
        [self.navigationItem.rightBarButtonItem setEnabled:true];
    
    //取消加载
//	if (_activityView ) {
//		[_activityView stopAnimating];
//		[_activityView removeFromSuperview];
//		_activityView = nil;
//		[_loadLabel removeFromSuperview];
//		_loadLabel = nil;
//        [_loadingView removeFromSuperview];
//        _loadLabel =nil;
//	}
    
    [myDelegate removeLoadingPatternIfNeed];
    
    
  //  if( isSubmitSuccess) return;
    
    UIAlertView *alert;
    NSError *error = [request error];
    if (error)
        alert = [[UIAlertView alloc] initWithTitle:@"链接错误" 
                                           message:@"暂时不能连接服务器" 
                                          delegate:self cancelButtonTitle:@"知道了" 
                                 otherButtonTitles:nil];
    [alert show];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
 
    
{
    
        isExitFromImagePicker=true;
    if(picker.sourceType==UIImagePickerControllerSourceTypePhotoLibrary)
    {
 
        // Access the uncropped image from info dictionary
        UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0]; 
        
        //???????????
        NSString *s;        
        
        
        
        
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
        
        cameraAmount=cameraAmount+1;
        
        
        cameraBadge.value=cameraAmount;
 
        
        [picker  dismissModalViewControllerAnimated:YES];
        
    }
    
    isExitFromImagePicker=true;
   	
}


#pragma mark -
#pragma mark BSKeyboardControls Delegate

 
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

-(void)newPost:(id)sender;
{
    
 
    NSString *s=[self removeNewlinesAndTabulation:[textField1 text] appending:false];
    
    
    if([s length]<1 )
    {
        
        UIAlertView *alert=[[UIAlertView alloc]
                            initWithTitle:@"标题不能为空"
                            
                            message:@""//\n\n\n\n"
                            delegate:self
                            cancelButtonTitle:@"知道了"
                            otherButtonTitles:nil,nil];
        
        
        //---------------------------------------------------------
        [alert show];
        [alert release];
        
        
        return;
    };
    if(isRequired) 
    {
        if(selectIndexSubClassification==-1)
        {
        UIAlertView *alert=[[UIAlertView alloc]
                            initWithTitle:@"必须选择分类"
                            
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
    else
    {         
//aaa
    };
    
    if([s length]>30 )
    {
        
        UIAlertView *alert=[[UIAlertView alloc]
                            initWithTitle:@"标题太长"
                            
                            message:@""//\n\n\n\n"
                            delegate:self
                            cancelButtonTitle:@"知道了"
                            otherButtonTitles:nil,nil];
        
        
        //---------------------------------------------------------
        [alert show];
        [alert release];
        
        
        return;
    }    
    
    
    NSString *s1=[self removeNewlinesAndTabulation:[textView1 text] appending:false];
    
    
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
        
        url=[NSURL URLWithString:[NSString stringWithFormat: @"%@topicpost.php?type=post&fid=%d&img=1",api_url,fid ]];
    }
    else {
        url=[NSURL URLWithString:[NSString stringWithFormat: @"%@topicpost.php?type=post&fid=%d",api_url,fid ]];
    }
    
    DebugLog(@"%@", url);
    
    ASIFormDataRequest  *request = [ASIFormDataRequest requestWithURL:url];
    
 
    NSDictionary *now = [NSKeyedUnarchiver unarchiveObjectWithFile:[documentsDirectory stringByAppendingPathComponent:@"nowlogin.plist"]];
    
    NSString* author  = [now objectForKey:@"username"];
    NSString* sessionid  = [now objectForKey:@"sessionid"];
    NSString* authorid  = [now objectForKey:@"uid"];
    
    
    //[request setPostValue:text forKey:@"subject"];
    [request setPostValue:author forKey:@"author"];
    [request setPostValue:authorid forKey:@"authorid"];  
       
       
       
    if(selectIndexSubClassification!=-1)
       
    {   
       
       //选择了就传
        DebugLog(@"%@", subClassificationKeyArray);
        [request setPostValue:[NSString stringWithFormat:@"%@",[subClassificationKeyArray objectAtIndex: selectIndexSubClassification]] forKey:@"typeid"];
       
    }
    else {
        int zerostr = 0;
        [request setPostValue:[NSString stringWithFormat:@"%d", zerostr] forKey:@"typeid"];
    }
    
    
    [request setPostValue:sessionid forKey:@"sid"];
    [request setPostValue:[textField1 text]  forKey:@"subject"]; //
    
    
    
 //\r\n\r\n来自iPhone客户端
    //message不必传这个话了,改为多传一个post字段
    
    [request setPostValue:@"i" forKey:@"status"];
    
    NSString * message=[NSString stringWithFormat:@"%@",[textView1 text]];
    [request setPostValue:message  forKey:@"message"];  
    
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
    
    if(selectIndexSubClassification!=-1) {
        DebugLog(@"1author-%@ 2authorid-%@  3sid-%@ 4subject-%@ 5message-%@ 6typeid-%@",author,authorid,sessionid, [textView1 text], message,[NSString stringWithFormat:@"%@",[subClassificationKeyArray objectAtIndex: selectIndexSubClassification]]);     
    } else {
        DebugLog(@"1author-%@ 2authorid-%@  3sid-%@ 4subject-%@ 5message-%@",author,authorid,sessionid, [textView1 text], message); 
    }
    
    
    
    
  //  [request setCachePolicy:ASIAskServerIfModifiedCachePolicy | ASIFallbackToCacheIfLoadFailsCachePolicy]; 
   //de [request setCachePolicy:ASIOnlyLoadIfNotCachedCachePolicy];
    
    [request setTag:1];
    [request setDelegate:self];
    [request setPersistentConnectionTimeoutSeconds:120];
    

   // isSubmitSuccess=false;
 
    [request startAsynchronous];
    
    //[request setFile:@"/Users/ben/Desktop/ben.jpg" forKey:@"photo"];
    
    
    //[self.navigationController popViewControllerAnimated:true];
    
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
//        if (self.networkStream != nil) {
//            [self.networkStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
//            self.networkStream.delegate = nil;
//            [self.networkStream close];
//            self.networkStream = nil;
//        }
//        if (self.fileStream != nil) {
//            [self.fileStream close];
//            self.fileStream = nil;
//        }
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
                bytesRead = [self.fileStream read:buffer maxLength:kSendBufferSize];
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
    [self.view addSubview:_activityView];cell
    [_activityView startAnimating];
    
    
    _loadLabel = [ViewTool addUILable:self.view x:135.0 y:118 x1:100 y1:20 fontSize:15 lableText:@"提交中..."];
    [_loadLabel setTextColor:[UIColor grayColor]];

     */
    //beta2
    
    
    if([request tag]==-1)
    {

        //取消加载
        
//        if (_activityView ) {
//            
//            [_activityView removeFromSuperview];
//            _activityView = nil;
//            [_loadLabel removeFromSuperview];
//            _loadLabel = nil;
//            
//            [_loadingView removeFromSuperview];
//            _loadingView=nil;
//            
//            
//            
//        }
        
        
        [myDelegate removeLoadingPatternIfNeed];
        
        //加载
//        
//        _loadingView=[[UIImageView alloc] initWithFrame:CGRectMake(90.0f, 70.0f,140.0f, 70.0f)];
//        _loadingView.image=[UIImage imageNamed:@"duqu.png"];
//        _loadingView.alpha=0.8;
//        [self.view addSubview:_loadingView];
//        
//        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
//        _activityView.frame = CGRectMake(110.0f, 92.0f, 20.0f, 20.0f);
//        [self.view addSubview:_activityView];
//        [_activityView startAnimating];
//        
//        //_loadLabel = [ViewTool addUILable:self.view x:140.0 y:158 x1:100 y1:20 fontSize:15 lableText:@"加载中..."];
//        _loadLabel = [ViewTool addUILable:self.view x:136.0 y:92 x1:100 y1:20 fontSize:15 lableText:@"读分类信息."];
//        
//        [_loadLabel setTextColor:[UIColor grayColor]];
        
        
        [myDelegate drawLoadingPattern:@"读取分类信息" isWithAnimation:NO];
    }
    else
    {
        
        //取消加载
        
//        if (_activityView ) {
//            
//            [_activityView removeFromSuperview];
//            _activityView = nil;
//            [_loadLabel removeFromSuperview];
//            _loadLabel = nil;
//            
//            [_loadingView removeFromSuperview];
//            _loadingView=nil;
//            
//        }
        
        [myDelegate removeLoadingPatternIfNeed];
        
        //加载
        
        
//        _loadingView=[[UIImageView alloc] initWithFrame:CGRectMake(90.0f, 70.0f,140.0f, 70.0f)];
//        _loadingView.image=[UIImage imageNamed:@"duqu.png"];
//        _loadingView.alpha=0.8;
//        [self.view addSubview:_loadingView];
//        
//        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
//        _activityView.frame = CGRectMake(110.0f, 92.0f, 20.0f, 20.0f);
//        [self.view addSubview:_activityView];
//        [_activityView startAnimating];
//        
//        //_loadLabel = [ViewTool addUILable:self.view x:140.0 y:158 x1:100 y1:20 fontSize:15 lableText:@"加载中..."];
//        _loadLabel = [ViewTool addUILable:self.view x:140.0 y:92 x1:100 y1:20 fontSize:15 lableText:@"提交中..."];
//        
//        [_loadLabel setTextColor:[UIColor grayColor]];
        
        [myDelegate drawLoadingPattern:@"提交中" isWithAnimation:NO];
        
    }
    
    
}
-(void)menuSelectionNotification:(NSNotification *)notification
{
    
    NSDictionary *dict = [notification userInfo];
 
   int index  =[[dict objectForKey:@"MenuIndex"] intValue ];
    selectIndexSubClassification=index;
   
    DebugLog(@"%d",selectIndexSubClassification);
    [tableView1 reloadData];
    
    [popoverController dismissPopoverAnimated:true];
    
}
- (void)requestFinished:(ASIHTTPRequest *)request {
        
    [self.navigationItem.rightBarButtonItem setEnabled:true];
    
    //取消加载
    
//    if (_activityView ) {
//		[_activityView removeFromSuperview];
//		_activityView = nil;
//		[_loadLabel removeFromSuperview];
//		_loadLabel = nil;
//        [_loadingView removeFromSuperview];
//        _loadLabel =nil;
//	}
    
    [myDelegate removeLoadingPatternIfNeed];
    /*
     
     发帖成功 code:200, result:post succ
     发帖失败 code:500, result:post failed
     回复成功 code:200, result:reply succ
     回复失败 code:200, result:reply failed
     错误 code:404
     
     */
    
    
    NSString *requestString = [[request responseString] stringByConvertingHTMLToPlainText];
    
    DebugLog(@"%@",requestString);
    if([request tag]==-1)
    {
        
        NSString *tems = [[requestString JSONValue] valueForKey:@"code"];
        
        DebugLog(@"%@",tems);
        
        
        if([tems isEqualToString:@"500"])
        //if([tmpArray count]==0)
        {
            //
            //donothing
            hasSubClassification=false;
                    
        }
        else
        {
            
            NSDictionary *tmpDictionary;
            NSArray *tmpArray; 
            tmpArray= [[requestString JSONValue] valueForKey:@"datas"];
            
            if ([tmpArray count]==0) return;
            hasSubClassification=true;
             
            
            /*
            NSString * jsonString = @"blblblblblb";
            NSStringEncoding  encoding;
            NSData * jsonData = [jsonString dataUsingEncoding:encoding];
            NSError * error=nil;
            NSDictionary * parsedData = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
            */
            /*
                DebugLog(@"%d", [tmpArray count]);
            NSString * jsonString = [tmpArray objectAtIndex:0];
            DebugLog(@"%@", jsonString);
            NSStringEncoding  encoding;
            NSData * jsonData = [jsonString dataUsingEncoding:NSASCIIStringEncoding];// [jsonString dataUsingEncoding:encoding];
            NSError * error=nil;
            NSDictionary * parsedData = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
            
         */
            
            DebugLog(@"%@", [[tmpArray objectAtIndex:0] objectForKey:@"required"]);
            
            if([ [[tmpArray objectAtIndex:0] objectForKey:@"required"] isEqualToString:@"yes"])
            {
                isRequired=true;
            }
            else
            {
                
                isRequired=false;
             
            }
            
            
            
            
            
            //[subClassificationArray removeAllObjects];
            NSArray * keys = [[tmpArray objectAtIndex:0] allKeys];
            NSArray * values = [[tmpArray objectAtIndex:0] allValues];
            
            for(int i=0;i<=[keys count]-1;i++)
            {
                if([[keys objectAtIndex:i] isEqualToString:@"required"])
                {
                    continue;
                }
                else
                {

                    [subClassificationArray addObject:[values objectAtIndex:i]];
                    [subClassificationKeyArray addObject:[keys objectAtIndex:i]];
                }
            }
            /*
            bool exitForce=false;
            int i=1;
            //[subClassificationArray removeAllObjects];
            while (!exitForce)
            {
                if([[tmpArray objectAtIndex:0] objectForKey:[NSString stringWithFormat:@"%d",i]]==nil)
                {
                    
                    break;
                }
                else
                    
                    
                    
                {
                    
                    
                    NSString *s= [[tmpArray objectAtIndex:0] objectForKey:[NSString stringWithFormat:@"%d",i]];
                   // s=[[tmpArray objectAtIndex:0] objectForKey:@"1"];
                    DebugLog(@"%@",s);
                    [subClassificationArray addObject:s];
                }
          
                i=i+1;      
           
            }
            
                     //   DebugLog(@"%@",[tmpArray objectForKey:@"required"]);
                            */
            
            [textView1 removeFromSuperview];
            //[textField1 removeFromSuperview];
            [textField2 removeFromSuperview];
            [tableView1 reloadData];
            
        }
        
        
        
        
    }
    else
    {
    
   
        //---------------------------------------------------------
        
        NSArray *tmpArray = [[requestString JSONValue] valueForKey:@"datas"];
        
        
        NSString *s = [[tmpArray objectAtIndex:0] valueForKey:@"result"];
        if([s isEqualToString:@"post succ"])
        {
            UIAlertView *alert=[[UIAlertView alloc]
                                initWithTitle:@"发帖成功"
                                
                                message:@""//\n\n\n\n"
                                delegate:self
                                cancelButtonTitle:@"知道了"
                                otherButtonTitles:nil,nil];
            
            
            //---------------------------------------------------------
            [alert show];
            [alert release];
        //    isSubmitSuccess=true;
            [self.navigationController popViewControllerAnimated:true];
            
            
            
            
            [[NSNotificationCenter defaultCenter] postNotificationName: @"notifyToReloadDetailNotification"
                                                                object: nil];
        }
        else  if([s isEqualToString:@"post failed"])
        {   
            UIAlertView *alert=[[UIAlertView alloc]
                                initWithTitle:@"发帖失败"
                                
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
                                initWithTitle:@"发帖失败"
                                
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
     
}


/* 
 * The "Done" button was pressed
 * We want to close the keyboard
 */
- (void)keyboardControlsDonePressed:(BSKeyboardControls *)controls
{
    [controls.activeTextField resignFirstResponder];
}

/* Either "Previous" or "Next" was pressed
 * Here we usually want to scroll the view to the active text field
 * If we want to know which of the two was pressed, we can use the "direction" which will have one of the following values:
 * KeyboardControlsDirectionPrevious        "Previous" was pressed
 * KeyboardControlsDirectionNext            "Next" was pressed
 */
 
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;
{
    
    
    
}
-(BOOL) textFieldShouldReturn:(UITextField *) textField
{
	
	
	[textField resignFirstResponder];
	
	
	return YES;
}
- (void)viewWillAppear:(BOOL)animated;  
{
    
     [self.navigationItem.rightBarButtonItem setEnabled:true];
    
    if(isExitFromImagePicker)
    {
        
        isExitFromImagePicker=false;
        return;
        
    }
    
   
    NSURL *requestURL;
    DebugLog(@"~~~~~~~~~~~~~ %d",fid);
    requestURL=[NSURL URLWithString:[NSString stringWithFormat: @"%@topicpost.php?type=thread_class&fid=%d", api_url ,fid   ]];
    
 

    DebugLog(@"%@",[NSString stringWithFormat: @"%@topicpost.php?type=thread_class&fid=%d", api_url ,fid   ]);
 
 	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL: requestURL ];
	[request setTag:-1];
    
    //_ equest=request;
    
    
	[request setDownloadCache:[ASIDownloadCache sharedCache]];
	[request setCachePolicy:ASIAskServerIfModifiedCachePolicy | ASIFallbackToCacheIfLoadFailsCachePolicy]; 
	[request setDelegate:self];
    [request setPersistentConnectionTimeoutSeconds:60];//_timeOut
 //  myRequest= [request retain];
    //_isWorkingASI=true;
	[request startAsynchronous];
    
}

- (void)viewWillDisAppear:(BOOL)animated;  
{
 
 /*

        for (ASIHTTPRequest *request in ASIHTTPRequest.sharedQueue.operations)
        {
            [request cancel];
            [request setDelegate:nil];
        }
       
*/
    
 
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
- (void)keyboardWillShow:(NSNotification *)notification {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:[[[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue]];
    [UIView setAnimationDuration:[[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone 
                                                                                target:self 
                                                                                action:@selector(keyboardDone)];
    NSMutableArray *toolbarItems = [NSMutableArray arrayWithArray:[toolbar items]];
    [toolbarItems addObject:doneButton];
    [toolbar setItems:toolbarItems];
    
    CGRect frame = self.view.frame;
    frame.size.height -= [[[notification userInfo] objectForKey:UIKeyboardBoundsUserInfoKey] CGRectValue].size.height;
    self.view.frame = frame;
    [UIView commitAnimations];
    
    
}*/
- (void)viewDidLoad
{
    NSLog(@"%@",imgname);
    [self setMyDelegate:self.tabBarController]; 
    [[self navigationItem] setTitle: forumtitle];       
    isExitFromImagePicker=false;
    
    selectIndexSubClassification=-1;
    subClassificationArray=[[NSMutableArray alloc] init];
    subClassificationKeyArray=[[NSMutableArray alloc] init];

  //  subClassificationArray=a;
  //  [a release];
    
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    api_url = delegate.myDomainAndPathVeryNC;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithTitle:@"发布"
                                                                  style:UIBarButtonItemStyleBordered
                                                                 target:self
                                                                 action:@selector(newPost:)];
    self.navigationItem.rightBarButtonItem = barButton;
  [barButton release];
    UIBarButtonItem *leftbarButton = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                                  style:UIBarButtonItemStyleBordered
                                                                 target:self
                                                                 action:@selector(backtopostmain)];
    self.navigationItem.leftBarButtonItem = leftbarButton;
    [leftbarButton release];
    
    //beta2
    
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
    

    
      
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuSelectionNotification:) name:@"notifyToMenuSelectionNotification" object:nil];
    
 //   [tableView1 reloadData];
 
  
        
}
- (void)backtopostmain
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidUnload
{
  //  [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [self.popoverController dismissPopoverAnimated:NO];
	self.popoverController = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(void)dealloc{
     //   [_textField release];
    
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"notifyToMenuSelectionNotification" object:nil];
    
    [myFaceScrollView release];
    [textField1 release];
    [textField2 release];
    
    [textView1 release];
    [tableView1 release];
   // [keyboardControls release];
    [self.popoverController dismissPopoverAnimated:NO];
	self.popoverController = nil;
    
    
 
        [myRequest release];
 
        
      

	[super dealloc];
}
#pragma mark -
#pragma mark Table View Data Source Methods

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView 

{
	return 2;
} 


- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section
{
	
    if(section==0)
    {
         //return 2;
        if(hasSubClassification) 
            return 2;
        else 
            return 1;
    } 
    else
	return 1;
}





- (CGFloat)tableView:(UITableView *)tableView 
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(indexPath.section==0)
        return 40.0f;//cell height
	else
	
        return 260.0f;//cell height
	
	
	
}
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
// waiting for update   
//        isRunningImagePickerController=true;
    if(_myFaceScrollView)[_myFaceScrollView setHidden:true];
 
                [keyboardButton setEnabled:false];
    /*
    UIAlertView *alert=[[UIAlertView alloc]
                        initWithTitle:@"暂时无此功能"
                        
                        message:@""//\n\n\n\n"
                        delegate:self
                        cancelButtonTitle:@"知道了"
                        otherButtonTitles:nil,nil];
    
    
    //---------------------------------------------------------
    [alert show];
    [alert release];
    
    
    return;
     */
   
        UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
        
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        ipc.delegate = self;
        
        ipc.allowsEditing = YES;
        
        [self presentModalViewController:ipc animated:YES];
   
   
 
    
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
                [keyboardButton setEnabled:true];
    // waiting for update  
//    isRunningImagePickerController=true;
    /*
    UIAlertView *alert=[[UIAlertView alloc]
                        initWithTitle:@"暂时无此功能"
                        
                        message:@""//\n\n\n\n"
                        delegate:self
                        cancelButtonTitle:@"知道了"
                        otherButtonTitles:nil,nil];
    
    
    //---------------------------------------------------------
    [alert show];
    [alert release];
    
    
    return;
     */
    ///>>>>>>>>>>>>>>>
    UIImagePickerController *picker=[[UIImagePickerController alloc]init];
    picker.delegate=self;
    picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    picker.allowsImageEditing = YES;
    
    
    
    
    
    //aUIImagePickerController=picker;
 
    
    [self.parentViewController presentModalViewController: picker animated:NO];
    
   // [aUIImagePickerController release];
 
    
    
}
-(void)launchFace:(id)sender;
{
    
    UIWindow * tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1]; 
    UIView* keyboard; 
    
    
    
    //if(_myFaceScrollView==nil)
    //{   
        
        
        
        
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
                    //faceScrollView.contentSize = CGSizeMake(320*4, 220);
                    [keyboard addSubview:faceScrollView];
                    _myFaceScrollView=faceScrollView;
                    faceScrollView.hidden=false;
                }
                break;
                
            }
            
        }
        
    //}
    
    
 
    
    
    [keyboardButton setEnabled:true];
    
    if(_myFaceScrollView)[_myFaceScrollView setHidden:false];
    
 
  
}
-(void)displayKeyboard:(id)sender;
{
    [keyboardButton setEnabled:false];
    
    if(_myFaceScrollView)[_myFaceScrollView setHidden:true];
    
    // [textView1 becomeFirstResponder];
} 
-(void)expressionClickWith:(FaceView *)faceView faceName:(NSString *)name
{
    
    //NSMutableString *s=[
    textView1.text =[NSString stringWithFormat:@"%@%@",[textView1 text],name];
    
    
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController*)picker{
    
  
  
    
	//[self  dismissModalViewControllerAnimated:YES];
//[picker.presentingViewController dismissModalViewControllerAnimated:YES];
  [picker dismissModalViewControllerAnimated:YES];
	
}
 - (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{	
    
    
    
    static NSString *SimpleTableIdentifier1 = @"CellTableIdentifier";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier: SimpleTableIdentifier1 ];
    
    if  (cell == nil) 
    {
        
        CGRect cellframe=CGRectMake(0, 0, 280, 60);
        cell=[[[UITableViewCell alloc] initWithFrame:cellframe// CGRectZero//SimpleTableIdentifier1
               
                                     reuseIdentifier:SimpleTableIdentifier1] autorelease];
        
        
        if(indexPath.section==0)
        {
           /// if(hasSubClassification) 
           
           // {
            
                if(indexPath.row==0)
                    
                {
                    UILabel *a2=[[UILabel alloc]initWithFrame:CGRectMake(10.0f,10.0f,50.0f,20.0f)];
                    
                    [a2 setTag:805];
                    
                    
                    [a2 setText:@"标题:"];
                    
                    
                    
                    [a2 	setTextAlignment:UITextAlignmentLeft];	
                    
 
                    
                    [cell.contentView addSubview:a2];
                    
                    [a2 release]; 
                    
                    
                    
                    
                    
                    UITextField *a=[[UITextField alloc]initWithFrame:CGRectMake(60.0f,10.0f,220.0f,20.0f)];
                    
                    textField1=a;
                    
                    
                    [textField1	setTextAlignment:UITextAlignmentLeft];	
                    
                    //  textField1.keyboardType =UIKeyboardAppearanceAlert;
                    [textField1 setBackgroundColor:[UIColor clearColor]];
                    //  textField1.keyboardAppearance= UIKeyboardAppearanceAlert; 
                    
                    
                    textField1.clearButtonMode= UITextFieldViewModeWhileEditing ;
                    [textField1  setFont:[UIFont fontWithName:@"ArialMT" size:16]];
                    //  [textField1 becomeFirstResponder];
                    [cell.contentView addSubview:textField1];
                    //[textView becomeFirstResponder];
                    [a release]; 
                    
                    cell.textLabel.text= @"" ;
                }
                else
                {
                    cell.textLabel.text=@"分类:";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                }

            //}
            
            
        }
        
        
        else 
        {
        
        
            DebugLog(@"333333333");
        
            //beta2
            
            UITextView *a=[[UITextView alloc]initWithFrame:CGRectMake(10.0f,10.0f,280.0f,280.0f)];
            
            textView1=a;
            //-------------------
            UIToolbar * myToolbar = [[UIToolbar alloc]  initWithFrame:CGRectMake(60.0f,20.0f,220.0f,30.0f)];
 
            
            NSMutableArray *barItems = [[NSMutableArray alloc] init];
            
 
            
            
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
            cameraBadge = badge;
            
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
            
            [keyboardBtn release];
            
            
            
            
            UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
            [barItems addObject:flexSpace];
            
            [flexSpace release];
            
            
            [myToolbar setItems:barItems animated:YES];
 
            textView1.inputAccessoryView = myToolbar;
 
            
            [textView1 setDelegate:self];
 
            
            [myToolbar release];
            
            
            
            //-------------------
            
            [textView1 	setTextAlignment:UITextAlignmentLeft];	
            
            textView1.keyboardAppearance=UIKeyboardAppearanceAlert; 
            [textView1 setBackgroundColor:[UIColor clearColor]];
            [textView1  setFont:[UIFont fontWithName:@"ArialMT" size:16]];
            
            [cell.contentView addSubview:textView1];
            
            
         // [a release];
          ///  [barItems release];
                    
             cell.textLabel.text= @"" ;
        }
        
        
            
        
    }
	
	
    
    [cell  setBackgroundColor:[UIColor whiteColor]];
    
    if((indexPath.section==0)&&(indexPath.row==1))
 
    {
        
        
        if(selectIndexSubClassification!=-1)
        {
            
            cell.textLabel.text=[NSString stringWithFormat:@"分类: %@",[subClassificationArray objectAtIndex:selectIndexSubClassification] ];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;  
        }
            

        else
        {
            if(hasSubClassification)
            {
                if (isRequired) {
                    cell.textLabel.text= @"分类: 可选择(必选)";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;                      
                } else {
                    cell.textLabel.text= @"分类: 请选择(非必选)";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;                      
                }

            
            }
            else
            {     
            cell.textLabel.text= @"分类: 无分类";
            cell.accessoryType = UITableViewCellAccessoryNone;  
            }
           
        }
           
        
    }
     
    return cell;
    
    
	
 	
}
//#pragma mark -
//#pragma mark Table Delegate Methods1 
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView;
{
    
    [tableView1 setContentOffset:CGPointMake(0,80) animated:YES];
    
    return true;
    
}
 

- (WEPopoverContainerViewProperties *)improvedContainerViewProperties {
	
	WEPopoverContainerViewProperties *props = [[WEPopoverContainerViewProperties alloc] autorelease];
	NSString *bgImageName = nil;
	CGFloat bgMargin = 0.0;
	CGFloat bgCapSize = 0.0;
	CGFloat contentMargin = 4.0;
	
	bgImageName = @"popoverBg.png";
	
	// These constants are determined by the popoverBg.png image file and are image dependent
	bgMargin = 13; // margin width of 13 pixels on all sides popoverBg.png (62 pixels wide - 36 pixel background) / 2 == 26 / 2 == 13 
	bgCapSize = 31; // ImageSize/2  == 62 / 2 == 31 pixels
	
	props.leftBgMargin = bgMargin;
	props.rightBgMargin = bgMargin;
	props.topBgMargin = bgMargin;
	props.bottomBgMargin = bgMargin;
	props.leftBgCapSize = bgCapSize;
	props.topBgCapSize = bgCapSize;
	props.bgImageName = bgImageName;
	props.leftContentMargin = contentMargin;
	props.rightContentMargin = contentMargin - 1; // Need to shift one pixel for border to look correct
	props.topContentMargin = contentMargin; 
	props.bottomContentMargin = contentMargin;
	
	props.arrowMargin = 4.0;
	
	props.upArrowImageName = @"popoverArrowUp.png";
	props.downArrowImageName = @"popoverArrowDown.png";
	props.leftArrowImageName = @"popoverArrowLeft.png";
	props.rightArrowImageName = @"popoverArrowRight.png";
	return props;	
}
- (void)tableView:(UITableView *)tableView 
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        if(indexPath.row==0)
        {
            //NSLog(@"click title");
            [tableView1 deselectRowAtIndexPath:indexPath animated:YES];
            [textField1 becomeFirstResponder];
            
        }
        else
        {
            //NSLog(@"click class");
            if(hasSubClassification==false) return;

            [tableView1 deselectRowAtIndexPath:indexPath animated:YES];
            [textField1 resignFirstResponder];
            [textView1 resignFirstResponder];
            
         
            //UIViewController
            WEPopoverContentViewController*contentViewController = [[WEPopoverContentViewController alloc] initWithStyle:UITableViewStylePlain  ];
            contentViewController.arrayCount=[subClassificationArray count];
           
            for(int i=0;i<[subClassificationArray count];i++)
            {
            
                [contentViewController.itemArray addObject:[subClassificationArray objectAtIndex:i]];
           
                
            }
    
            [contentViewController reloadTableView];
            
            
            
           // contentViewController.itemArray=a;
            
            self.popoverController = [[[WEPopoverController alloc] initWithContentViewController:contentViewController] autorelease];
            
            
            
            
            if ([self.popoverController respondsToSelector:@selector(setContainerViewProperties:)]) {
                [self.popoverController setContainerViewProperties:[self improvedContainerViewProperties]];
            }
            
            
            
            		CGRect frame = [tableView cellForRowAtIndexPath:indexPath].frame;
            [self.popoverController presentPopoverFromRect: frame// CGRectMake(0,0,200,150)
                                                    inView:self.view 
                                  permittedArrowDirections:UIPopoverArrowDirectionUp
                                                  animated:YES];
            [contentViewController release];
            //   [button setTitle:@"Hide Popover" forState:UIControlStateNormal];
            
           /*
            
            UIViewController *contentViewController = [[WEPopoverContentViewController alloc] initWithStyle:UITableViewStylePlain];
            CGRect frame = [tableView cellForRowAtIndexPath:indexPath].frame;
            //double percentage =  (rand() / ((double)RAND_MAX));
            //double percentage = 0.95;
            //CGRect rect = CGRectMake(frame.size.width * percentage, frame.origin.y, 1, frame.size.height); 
            CGRect rect = frame;
            
            self.popoverController = [[[popoverClass alloc] initWithContentViewController:contentViewController] autorelease];
            
            if ([self.popoverController respondsToSelector:@selector(setContainerViewProperties:)]) {
                [self.popoverController setContainerViewProperties:[self improvedContainerViewProperties]];
            }
            
            self.popoverController.delegate = self;
            
            //Uncomment the line below to allow the table view to handle events while the popover is displayed.
            //Otherwise the popover is dismissed automatically if a user touches anywhere outside of its view.
            
            self.popoverController.passthroughViews = [NSArray arrayWithObject:self.tableView];
            
            [self.popoverController presentPopoverFromRect:rect  
                                                    inView:self.view 
                                  permittedArrowDirections:(UIPopoverArrowDirectionUp|UIPopoverArrowDirectionDown|
                                                            UIPopoverArrowDirectionLeft|UIPopoverArrowDirectionRight)
                                                  animated:YES];
            currentPopoverCellIndex = indexPath.row;
            
            [contentViewController release];
            
 
            */
        }
        
    }
    if(indexPath.section==1)
    {
        //NSLog(@"click content");
        [tableView1 deselectRowAtIndexPath:indexPath animated:YES];
        [textView1 becomeFirstResponder];
        
    }
}



@end
