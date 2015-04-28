//
//  ShopMapViewController.m
//  化龙巷
//
//  Created by mac on 12-4-10.
//  Copyright (c) 2012年 Osugroup. All rights reserved.
//

#import "ShopMapViewController.h"
#import "customAnnotation.h"
@interface ShopMapViewController ()

@end

@implementation ShopMapViewController
@synthesize lat,lng,shopname;
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
    map = [[MKMapView alloc] initWithFrame:[self.view bounds]];
    map.mapType = MKMapTypeStandard;
    map.showsUserLocation = YES;
    
    CLLocationCoordinate2D coords = CLLocationCoordinate2DMake(lat,lng);
    float zoomLevel = 0.002;
    MKCoordinateRegion region = MKCoordinateRegionMake(coords,MKCoordinateSpanMake(zoomLevel,zoomLevel));
    [map setRegion:[map regionThatFits:region] animated:YES];
    [self.view addSubview:map];
    
    map.delegate = self;
    [self createAnnotationWithCoords:coords];
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

- (void)dealloc
{
    [map release];
    [super dealloc];
}
- (void)createAnnotationWithCoords:(CLLocationCoordinate2D) coords{
    customAnnotation *annotation = [[customAnnotation alloc] initWithCoordinate:coords];
    annotation.title = shopname;
    [map addAnnotation:annotation];
    [annotation release];
}
@end
