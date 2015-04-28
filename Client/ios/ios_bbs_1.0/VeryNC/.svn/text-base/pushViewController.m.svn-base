//
//  pushViewController.m
//  VeryNC
//
//  Created by  on 12-7-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "pushViewController.h"
#import "ReaderController.h"

@interface pushViewController ()

@end

@implementation pushViewController
@synthesize readerView;

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
    
    appDelegate=[[UIApplication sharedApplication] delegate];
    
    /*
    ReaderController *reader = [[ReaderController alloc] init];
    
    selectCell.isReaded = YES;
    reader.Title = [selectCell title];
    reader.tid = [selectCell tid];
    reader.isclosed = [selectCell isclosed];
    NSUserDefaults *tmpUserDefaults = [NSUserDefaults standardUserDefaults];
    [tmpUserDefaults setBool:YES forKey:[NSString stringWithFormat:@"%d",selectCell.tid]];
    
    DebugLog(@"%d",selectCell.tid);
    DebugLog(@"%d",selectCell.fid);
    
    reader.fid=-1;
    
    reader.tid=selectCell.tid;
    [tmpUserDefaults synchronize];
    [reader setHidesBottomBarWhenPushed:YES];
    [myDelegate hideImage];
    [self.navigationController pushViewController:reader animated:YES];
    [reader release];
    
    */
    
    ReaderController *reader = [[ReaderController alloc] init];
    reader.tid = 1181;
//    reader.Title = @"";
//    reader.fid=-1;
//    [reader setHidesBottomBarWhenPushed:YES];

    
    [readerView addSubview:reader.view];
    
//    [self.navigationController pushViewController:reader animated:YES];
    
    [reader release];
    
    
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setReaderView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)closeViewController:(id)sender {
//    exit(0);
    [self dismissModalViewControllerAnimated:YES];
}
- (void)dealloc {
    [readerView release];
    [super dealloc];
}
@end
