//
//  WEPopoverContentViewController.h
//  WEPopover
//
//  Created by Werner Altewischer on 06/11/10.
//  Copyright 2010 Werner IT Consultancy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import  "DebugLog.h"

@interface WEPopoverContentViewController : UITableViewController {

    NSInteger arrayCount;
}


@property (nonatomic, assign) int  arrayCount;
@property (nonatomic,strong)NSMutableArray *itemArray;
-(void)reloadTableView;

@end
