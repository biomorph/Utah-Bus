//
//  Shapes.h
//  Utah Bus
//
//  Created by Ravi Alla on 8/9/12.
//  Copyright (c) 2012 Ravi Alla. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Shapes : NSManagedObject

@property (nonatomic, retain) NSString * shape_id;
@property (nonatomic) float shape_pt_lat;
@property (nonatomic) float shape_pt_lon;
@property (nonatomic) int16_t shape_pt_sequence;

@end
