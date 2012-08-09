//
//  Stops.h
//  Utah Bus
//
//  Created by Ravi Alla on 8/9/12.
//  Copyright (c) 2012 Ravi Alla. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Stops : NSManagedObject

@property (nonatomic, retain) NSString * stop_code;
@property (nonatomic) float stop_lat;
@property (nonatomic) float stop_lon;
@property (nonatomic, retain) NSString * stop_name;

@end
