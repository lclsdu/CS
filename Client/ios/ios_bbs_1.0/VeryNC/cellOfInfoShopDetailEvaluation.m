//
//  cellOfInfoShopDetailEvaluation.m
//  化龙巷
//
//  Created by wu jinjin on 12-3-29.
//  Copyright (c) 2012年 Osugroup. All rights reserved.
//

#import "cellOfInfoShopDetailEvaluation.h"

@interface cellOfInfoShopDetailEvaluation ()

@end

@implementation cellOfInfoShopDetailEvaluation
@synthesize authorFaceImage;
@synthesize noOfevaluation;
@synthesize whoEvaluate;
@synthesize evaluationContentLabel;
@synthesize goodOrNot;
@synthesize resultArrayOfEvaluator;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
		[self initCell];
	}
	return self;
}
- (void) initCell
{
	NSArray* nibViews =  [[NSBundle mainBundle] loadNibNamed:@"cellOfInfoShopDetailEvaluation" owner:self options:nil];
	UIView* myView = [nibViews objectAtIndex: 0];
	
	[self.contentView addSubview:myView];
	self.selectionStyle = UITableViewCellSelectionStyleGray;
	self.backgroundColor = [UIColor clearColor];
	myView.backgroundColor = [UIColor clearColor];
	self.contentView.backgroundColor = [UIColor clearColor];	
	
	
}

- (IBAction)moreButtonClicked:(id)sender {
    DebugLog(@"moreButtonClicked");
    evaluationTableViewController * evaluationTableController=[[evaluationTableViewController alloc]initWithNibName:@"evaluationTableViewController" bundle:nil];
//    evaluationTableController.arrayForEvaluation=self.resultArrayOfEvaluator;
    [self.superview.superview  addSubview:evaluationTableController.view];
    
    
    
    
}
@end
