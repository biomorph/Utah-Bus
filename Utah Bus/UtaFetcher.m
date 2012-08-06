//
//  UtaFetcher.m
//  Utah Bus
//
//  Created by Ravi Alla on 8/3/12.
//  Copyright (c) 2012 Ravi Alla. All rights reserved.
//

#import "UtaFetcher.h"
#import "UTAViewController.h"
@interface UtaFetcher()//<UTAXMLFetcherDelegate>
@property (nonatomic, strong) NSMutableArray *publishedLineName;
@property (nonatomic, strong) NSMutableArray *vehicleLatitude;
@property (nonatomic, strong) NSMutableArray *vehicleLongitude;
@property (nonatomic, strong) NSMutableArray *progressRate;
@property (nonatomic, strong) NSMutableArray *departureTime;
@property (nonatomic, strong) NSMutableArray *directionOfVehicle;
@property (nonatomic, strong) NSMutableArray *stopIdsAlongTheWay;
@property (nonatomic, strong) NSMutableString *currentNode;
@end


@implementation UtaFetcher

@synthesize vehicleInfo = _vehicleInfo;
@synthesize publishedLineName = _publishedLineName;
@synthesize vehicleLatitude = _vehicleLatitude;
@synthesize vehicleLongitude = _vehicleLongitude;
@synthesize progressRate = _progressRate;
@synthesize departureTime = _departureTime;
@synthesize directionOfVehicle = _directionOfVehicle;
@synthesize stopIdsAlongTheWay = _stopIdsAlongTheWay;
@synthesize currentNode = _currentNode;




// Get the xml data from UTA website and send it to an NSXMLParser instance
- (NSDictionary *) executeUtaFetcher :(NSString *) forQuery
{
    BOOL success;
    NSXMLParser *xmlParser;
    NSString *query = [forQuery stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSData *xmlData = [NSData dataWithContentsOfURL:[NSURL URLWithString:query]];
    xmlParser = [[NSXMLParser alloc] initWithData:xmlData];
    [xmlParser setDelegate:self];
    [xmlParser setShouldResolveExternalEntities:YES];
     success = [xmlParser parse];
    return self.vehicleInfo;
    
}

//Lazily instantiate the vehicle info dictionary and other mutable arrays used for holding the parsed data
- (NSMutableDictionary *) vehicleInfo {
    if (!_vehicleInfo) {
        _vehicleInfo = [[NSMutableDictionary alloc] init];
    }
    return _vehicleInfo;
}

- (NSMutableArray *) publishedLineName {
    if (!_publishedLineName){
        _publishedLineName = [[NSMutableArray alloc]init];
    }
    return _publishedLineName;
}
- (NSMutableArray *) vehicleLatitude {
    if (!_vehicleLatitude){
        _vehicleLatitude = [[NSMutableArray alloc]init];
    }
    return _vehicleLatitude;
}
- (NSMutableArray *) vehicleLongitude {
    if (!_vehicleLongitude){
        _vehicleLongitude = [[NSMutableArray alloc]init];
    }
    return _vehicleLongitude;
}
- (NSMutableArray *) progressRate {
    if (!_progressRate){
        _progressRate = [[NSMutableArray alloc]init];
    }
    return _progressRate;
}
- (NSMutableArray *) departureTime {
    if (!_departureTime){
        _departureTime = [[NSMutableArray alloc]init];
    }
    return _departureTime;
}
- (NSMutableArray *) directionOfVehicle {
    if (!_directionOfVehicle){
        _directionOfVehicle = [[NSMutableArray alloc]init];
    }
    return _directionOfVehicle;
}

- (NSMutableArray *) stopIdsAlongTheWay {
    if (!_stopIdsAlongTheWay){
        _stopIdsAlongTheWay = [[NSMutableArray alloc]init];
    }
    return _stopIdsAlongTheWay;
}
- (NSMutableString *) currentNode {
    if (!_currentNode){
        _currentNode = [[NSMutableString alloc]init];
    }
    return _currentNode;
}

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    
}

// NSXMLParser delegate method,that creates a string by concatenating the characters into currentNode when characters are found in elements 
- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [self.currentNode appendString:string];
}

// NSXMLParser delegate method, that adds the currentNode string to different mutable arrays depending on element name, when an element ends 
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:PUBLISHED_LINE_NAME]) {
        [self.publishedLineName addObject:self.currentNode];
    }
    if ([elementName isEqualToString:LATITUDE]) {
        [self.vehicleLatitude addObject:self.currentNode];
    }
    if ([elementName isEqualToString:LONGITUDE]) {
        [self.vehicleLongitude addObject:self.currentNode];
    }
    if ([elementName isEqualToString:PROGRESS_RATE]) {
        [self.progressRate addObject:self.currentNode];
    }
    if ([elementName isEqualToString:DEPARTURE_TIME]){
        [self.departureTime addObject:self.currentNode];
    }
    if ([elementName isEqualToString:DIRECTION_OF_VEHICLE]){
        [self.directionOfVehicle addObject:self.currentNode];
    }
    if ([elementName isEqualToString:STOP_ID_ALONG_THE_WAY]){
        [self.stopIdsAlongTheWay addObject:self.currentNode];
    }
    self.currentNode = nil;
}

// NSXMLParser delegate method, that populates the vehicle info dictionary with the mutable arrays created in the method above, when the xml document is parsed completely, it also sets the contents of the mutable arrays to nil;
- (void) parserDidEndDocument:(NSXMLParser *)parser
{
    self.vehicleInfo = [NSDictionary dictionaryWithObjectsAndKeys:self.publishedLineName,PUBLISHED_LINE_NAME,self.vehicleLatitude,LATITUDE,self.vehicleLongitude,LONGITUDE,self.progressRate,PROGRESS_RATE,self.departureTime,DEPARTURE_TIME,self.directionOfVehicle,DIRECTION_OF_VEHICLE,self.stopIdsAlongTheWay,STOP_ID_ALONG_THE_WAY, nil];
    self.publishedLineName = nil;
    self.vehicleLatitude = nil;
    self.vehicleLongitude = nil;
    self.progressRate = nil;
    self.departureTime = nil;
    self.directionOfVehicle = nil;
    self.stopIdsAlongTheWay =nil;
}

@end
