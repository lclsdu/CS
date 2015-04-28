//
//  SectionHeaderView.h
//
//  Created by Kryhear on 12-2-17.
//  Copyright 2011 ftkey.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSLineView.h"
#import  "DebugLog.h"
@protocol SectionHeaderViewDelegate;

@interface SectionHeaderView : UIView {

}
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UIButton *disclosureButton;
@property (nonatomic, retain) SSLineView *lineView;
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, assign) BOOL opened;

@property (nonatomic, assign) id <SectionHeaderViewDelegate> delegate;
-(id)initWithTitle:(NSString*)title frame:(CGRect)frame section:(NSInteger)sectionNumber opened:(BOOL)isOpened delegate:(id<SectionHeaderViewDelegate>)aDelegate;

@end

@protocol SectionHeaderViewDelegate <NSObject> 

@optional
-(void)sectionHeaderView:(SectionHeaderView*)sectionHeaderView sectionAllCloseExcept:(NSInteger)section;
-(void)sectionHeaderView:(SectionHeaderView*)sectionHeaderView sectionClosed:(NSInteger)section;
-(void)sectionHeaderView:(SectionHeaderView*)sectionHeaderView sectionOpened:(NSInteger)section;
@end
