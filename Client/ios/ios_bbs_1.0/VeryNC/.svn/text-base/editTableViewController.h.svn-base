//
//  editTableViewController.h
//  VeryNC
//
//  Created by wu jinjin on 12-4-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyProtocol.h"
#import "AppDelegate.h"
#import "Constants.h"
#import "Tools.h"
#import "newsHeaderObject.h"
#import "SqliteSet.h"

@interface editTableViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>{
    IBOutlet id<MyprotocolDelegate> myDelegate;
	AppDelegate *appDelegate;
    

    IBOutlet UITableView *editTableView;
    NSMutableArray * navigationArray;
    NSMutableArray * moreArray;
    NSMutableArray * navigationEditArray;
    NSMutableArray * moreEditArray;
    
    
    BOOL moveTag;


}

@property (retain,nonatomic) AppDelegate *appDelegate;
@property (nonatomic, assign)IBOutlet id<MyprotocolDelegate> myDelegate;


@property (nonatomic, assign) IBOutlet UITableView *editTableView;
@property (nonatomic, assign) NSMutableArray * navigationArray;
@property (nonatomic, assign) NSMutableArray * moreArray;
@property (nonatomic, assign) NSMutableArray * navigationEditArray;
@property (nonatomic, assign) NSMutableArray * moreEditArray;

@end
