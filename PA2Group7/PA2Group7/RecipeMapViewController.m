//
//  RecipeMapViewController.m
//  PA2Group7
//
//  Created by UH Game and Entrepreneurship on 10/22/15.
//  Copyright © 2015 ubicomp7. All rights reserved.
//

#import "RecipeMapViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <AddressBook/AddressBook.h>
#import <Contacts/Contacts.h>

#define METERS_MILE 1609.344
#define METERS_FEET 3.28084

@interface RecipeMapViewController ()

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation RecipeMapViewController

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
    
    
    CLLocationCoordinate2D pinCoordinate;
    double longitude = [_recipe.longitude doubleValue];
    double lat = [_recipe.latitude doubleValue];
    pinCoordinate.longitude = longitude;
    pinCoordinate.latitude = lat;
    MKPointAnnotation *point = [[MKPointAnnotation alloc]init];
    point.coordinate = pinCoordinate;
    point.title = [_recipe name];
    NSString *desc = [NSString stringWithFormat:@"%f, %f", lat, longitude];
    point.subtitle = desc;

    [_mapView addAnnotation:point];
            // add annotation to the map

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
