//
//  ViewController.h
//  Utah Bus
//
//  Created by Ravi Alla on 8/3/12.
//  Copyright (c) 2012 Ravi Alla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "UtaFetcher.h"
#import "UtaAPIKey.h"
#import <CoreData/CoreData.h>
#import "Routes.h"
#import "Shapes.h"
#import "Stops.h"
#import "Trips.h"



@interface UTAViewController : UIViewController <NSFetchedResultsControllerDelegate>
@property (strong, nonatomic) IBOutlet UITextField *routeName;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
