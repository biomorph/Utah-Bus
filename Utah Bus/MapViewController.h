//
//  MapViewController.h
//  Utah Bus
//
//  Created by Ravi Alla on 8/6/12.
//  Copyright (c) 2012 Ravi Alla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController
@property (nonatomic, strong) NSDictionary *coordinates;
@end
