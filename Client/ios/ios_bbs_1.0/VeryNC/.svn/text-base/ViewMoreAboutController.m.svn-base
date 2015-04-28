//
//  ViewMoreAboutController.m
//   
//
//  Created by David Suen on 12-3-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewMoreAboutController.h"

 

@implementation ViewMoreAboutController
@synthesize vViewMoreFeedbackController;


-(IBAction)buttonPressed:(id)sender;
{
    
    
    ViewMoreFeedbackController *a=[[ViewMoreFeedbackController alloc]init];
    
    
    [self.navigationController pushViewController:a animated:true];
    [a release];
    

}
-(IBAction)pressPowerByButton:(id)sender;
{
    
    
    
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.verync.com"]];
    
    
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
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 
- (void)dealloc {
    
    [vViewMoreFeedbackController release];
 
    
    [super dealloc];
}


@end
