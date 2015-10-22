//
//  RecipeMapViewController.h
//  PA2Group7
//
//  Created by UH Game and Entrepreneurship on 10/22/15.
//  Copyright © 2015 ubicomp7. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Recipe.h"

@interface RecipeMapViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate>
@property (nonatomic,strong) Recipe* recipe;

@end
