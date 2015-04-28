//
//  collectionViewController.m
//  VeryNC
//
//  Created by 吴 津津 on 12-5-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "collectionViewController.h"
#import "photoDetailViewController.h"
#import "EGOImageView.h"
@interface collectionViewController ()

@end
#define kArticalTag 100
#define kPictureTag 101

@implementation collectionViewController
@synthesize api_url,picarray;

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
    // Do any additional setup after loading the view from its nib.
     [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:158.0/255.0 green:26.0/255.0 blue:36.0/255.0 alpha:1.000]];
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    api_url = delegate.myDomainAndPathVeryNC;
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearHistoryNotification:) name:@"notifyToClearHistoryNotification" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshFavoriteNotification:) name:@"notifyToRefreshFavoriteNotification" object:nil];
    
    
    
	[[self navigationItem] setTitle:@"我的收藏"];
	
	resultArray = [[NSMutableArray alloc] init];
	btnArray = [[NSMutableArray alloc] init];
    
	pageNum = 1;
	
	UIImageView *menuBack = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menuback.png"]];
	[[self view] addSubview:menuBack];
	[menuBack release];
    
    
	selectView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navi.png"]];
    
    
    
    
    
	[selectView setFrame:CGRectMake(10, 5, 100, 23)];
	[selectView.layer setMasksToBounds:YES];
	[selectView.layer setCornerRadius:4.0];
	[[self view] addSubview:selectView];
	[selectView release];
    
    
	NSArray *btnTitleArray = [NSArray arrayWithObjects:@"文章", @"图片",nil];
	for (int i = 0; i < [btnTitleArray count]; i++) {
		UIButton *menuBtn = [[UIButton alloc] initWithFrame:CGRectMake(80 + 80*i, 5, 80, 23)];
		[menuBtn setTitle:[btnTitleArray objectAtIndex:i] forState:UIControlStateNormal];
		[menuBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
		[menuBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
		[menuBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
		[menuBtn setTag:kArticalTag + i];
		[menuBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
		[menuBtn addTarget:self action:@selector(pressMenu:) forControlEvents:64];
		[[self view] addSubview:menuBtn];
		//[menuBtn release];
		[btnArray addObject:menuBtn];
		[menuBtn release];
	}
	
    
    
	tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 32, 320, 380) style:UITableViewStylePlain];
	[tableView setDelegate:self];
	[tableView setDataSource:self];
	[self.view addSubview:tableView];
	[tableView setSeparatorColor:[UIColor clearColor]];
	[tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
	[tableView setBackgroundColor:[UIColor colorWithRed:0.922 green:0.922 blue:0.922 alpha:1.000]];
	[tableView release];
    
 /*   
	if (_refreshHeaderView == nil) {
		
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - tableView.bounds.size.height, self.view.frame.size.width, tableView.bounds.size.height)];
		view.delegate = self;
		[tableView addSubview:view];
		_refreshHeaderView = view;
		[view release];
		
	}
    */
	
	[self pressMenu:[btnArray objectAtIndex:0]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma -mark recieve notification

-(void)refreshFavoriteNotification:(NSNotification *)notification;
{
    
    if(selectTag==kArticalTag)
        
    {
        
        [resultArray removeAllObjects];
        
        [SqliteSet queryFavourite:resultArray];
        
        [tableView reloadData];
        
        
    }
    
    
    
}

#pragma -mark button clicked



- (void)pressMenu:(UIButton *)sender {
	if (sender.tag != selectTag) {
		pageNum = 1;
		if (hashLoad[selectTag] == 0) {
			[resultArray removeAllObjects];
			[tableView reloadData];
		}
		[self pressMenu:sender More:NO];
		
	}
	
}



- (void)pressMenu:(UIButton *)sender More:(BOOL)_isMore{
	for (UIButton *tmpBtn in btnArray) {
		[tmpBtn setSelected:NO];
	}
    
	[sender setSelected:YES];
	[UIView animateWithDuration:0.2f animations:^{
		CGRect frame = [sender frame];
		frame.origin.x -= 2;	 
		[selectView setFrame:frame];
	}];
	selectTag = sender.tag;
	isMore = _isMore;
	
	
	//NSString *requestURL;
	switch (selectTag) {

		case kArticalTag:{
            [photoViewBackgroundImage removeFromSuperview];
            [scrollView removeFromSuperview];
            if([resultArray count]>0)   [resultArray removeAllObjects];
            
            [SqliteSet queryFavourite:resultArray];
            
		 	[tableView reloadData];
            
			break;
		}
		case kPictureTag:{
            photoViewBackgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 32, 320, 400)];
            photoViewBackgroundImage.image=[UIImage imageNamed:@"imageset_background.png"];
            [self.view addSubview:photoViewBackgroundImage];
            [photoViewBackgroundImage release];   
            
            self.picarray = [[NSMutableArray alloc] init];
            self.picarray = [SqliteSet queryFavouritePicItem];
            
            //add picshow list
            
            int tmpArrayCount = [picarray count];
            int jiou = tmpArrayCount % 2;
            int louceng = tmpArrayCount / 2;
            
            
            if(tmpArrayCount > 0){
                
                //CGRect wholeWindow = [[self view] bounds];
                scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 32, 320, 400)];
                [[self view] addSubview:scrollView];
                CGRect reallyBigRect;
                reallyBigRect.origin = CGPointZero;
                reallyBigRect.size.width = 320;
                if (jiou == 1) {
                    reallyBigRect.size.height = 100 + (135 * (louceng + 1));                
                } else {
                    reallyBigRect.size.height = 100 + (145 * (louceng));                
                }
                [scrollView setContentSize:reallyBigRect.size];  
                
                
                /*
                if (tmpArrayCount > 10) {
                    if (jiou == 1) {
                        UIButton *morePressButton = [[UIButton alloc] initWithFrame:CGRectMake(6, 23 + (144 * (louceng + 1)), 305, 33)];
                        [morePressButton setBackgroundImage:[UIImage imageNamed:@"buttonbg01.png"] forState:UIControlStateNormal];
                        [scrollView addSubview:morePressButton];                    
                    } else {
                        UIButton *morePressButton = [[UIButton alloc] initWithFrame:CGRectMake(6, 23 + (144 * (louceng)), 305, 33)];
                        [morePressButton setBackgroundImage:[UIImage imageNamed:@"buttonbg01.png"] forState:UIControlStateNormal];
                        [scrollView addSubview:morePressButton];    
                    }                
                }
                */
                
                
                
                
                if ( jiou == 1) {//奇数
                    
                    //左+1
                    for (int i = 0; i < (louceng + 1); i++) {
                        UIImageView *photobgView1;
                        photobgView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photobg.png"]];
                        [photobgView1 setFrame:CGRectMake(10, (16 + (144 * i)), 151, 133)];
                        [photobgView1.layer setMasksToBounds:YES];
                        [photobgView1.layer setCornerRadius:4.0];
                        [scrollView addSubview:photobgView1];
                        [photobgView1 release];
                        
                        NSString *imageString1 = [[picarray objectAtIndex:0 + (i * 2 )] valueForKey:@"picshow_coverpic"];
                        NSURL *imageURL1 = [NSURL URLWithString:imageString1];
                        //NSData *imageData1 = [NSData dataWithContentsOfURL:imageURL1];
                        //UIButton *pollbtnone1 = [[UIButton alloc] initWithFrame:CGRectMake(35, 23 + (144 * i), 103, 103)];
                        //[pollbtnone1 addTarget:self action:@selector(onClickImage:) forControlEvents:UIControlEventTouchUpInside];
                        //pollbtnone1.tag = 0 + (i * 2 );
                        //[pollbtnone1 setBackgroundImage:[UIImage imageWithData:imageData1] forState:UIControlStateNormal];
                        //[scrollView addSubview:pollbtnone1];    
                        EGOImageView *imageView = [[EGOImageView alloc] initWithPlaceholderImage:nil];
                        imageView.frame = CGRectMake(35, 23 + (144 * i), 103, 103);
                        imageView.imageURL = imageURL1;
                        imageView.userInteractionEnabled = YES;
                        UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage:)];
                        [imageView addGestureRecognizer:singleTap];
                        [singleTap setAccessibilityValue:[NSString stringWithFormat:@"%d",0 + (i * 2 )]];
                        imageView.tag = 0 + (i * 2 );
                        [scrollView addSubview:imageView];
                        
                        NSString *titleString1 = [[picarray objectAtIndex:0 + (i * 2)] valueForKey:@"picshow_title"];
                        UILabel *titleLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(30, 106 + (144 * i), 116, 60)];
                        titleLabel1.text = titleString1;
                        titleLabel1.backgroundColor = [UIColor clearColor];
                        titleLabel1.textColor = [UIColor grayColor];                   
                        [scrollView addSubview:titleLabel1];            
                        titleLabel1.font = [UIFont boldSystemFontOfSize:11];                    
                    }
                    
                    
                    if (tmpArrayCount != 1) {
                        //右                    
                        for (int y = 0; y < louceng; y++) {
                            UIImageView *photobgView2;
                            photobgView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photobg.png"]];
                            [photobgView2 setFrame:CGRectMake(161, (16 + (144 * y)), 151, 133)];
                            [photobgView2.layer setMasksToBounds:YES];
                            [photobgView2.layer setCornerRadius:4.0];
                            [scrollView addSubview:photobgView2];
                            [photobgView2 release]; 
                            
                            NSString *imageString2 = [[picarray objectAtIndex:1 + (y * 2)] valueForKey:@"picshow_coverpic"];
                            NSURL *imageURL2 = [NSURL URLWithString:imageString2];
                            //NSData *imageData2 = [NSData dataWithContentsOfURL:imageURL2];
                            //UIButton *pollbtnone2 = [[UIButton alloc] initWithFrame:CGRectMake(186, 23 + (144 * y), 103, 103)];
                            //[pollbtnone2 addTarget:self action:@selector(onClickImage:) forControlEvents:UIControlEventTouchUpInside];
                            //pollbtnone2.tag = 1 + (y * 2);
                            //[pollbtnone2 setBackgroundImage:[UIImage imageWithData:imageData2] forState:UIControlStateNormal];
                            //[scrollView addSubview:pollbtnone2];
                            EGOImageView *imageView = [[EGOImageView alloc] initWithPlaceholderImage:nil];
                            imageView.frame = CGRectMake(186, 23 + (144 * y), 103, 103);
                            imageView.imageURL = imageURL2;
                            imageView.userInteractionEnabled = YES;
                            UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage:)];
                            [imageView addGestureRecognizer:singleTap];
                            [singleTap setAccessibilityValue:[NSString stringWithFormat:@"%d",1 + (y * 2 )]];
                            imageView.tag = 1 + (y * 2);
                            [scrollView addSubview:imageView];
                            
                            NSString *titleString2 = [[picarray objectAtIndex:1 + (y * 2)] valueForKey:@"picshow_title"];
                            UILabel *titleLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(180, 106 + (144 * y), 116, 60)];
                            titleLabel2.text = titleString2;
                            titleLabel2.backgroundColor = [UIColor clearColor];
                            titleLabel2.textColor = [UIColor grayColor];                   
                            [scrollView addSubview:titleLabel2];            
                            titleLabel2.font = [UIFont boldSystemFontOfSize:11];                           
                        }                    
                    }
                    
                } else if ( jiou == 0) {//偶数
                    //左右相等
                    
                    for (int z = 0; z < louceng; z++) {
                        UIImageView *photobgView1;
                        photobgView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photobg.png"]];
                        [photobgView1 setFrame:CGRectMake(10, (16 + (144 * z)), 151, 133)];
                        [photobgView1.layer setMasksToBounds:YES];
                        [photobgView1.layer setCornerRadius:4.0];
                        [scrollView addSubview:photobgView1];
                        [photobgView1 release];         
                        
                        
                        NSString *imageString1 = [[picarray objectAtIndex:0 + (z * 2 )] valueForKey:@"picshow_coverpic"];
                        NSURL *imageURL1 = [NSURL URLWithString:imageString1];
                        //NSData *imageData1 = [NSData dataWithContentsOfURL:imageURL1];
                        //UIButton *pollbtnone1 = [[UIButton alloc] initWithFrame:CGRectMake(35, 23 + (144 * z), 103, 103)];
                        //[pollbtnone1 addTarget:self action:@selector(onClickImage:) forControlEvents:UIControlEventTouchUpInside];
                        //pollbtnone1.tag = 0 + (z * 2 );
                        //[pollbtnone1 setBackgroundImage:[UIImage imageWithData:imageData1] forState:UIControlStateNormal];
                        //[scrollView addSubview:pollbtnone1];    
                        EGOImageView *imageView = [[EGOImageView alloc] initWithPlaceholderImage:nil];
                        imageView.frame = CGRectMake(35, 23 + (144 * z), 103, 103);
                        imageView.imageURL = imageURL1;
                        imageView.userInteractionEnabled = YES;
                        UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage:)];
                        [imageView addGestureRecognizer:singleTap];
                        [singleTap setAccessibilityValue:[NSString stringWithFormat:@"%d",0 + (z * 2 )]];
                        imageView.tag = 0 + (z * 2 );
                        [scrollView addSubview:imageView];
                        
                        
                        NSString *titleString1 = [[picarray objectAtIndex:0 + (z * 2)] valueForKey:@"picshow_title"];
                        UILabel *titleLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(30, 106 + (144 * z), 116, 60)];
                        titleLabel1.text = titleString1;
                        titleLabel1.backgroundColor = [UIColor clearColor];
                        titleLabel1.textColor = [UIColor grayColor];                   
                        [scrollView addSubview:titleLabel1];            
                        titleLabel1.font = [UIFont boldSystemFontOfSize:11];                    
                        
                        
                        
                    }
                    
                    for (int x = 0; x < louceng; x++) {
                        UIImageView *photobgView2;
                        photobgView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photobg.png"]];
                        [photobgView2 setFrame:CGRectMake(161, (16 + (144 * x)), 151, 133)];
                        [photobgView2.layer setMasksToBounds:YES];
                        [photobgView2.layer setCornerRadius:4.0];
                        [scrollView addSubview:photobgView2];
                        [photobgView2 release];     
                        
                        NSString *imageString2 = [[picarray objectAtIndex:1 + (x * 2)] valueForKey:@"picshow_coverpic"];
                        NSURL *imageURL2 = [NSURL URLWithString:imageString2];
                        //NSData *imageData2 = [NSData dataWithContentsOfURL:imageURL2];
                        //UIButton *pollbtnone2 = [[UIButton alloc] initWithFrame:CGRectMake(186, 23 + (144 * x), 103, 103)];
                        //[pollbtnone2 setBackgroundImage:[UIImage imageWithData:imageData2] forState:UIControlStateNormal];
                        //[pollbtnone2 addTarget:self action:@selector(onClickImage:) forControlEvents:UIControlEventTouchUpInside];
                        //pollbtnone2.tag = 1 + (x * 2);
                        //[scrollView addSubview:pollbtnone2];   
                        EGOImageView *imageView = [[EGOImageView alloc] initWithPlaceholderImage:nil];
                        imageView.frame = CGRectMake(186, 23 + (144 * x), 103, 103);
                        imageView.imageURL = imageURL2;
                        imageView.userInteractionEnabled = YES;
                        UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage:)];
                        [imageView addGestureRecognizer:singleTap];
                        [singleTap setAccessibilityValue:[NSString stringWithFormat:@"%d",1 + (x * 2)]];
                        imageView.tag = 1 + (x * 2);
                        [scrollView addSubview:imageView];
                        
                        NSString *titleString2 = [[picarray objectAtIndex:1 + (x * 2)] valueForKey:@"picshow_title"];
                        UILabel *titleLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(180, 106 + (144 * x), 116, 60)];
                        titleLabel2.text = titleString2;
                        titleLabel2.backgroundColor = [UIColor clearColor];
                        titleLabel2.textColor = [UIColor grayColor];                   
                        [scrollView addSubview:titleLabel2];            
                        titleLabel2.font = [UIFont boldSystemFontOfSize:11];                      
                    }
                    
                    
                }    
                }
            
			break;
		}
	}
	
}


#pragma mark -
#pragma mark UITableViewDataSource


- (void)tableView:(UITableView *)_tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
	    

        
		ReaderController *reader = [[ReaderController alloc] init];
        
		reader.tid = [[resultArray objectAtIndex:indexPath.row] Fid]; //[[selectList.fidArray objectAtIndex:indexPath.row] intValue];
		reader.Title =[[resultArray objectAtIndex:indexPath.row] Name];  //[selectList.childArray objectAtIndex:indexPath.row];
        reader.fid=-1;
		[reader setHidesBottomBarWhenPushed:YES];
		[self.navigationController pushViewController:reader animated:YES];
		[reader release];

        
}












//为tableview添加项
- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
   
	 NSString *CellIdentifier = [NSString stringWithFormat: @"Cell%d",indexPath.row];
    
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	SSLineView *lineView = [[SSLineView alloc] initWithFrame:CGRectMake(0, 49, 320, 2)];
	[cell addSubview:lineView];
    
    
   if (selectTag == kArticalTag){
        
        //robust
        if([[resultArray objectAtIndex:indexPath.row] isKindOfClass:[FavouriteObject class]])
        {
            
            FavouriteObject *cellObject = [resultArray objectAtIndex:indexPath.row];
            //verync crash
            UILabel *titleLabel = [ViewTool addUILable:cell x:25 y:5 x1:270 y1:40 fontSize:15 lableText:cellObject.Name]  ;//帖子标题
            
            
            [titleLabel setHighlightedTextColor:[UIColor whiteColor]];
            //  [titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
            titleLabel.numberOfLines = 2;
            UIImageView *accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow.png"]];
            [cell setAccessoryView:accessoryView];
        }
        
	}
    /*
	else if (selectTag == kRecentTag){
		if ([indexPath row] == [resultArray count] - 1 && [resultArray count] != 0) {
            
            //[cell.textLabel setText:@"更多"];
            [cell.textLabel setText:  [resultArray  objectAtIndex:[resultArray count] - 1]];
			[cell.textLabel setTextAlignment:UITextAlignmentCenter];
        }
        else {
            //robust
            if([[resultArray objectAtIndex:indexPath.row] isKindOfClass:[FavouriteObject class]])
            {
                
                
                FavouriteObject *cellObject = [resultArray objectAtIndex:indexPath.row];
                UILabel *titleLabel = [ViewTool addUILable:cell x:25 y:5 x1:270 y1:40 fontSize:15 lableText:cellObject.Name];//帖子标题
                [titleLabel setHighlightedTextColor:[UIColor whiteColor]];
                //[titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
                titleLabel.numberOfLines = 2;
                
            }
        }
	}*/
	if (selectTag == kArticalTag || [indexPath row] != [resultArray count] - 1) {
		UIImageView *accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow.png"]];
		[cell setAccessoryView:accessoryView];
		[accessoryView release];
	}
	return cell;
}

//每组的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
	return [resultArray count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 50;
}

//点击切换到图片详细页面
- (void)onClickImage:(UITapGestureRecognizer *)sender
{
    //UIImageView *btn = sender;
    NSString *num = sender.accessibilityValue;
    photoDetailViewController *photodetail = [[photoDetailViewController alloc] initWithNibName:@"photoDetailViewController" bundle:nil];
    photodetail.picshow_id    = [[picarray objectAtIndex:[num intValue]] objectForKey:@"picshow_id"];
    photodetail.picshow_title = [[picarray objectAtIndex:[num intValue]] objectForKey:@"picshow_title"];
    photodetail.tid           = [[picarray objectAtIndex:[num intValue]] objectForKey:@"tid"];
    photodetail.fid           = [[picarray objectAtIndex:[num intValue]] objectForKey:@"fid"];
    photodetail.picshow_coverpic = [[picarray objectAtIndex:[num intValue]] objectForKey:@"picshow_coverpic"];
    [photodetail setHidesBottomBarWhenPushed:YES];
    [myDelegate hideImage];
    [self.navigationController pushViewController:photodetail animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:158.0/255.0 green:26.0/255.0 blue:36.0/255.0 alpha:1.000]];
}
@end
