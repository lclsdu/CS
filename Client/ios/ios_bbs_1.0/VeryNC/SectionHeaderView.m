//
//  SectionHeaderView.m
//  TQQTableView
//
//  Created by Kryhear on 12-2-17.
//  Copyright 2011 ftkey.com. All rights reserved.
//

#import "SectionHeaderView.h"


@implementation SectionHeaderView
@synthesize titleLabel, disclosureButton, delegate, section , opened, lineView;

-(id)initWithTitle:(NSString*)title frame:(CGRect)frame section:(NSInteger)sectionNumber opened:(BOOL)isOpened delegate:(id)aDelegate{
    if (self = [super initWithFrame:frame]) {
		
		UITapGestureRecognizer *tapGesture = [[[UITapGestureRecognizer alloc] initWithTarget:self 
																					  action:@selector(toggleAction:)] autorelease];
		[self addGestureRecognizer:tapGesture];
		self.userInteractionEnabled = YES;
		section = sectionNumber;
		delegate = aDelegate;
		opened = isOpened;
		titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 0, 300, frame.size.height)];
		[titleLabel setText:title];
		[titleLabel setTextAlignment:UITextAlignmentLeft];
		[titleLabel setTextColor:[UIColor blackColor]];
		[titleLabel setFont:[UIFont systemFontOfSize:17]];
		[titleLabel setBackgroundColor:[UIColor whiteColor]];
		[self addSubview:titleLabel];
		
		disclosureButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        disclosureButton.frame = CGRectMake(270.0, 20.0, 11.0, 11.0);
		[disclosureButton setImage:[UIImage imageNamed:@"cross.png"] forState:UIControlStateNormal];
		[disclosureButton setImage:[UIImage imageNamed:@"across.png"] forState:UIControlStateSelected];
		disclosureButton.userInteractionEnabled = NO;
		disclosureButton.selected = isOpened;
        [self addSubview:disclosureButton];
		
		lineView = [[SSLineView alloc] initWithFrame:CGRectMake(0, frame.size.height - 2, 320, 2)];
		[self addSubview:lineView];
		
		[self setBackgroundColor:[UIColor whiteColor]];
		
	}
	return self;
}

-(IBAction)toggleAction:(id)sender {
	
	disclosureButton.selected = !disclosureButton.selected;
	[delegate sectionHeaderView:self sectionAllCloseExcept:section];
	if (disclosureButton.selected) {
		if ([delegate respondsToSelector:@selector(sectionHeaderView:sectionOpened:)]) {
			[delegate sectionHeaderView:self sectionOpened:section];
		}
	}
	else {
		if ([delegate respondsToSelector:@selector(sectionHeaderView:sectionClosed:)]) {
			[delegate sectionHeaderView:self sectionClosed:section];
		}
	}

}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code.
 }
 */

- (void)dealloc {
	[titleLabel release];
    [disclosureButton release];
	[lineView release];
    [super dealloc];
}


@end
