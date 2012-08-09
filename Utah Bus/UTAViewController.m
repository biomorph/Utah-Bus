//
//  ViewController.m
//  Utah Bus
//
//  Created by Ravi Alla on 8/3/12.
//  Copyright (c) 2012 Ravi Alla. All rights reserved.
//

#import "UTAViewController.h"
#import "UtaFetcher.h"
#import "MapViewController.h"
#import "LocationAnnotation.h"

@interface UTAViewController ()

@property (nonatomic, strong) NSString *onwardCalls;
@property (nonatomic, strong) NSArray *vehicleInfoArray;
@property (nonatomic, strong) UtaFetcher *utaFetcher;
@property (nonatomic, strong) LocationAnnotation *annotation;
@end

@implementation UTAViewController
@synthesize routeName = _routeName;
@synthesize onwardCalls = _onwardCalls;
@synthesize utaFetcher = _utaFetcher;
@synthesize vehicleInfoArray = _vehicleInfoArray;
@synthesize managedObjectContext = _managedObjectContext;


- (UtaFetcher *) utaFetcher
{
    if (!_utaFetcher) _utaFetcher = [[UtaFetcher alloc] init];
    return _utaFetcher;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Routes"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:NULL];
    for (NSManagedObject *route in fetchedObjects){
        NSLog(@"routeID is %@",[route valueForKey:@"route_long_name"]);
    }
}

//This method dismisses the onscreen keyboard when touched away from text field
- (void)touchesEnded: (NSSet *)touches withEvent: (UIEvent *)event {
    
    for (UIView* view in self.view.subviews) {
        
        if ([view isKindOfClass:[UITextField class]])
            
            [view resignFirstResponder];
        
    }
    
}

- (IBAction)showBuses:(id)sender {
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [spinner startAnimating];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:spinner];
    NSString *urlString = [NSString stringWithFormat:@"http://api.rideuta.com/SIRI/SIRI.svc/VehicleMonitor/ByRoute?route=%@&onwardcalls=true&usertoken=%@",self.routeName.text,UtaAPIKey];
    dispatch_queue_t xmlGetter = dispatch_queue_create("UTA xml getter", NULL);
    dispatch_async(xmlGetter, ^{
        self.vehicleInfoArray = [self.utaFetcher executeUtaFetcher:urlString];
        [spinner stopAnimating];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self performSegueWithIdentifier:@"show on map" sender:sender];
    });
    });
    dispatch_release(xmlGetter);
   

}
- (NSArray *) mapAnnotations
{
    NSMutableArray *annotations = [NSMutableArray arrayWithCapacity:[self.vehicleInfoArray count]];
    for(NSDictionary *vehicle in self.vehicleInfoArray){
        [annotations addObject:[LocationAnnotation annotationForVehicleOrStop:vehicle]];
        
    }
    return annotations;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"show on map"]){
        [segue.destinationViewController setAnnotations:[self mapAnnotations]];
    }
}

- (void)viewDidUnload
{
    [self setRouteName:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
