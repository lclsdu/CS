//
//  editTableViewController.m
//  VeryNC
//
//  Created by wu jinjin on 12-4-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "editTableViewController.h"

@interface editTableViewController ()

@end

@implementation editTableViewController
@synthesize appDelegate;
@synthesize myDelegate;


@synthesize editTableView;
@synthesize navigationArray;
@synthesize moreArray;
@synthesize navigationEditArray;
@synthesize moreEditArray;

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
    DebugLog(@"editTableViewController");
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[self navigationItem] setTitle: @"新闻"]; 
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:158.0/255.0 green:26.0/255.0 blue:36.0/255.0 alpha:1.000]];
    appDelegate=[[UIApplication sharedApplication]delegate];
    navigationArray=appDelegate.newsHeaderArray1;
    [navigationArray removeLastObject];
    moreArray=appDelegate.newsHeaderMoreArray;
    
    //NSLog(@"*** %d %d",[navigationArray count],[moreArray count]);
    moveTag=NO;
    

    [editTableView setEditing:YES animated:YES];

}

- (void)viewDidUnload
{
    [editTableView release];
    editTableView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)viewWillDisappear:(BOOL)animated{
    newsHeaderObject * moreObject=[[newsHeaderObject alloc] init];
    moreObject.primaryId=[appDelegate.newsHeaderArray1 count];
    moreObject.tag=@"1000011";
    moreObject.Name=@"更多";
    
    
    
    NSString *sql1 = [NSString stringWithFormat:@"INSERT INTO Newsheader VALUES(%d,'%@' ,'%@')",moreObject.primaryId,moreObject.tag,moreObject.name];
    
    DebugLog(@"SQL : %@",sql1);
    [SqliteSet InsertNewsHeader:sql1];
    
    [navigationArray addObject:moreObject];
    appDelegate.newsHeaderArray1=navigationArray;
    [moreObject release];
    appDelegate.newsHeaderMoreArray=moreArray;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"notifyToNewsHeaderReload" object:nil];



}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
//    [appDelegate release];
    [myDelegate release];
    
    
    
    [editTableView release];
//    [navigationArray release];
//    [moreArray release];
    [navigationEditArray release];
    [moreEditArray release];
    [super dealloc];

}
#pragma mark-
#pragma mark tableView datasource and delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2; 
}  
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return [NSString stringWithString:@"导航"];
    }
else {
    return [NSString stringWithString:@"更多"];
}
    
    
}   


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return  [navigationArray count];
    }
    else if (section==1){
        return [moreArray count];
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell_%d_%d",indexPath.section,indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
    if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        if (indexPath.section==0) {
            newsHeaderObject * headerObject= [navigationArray objectAtIndex:indexPath.row];  
            cell.textLabel.text=headerObject.name;
          
        }else if(indexPath.section==1){
            newsHeaderObject * headerObject= [moreArray objectAtIndex:indexPath.row];
            cell.textLabel.text=headerObject.name;        
            
        }

    }
    
    return cell;
    
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath;
{
  
    if (indexPath.row==0 && indexPath.section==0) {
         return NO;
    }else {
        return YES;
    }

}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{   
    if(destinationIndexPath.section == 0 && destinationIndexPath.row == 0){
        [tableView reloadData];
    }else{
    moveTag=YES;
    
    if (sourceIndexPath.section==0) 
    {
        if (destinationIndexPath.section==0) {
            
            newsHeaderObject * temp=[navigationArray objectAtIndex:sourceIndexPath.row];
            [temp retain];
            
            [navigationArray removeObject:[navigationArray objectAtIndex:sourceIndexPath.row]];
            /*
            NSString *sql0 = [NSString stringWithFormat:@"DELETE FROM Newsheader where tag=%d",temp.primaryId];
            
            DebugLog(@"SQL : %@",sql0);
            [SqliteSet deleteNewsHeaderItem:sql0];
            */
            for (int i=0; i<[navigationArray count]; i++) {
                
                for (int i = 0; i < [appDelegate.newsHeaderArray1 count]; i++) {
                   
                    
                    newsHeaderObject * headerObject=[appDelegate.newsHeaderArray1 objectAtIndex:i];
                    DebugLog(@"%d,%@,%@",headerObject.primaryId,headerObject.tag,headerObject.name);
                }
//                NSString *sql1 = [NSString stringWithFormat:@"INSERT INTO Newsheader VALUES(%d,'%@' ,'%@')",i,tempInsert.tag,tempInsert.name];
                
            }
            
            [navigationArray insertObject:temp atIndex:destinationIndexPath.row];
            [SqliteSet deleteNewsHeaderItem:@"Delete from Newsheader"];
            
            
            for (int i=0; i<[navigationArray count]; i++) {
              
                newsHeaderObject * tempInsert=[navigationArray objectAtIndex:i];
                NSString *sql1 = [NSString stringWithFormat:@"INSERT INTO Newsheader VALUES(%d,'%@' ,'%@')",i,tempInsert.tag,tempInsert.name];
            
                DebugLog(@"SQL : %@",sql1);
                [SqliteSet InsertNewsHeader:sql1];
            }
            
            
            
            [temp release];
            
      
        }else {
            newsHeaderObject * temp=[navigationArray objectAtIndex:sourceIndexPath.row];
             [temp retain];
            [navigationArray removeObject:[navigationArray objectAtIndex:sourceIndexPath.row]];
            NSString *sql0 = [NSString stringWithFormat:@"DELETE FROM Newsheader where primaryId=%d",temp.primaryId];
            
            DebugLog(@"SQL : %@",sql0);
            [SqliteSet deleteNewsHeaderItem:sql0];
            [moreArray insertObject:temp atIndex:destinationIndexPath.row];
            [SqliteSet deleteNewsHeaderItem:@"Delete from Newsheadermore"];
            for (int i=0; i<[moreArray count]; i++) {
                
                newsHeaderObject * tempInsert=[moreArray objectAtIndex:i];
                NSString *sql1 = [NSString stringWithFormat:@"INSERT INTO Newsheadermore VALUES(%d,'%@' ,'%@')",i,tempInsert.tag,tempInsert.name];
                
                DebugLog(@"SQL : %@",sql1);
                [SqliteSet InsertNewsHeader:sql1];
            }
            

            [temp release];
           
            
        }
        
   
    }else if  (sourceIndexPath.section==1)   {
        if (destinationIndexPath.section==0) {
            newsHeaderObject * temp=[moreArray objectAtIndex:sourceIndexPath.row];
             [temp retain];
            [moreArray removeObject:[moreArray objectAtIndex:sourceIndexPath.row]];
             NSString *sql0 = [NSString stringWithFormat:@"DELETE FROM Newsheadermore where primaryId=%d",temp.primaryId];
            
            DebugLog(@"SQL : %@",sql0);
            [SqliteSet deleteNewsHeaderItem:sql0];
            
            [navigationArray insertObject:temp atIndex:destinationIndexPath.row];
            
            [SqliteSet deleteNewsHeaderItem:@"Delete from Newsheader"];
            
            
            for (int i=0; i<[navigationArray count]; i++) {
                
                newsHeaderObject * tempInsert=[navigationArray objectAtIndex:i];
                
                
                NSString *sql1 = [NSString stringWithFormat:@"INSERT INTO Newsheader VALUES(%d,'%@' ,'%@')",i,tempInsert.tag,tempInsert.name];
                
                DebugLog(@"SQL : %@",sql1);
                [SqliteSet InsertNewsHeader:sql1];
            }
            
            
          
            
            
            [temp release];
            
        }else {
            newsHeaderObject * temp=[moreArray objectAtIndex:sourceIndexPath.row];
             [temp retain];
            [moreArray removeObject:[moreArray objectAtIndex:sourceIndexPath.row]];
            
            [moreArray insertObject:temp atIndex:destinationIndexPath.row];
            [SqliteSet deleteNewsHeaderItem:@"Delete from Newsheadermore"];
            for (int i=0; i<[moreArray count]; i++) {
                
                newsHeaderObject * tempInsert=[moreArray objectAtIndex:i];
                NSString *sql1 = [NSString stringWithFormat:@"INSERT INTO Newsheadermore VALUES(%d,'%@' ,'%@')",i,tempInsert.tag,tempInsert.name];
                
                DebugLog(@"SQL : %@",sql1);
                [SqliteSet InsertNewsHeader:sql1];
            }
            
            [temp release];
            
        }
        
        
        
        
        
    }
        

    }

}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

@end
