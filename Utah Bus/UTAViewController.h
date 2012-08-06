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

/*@class UTAViewController;
@protocol UTAXMLFetcherDelegate

- (NSDictionary *) executeUtaFetcher : (UTAViewController *)sender:(NSString *) forQuery;
@end*/


@interface UTAViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *routeName;
@property (strong, nonatomic) IBOutlet UISwitch *showStops;
//@property (weak, nonatomic) id <UTAXMLFetcherDelegate> xmlDelegate;

@end
