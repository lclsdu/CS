//
//  viewTool.h
//  LingNan HD
//
//  Created by osu on 11-1-28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "FileTool.h"
#import <MediaPlayer/MediaPlayer.h>
#import  "DebugLog.h"
@interface ViewTool : NSObject {
    
}
+(UIImageView *)addUIImageViewWithAutoSizeAndPath:(UIView *)fview imagePath:(NSString*)iname x:(float)x y:(float)y;
+(UIImageView *)addUIImageViewWithPath:(UIView *)fview imageName:(NSString*)iname  x:(float)x y:(float)y x1:(float)x1 y1:(float)y1 ;
+(UIImageView *)addUIImageView:(UIView *)fview imageName:(NSString*)iname  type:(NSString *)itype x:(float)x y:(float)y x1:(float)x1 y1:(float)y1;
+(UIButton *)addUIButton:(UIView *)fview imageName:(NSString*)iname  type:(NSString *)itype x:(float)x y:(float)y x1:(float)x1 y1:(float)y1;
+(UIButton *)addUIButtonWithPath:(UIView *)fview imageName:(NSString*)iname  x:(float)x y:(float)y x1:(float)x1 y1:(float)y1;
+(UILabel *)addUILable:(UIView *)fview  x:(float)x y:(float)y x1:(float)x1 y1:(float)y1 fontSize:(int)size  lableText:(NSString*)text;
+(UITextView *)addUITextView:(UIView *)fview  x:(float)x y:(float)y x1:(float)x1 y1:(float)y1 fontSize:(int)size Text:(NSString*)text;
+(UIImage*)getPngImageAtBundle:(NSString *)name;
+(UIScrollView *)addUIScrollView:(UIView *)fview imageNum:(int)num x:(float)x y:(float)y x1:(float)x1 y1:(float)y1;
+(MPMoviePlayerController *)addMovie:(UIView *)fview target:(id)target movieName:(NSString *)name type:(NSString *)type;
+(UITextField *)addUITextFile:(UIView *)fview  x:(float)x y:(float)y x1:(float)x1 y1:(float)y1;
+(UIView *)addUIView:(UIView *)fview   x:(float)x y:(float)y x1:(float)x1 y1:(float)y1;
+(void)addArrayOfImageViewAtBundle:(NSArray *)imagesNameArray fatherView:(UIView *)view lieShu:(int)lieshu  Imagewidth:(int)width  ImageHeight:(int)height jianGeKuan:(int)jiangegekuan jianGeGao:(int)jiangegao Top:(int)top Left:(int)left;
+(void)addArrayOfButtonViewAtBundle:(NSArray *)imagesNameArray fatherView:(UIView *)view lieShu:(int)lieshu  Imagewidth:(int)width  ImageHeight:(int)height jianGeKuan:(int)jiangegekuan jianGeGao:(int)jiangegao Top:(int)top Left:(int)left target:(id)target action:(SEL)action;
	//放大缩小image;
+(UIImage *)setImageScale:(UIImage *)img size:(CGSize)c;
+(void)addGifImageView:(NSArray *)imageArray fatherView:(UIView *)view Time:(float)time  x:(float)x y:(float)y x1:(float)x1 y1:(float)y1;
+(UIImageView *)addUIImageViewWithAutoSize:(UIView *)fview imageName:(NSString*)iname  type:(NSString *)itype x:(float)x y:(float)y x1:(float)x1 y1:(float)y1;

+(void)addUIProgressview:(UIView*)fview x:(float)x y:(float)y x1:(float)x1 y1:(float)y1;
+(void)addArrayOfImageViewAtPath:(NSArray *)imagesNameArray fatherView:(UIView *)view lieShu:(int)lieshu  Imagewidth:(int)width  ImageHeight:(int)height jianGeKuan:(int)jiangegekuan jianGeGao:(int)jiangegao Top:(int)top Left:(int)left;
+(void)addArrayOfButtonViewAtPath:(NSArray *)imagesNameArray fatherView:(UIView *)view lieShu:(int)lieshu  Imagewidth:(int)width  ImageHeight:(int)height jianGeKuan:(int)jiangegekuan jianGeGao:(int)jiangegao Top:(int)top Left:(int)left target:(id)target action:(SEL)action;
+(UIButton *)addUIButtonWithAutoSize:(UIView *)fview imageName:(NSString*)iname  type:(NSString *)itype x:(float)x y:(float)y x1:(float)x1 y1:(float)y1;
+(void)addArrayOfButtonViewAtPath:(NSArray *)imagesNameArray fatherView:(UIView *)view lieShu:(int)lieshu  Imagewidth:(int)width  ImageHeight:(int)height jianGeKuan:(int)jiangegekuan jianGeGao:(int)jiangegao Top:(int)top Left:(int)left target:(id)target action:(SEL)action;
+(void)autoResizeImage:(UIImageView*)scimage;
+(void)addButtonFor3DROOM:(NSString *)btnArrStr fatherView:(UIView *)view img:(NSString *)imgName
					width:(int)sizeW height:(int)sizeH target:(id)target action:(SEL)action;
+(UIButton *)addUIButtonWithSize:(UIView *)fview imageName:(NSString*)iname  type:(NSString *)itype x:(float)x y:(float)y x1:(float)x1 y1:(float)y1;
+(void)addArrayOfButtonViewAtPathAutoSize:(NSArray *)imagesNameArray fatherView:(UIView *)view lieShu:(int)lieshu  Imagewidth:(int)width  ImageHeight:(int)height jianGeKuan:(int)jiangegekuan jianGeGao:(int)jiangegao Top:(int)top Left:(int)left target:(id)target action:(SEL)action;
+(UIImageView *)addGifImageView2:(NSArray *)imageArray fatherView:(UIView *)view Time:(float)time  x:(float)x y:(float)y x1:(float)x1 y1:(float)y1;
@end
