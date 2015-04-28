//
//  pickerView.m
//  化龙巷
//
//  Created by wu jinjin on 12-3-26.
//  Copyright (c) 2012年 Osugroup. All rights reserved.
//

#import "pickerView.h"
#import "AppDelegate.h"
#import "businessViewController.h"
@interface pickerView ()

@end

@implementation pickerView
@synthesize picker,TAG,api_url;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        picker.showsSelectionIndicator=YES;
//        picker.delegate=self;
//        picker.dataSource=self;
        
    }
    return self;
}

- (void)viewDidLoad
{
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    api_url = delegate.myDomainAndPathVeryNC;
    
    resultArray=[[NSMutableArray alloc]init];
    resultRootArray=[[NSMutableArray alloc]init];
    indexOfComponent=0;
    rowOfComponentOneCategory=0;
    rowOfComponentTwoCategory=0;
    rowOfComponentOneDistance=0;
   
    
    
    
    
    
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@zuobiao.php?type=shop_class",api_url]]];
	[request setDownloadCache:[ASIDownloadCache sharedCache]];
	[request setCachePolicy:ASIAskServerIfModifiedWhenStaleCachePolicy];
	[request setDelegate:self];
	[request startAsynchronous];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewDidAppear:(BOOL)animated{
//    UIView * viewOfBackground=[[picker subviews]objectAtIndex:0];
//    [viewOfBackground setBackgroundColor:[UIColor colorWithRed:35.0/255.0 green:206.0/255.0 blue:250.0/255.0 alpha:1.0]];
    

}




  
- (void)viewDidUnload
{
    [self setPicker:nil];
    [cancel release];
    cancel = nil;
    [done release];
    done = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [picker release];
    [cancel release];
    [done release];
    [super dealloc];
}

#pragma mark - UIPickerViewDelegate


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if ([self.TAG compare:@"category"]==0) {
        return 2;
    }else {
        return 1;
    }
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if ([self.TAG compare:@"category"]==0) {
        if (component==0) {
           
            return [resultRootArray count]+1;
        }else {
            int x=0;
            if ([resultRootArray count]>x) {
                if (indexOfComponent==x) {
                    return 0;
                }else{
                    return [[resultRootArray objectAtIndex:indexOfComponent-1] count]-1; 
                }
            }
            return [resultRootArray count];
        }
    }else {
        return 4;
    }
    
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
   
    
    
    if ([self.TAG compare:@"category"]==0) {
        if (component==0) {
            if (row==0) {
                return [NSString stringWithUTF8String:"全部分类"];
            }else{
                return [[[resultRootArray objectAtIndex:row-1]objectAtIndex:0]valueForKey:@"name"];
            }
        }
        return [[[resultRootArray objectAtIndex:indexOfComponent-1]objectAtIndex:row+1]valueForKey:@"name"];
    }else {
        if (row==0) {
            return [NSString stringWithUTF8String:"不限距离"];
        }else if (row==1) {
            return [NSString stringWithUTF8String:"附近两千米"];
        }else if (row==2){
            return [NSString stringWithUTF8String:"附近一千米"];
        
        }else if(row==3){
            return [NSString stringWithUTF8String:"附近五百米"];
        }
    }
    
}



//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
//    UILabel *retval = (id)view;
//    if (!retval) {
//        retval= [[[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView rowSizeForComponent:component].width, [pickerView rowSizeForComponent:component].height)] autorelease];
//    }
//    
//    
//    if ([self.TAG compare:@"category"]==0) {
//        if (component==0) {
//            if (row==0) {
//                retval.text= [NSString stringWithUTF8String:"全部分类"];
//            }else{
//                retval.text= [[[resultRootArray objectAtIndex:row-1]objectAtIndex:0]valueForKey:@"name"];
//            }
//        }
//       
//        retval.text =[[[resultRootArray objectAtIndex:indexOfComponent-1]objectAtIndex:row+1]valueForKey:@"name"];
//    }else {
//        
//        if (row==0) {
//            retval.text= [NSString stringWithUTF8String:"附近两千米"];
//        }else if (row==1){
//            retval.text= [NSString stringWithUTF8String:"附近一千米"];
//            
//        }else if(row==2){
//            retval.text= [NSString stringWithUTF8String:"附近五百米"];
//        }
//    }
//    
//
//    retval.font = [UIFont systemFontOfSize:20];
//    return retval;
//}







- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //NSLog(@"didSelectRow---%d",row);
    if ([self.TAG compare:@"category"]==0) { 
        if (component==0) {
            rowOfComponentOneCategory=row;
            indexOfComponent=row;//for checking if it is the All category 
            [picker selectRow:0 inComponent:1 animated:NO];
            [picker reloadComponent:1];  
        }else {
            rowOfComponentTwoCategory=row;
        }
    }else {
        rowOfComponentOneDistance=row;        
        
    }
    
    
    
    
    
    //    if (component==0&&[loadFinished isEqualToString:@"cityParse"]) {
    //        //get city array
    //        self.data=[NSMutableData data];
    //        NSString *provinceInfo=[provinces objectAtIndex:row];
    //        NSString *provinceCode=[provinceInfo substringFromIndex:([provinceInfo rangeOfString:@","].location+1)];
    //        NSString *soapMessage=[NSString stringWithFormat:@"theRegionCode=%@",provinceCode];
    //        //NSLog(soapMessage);
    //        NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    //        NSURL *url = [NSURL URLWithString:@"http://webservice.webxml.com.cn/WebServices/WeatherWS.asmx/getSupportCityDataset"];
    //        NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    //        [urlRequest addValue: @"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    //        [urlRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    //        [urlRequest setHTTPMethod:@"POST"];
    //        [urlRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    //        NSConnection *connection=[NSURLConnection connectionWithRequest:urlRequest delegate:self];
    //        [CityPicker selectRow:0 inComponent:1 animated:YES];
    //        [CityPicker reloadComponent:1];
    //    }
}


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    if ([self.TAG compare:@"category"]==0) { 
        return 120;
    
    
    
    }else{
    
    
        return 240;
    
    }
    
    
    
    
 }




#pragma mark - ASIHTTPDelegate
- (void)requestStarted:(ASIHTTPRequest *)request {
    
    
}

- (void)requestFinished:(ASIHTTPRequest *)request {
    
    if (resultArray) {
        [resultArray removeAllObjects];
    }
    [resultRootArray removeAllObjects];
    NSString *requestString = [request responseString];
    NSArray *tmpArray = [[requestString JSONValue] valueForKey:@"datas"];
    int a=0;
    NSMutableArray * secondLayerArray[[tmpArray count]];
    
    for (int i = 0; i < [tmpArray count]; i++) {
        ShopObject * shopDetail =  [[ShopObject alloc] init];
        
        shopDetail.cid = [[[tmpArray objectAtIndex:i] valueForKey:@"cid"] intValue];
        shopDetail.pid = [[[tmpArray objectAtIndex:i] valueForKey:@"pid"] intValue];
        shopDetail.name = [[tmpArray objectAtIndex:i] valueForKey:@"name"] ;
        [resultArray addObject:shopDetail];
        int x=0;
        if (shopDetail.pid==x) {
            secondLayerArray[a]=[[NSMutableArray alloc] init];
            [secondLayerArray[a] addObject:shopDetail];
//            NSLog(@"shopDetail: %d",shopDetail.cid);
            [resultRootArray addObject:secondLayerArray[a]];
            a++;
            [ShopObject release];
        }   
    
    }
 
    
    
    
    
    for (int i = 0; i < [tmpArray count]; i++) {
        ShopObject * shopDetail =  [[ShopObject alloc] init];
        
        shopDetail.cid = [[[tmpArray objectAtIndex:i] valueForKey:@"cid"] intValue];
        shopDetail.pid = [[[tmpArray objectAtIndex:i] valueForKey:@"pid"] intValue];
        shopDetail.name = [[tmpArray objectAtIndex:i] valueForKey:@"name"] ;
        for (int ii=0; ii<[resultRootArray count]; ii++) {
            ShopObject * tmp= [[resultRootArray objectAtIndex:ii] objectAtIndex:0];
            if (shopDetail.pid==tmp.cid) {
                [[resultRootArray objectAtIndex:ii]addObject:shopDetail];
                
            }
            
        }
   
    }

    [picker reloadAllComponents];

    
}

#pragma mark -buttonClicked

- (IBAction)cancelButtonClicked:(id)sender {
    
    [self.view removeFromSuperview];
}

- (IBAction)doneButtonClicked:(id)sender {
    //NSLog(@"in_donebutton_function");
    if ([self.TAG compare:@"category"]==0) { 
        if (rowOfComponentOneCategory==0) {
            NSString * classOff=[NSString stringWithString:@"classOff"]; 
            [[NSNotificationCenter defaultCenter]postNotificationName:@"classToBeOff" object:classOff];
            
            
        }else {
            if ([[resultRootArray objectAtIndex:rowOfComponentOneCategory-1]count]>1) {
                //     NSLog(@"updateInfoAccordingToComponentTwoCategory %@",[[[resultRootArray objectAtIndex:rowOfComponentOneCategory-1] objectAtIndex:rowOfComponentTwoCategory+1]valueForKey:@"cid"]);
                
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"updateInfoAccordingToComponentTwoCategory" object:[[resultRootArray objectAtIndex:rowOfComponentOneCategory-1] objectAtIndex:rowOfComponentTwoCategory+1]];
               
        
            
            }else {
                [[NSNotificationCenter defaultCenter]postNotificationName:@"updateInfoAccordingToComponentOneCategory" object:[[resultRootArray objectAtIndex:rowOfComponentOneCategory-1] objectAtIndex:0]]; 
                
              //  NSLog(@"updateInfoAccordingToComponentOneCategory %@",[[[resultRootArray objectAtIndex:rowOfComponentOneCategory-1] objectAtIndex:0]valueForKey:@"pid"]); 
            }
        }
    }
    else {
       [[NSNotificationCenter defaultCenter]postNotificationName:@"updateInfoAccordingToDistance" object:[NSString stringWithFormat:@"%d",rowOfComponentOneDistance]];
        
        
    }
    
    [self.view removeFromSuperview];
}

//user defaults
-(bool)checkIfHasLogIn;
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; 
    
    
    NSFileManager* fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:[documentsDirectory stringByAppendingPathComponent:@"nowlogin.plist"] isDirectory:NULL]) 
        
    {
        
        NSDictionary *now = [NSKeyedUnarchiver unarchiveObjectWithFile:[documentsDirectory stringByAppendingPathComponent:@"nowlogin.plist"]];
        NSString *nowname  = [now objectForKey:@"username"];
        
        if(nowname==nil)
            return NO;
        else  
            
            return YES;
    }
    else {
        
        return NO;
        
    }
    
    
}



@end
