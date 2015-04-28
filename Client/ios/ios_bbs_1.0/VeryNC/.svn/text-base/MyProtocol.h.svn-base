//
//  MyProtocol.h
//   
//
//  Created by David Suen on 12-3-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
 
#import <UIKit/UIKit.h>

@class Myprotocol; 

@protocol MyprotocolDelegate <NSObject>
@optional


//通过protocol 访问的函数
-(void)dosomething;
-(void)gotoStore;
-(void)hideImage;
-(void)showImage;
 

//-(void)startASIRequest:(NSString *)urlString tag:(NSInteger)tag; 
-(void)drawLoadingPattern:(NSString*)text isWithAnimation:(bool)isWithAnimation;

-(void)removeLoadingPatternIfNeed;

-(void)ShowConnectionFailureAlert;
 

@end











//----------------------------------------------------

@interface Myprotocol :  NSObject {
    
	id <MyprotocolDelegate> myDelegate;
}

 

@property (nonatomic, assign) id <MyprotocolDelegate> myDelegate;


@end