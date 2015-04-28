//
//  InfoSlideshow.m
//  Photoshow
//
//  Created by WANG ZHENG on 10-8-10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "InfoTableViewHeader.h"


@implementation InfoTableViewHeader


-(void) setHeaderTitle:(NSString*)s ;
{
	
	[headerTitle release];
	headerTitle= [s copy];
	
}
-(NSString *) getHeaderTitle;
{
	return [[headerTitle copy] autorelease];
	
}
-(void) setIsFolded:(bool)v ;
{
	isFolded=v;
}
-(bool) getIsFolded;
{
	
	return isFolded;
	
}

-(void) setIdTable:(NSInteger)n ;
{
	 idTable=n;
}
	
-(NSInteger) getIdTable ;
{
	return idTable;
}
- (void)dealloc {
	[headerTitle release];
 
    [super dealloc];
}
@end
