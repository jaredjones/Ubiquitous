//
//  MapViewController.m
//  Exercise5Group7
//
//  Created by Jared Jones on 10/8/15.
//  Copyright © 2015 team7. All rights reserved.
//

#import "MapViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <AddressBook/AddressBook.h>
#import <Contacts/Contacts.h>

#define METERS_MILE 1609.344
#define METERS_FEET 3.28084

@interface MapViewController()

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation MapViewController
- (void)viewDidLoad{
    
    [_mapView setShowsUserLocation:YES];
    _mapView.delegate = self;
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    if ([[self locationManager] respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [[self locationManager] requestWhenInUseAuthorization];
    }
    
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest; // 100 m
    //[_locationManager startUpdatingLocation];
    
    [self addGestureRecogniserToMapView];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder geocodeAddressString:[_user address] completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Invalid Address" message:@"The address does not exist for the user you are looking up." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
            
            NSLog(@"%@",error);
            return;
        }
        if (placemarks && placemarks.count > 0) {
            CLPlacemark *topResult = [placemarks objectAtIndex:0];
            
            MKPointAnnotation *point = [[MKPointAnnotation alloc]init];
            point.coordinate = topResult.location.coordinate;
            point.title = [[[_user firstName]stringByAppendingString:@" "]stringByAppendingString:[_user lastName]];
            point.subtitle = [_user address];
            
            MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(topResult.location.coordinate, 2*METERS_MILE, 2*METERS_MILE);
            [_mapView setRegion:viewRegion animated:YES];
            
            [_mapView addAnnotation:point];
            // add annotation to the map
        }
    }];
    
}

- (void)addGestureRecogniserToMapView{
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(addPinToMap:)];
    lpgr.minimumPressDuration = 0.5;
    [_mapView addGestureRecognizer:lpgr];
    
}

-(void)addPinToMap:(UIGestureRecognizer *)gestureRecognizer{
    if (gestureRecognizer.state != UIGestureRecognizerStateBegan)
        return;
    
    CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];
    CLLocationCoordinate2D touchMapCoordinate =
    [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
    
    MKPointAnnotation *toAdd = [[MKPointAnnotation alloc]init];
    
    CLLocation *loc = [[CLLocation alloc]initWithLatitude:touchMapCoordinate.latitude longitude:touchMapCoordinate.longitude];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:loc completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks && placemarks.count > 0) {
            CLPlacemark *topResult = [placemarks objectAtIndex:0];
            
            MKPointAnnotation *point = [[MKPointAnnotation alloc]init];
            point.coordinate = topResult.location.coordinate;
            
            
            NSString *zip = [[topResult addressDictionary] objectForKey:kABPersonAddressZIPKey];
            NSString *city = [[topResult addressDictionary] objectForKey:kABPersonAddressCityKey];
            NSString *state = [[topResult addressDictionary] objectForKey:kABPersonAddressStateKey];
            
            point.title = [[[[city stringByAppendingString:@", "] stringByAppendingString:state] stringByAppendingString:@", "]stringByAppendingString:zip];
            
            [_mapView addAnnotation:point];
            
            // add annotation to the map
        }
    }];
}

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    /*CLLocation *location = locations.lastObject;
    //location.coordinate.latitude
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 2*METERS_MILE, 2*METERS_MILE);
    [_mapView setRegion:viewRegion animated:YES];
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc]init];
    point.coordinate = location.coordinate;
    point.title = @"Your Location";
    
    [_mapView addAnnotation:point];
    
    NSLog(@"Lat:%f Lng:%f", location.coordinate.latitude, location.coordinate.longitude);
    
    [_locationManager stopUpdatingLocation];*/
}

@end
