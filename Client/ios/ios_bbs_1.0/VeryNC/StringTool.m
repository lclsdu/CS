//
//  StringTool.m
//  欧神诺ShowSide
//
//  Created by apple on 11-7-2.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StringTool.h"


@implementation StringTool
+(NSArray *)fenxiStringArray:(NSString *)string separate:(NSString *)sp {
	NSArray *array = [string componentsSeparatedByString:sp];
	NSString *temString = @"";
	int temCount= 0;
	for(NSString *s in array) {
		if (temCount==0) {
			if (!([s isEqualToString:@""]||s.length<2||s==nil)){
				temString = [NSString stringWithFormat:@"%@",s];	
				temCount++;
			} 
		}else {
			if (!([s isEqualToString:@""]||s.length<2||s==nil)){
				temString = [NSString stringWithFormat:@"%@,%@",temString,s];
			} 
		}
		
	}
	return [temString componentsSeparatedByString:sp];
	
}

//校验用户名
+ (BOOL) validateUserName : (NSString *) str
{
    NSString *patternStr = [NSString stringWithFormat:@"^.{0,4}$|.{21,}|^[^A-Za-z0-9\u4E00-\u9FA5]|[^\\w\u4E00-\u9FA5.-]|([_.-])\1"];
    NSRegularExpression *regularexpression = [[NSRegularExpression alloc] 
                                              initWithPattern:patternStr
                                              options:NSRegularExpressionCaseInsensitive 
                                              error:nil];
    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:str 
                                                                  options:NSMatchingReportProgress
                                                                    range:NSMakeRange(0, str.length)];
    
    [regularexpression release];
    
    if(numberofMatch > 0)
    {
        return YES;
    }
    return NO;
}

//校验用户密码
+ (BOOL) validateUserPasswd : (NSString *) str
{
    
    NSRegularExpression *regularexpression = [[NSRegularExpression alloc] 
                                              initWithPattern:@"^[a-zA-Z0-9]{6,16}$"
                                              options:NSRegularExpressionCaseInsensitive 
                                              error:nil];
    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:str 
                                                                  options:NSMatchingReportProgress
                                                                    range:NSMakeRange(0, str.length)];
    
    [regularexpression release];
    
    if(numberofMatch > 0)
    {
        NSLog(@"%@ isNumbericString: YES", str);
        return YES;
    }
    
    NSLog(@"%@ isNumbericString: NO", str);
    return NO;
}

//校验用户生日
+ (BOOL) validateUserBornDate : (NSString *) str
{
    
    NSString *patternStr = @"^((((1[6-9]|[2-9]\\d)\\d{2})-(0?[13578]|1[02])-(0?[1-9]|[12]\\d|3[01]))|(((1[6-9]|[2-9]\\d)\\d{2})-(0?[13456789]|1[012])-(0?[1-9]|[12]\\d|30))|(((1[6-9]|[2-9]\\d)\\d{2})-0?2-(0?[1-9]|1\\d|2[0-8]))|(((1[6-9]|[2-9]\\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))-0?2-29-))$";
    NSRegularExpression *regularexpression = [[NSRegularExpression alloc] 
                                              initWithPattern:patternStr
                                              options:NSRegularExpressionCaseInsensitive 
                                              error:nil];
    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:str 
                                                                  options:NSMatchingReportProgress
                                                                    range:NSMakeRange(0, str.length)];
    
    [regularexpression release];
    
    if(numberofMatch > 0)
    {
        NSLog(@"%@ isNumbericString: YES", str);
        return YES;
    }
    
    NSLog(@"%@ isNumbericString: NO", str);
    return NO;
}

//校验用户手机号码
+ (BOOL) validateUserPhone : (NSString *) str
{
    NSRegularExpression *regularexpression = [[NSRegularExpression alloc] 
                                              initWithPattern:@"((\\d{11})|^((\\d{7,8})|(\\d{4}|\\d{3})-(\\d{7,8})|(\\d{4}|\\d{3})-(\\d{7,8})-(\\d{4}|\\d{3}|\\d{2}|\\d{1})|(\\d{7,8})-(\\d{4}|\\d{3}|\\d{2}|\\d{1}))$)"
                                              options:NSRegularExpressionCaseInsensitive 
                                              error:nil];
    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:str 
                                                                  options:NSMatchingReportProgress
                                                                    range:NSMakeRange(0, str.length)];
    
    [regularexpression release];
    
    if(numberofMatch > 0)
    {
        NSLog(@"%@ isNumbericString: YES", str);
        return YES;
    }
    
    NSLog(@"%@ isNumbericString: NO", str);
    return NO;
}

//校验用户邮箱
+ (BOOL) validateUserEmail : (NSString *) str
{
    NSRegularExpression *regularexpression = [[NSRegularExpression alloc] 
                                              initWithPattern:@"\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*"
                                              options:NSRegularExpressionCaseInsensitive 
                                              error:nil];
    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:str 
                                                                  options:NSMatchingReportProgress
                                                                    range:NSMakeRange(0, str.length)];
    
    [regularexpression release];
    
    if(numberofMatch > 0)
    {
        NSLog(@"%@ isNumbericString: YES", str);
        return YES;
    }
    
    NSLog(@"%@ isNumbericString: NO", str);
    return NO;
}

@end
