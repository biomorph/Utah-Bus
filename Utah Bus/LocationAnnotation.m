//
//  LocationAnnotation.m
//  Utah Bus
//
//  Created by Ravi Alla on 8/6/12.
//  Copyright (c) 2012 Ravi Alla. All rights reserved.
//

#import "LocationAnnotation.h"
#import "UtaFetcher.h"

@implementation LocationAnnotation
+ (LocationAnnotation *) annotationForVehicleOrStop: (NSDictionary *) vehicleOrStop
{
    LocationAnnotation *annotation = [[LocationAnnotation alloc]init];
    annotation.vehicleOrStop = vehicleOrStop;
    return annotation;
}

- (NSString *) title
{
    return nil;
}

@end
