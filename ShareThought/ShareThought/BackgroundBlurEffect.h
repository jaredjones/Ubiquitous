//
//  BackgroundBlurEffect.h
//  ShareThought
//
//  Created by Jared Jones on 10/23/15.
//  Copyright © 2015 Team7. All rights reserved.
//

#import <objc/runtime.h>

@interface UIBlurEffect (Protected)
@property (nonatomic, readonly) id effectSettings;
@end

@interface BackgroundBlurEffect : UIBlurEffect
@end

@implementation BackgroundBlurEffect

+ (instancetype)effectWithStyle:(UIBlurEffectStyle)style withRadius: (NSNumber *)radius
{
    id result = [super effectWithStyle:style];
    object_setClass(result, self);
    
    return result;
}

- (id)effectSettings
{
    id settings = [super effectSettings];
    for(id key in settings)
        NSLog(@"key=%@ key", key);
    
    [settings setValue:@10 forKey:@"blurRadius"];
    return settings;
}

- (id)copyWithZone:(NSZone*)zone
{
    id result = [super copyWithZone:zone];
    object_setClass(result, [self class]);
    return result;
}

@end