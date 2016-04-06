//
//  MainViewController.m
//  MapView_Annotation
//
//  Created by Armor on 06/04/16.
//  Copyright © 2016 Armor. All rights reserved.
//

#import "MainViewController.h"
#import "Place.h"
#import "PlaceMark.h"
#import "MapView.h"

@interface MainViewController ()<CLLocationManagerDelegate,MKAnnotation,MKMapViewDelegate,MKOverlay>
{
    CLLocationManager *locationManager;
    
    NSString *fromLatti;
    NSString *fromLongi;
    MapView* mapView;
    
    MKPointAnnotation *car;
}
@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Current Location";
    
    [CLLocationManager locationServicesEnabled];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        [locationManager requestWhenInUseAuthorization];
    
    
    NSLog(@"User latitude: %f",locationManager.location.coordinate.latitude);
    NSLog(@"User longitude: %f",locationManager.location.coordinate.longitude);
    
    fromLatti =[NSString stringWithFormat:@"%f",locationManager.location.coordinate.latitude];
    fromLongi =[NSString stringWithFormat:@"%f",locationManager.location.coordinate.longitude];
    
    [locationManager startUpdatingLocation];
    
     mapView = [[MapView alloc] initWithFrame:
                        CGRectMake(0, 0, 320, 568)];
    
    [self.view addSubview:mapView];
    
    Place* home = [[Place alloc] init];
    home.name = @"Current Location";
    home.description = @"";
    home.latitude = [fromLatti doubleValue];
    home.longitude = [fromLongi doubleValue];

//    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
//    [[mapView viewForAnnotation:point] setTag:1];
//    UIImage *image = [UIImage imageNamed:@"pinshot.png"];
//    [[mapView viewForAnnotation:point] setImage:image];
    
   
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    
    if(annotation != _mapView.userLocation)
    {
        static NSString *reuseId = @"pin";
        MKPinAnnotationView *pav = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseId];
        if (pav == nil)
        {
            pav = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseId];
            pav.draggable = YES; // Right here baby!
            pav.canShowCallout = YES;
            pav.animatesDrop = YES;
            
        }
        else
        {
            pav.annotation = annotation;
            pav.image = [UIImage imageNamed:@"pinshot.png"];
        }
        
        return pav;
    }
    else
    {
        [_mapView.userLocation setTitle:@"Current Location"];
        return nil;
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
