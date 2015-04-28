//
//  WEPopoverOrderViewController.m
//  化龙巷
//
//  Created by Rhythm on 12-4-12.
//  Copyright (c) 2012年 Osugroup. All rights reserved.
//

#import "WEPopoverOrderViewController.h"

@interface WEPopoverOrderViewController ()

@end

@implementation WEPopoverOrderViewController

@synthesize arrayCount;
@synthesize itemArray;
@synthesize funcname;
#pragma mark -
#pragma mark Initialization

#define _rowCount 4

- (id)initWithStyle:(UITableViewStyle)style    {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if ((self = [super initWithStyle:style])) {
		self.contentSizeForViewInPopover = CGSizeMake(160, _rowCount * 30 - 1);
        
        NSMutableArray *a=[[NSMutableArray alloc] init];
        itemArray =a;
    }
    return self;
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
	self.tableView.rowHeight = 30.0;
	self.view.backgroundColor = [UIColor clearColor];
    self.view.alpha = 0.9;
    
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
    CGFloat r = (CGFloat) 50/255.0;
    CGFloat g = (CGFloat) 51/255.0;
    CGFloat b = (CGFloat) 53/255.0;
	cell.textLabel.textColor = [UIColor colorWithRed:r green:g blue:b alpha:1.0];
//    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
    if (indexPath.row == 0) {
        cell.imageView.image = [UIImage imageNamed:@"ico1.png"];        
    } else if (indexPath.row == 1) {
        cell.imageView.image = [UIImage imageNamed:@"ico4.png"];        
    } else if (indexPath.row == 2) {
        cell.imageView.image = [UIImage imageNamed:@"ico5.png"];        
    } else if (indexPath.row == 3) {
        cell.imageView.image = [UIImage imageNamed:@"ico2.png"];        
    }

        cell.alpha=0.9;
    return cell;
}   


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    
    //    NSString *s= [[[NSString alloc] initWitFormat:@"ooo"] autorelease];;// Format:@"%d",[indexPath row]] autorelease];
    //NSDictionary *userInfo=  [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%d",[indexPath row]] forKey:@"MenuIndex"];
    
    
    if(indexPath.row == 0){
        if([funcname isEqualToString:@"news"]){
            [[NSNotificationCenter defaultCenter] postNotificationName:@"notifyToThreadListReload" object:@"collection"];
        }
    }
    if(indexPath.row == 1){
        if([funcname isEqualToString:@"news"]){
            [[NSNotificationCenter defaultCenter] postNotificationName:@"notifyToThreadListReload" object:@"set"];
        }
    }
    if(indexPath.row == 2){
        if([funcname isEqualToString:@"news"]){
            [[NSNotificationCenter defaultCenter] postNotificationName:@"notifyToThreadListReload" object:@"edit"];
        }
    }
	if(indexPath.row == 3){
       
        if([funcname isEqualToString:@"news"]){
            [[NSNotificationCenter defaultCenter] postNotificationName:@"notifyToThreadListReload" object:@"about"];
        }
      
    }
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
