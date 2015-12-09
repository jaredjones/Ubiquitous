
#import "DemoModelData.h"

@implementation DemoModelData

- (instancetype)init
{
    self = [super init];
    if (self) {
        _idSelf = @"5812-2891-582";
        _idOther = @"2850-52-691";
        
        _displayNameSelf = @"Jared Jones";
        _displayNameOther = @"Stefan Theard";
        
        self.messages = [[NSMutableArray alloc]init];
        
        /*
         self.messages = [[NSMutableArray alloc] initWithObjects:
         [[JSQMessage alloc] initWithSenderId:_idSelf
         senderDisplayName:_displayNameSelf
         date:[NSDate distantPast]
         text:@"This project is amazing, but we need to further improve the UI Design!"],
         
         [[JSQMessage alloc] initWithSenderId:_idOther
         senderDisplayName:_displayNameOther
         date:[NSDate distantPast]
         text:@"I agree, we need to improve the design of this application."],
         nil];
         */
        
        
        
        
        /**
         *  Create avatar images once.
         *
         *  Be sure to create your avatars one time and reuse them for good performance.
         *
         *  If you are not using avatars, ignore this.
         */
        /*JSQMessagesAvatarImage *jsqImage = [JSQMessagesAvatarImageFactory avatarImageWithUserInitials:@"JSQ"
                                                                                      backgroundColor:[UIColor colorWithWhite:0.85f alpha:1.0f]
                                                                                            textColor:[UIColor colorWithWhite:0.60f alpha:1.0f]
                                                                                                 font:[UIFont systemFontOfSize:14.0f]
                                                                                             diameter:kJSQMessagesCollectionViewAvatarSizeDefault];
        
        JSQMessagesAvatarImage *cookImage = [JSQMessagesAvatarImageFactory avatarImageWithImage:[UIImage imageNamed:@"demo_avatar_cook"]
                                                                                       diameter:kJSQMessagesCollectionViewAvatarSizeDefault];
        
        JSQMessagesAvatarImage *jobsImage = [JSQMessagesAvatarImageFactory avatarImageWithImage:[UIImage imageNamed:@"demo_avatar_jobs"]
                                                                                       diameter:kJSQMessagesCollectionViewAvatarSizeDefault];
        
        JSQMessagesAvatarImage *wozImage = [JSQMessagesAvatarImageFactory avatarImageWithImage:[UIImage imageNamed:@"demo_avatar_woz"]
                                                                                      diameter:kJSQMessagesCollectionViewAvatarSizeDefault];
        
        self.avatars = @{ kJSQDemoAvatarIdSquires : jsqImage,
                          kJSQDemoAvatarIdCook : cookImage,
                          kJSQDemoAvatarIdJobs : jobsImage,
                          kJSQDemoAvatarIdWoz : wozImage };
        
        
        self.users = @{ kJSQDemoAvatarIdJobs : kJSQDemoAvatarDisplayNameJobs,
                        kJSQDemoAvatarIdCook : kJSQDemoAvatarDisplayNameCook,
                        kJSQDemoAvatarIdWoz : kJSQDemoAvatarDisplayNameWoz,
                        kJSQDemoAvatarIdSquires : kJSQDemoAvatarDisplayNameSquires };
        */
        
        /**
         *  Create message bubble images objects.
         *
         *  Be sure to create your bubble images one time and reuse them for good performance.
         *
         */
        JSQMessagesBubbleImageFactory *bubbleFactory = [[JSQMessagesBubbleImageFactory alloc] init];
        
        self.outgoingBubbleImageData = [bubbleFactory outgoingMessagesBubbleImageWithColor:[UIColor lightGrayColor]];
        self.incomingBubbleImageData = [bubbleFactory incomingMessagesBubbleImageWithColor:[UIColor darkGrayColor]];
    }
    
    return self;
}

- (void)addPhotoMediaMessage
{
    /*JSQPhotoMediaItem *photoItem = [[JSQPhotoMediaItem alloc] initWithImage:[UIImage imageNamed:@"goldengate"]];
    JSQMessage *photoMessage = [JSQMessage messageWithSenderId:kJSQDemoAvatarIdSelf
                                                   displayName:kJSQDemoAvatarDisplayNameSelf
                                                         media:photoItem];
    [self.messages addObject:photoMessage];*/
}

- (void)addLocationMediaMessageCompletion:(JSQLocationMediaItemCompletionBlock)completion
{
    /*CLLocation *ferryBuildingInSF = [[CLLocation alloc] initWithLatitude:37.795313 longitude:-122.393757];
    
    JSQLocationMediaItem *locationItem = [[JSQLocationMediaItem alloc] init];
    [locationItem setLocation:ferryBuildingInSF withCompletionHandler:completion];
    
    JSQMessage *locationMessage = [JSQMessage messageWithSenderId:kJSQDemoAvatarIdSelf
                                                      displayName:kJSQDemoAvatarDisplayNameSelf
                                                            media:locationItem];
    [self.messages addObject:locationMessage];*/
}

- (void)addVideoMediaMessage
{
    /*// don't have a real video, just pretending
    NSURL *videoURL = [NSURL URLWithString:@"file://"];
    
    JSQVideoMediaItem *videoItem = [[JSQVideoMediaItem alloc] initWithFileURL:videoURL isReadyToPlay:YES];
    JSQMessage *videoMessage = [JSQMessage messageWithSenderId:kJSQDemoAvatarIdSelf
                                                   displayName:kJSQDemoAvatarDisplayNameSelf
                                                         media:videoItem];
    [self.messages addObject:videoMessage];*/
}

@end