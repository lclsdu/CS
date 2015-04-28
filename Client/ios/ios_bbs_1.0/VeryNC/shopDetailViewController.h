//
//  shopDetailViewController.h
//  化龙巷
//
//  Created by wu jinjin on 12-3-21.
//  Copyright (c) 2012年 Osugroup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tools.h"
#import "ShopObject.h"
#import "evaluatorObject.h"
//#import "MoreFeedbackViewController.h"
#import "cellOfInfoShopDetailEvaluation.h"
#import "evaluationTableViewController.h"
#import "evaluationAddViewController.h"
#import <QuartzCore/QuartzCore.h>
#import  "DebugLog.h"
@interface shopDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
//    IBOutlet UITableView *tableViewForDetail;
    
//    UITableView *tableViewForDetail;
    NSMutableArray * resultArray;
    NSMutableArray * resultArrayOfEvaluator;
    NSArray * resultShoppicArray;
    BOOL sectionOne;
    UITableView *tableViewForDetail;
    UIView * moreView;
    UITextView * moreTextView;
    UIButton *button;
    int countOfRequest;
   
//    IBOutlet UITextView *descriptionView;
}
@property (retain, nonatomic) IBOutlet UILabel * titleLabel;
@property (retain, nonatomic) IBOutlet UIImageView *imageView;
@property (retain, nonatomic) IBOutlet UILabel *score;
@property (retain, nonatomic) IBOutlet UIButton *evaluateButton;
@property (retain, nonatomic) IBOutlet UIButton *photoButton;

@property (retain, nonatomic) UITableView *tableViewForDetail;
@property (retain, nonatomic) IBOutlet UIImageView *starOne;
@property (retain, nonatomic) IBOutlet UIImageView *starTwo;
@property (retain, nonatomic) IBOutlet UIImageView *starThree;
@property (retain, nonatomic) IBOutlet UIImageView *starFour;
@property (retain, nonatomic) IBOutlet UIImageView *starFive;
@property (retain, nonatomic) IBOutlet UILabel *evaluationLabel;
@property (retain, nonatomic) NSArray *resultShoppicArray;
@property (retain, nonatomic) NSMutableArray *resultArrayOfEvaluator;

@property (retain, nonatomic) IBOutlet UIScrollView *scrollerView;
- (IBAction)evaluateButtonClicked:(id)sender;

- (IBAction)photoButtonClicked:(id)sender;

@property (retain, nonatomic) IBOutlet NSString * shop_id;
@property (nonatomic,strong) NSString *api_url,*pic_url1,*pic_url2,*pic_url3;
@end
