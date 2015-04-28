//
//  pickerView.h
//  化龙巷
//
//  Created by wu jinjin on 12-3-26.
//  Copyright (c) 2012年 Osugroup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tools.h"
#import "ShopObject.h"
#import  "DebugLog.h"
@interface pickerView : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource>{

    IBOutlet UIButton *done;
    IBOutlet UIButton *cancel;
    NSMutableArray * resultArray;
    NSMutableArray * resultRootArray;
    int indexOfComponent;
    int rowOfComponentOneCategory,rowOfComponentTwoCategory,rowOfComponentOneDistance;
    
}
@property (retain, nonatomic) IBOutlet UIPickerView *picker;
@property (retain, nonatomic) NSString * TAG;
@property (nonatomic,strong) NSString *api_url;
- (IBAction)cancelButtonClicked:(id)sender;

- (IBAction)doneButtonClicked:(id)sender;
@end
