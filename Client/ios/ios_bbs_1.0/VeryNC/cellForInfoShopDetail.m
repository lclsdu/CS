//
//  cellForInfoShopDetail.m
//  化龙巷
//
//  Created by wu jinjin on 12-3-28.
//  Copyright (c) 2012年 Osugroup. All rights reserved.
//

#import "cellForInfoShopDetail.h"

@interface cellForInfoShopDetail ()

@end

@implementation cellForInfoShopDetail
@synthesize authorFaceImage;
@synthesize noOfevaluation;
@synthesize whoEvaluate;
@synthesize evaluationContentLabel;
@synthesize goodOrNot;
//@synthesize resultArrayOfEvaluator;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        
        
		[self initCell];
	}
	return self;
}
- (void) initCell
{
	NSArray* nibViews =  [[NSBundle mainBundle] loadNibNamed:@"cellForInfoShopDetail" owner:self options:nil];
	UIView* myView = [nibViews objectAtIndex: 0];
    DebugLog(@"cellForInfoShopDetail");
	
	[self.contentView addSubview:myView];
	self.selectionStyle = UITableViewCellSelectionStyleGray;
	self.backgroundColor = [UIColor clearColor];
	myView.backgroundColor = [UIColor clearColor];
	self.contentView.backgroundColor = [UIColor clearColor];	
	
	
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [authorFaceImage release];
    [noOfevaluation release];
    [whoEvaluate release];
    [evaluationContentLabel release];
    [goodOrNot release];
    [super dealloc];
}
- (IBAction)moreButtonClicked:(id)sender {
    
    evaluationTableViewController * evaluationTableView=[[evaluationTableViewController alloc]initWithNibName:@"evaluationTableViewController" bundle:nil];
  //bug  evaluationTableView.arrayForEvaluation=resultArrayOfEvaluator;
    [self.superview addSubview:evaluationTableView.view];
    
}
@end
