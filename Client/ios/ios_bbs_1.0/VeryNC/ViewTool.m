//
//  viewTool.m
//  LingNan HD
//
//  Created by osu on 11-1-28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewTool.h"

@implementation ViewTool
//在父亲视图fview加入UIImageview
+(UIImageView *)addUIImageView:(UIView *)fview imageName:(NSString*)iname  type:(NSString *)itype x:(float)x y:(float)y x1:(float)x1 y1:(float)y1{	
	UIImageView *i=[[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:iname ofType:itype]]];
	i.frame=CGRectMake(x, y, x1, y1);
	[fview addSubview:i];
	[i release];
	return	i;
}
 

+(UIImageView *)addUIImageView:(UIView *)fview imageName:(NSString*)iname  x:(float)x y:(float)y x1:(float)x1 y1:(float)y1 docPath:(NSString *)docPath{	
	UIImageView *i=[[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:[docPath stringByAppendingPathComponent:iname]]];
	i.frame=CGRectMake(x, y, x1, y1);
	[fview addSubview:i];
	[i release];
	return	i;
}

+(UIImageView *)addUIImageViewWithPath:(UIView *)fview imageName:(NSString*)iname  x:(float)x y:(float)y x1:(float)x1 y1:(float)y1{	
	UIImageView *i=[[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:iname]];
	i.frame=CGRectMake(x, y, x1, y1);
	[fview addSubview:i];
	[i release];
	return	i;
}

+(UIView *)addUIView:(UIView *)fview   x:(float)x y:(float)y x1:(float)x1 y1:(float)y1 {	
	UIView  *view =[[UIView alloc] initWithFrame:CGRectMake(x, y, x1, y1)] ;
	[fview addSubview:view];
	[view release];
	return	view;
}
//
//+(UIImageView *)addUIImageViewWithThread:(UIView *)fview imageName:(NSString*)iname  type:(NSString *)itype x:(float)x y:(float)y x1:(float)x1 y1:(float)y1{	
////	UIImageView *i=[[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:iname ofType:itype]]];
//	//i.frame=CGRectMake(x, y, x1, y1);
//	
//	[fview addSubview:i];
//	[i release];
//	return	i;
//}


//在父亲视图fview加入UIButton
+(UIButton *)addUIButton:(UIView *)fview imageName:(NSString*)iname  type:(NSString *)itype x:(float)x y:(float)y x1:(float)x1 y1:(float)y1
{	
	UIButton *b=[[UIButton alloc] initWithFrame:CGRectMake(x, y, x1, y1)];
	 [b setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:iname ofType:itype]] forState:UIControlStateNormal];			
	[fview addSubview:b];
	//[b addTarget:self action:@selector(m) forControlEvents:UIControlEventTouchUpInside];
	[b release];
	return	b;
}

+(UIButton *)addUIButtonWithSize:(UIView *)fview imageName:(NSString*)iname  type:(NSString *)itype x:(float)x y:(float)y x1:(float)x1 y1:(float)y1
{	
	UIButton *b=[[UIButton alloc] initWithFrame:CGRectMake(x, y, x1, y1)];
	UIImage *image =[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:iname ofType:itype]];
	b.frame =CGRectMake(x, y, image.size.width, image.size.height);
	[b setBackgroundImage:image forState:UIControlStateNormal];			
	[fview addSubview:b];
		//[b addTarget:self action:@selector(m) forControlEvents:UIControlEventTouchUpInside];
	[b release];
	return	b;
}


+(UIButton *)addUIButtonWithPath:(UIView *)fview imageName:(NSString*)iname  x:(float)x y:(float)y x1:(float)x1 y1:(float)y1
{	
	UIButton *b=[[UIButton alloc] initWithFrame:CGRectMake(x, y, x1, y1)];
	[b setBackgroundImage:[UIImage imageWithContentsOfFile:iname] forState:UIControlStateNormal];			
	[fview addSubview:b];
	[b release];
	return	b;
}

+(void)addArrayOfButtonViewAtPathAutoSize:(NSArray *)imagesNameArray fatherView:(UIView *)view lieShu:(int)lieshu  Imagewidth:(int)width  ImageHeight:(int)height jianGeKuan:(int)jiangegekuan jianGeGao:(int)jiangegao Top:(int)top Left:(int)left target:(id)target action:(SEL)action{
	for (int i=0; i<[imagesNameArray count]; i++) {
		DebugLog(@"1212%@  %d",[imagesNameArray objectAtIndex:i],i);
		UIButton *b =[ViewTool addUIButtonWithPath:view imageName:[imagesNameArray objectAtIndex:i] x:left+(i%lieshu)*(width+jiangegekuan) y:top+(i/lieshu)*(height+jiangegao) x1:width y1:height];
		[b addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
		b.frame =CGRectMake(b.frame.origin.x,top+(i/lieshu)*(height+jiangegao)+(width-width/(b.currentBackgroundImage.size.width/b.currentBackgroundImage.size.height))/2, width, width/(b.currentBackgroundImage.size.width/b.currentBackgroundImage.size.height));
		
		b.tag=i;
	}
}

//移动view动画
+(void) animatedView:(UIView*)v  time:(float)t alpha:(float)a  x:(float)x y:(float)y x1:(float)x1 y1:(float)y1 {
	[UIView beginAnimations:@"animationID" context:nil];
	[UIView setAnimationDuration:t];
	v.frame =  CGRectMake(x, y, x1, y1);
	v.alpha=a;
	[UIView commitAnimations];
}

//加入UILable
+(UILabel *)addUILable:(UIView *)fview  x:(float)x y:(float)y x1:(float)x1 y1:(float)y1 fontSize:(int)size  lableText:(NSString*)text {
	UIFont *font =[UIFont fontWithName:@"Helvetica" size:size];
	UILabel *l=[[UILabel alloc] initWithFrame:CGRectMake(x, y, x1, y1)];
	l.backgroundColor =[UIColor clearColor];
	l.textColor = [UIColor blackColor];
	l.numberOfLines = 1;		
	l.font=font;
	l.text=text;
	[l setTextAlignment:UITextAlignmentLeft];
	[fview addSubview:l];
	[l release];
	return l;
}
 
//加入UITextFile
+(UITextField *)addUITextFile:(UIView *)fview  x:(float)x y:(float)y x1:(float)x1 y1:(float)y1  {
	UITextField *tf=[[UITextField alloc] initWithFrame:CGRectMake(x, y, x1, y1)];
	tf.backgroundColor =[UIColor clearColor];	
	//	UITextBorderStyleNone,
	//    UITextBorderStyleLine,
	//    UITextBorderStyleBezel,
	//    UITextBorderStyleRoundedRect
	tf.borderStyle=UITextBorderStyleRoundedRect;
	[fview addSubview:tf];
	[tf release];
	return tf;
}


+(UITextView *)addUITextView:(UIView *)fview  x:(float)x y:(float)y x1:(float)x1 y1:(float)y1 fontSize:(int)size Text:(NSString*)text {
	UITextView *tf=[[UITextView alloc] initWithFrame:CGRectMake(x, y, x1, y1)];
    UIFont *font =[UIFont fontWithName:@"Helvetica" size:size];
    tf.font=font;
	tf.backgroundColor =[UIColor clearColor];	
	//	UITextBorderStyleNone,
	//    UITextBorderStyleLine,
	//    UITextBorderStyleBezel,
	//    UITextBorderStyleRoundedRect
	//tf.borderStyle=UITextBorderStyleRoundedRect;
	tf.text = text;
	[fview addSubview:tf];
	[tf release];
	return tf;
}
//加入UIScrollView
+(UIScrollView *)addUIScrollView:(UIView *)fview imageNum:(int)num x:(float)x y:(float)y x1:(float)x1 y1:(float)y1 {
	UIScrollView *scroll =[[UIScrollView alloc] initWithFrame:CGRectMake(x, y, x1, y1)];
	scroll.contentSize =CGSizeMake(x1, y1*num);
	scroll.pagingEnabled=YES;
	[scroll setBackgroundColor:[UIColor blackColor]];
	[fview addSubview:scroll];
	[scroll release];	
	return scroll;
}


//获取image
+(UIImage*)getPngImageAtBundle:(NSString *)name{
	UIImage *i;	
	i=[UIImage imageWithContentsOfFile:[FileTool getBundlePath:name type:@"png"]];
	return i;
}

//加入视频并播放
+(MPMoviePlayerController *)addMovie:(UIView *)fview target:(id)target movieName:(NSString *)name type:(NSString *)type {
	MPMoviePlayerController *movieplayer;
	NSString *path = [FileTool getBundlePath:name type:type];
	
	[[NSNotificationCenter defaultCenter] addObserver:target 
											 selector:@selector(myMovieFinishedCallback:) 
												 name:MPMoviePlayerPlaybackDidFinishNotification 
											   object:movieplayer]; 
	
//	[[NSNotificationCenter defaultCenter] addObserver:self 
//											 selector:@selector(myMovieExitFullScreen:) 
//												 name:MPMoviePlayerDidExitFullscreenNotification 
//											   object:movieplayer]; 
	
	movieplayer = [[MPMoviePlayerController alloc] initWithContentURL: [NSURL fileURLWithPath:path]]; 
	
	
	movieplayer.controlStyle =MPMovieControlStyleEmbedded;
//	movieplayer.scalingMode = MPMovieScalingModeAspectFill;
	movieplayer.view.frame = CGRectMake(0, 0, 768, 1024);
	[movieplayer setFullscreen:NO];
 	[fview addSubview:movieplayer.view];
	[movieplayer play];
	
	return movieplayer;

}

	//加入视频并播放
+(MPMoviePlayerController *)addMovieAtDoc:(UIView *)fview target:(id)target movieName:(NSString *)name type:(NSString *)type {
	MPMoviePlayerController *movieplayer;
 	
	[[NSNotificationCenter defaultCenter] addObserver:target 
											 selector:@selector(myMovieFinishedCallback:) 
												 name:MPMoviePlayerPlaybackDidFinishNotification 
											   object:movieplayer]; 
	
 
	
	movieplayer = [[MPMoviePlayerController alloc] initWithContentURL: [NSURL fileURLWithPath:name]]; 
	
	
	movieplayer.controlStyle =MPMovieControlStyleEmbedded;
		//	movieplayer.scalingMode = MPMovieScalingModeAspectFill;
	movieplayer.view.frame = CGRectMake(0, 0, 768, 1024);
	[movieplayer setFullscreen:NO];
 	[fview addSubview:movieplayer.view];
	[movieplayer play];
	
	return movieplayer;
	
}

//画圆
+(void)calcCircleV:(UIImageView*)object Vertical:(float)y YuanX:(float)heng YuanY:(float)zong Radius:(float)radius SizeC:(int)chang SizeK:(int)kuang{
	radius = radius*radius;
	[object	setFrame:CGRectMake(sqrt(radius-pow(y-zong, 2) + heng), y, chang, kuang)];
	DebugLog(@"%.2f   %.2f",y,sqrt(radius-pow(y-zong, 2) + heng));
}

+(void)calcCircleH:(UIImageView*)object Vertical:(float)x YuanX:(float)heng YuanY:(float)zong Radius:(float)radius SizeC:(int)chang SizeK:(int)kuang{
	radius = radius*radius;
	[object	setFrame:CGRectMake(x, zong - sqrt(radius-pow(x- heng, 2)), chang, kuang)];
	DebugLog(@"%.2f   %.2f",x,sqrt(radius-pow(x-heng, 2) + zong));
}

+(void)myMovieFinishedCallback:(NSNotification *)aNotification movieplayer:(MPMoviePlayerController*)movieplayer target:(id)target
{	DebugLog(@" myMovieFinishedCallback");
	float version = [[[UIDevice currentDevice] systemVersion] floatValue];
	if (version >= 4.2)
	{
		[[NSNotificationCenter defaultCenter] removeObserver:target 
														name:MPMoviePlayerPlaybackDidFinishNotification 
													  object:movieplayer]; 
		
		[movieplayer.view removeFromSuperview];
		movieplayer = nil;
		[movieplayer release]; 
	}
	
	if (version < 4.2||version > 3.2)
	{	
		[[NSNotificationCenter defaultCenter] removeObserver:target 
														name:MPMoviePlayerPlaybackDidFinishNotification 
													  object:movieplayer]; 
		
		[movieplayer.view removeFromSuperview];
		movieplayer = nil;
		[movieplayer release]; 
		
	}
}


+(void)myMovieExitFullScreen:(NSNotification *)aNotification movieplayer:(MPMoviePlayerController*)movieplayer target:(id)target

{	 
	DebugLog(@" myMovieExitFullScreen");
	float version = [[[UIDevice currentDevice] systemVersion] floatValue];
	if (version >= 4.2)
	{	[movieplayer stop];
		[[NSNotificationCenter defaultCenter] removeObserver:target 
														name:MPMoviePlayerPlaybackDidFinishNotification 
													  object:movieplayer]; 
		
		//[movieplayer.view removeFromSuperview];
		
		movieplayer = nil;
		[movieplayer release]; 
	}
	
	if (version < 4.2||version > 3.2)
	{
		[[NSNotificationCenter defaultCenter] removeObserver:target 
														name:MPMoviePlayerPlaybackDidFinishNotification 
													  object:movieplayer]; 
		[movieplayer stop];
		[movieplayer.view removeFromSuperview];
		movieplayer = nil;
		[movieplayer release]; 
		
	}
}

+(void)addArrayOfImageViewAtBundle:(NSArray *)imagesNameArray fatherView:(UIView *)view lieShu:(int)lieshu  Imagewidth:(int)width  ImageHeight:(int)height jianGeKuan:(int)jiangegekuan jianGeGao:(int)jiangegao Top:(int)top Left:(int)left{

	for (int i=0; i<[imagesNameArray count]; i++) {
			DebugLog(@"1212%@  %d",[imagesNameArray objectAtIndex:i],i);
			[ViewTool addUIImageView:view imageName:[imagesNameArray objectAtIndex:i] type:@"" x:left+(i%lieshu)*(width+jiangegekuan) y:top+(i/lieshu)*(height+jiangegao) x1:width y1:height];
		}
} 

+(void)addArrayOfImageViewAtPath:(NSArray *)imagesNameArray fatherView:(UIView *)view lieShu:(int)lieshu  Imagewidth:(int)width  ImageHeight:(int)height jianGeKuan:(int)jiangegekuan jianGeGao:(int)jiangegao Top:(int)top Left:(int)left{
	for (int i=0; i<[imagesNameArray count]; i++) {
		DebugLog(@"1212%@  %d",[imagesNameArray objectAtIndex:i],i);
		[ViewTool addUIImageViewWithPath:view imageName:[imagesNameArray objectAtIndex:i]  x:left+(i%lieshu)*(width+jiangegekuan) y:top+(i/lieshu)*(height+jiangegao) x1:width y1:height];
	}
} 

+(void)addArrayOfButtonViewAtBundle:(NSArray *)imagesNameArray fatherView:(UIView *)view lieShu:(int)lieshu  Imagewidth:(int)width  ImageHeight:(int)height jianGeKuan:(int)jiangegekuan jianGeGao:(int)jiangegao Top:(int)top Left:(int)left target:(id)target action:(SEL)action{
	for (int i=0; i<[imagesNameArray count]; i++) {
 
		UIButton *b =[ViewTool addUIButton:view imageName:[imagesNameArray objectAtIndex:i] type:@"" x:left+(i%lieshu)*(width+jiangegekuan) y:top+(i/lieshu)*(height+jiangegao) x1:width y1:height];
		[b addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
		b.tag=i;
	}
}

+(void)addArrayOfButtonViewAtPath:(NSArray *)imagesNameArray fatherView:(UIView *)view lieShu:(int)lieshu  Imagewidth:(int)width  ImageHeight:(int)height jianGeKuan:(int)jiangegekuan jianGeGao:(int)jiangegao Top:(int)top Left:(int)left target:(id)target action:(SEL)action{
	for (int i=0; i<[imagesNameArray count]; i++) {
		UIButton *b =[ViewTool addUIButtonWithPath:view imageName:[imagesNameArray objectAtIndex:i] x:left+(i%lieshu)*(width+jiangegekuan) y:top+(i/lieshu)*(height+jiangegao) x1:width y1:height];
		[b addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
		b.tag=i;
	}
}

	//放大缩小image;
+(UIImage *)setImageScale:(UIImage *)img size:(CGSize)c
{
    UIGraphicsBeginImageContext(c);
    [img drawInRect:CGRectMake(0, 0, c.width, c.height)];
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//图像播放gif
+(void)addGifImageView:(NSArray *)imageArray fatherView:(UIView *)view Time:(float)time  x:(float)x y:(float)y x1:(float)x1 y1:(float)y1{
	
	UIImageView *myAnimatedView = [UIImageView alloc];  //创建一个UIImageView对象  
	[myAnimatedView initWithFrame:CGRectMake(x, y, x1, y1)];  //初始化UIImageView对象的大小
	
	
	
	myAnimatedView.animationImages = imageArray;  //animationImages属性返回一个存放动画图片的数组  
	myAnimatedView.animationDuration = time;   //浏览整个图片一次所用的时间  
	myAnimatedView.animationRepeatCount =1;   // 0 = loops forever 动画重复次数  
	[myAnimatedView startAnimating]; //开始动画   
	[view addSubview:myAnimatedView];  //把该UIImageView对象添加到view视图中 
	[myAnimatedView release];  //释放  
}

+(UIImageView *)addGifImageView2:(NSArray *)imageArray fatherView:(UIView *)view Time:(float)time  x:(float)x y:(float)y x1:(float)x1 y1:(float)y1{
	
	UIImageView *myAnimatedView = [UIImageView alloc];  //创建一个UIImageView对象  
	[myAnimatedView initWithFrame:CGRectMake(x, y, x1, y1)];  //初始化UIImageView对象的大小
	
	
	
	myAnimatedView.animationImages = imageArray;  //animationImages属性返回一个存放动画图片的数组  
	myAnimatedView.animationDuration = time;   //浏览整个图片一次所用的时间  
	myAnimatedView.animationRepeatCount =1;   // 0 = loops forever 动画重复次数  
	[myAnimatedView startAnimating]; //开始动画   
	[view addSubview:myAnimatedView];  //把该UIImageView对象添加到view视图中 
	[myAnimatedView release];  //释放  
	return myAnimatedView;
}

+(UIImageView *)addUIImageViewWithAutoSizeAndPath:(UIView *)fview imagePath:(NSString*)iname x:(float)x y:(float)y{	
	UIImage	*image = [UIImage imageWithContentsOfFile:iname];
	UIImageView *i=[[UIImageView alloc] initWithImage:image];
	i.frame=CGRectMake(x, y, image.size.width, image.size.height);
	[fview addSubview:i];
	[i release];
	return	i;
}

+(UIImageView *)addUIImageViewWithAutoSize:(UIView *)fview imageName:(NSString*)iname  type:(NSString *)itype x:(float)x y:(float)y x1:(float)x1 y1:(float)y1{	
	UIImage	*image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:iname ofType:itype]];
	UIImageView *i=[[UIImageView alloc] initWithImage:image];
	i.frame=CGRectMake(x, y, image.size.width, image.size.height);
	[fview addSubview:i];
	[i release];
	return	i;
}

+(UIButton *)addUIButtonWithAutoSize:(UIView *)fview imageName:(NSString*)iname  type:(NSString *)itype x:(float)x y:(float)y x1:(float)x1 y1:(float)y1
{	
	UIButton *b=[[UIButton alloc] initWithFrame:CGRectMake(x, y, x1, y1)];
	UIImage *image =[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:iname ofType:itype]];
	b.frame =CGRectMake(x, y, image.size.width, image.size.height);
	[b setBackgroundImage:image forState:UIControlStateNormal];			
	[fview addSubview:b];
		//[b addTarget:self action:@selector(m) forControlEvents:UIControlEventTouchUpInside];
	[b release];
	return	b;
}
 
+(void)addUIProgressview:(UIView*)fview x:(float)x y:(float)y x1:(float)x1 y1:(float)y1{
	 
}
	//+(void)autoResizeImage:(UIImageView*)scimage  Width:(int)width Height:(int)height
+(void)autoResizeImage:(UIImageView*)scimage{
	if (scimage.image!=nil) {
	UIImage*	xci =scimage.image;
		if (xci.size.width/xci.size.height>=1024.0/768) {
			scimage.frame=CGRectMake((1024-xci.size.width)/2,(1024-xci.size.height*(768.0/xci.size.width))/2, 768, xci.size.height*(768.0/xci.size.width));
		}
		if (xci.size.width/xci.size.height<1024.0/768) {
			scimage.frame=CGRectMake((768-xci.size.width*(1024.0/xci.size.height))/2,0,  xci.size.width*(1024.0/xci.size.height), 1024.0);
		} 
	}
}

+(void)addButtonFor3DROOM:(NSString *)btnArrStr fatherView:(UIView *)view img:(NSString *)imgName 
					width:(int)sizeW height:(int)sizeH target:(id)target action:(SEL)action{
	NSArray *btnArr = [btnArrStr componentsSeparatedByString:@"|"];
    
	for (int i = 0; i < [btnArr count]; i++) {
		NSArray *subArr = [[btnArr objectAtIndex:i]componentsSeparatedByString:@","];
		UIButton *tmpBtn = [ViewTool addUIButton:view imageName:imgName type:@"" x:[[subArr objectAtIndex:1] intValue] - 48 y:[[subArr objectAtIndex:2] intValue] - 13 x1:sizeW y1:sizeH];
		[tmpBtn addTarget:target action:action forControlEvents:64];
		[tmpBtn setTag:[[subArr objectAtIndex:0] intValue]];
		DebugLog(@"tmpBtn tag:%d",tmpBtn.tag);
	}
}

@end