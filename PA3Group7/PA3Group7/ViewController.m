//
//  ViewController.m
//  PA3Group7
//
//  Created by Jared Jones on 11/19/15.
//  Copyright © 2015 Jared Jones. All rights reserved.
//

#import <CoreMotion/CoreMotion.h>

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *topBar;
@property (weak, nonatomic) IBOutlet UIView *bottomBar;
@property (weak, nonatomic) IBOutlet UIView *leftBar;
@property (weak, nonatomic) IBOutlet UIView *rightBar;

@property (nonatomic, strong) UIView *sprite;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UITapGestureRecognizer *tapGest;
@property (nonatomic, strong) UIPinchGestureRecognizer *pinchGest;
@property (nonatomic, strong) UIPanGestureRecognizer *panGest;
@property (strong, nonatomic) CMMotionManager *motionManager;
@property CGFloat sWidth;

@property CGFloat xTilt;
@property CGFloat yTilt;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _sprite = [[UIView alloc]init];
    _sWidth = 150;
    [_sprite setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:_sprite];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidLayoutSubviews{
    [_sprite setFrame:CGRectMake(self.view.frame.size.width / 2 - (_sWidth / 2),
                                 self.view.frame.size.height / 2 - (_sWidth / 2)
                                 ,_sWidth,
                                 _sWidth)];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.01666 target:self selector:@selector(updateFrame:) userInfo:nil repeats:YES];
    
    _motionManager = [[CMMotionManager alloc] init];
    _motionManager.deviceMotionUpdateInterval = 0.03; // update every 30ms
    [_motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue]
                                        withHandler:^(CMDeviceMotion *motion, NSError *error){
                                            _xTilt= motion.gravity.x;
                                            _yTilt = motion.gravity.y;
    }];
    
    _tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(spriteTapped:)];
    _tapGest.numberOfTapsRequired = 2;
    
    _pinchGest = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(spritePinched:)];
    
    _panGest = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(spritePanned:)];
    
    [_sprite addGestureRecognizer:_tapGest];
    [_sprite addGestureRecognizer:_pinchGest];
    [_sprite addGestureRecognizer:_panGest];
}

CGPoint startPoint;
- (void)spritePanned: (UIPanGestureRecognizer*) pGest{
    if (pGest.state == UIGestureRecognizerStateBegan){
        [_timer invalidate];
        startPoint = CGPointMake(_sprite.frame.origin.x, _sprite.frame.origin.y);
    }
    
    if (pGest.state == UIGestureRecognizerStateEnded){
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.01666 target:self selector:@selector(updateFrame:) userInfo:nil repeats:YES];
    }
    
    CGPoint p = [pGest translationInView:self.view];
    CGRect rect = _sprite.frame;
    
    if ((startPoint.x + p.x) >= (self.view.frame.size.width - _sWidth - 30)){
        [_sprite setBackgroundColor: _rightBar.backgroundColor];
        rect.origin.x = (self.view.frame.size.width - _sWidth - 30);
    }else if((startPoint.x + p.x) <= 30)
    {
        [_sprite setBackgroundColor: _leftBar.backgroundColor];
        rect.origin.x = 30;
    }else{
        rect.origin.x = startPoint.x + p.x;
    }
    
    if ((startPoint.y + p.y) >= (self.view.frame.size.height - _sWidth - 30)){
        rect.origin.y = (self.view.frame.size.height - _sWidth - 30);
        [_sprite setBackgroundColor: _bottomBar.backgroundColor];
    }else if((startPoint.y + p.y) <= 30){
        rect.origin.y = 30;
        [_sprite setBackgroundColor: _topBar.backgroundColor];
    }
    else{
        rect.origin.y = startPoint.y + p.y;
    }
    
    BOOL topLeft = rect.origin.x == 30 && rect.origin.y == 30;
    BOOL topRight = rect.origin.x == self.view.frame.size.width - _sWidth - 30 &&
    rect.origin.y == 30;
    BOOL bottomLeft = rect.origin.x == 30 &&
    rect.origin.y == self.view.frame.size.height - _sWidth - 30;
    BOOL bottomRight = rect.origin.x == self.view.frame.size.width - _sWidth - 30 &&
    rect.origin.y == self.view.frame.size.height - _sWidth - 30;
    
    
    if (topLeft || topRight || bottomLeft || bottomRight ){
        [_sprite setBackgroundColor: [UIColor blackColor]];
    }
    
    [_sprite setFrame:rect];
}

BOOL isSquare = YES;
CGFloat staticNumber;
- (void)spritePinched: (UIPinchGestureRecognizer *)pGest{
    if (pGest.state == UIGestureRecognizerStateEnded){
        staticNumber = _sWidth;
        return;
    }
    if (pGest.state == UIGestureRecognizerStateBegan){
        staticNumber = _sWidth;
    }
    
    CGRect frm = _sprite.frame;
    _sWidth = staticNumber * pGest.scale;
    frm.size.width = _sWidth;
    frm.size.height = _sWidth;
    
    if (frm.size.width >= self.view.frame.size.width / 2){
        frm.size.width = self.view.frame.size.width / 2;
        frm.size.height = self.view.frame.size.width / 2;
        _sWidth = frm.size.width;
    }
    
    if (!isSquare){
        [_sprite.layer setCornerRadius:_sWidth / 2];
    }
    
    [_sprite setFrame:frm];
}

- (void)spriteTapped: (UITapGestureRecognizer *)gRec{
    if (isSquare){
        isSquare = NO;
        [_sprite.layer setCornerRadius:_sWidth / 2];
    }else{
        [_sprite.layer setCornerRadius:0.0f];
        isSquare = YES;
    }
}

- (void)updateFrame: (NSTimer *)timer{
    CGRect frm = _sprite.frame;
    frm.origin.x = frm.origin.x += _xTilt*15;
    frm.origin.y = frm.origin.y -= _yTilt*15;
    
    
    if (frm.origin.x >= (self.view.frame.size.width - _sWidth - 30)){
        frm.origin.x = self.view.frame.size.width - _sWidth - 30;
        [_sprite setBackgroundColor: _rightBar.backgroundColor];
    }
    
    if (frm.origin.x <=  30){
        frm.origin.x = 30;
        [_sprite setBackgroundColor: _leftBar.backgroundColor];
    }
    
    if (frm.origin.y <= 30){
        frm.origin.y = 30;
        [_sprite setBackgroundColor: _topBar.backgroundColor];
    }
    
    if (frm.origin.y >= self.view.frame.size.height - _sWidth - 30){
        frm.origin.y = self.view.frame.size.height - _sWidth - 30;
        [_sprite setBackgroundColor: _bottomBar.backgroundColor];
    }
    
    BOOL topLeft = frm.origin.x == 30 && frm.origin.y == 30;
    BOOL topRight = frm.origin.x == self.view.frame.size.width - _sWidth - 30 &&
                    frm.origin.y == 30;
    BOOL bottomLeft = frm.origin.x == 30 &&
                        frm.origin.y == self.view.frame.size.height - _sWidth - 30;
    BOOL bottomRight = frm.origin.x == self.view.frame.size.width - _sWidth - 30 &&
                        frm.origin.y == self.view.frame.size.height - _sWidth - 30;
    
    
    if (topLeft || topRight || bottomLeft || bottomRight ){
        [_sprite setBackgroundColor: [UIColor blackColor]];
    }
    
    [_sprite setFrame:frm];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake)
    {
        NSInteger aRedValue = arc4random()%255;
        NSInteger aGreenValue = arc4random()%255;
        NSInteger aBlueValue = arc4random()%255;
        
        UIColor *randColor = [UIColor colorWithRed:aRedValue/255.0f green:aGreenValue/255.0f blue:aBlueValue/255.0f alpha:1.0f];
        self.view.backgroundColor = randColor;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return (UIInterfaceOrientationMaskPortrait);
}

@end
