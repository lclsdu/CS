//
//  ViewMoreSettingController.m
//   
//
//  Created by David Suen on 12-3-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewMoreSettingController.h"
#import "MoreAccountViewController.h"
#import "ViewMoreFeedbackController.h" 
#import "ViewMoreAboutController.h"

@implementation ViewMoreSettingController
@synthesize myDelegate;
@synthesize tableView;
@synthesize appDelegate;
-(void)defaultSaveAppSetting_onlylouzhu:(bool)b;

{
	NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    [defaults setBool:b forKey:@"onlylouzhu"]; 
    
    
	[defaults synchronize];
    
}
-(void)defaultSaveAppSetting_forbiddisplaypic:(bool)b;

{
	NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    
    [defaults setBool:b forKey:@"forbiddisplaypic"];  
    
	[defaults synchronize];
    
}


-(bool)defaultLoadAppSetting_forbiddisplaypic;
{
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:@"forbiddisplaypic"];
    
    
    
}
-(bool)defaultLoadAppSetting_onlylouzhu;
{
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:@"onlylouzhu"];
    
    
    
}
//---------------end of user default
- (void)viewWillAppear:(BOOL)animated;  
{
    
   
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:158.0/255.0 green:26.0/255.0 blue:36.0/255.0 alpha:1.000]];
    [[self navigationItem] setTitle: @"设置"]; 
    [tableView reloadData];
    
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
    [tableView release];
    [appDelegate release];
    [super dealloc];
}
#pragma mark -
#pragma mark Table View Data Source Methods

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView 

{
	return 5;
} 


- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section
{
	
    
	switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return 1;
            break;
        case 3:
            return 1;
            break;
        case 4:
            return 1;
            break;
        default:
            break;
    }
}





//------------------------------------------------------------------------------------------------

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
	/*
	 
     UIImageView *selectedBackgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 768, 60)];
     [selectedBackgroundView setImage:[UIImage imageNamed:@"tableviewcellbackground.png"]];
     [cell setBackgroundView:selectedBackgroundView];
     [selectedBackgroundView release];
	 
     */
}

/*
 
 - (NSString *)tableView: (UITableView *)tableView 
 titleForHeaderInsection:(NSInteger )section
 
 
 {
 
 
 }
 */
-(void)switchValueChanged1:(id)sender;
{
	if([sender isKindOfClass:[UISwitch class] ]) 
	{
		
		UISwitch * t =(UISwitch*)sender;
        
        [self defaultSaveAppSetting_onlylouzhu: [t isOn]];
	}	
    
}
-(void)switchValueChanged2:(id)sender;
{
    
    if([sender isKindOfClass:[UISwitch class] ]) 
	{
		
		UISwitch * t =(UISwitch*)sender;
        
        [self defaultSaveAppSetting_forbiddisplaypic:  [t isOn]];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{	
    
    
    
    static NSString *SimpleTableIdentifier1 = @"CellTableIdentifier";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier: SimpleTableIdentifier1 ];
    
    if  (cell == nil) 
    {
        CGRect cellframe=CGRectMake(0, 0, 280, 60);
        cell=[[[UITableViewCell alloc] initWithFrame:  cellframe //SimpleTableIdentifier1
               
                                     reuseIdentifier:SimpleTableIdentifier1] autorelease];
        
        
        switch(indexPath.section)
        {
                
            case 1:
            {
                
                
                switch(indexPath.row)
                {
                        
                    case 0:
                    {
                        
                        UISwitch *switchview=[[UISwitch alloc]init];
                        
                        switchview.tag=11106 ;
                        cell.accessoryView= switchview;
                        
                        [switchview addTarget:self action:@selector(switchValueChanged1:) forControlEvents:UIControlEventValueChanged];
                        
                        [switchview release];	
                        
                        break;
                    }
                    case 1:
                    {
                        UISwitch *switchview=[[UISwitch alloc]init];
                        
                        switchview.tag=11107 ;
                        cell.accessoryView= switchview;
                        
                        [switchview addTarget:self action:@selector(switchValueChanged2:) forControlEvents:UIControlEventValueChanged];
                        
                        [switchview release];	
                        
                        break;
                    }
                }
                
                
                
                break;
                
            }
                
                
                
                
                
                
        }
        
        
 
        
    }
	
	
    
    
	[cell  setBackgroundColor:[UIColor whiteColor]];
	switch(indexPath.section)
    {
        case 0:
        {
            cell.textLabel.text= @"个人账号" ;
            cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;//
            cell.accessoryView = UITableViewCellAccessoryNone;
            break;
            
        } 
        case 1:
        {
            
            
            switch(indexPath.row)
            {
                    
                case 0:
                {
                    
                    
                    cell.textLabel.text= @"帖子页默认只看楼主" ;
                    UISwitch *a=(UISwitch*)cell.accessoryView;//[cell.contentView viewWithTag:11106]; 
                    bool b=[self defaultLoadAppSetting_onlylouzhu];
                    [a setOn:b animated:true];
                    
                    break;
                }
                case 1:
                {
                    cell.textLabel.text=@"2G/3G网络不显示图片"  ;
                    UISwitch *a=(UISwitch*)cell.accessoryView;//[cell.contentView viewWithTag:11107]; 
                    bool b=[self defaultLoadAppSetting_forbiddisplaypic];
                    [a setOn:b animated:true];
                    
                    break;
                }
            }
            
            
            
            break;
            
        }
            
            
        case 2:
        {
            cell.textLabel.text= @"清除缓存" ;
            cell.accessoryType=  UITableViewCellAccessoryDisclosureIndicator;//
            break;
            
        }
            
        case 3:
        {
            
            cell.textLabel.text= @"恢复默认设置" ;
            cell.accessoryType=  UITableViewCellAccessoryDisclosureIndicator;//
            break;
            
        }
        case 4:
        {
            
            
            switch(indexPath.row)
            {
                    
                case 0:
                {
                    cell.textLabel.text= @"意见反馈" ;
                    cell.accessoryType=  UITableViewCellAccessoryDisclosureIndicator;//
                    break;
                }
                case 1:
                {
                    cell.textLabel.text= @"关于" ;
                    cell.accessoryType=  UITableViewCellAccessoryDisclosureIndicator;//
                    cell.accessoryView = UITableViewCellAccessoryNone;
                    break;
                }
            }
            break;
            
        }    
            
    }
	
    
    return cell;
    
    
	
 	
}  
//#pragma mark -
//#pragma mark Table Delegate Methods1 

- (void)tableView:(UITableView *)tableView 
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        MoreAccountViewController *accountview = [[MoreAccountViewController alloc] initWithNibName:@"MoreAccountViewController" bundle:nil];
        [self.navigationController pushViewController:accountview animated:YES];
    }
    if((indexPath.section==2) && (indexPath.row==0))    [self clearHistory];
    
    if((indexPath.section==3) && (indexPath.row==0))   [self resetUserDefault];
    if((indexPath.section==4) && (indexPath.row==0)){
        ViewMoreFeedbackController *feedback = [[ViewMoreFeedbackController alloc] initWithNibName:@"ViewMoreFeedback" bundle:nil];
        [self.navigationController pushViewController:feedback animated:YES];
    }
    if((indexPath.section==4) && (indexPath.row==1)){
        ViewMoreAboutController *moreabout = [[ViewMoreAboutController alloc] initWithNibName:@"ViewMoreAbout" bundle:nil];
        [self.navigationController pushViewController:moreabout animated:YES];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}
-(void)clearHistory;
{
    
    
    //doSomeThing here
    if([SqliteSet clearFavorite]&&[SqliteSet clearRecentView])
        
    {
        
        
        UIAlertView *alert=[[UIAlertView alloc]
                            initWithTitle: @"缓存清理完成"
                            
                            message:@""//\n\n\n\n"
                            delegate:self
                            cancelButtonTitle:@"好"
                            otherButtonTitles:nil,nil];
        
        
        //---------------------------------------------------------
        [alert show];
        [alert release];
        
    }
    else {
        
        UIAlertView *alert=[[UIAlertView alloc]
                            initWithTitle: @"缓存清理失败"
                            
                            message:@""//\n\n\n\n"
                            delegate:self
                            cancelButtonTitle:@"好"
                            otherButtonTitles:nil,nil];
        
        
        //---------------------------------------------------------
        [alert show];
        [alert release];
        
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notifyToClearHistoryNotification" object:nil];
    
    
}
-(void)resetUserDefault;
{
    
    
    //doSomeThing here
    
    [self defaultSaveAppSetting_onlylouzhu:false];
    [self defaultSaveAppSetting_forbiddisplaypic:false];
    
    [tableView reloadData];
    
    
    UIAlertView *alert=[[UIAlertView alloc]
                        initWithTitle: @"恢复默认设置完成"
                        
                        message:@""//\n\n\n\n"
                        delegate:self
                        cancelButtonTitle:@"好"
                        otherButtonTitles:nil,nil];
    
    
    //---------------------------------------------------------
    [alert show];
    [alert release];
    
    
    
}


- (CGFloat)tableView:(UITableView *)tableView 
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	
	return 60.0f;//cell height
	
	
	
}


@end
