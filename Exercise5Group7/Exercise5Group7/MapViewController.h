//
//  MapViewController.h
//  Exercise5Group7
//
//  Created by Jared Jones on 10/8/15.
//  Copyright © 2015 team7. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "User.h"

@interface MapViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate>
@property (nonatomic, strong) User* user;
@end
