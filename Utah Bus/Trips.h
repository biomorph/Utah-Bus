//
//  Trips.h
//  Utah Bus
//
//  Created by Ravi Alla on 8/9/12.
//  Copyright (c) 2012 Ravi Alla. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Trips : NSManagedObject

@property (nonatomic, retain) NSString * route_id;
@property (nonatomic, retain) NSString * trip_headsign;
@property (nonatomic, retain) NSString * shape_id;

@end
