//
//  Created by Jesse Squires
//  http://www.jessesquires.com
//
//
//  Documentation
//  http://cocoadocs.org/docsets/JSQMessagesViewController
//
//
//  GitHub
//  https://github.com/jessesquires/JSQMessagesViewController
//
//
//  License
//  Copyright (c) 2014 Jesse Squires
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

#import "JSQMessages.h"

/**
 *  This is for demo/testing purposes only.
 *  This object sets up some fake model data.
 *  Do not actually do anything like this.
 */

static NSString * const kJSQDemoAvatarDisplayNameSelf = @"Jared Jones";
static NSString * const kJSQDemoAvatarDisplayNameStefan = @"Stefan Theard";
static NSString * const kJSQDemoAvatarDisplayNameTim = @"Timothy Dickson";
static NSString * const kJSQDemoAvatarDisplayNameFaysal = @"Faysal Sharif";
static NSString * const kJSQDemoAvatarDisplayNameAidaly = @"Aidaly Santamaria";

static NSString * const kJSQDemoAvatarIdSelf = @"053496-4509-289";
static NSString * const kJSQDemoAvatarIdStefan = @"468-768355-23123";
static NSString * const kJSQDemoAvatarIdTim = @"707-8956784-57";
static NSString * const kJSQDemoAvatarIdFaysal = @"309-41802-93823";
static NSString * const kJSQDemoAvatarIdAidaly = @"329-41202-23523";



@interface DemoModelData : NSObject

@property (strong, nonatomic) NSMutableArray *messages;

@property (strong, nonatomic) NSDictionary *avatars;

@property (strong, nonatomic) JSQMessagesBubbleImage *outgoingBubbleImageData;

@property (strong, nonatomic) JSQMessagesBubbleImage *incomingBubbleImageData;

@property (strong, nonatomic) NSDictionary *users;

- (void)addPhotoMediaMessage;

- (void)addLocationMediaMessageCompletion:(JSQLocationMediaItemCompletionBlock)completion;

- (void)addVideoMediaMessage;

@end