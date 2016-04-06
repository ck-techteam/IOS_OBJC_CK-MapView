//
//  MainViewController.h
//  MapView_Annotation
//
//  Created by Armor on 06/04/16.
//  Copyright © 2016 Armor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MainViewController : UIViewController<MKMapViewDelegate>

@property(nonatomic,strong)IBOutlet MKMapView *mapView;
@end
