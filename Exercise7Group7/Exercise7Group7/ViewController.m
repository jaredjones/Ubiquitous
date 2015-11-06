//
//  ViewController.m
//  Exercise7Group7
//
//  Created by Jared Jones on 11/5/15.
//  Copyright © 2015 team7. All rights reserved.
//

#import "ViewController.h"

#import <CoreMotion/CoreMotion.h>


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;

@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@property (weak, nonatomic) IBOutlet UIImageView *imageView4;
@property (weak, nonatomic) IBOutlet UIImageView *imageView5;
@property (weak, nonatomic) IBOutlet UIImageView *imageView6;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imageViewCollection;

@property (strong, nonatomic)NSArray *imageViewArray;
@property NSUInteger currentIndex;

@property (strong, nonatomic) CMMotionManager *motionManager;
@property (strong, nonatomic) NSTimer *timer;
@property BOOL canFire;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _mainImageView.image = _imageView2.image;
    _currentIndex = 1;
    
    _imageViewArray = @[_imageView1, _imageView2, _imageView3, _imageView4, _imageView5, _imageView6];
    
    _timer = [[NSTimer alloc]init];
    _canFire = true;
    
    _motionManager = [[CMMotionManager alloc] init];
    _motionManager.deviceMotionUpdateInterval = 0.03; // update every 30ms
    [_motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue]
                                       withHandler:^(CMDeviceMotion *motion, NSError *error)
     {
         if (_canFire){
             if (motion.userAcceleration.x > 1.0 && motion.gravity.x > 0.5){
                 if (_currentIndex == 5 || _currentIndex == 2)
                     return;
                 _currentIndex++;
                 _mainImageView.image = ((UIImageView *)_imageViewArray[_currentIndex]).image;
                 _canFire = false;
                 [NSTimer scheduledTimerWithTimeInterval: 1.0
                                                  target: self
                                                selector:@selector(canFireIsTrue:)
                                                userInfo: nil repeats:NO];
             }else if (motion.userAcceleration.x > 1.0 && motion.gravity.y < -0.5){
                 if (_currentIndex == 0 || _currentIndex == 3)
                     return;
                 _currentIndex--;
                 _mainImageView.image = ((UIImageView *)_imageViewArray[_currentIndex]).image;
                 _canFire = false;
                 [NSTimer scheduledTimerWithTimeInterval: 1.0
                                                  target: self
                                                selector:@selector(canFireIsTrue:)
                                                userInfo: nil repeats:NO];
             }else if (motion.userAcceleration.z > 1.0 && motion.gravity.z > 0.5){
                 if (_currentIndex == 3 || _currentIndex == 4 || _currentIndex == 5)
                     return;
                 _canFire = false;
                 _currentIndex+=3;
                 _mainImageView.image = ((UIImageView *)_imageViewArray[_currentIndex]).image;
                 [NSTimer scheduledTimerWithTimeInterval: 1.0
                                                  target: self
                                                selector:@selector(canFireIsTrue:)
                                                userInfo: nil repeats:NO];
             }else if (motion.userAcceleration.z > 1.0 && motion.gravity.z < -0.5){
                 if (_currentIndex == 0 || _currentIndex == 1 || _currentIndex == 2)
                     return;
                 _currentIndex-=3;
                 _mainImageView.image = ((UIImageView *)_imageViewArray[_currentIndex]).image;
                 _canFire = false;
                 [NSTimer scheduledTimerWithTimeInterval: 1.0
                                                  target: self
                                                selector:@selector(canFireIsTrue:)
                                                userInfo: nil repeats:NO];
             }
         }
     }
     ];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)canFireIsTrue: (NSTimer *)timer{
    _canFire = true;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    
}

- (IBAction)cameraButtonPressed:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    
    UIImageView *chosenImgView = nil;
    for (UIImageView *view in _imageViewCollection){
        if (view.image == _mainImageView.image){
            chosenImgView = view;
            break;
        }
    }
    
    _mainImageView.image = chosenImage;
    chosenImgView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

@end
