//
//  WEPopoverContentViewController.m
//  WEPopover
//
//  Created by Werner Altewischer on 06/11/10.
//  Copyright 2010 Werner IT Consultancy. All rights reserved.
//

#import "WEPopoverContentViewController.h"


@implementation WEPopoverContentViewController

@synthesize arrayCount;
@synthesize itemArray;

#pragma mark -
#pragma mark Initialization

#define _rowCount 5

- (id)initWithStyle:(UITableViewStyle)style    {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if ((self = [super initWithStyle:style])) {
		self.contentSizeForViewInPopover = CGSizeMake(180, _rowCount * 34 - 1);
        
        NSMutableArray *a=[[NSMutableArray alloc] init];
        itemArray =a;
    }
    return self;
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

	self.tableView.rowHeight = 34.0;
//	self.view.backgroundColor = [UIColor clearColor];
//    self.view.alpha=0.5;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
-(void)reloadTableView;
{
             DebugLog(@"------%d",[ itemArray count]);
    //
    [self.tableView reloadData];
    
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return arrayCount ;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	cell.textLabel.text =[itemArray objectAtIndex:  [indexPath row]]; //[NSString stringWithFormat:@"Item %d", [indexPath row]]; 
//    CGFloat r = (CGFloat) 0/255.0;
//    CGFloat g = (CGFloat) 0/255.0;
//    CGFloat b = (CGFloat) 0/255.0;    
//	cell.textLabel.textColor = [UIColor colorWithRed:r green:g blue:b alpha:0.9];
//    cell.alpha=0.5;
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:18];    
    return cell;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    
//    NSString *s= [[[NSString alloc] initWitFormat:@"ooo"] autorelease];;// Format:@"%d",[indexPath row]] autorelease];
    NSDictionary *userInfo=  [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%d",[indexPath row]]
                              
                              forKey:@"MenuIndex"];
                              
                              
                              
[[NSNotificationCenter defaultCenter] postNotificationName:@"notifyToMenuSelectionNotification" object:nil userInfo:userInfo];
                         
     
                          
	
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

