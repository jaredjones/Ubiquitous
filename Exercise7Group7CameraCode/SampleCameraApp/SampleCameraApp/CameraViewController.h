//
//  CameraViewController.h
//  SampleCameraApp
//
//  Created by UH Game and Entrepreneurship on 11/3/15.
//  Copyright © 2015 Team7. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface CameraViewController : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property BOOL newMedia;
@property (nonatomic,strong) IBOutlet UIImageView *imageview;
- (IBAction)useCamera:(id)sender;
- (IBAction)useCameraRoll:(id)sender;

@end
