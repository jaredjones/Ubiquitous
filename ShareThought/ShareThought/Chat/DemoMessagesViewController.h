
// Import all the things
#import "JSQMessages.h"

#import "DemoModelData.h"
#import "User.h"

@class DemoMessagesViewController;

@protocol JSQDemoViewControllerDelegate <NSObject>

- (void)didDismissJSQDemoViewController:(DemoMessagesViewController *)vc;

@end




@interface DemoMessagesViewController : JSQMessagesViewController <UIActionSheetDelegate, JSQMessagesComposerTextViewPasteDelegate>

@property (weak, nonatomic) id<JSQDemoViewControllerDelegate> delegateModal;

@property (strong, nonatomic) DemoModelData *demoData;

@property (strong, nonatomic) User *user;

- (void)closePressed:(UIBarButtonItem *)sender;

@end