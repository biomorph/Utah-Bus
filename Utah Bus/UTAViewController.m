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

@interface UTAViewController ()

@property (nonatomic, strong) NSString *onwardCalls;
@property (nonatomic, strong) NSDictionary *vehicleInfo;
@property (nonatomic, strong) UtaFetcher *utaFetcher;
@end

@implementation UTAViewController
@synthesize routeName = _routeName;
@synthesize showStops = _showStops;
@synthesize onwardCalls = _onwardCalls;
@synthesize utaFetcher = _utaFetcher;
@synthesize vehicleInfo = _vehicleInfo;


- (UtaFetcher *) utaFetcher
{
    if (!_utaFetcher) _utaFetcher = [[UtaFetcher alloc] init];
    return _utaFetcher;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.onwardCalls = @"false";
	// Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)showStops:(id)sender {
    if (self.showStops.on) self.onwardCalls = @"true";
    else self.onwardCalls = @"false";
}
- (IBAction)showBuses:(id)sender {
    NSString *urlString = [NSString stringWithFormat:@"http://api.rideuta.com/SIRI/SIRI.svc/VehicleMonitor/ByRoute?route=%@&onwardcalls=%@&usertoken=%@",self.routeName.text,self.onwardCalls,UtaAPIKey];
    dispatch_queue_t xmlGetter = dispatch_queue_create("UTA xml getter", NULL);
    dispatch_async(xmlGetter, ^{
        self.vehicleInfo = [self.utaFetcher executeUtaFetcher:urlString];
    dispatch_async(dispatch_get_main_queue(), ^{
        //[self performSegueWithIdentifier:@"show on map" sender:sender];
    });
    });
    dispatch_release(xmlGetter);
    

}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSArray *latitudes = [self.vehicleInfo objectForKey:LATITUDE];
    NSArray *longitudes = [self.vehicleInfo objectForKey:LONGITUDE];
    NSMutableArray *locations = [NSMutableArray arrayWithCapacity:[latitudes count]];
    for (int count = 0; count <= [latitudes count]; count++) {
        NSArray *location = [NSArray arrayWithObjects:[latitudes objectAtIndex:count],[longitudes objectAtIndex:count], nil];
        [locations addObject:location];
    }
    NSDictionary *coordinates = [NSDictionary dictionaryWithObject:locations forKey:@"bus locations"];
    if([segue.identifier isEqualToString:@"show on map"]){
        [segue.destinationViewController setCoordinates:coordinates];
    }
}

- (void)viewDidUnload
{
    [self setRouteName:nil];
    [self setShowStops:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
