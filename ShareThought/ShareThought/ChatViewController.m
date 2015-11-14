//
//  ChatViewController.m
//  ShareThought
//
//  Created by Jared Jones on 10/30/15.
//  Copyright © 2015 Team7. All rights reserved.
//

#import "ChatViewController.h"
#import "TopChatNavBarVisualEffectView.h"
#import "BackgroundBlurEffect.h"

@interface ChatViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *chatScrollView;
@property (weak, nonatomic) IBOutlet UIView *textEntryAndSubmitView;
@property (weak, nonatomic) IBOutlet TopChatNavBarVisualEffectView *topBarVisualEffectView;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UITextView *messageTextView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *chatScrollViewBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textEntryAndSubmitViewHeightConstraint;

@property CGFloat textViewAndContentDifference;

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _messageTextView.keyboardAppearance = UIKeyboardAppearanceDark;
    _messageTextView.delegate = self;
    _messageTextView.layer.cornerRadius = 5.0f;
    
    _textViewAndContentDifference = _textEntryAndSubmitViewHeightConstraint.constant - _messageTextView.contentSize.height;
    
    /*_messageTextField.attributedPlaceholder = [[NSAttributedString alloc]
                                               initWithString:@"Type a message..."
                                               attributes:@{ NSForegroundColorAttributeName: [UIColor darkGrayColor] }];
    */
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, _textEntryAndSubmitView.bounds.origin.y, _textEntryAndSubmitView.bounds.size.width, 0.5)];
    lineView.backgroundColor = [UIColor blackColor];
    [_textEntryAndSubmitView addSubview:lineView];
    
    _topBarVisualEffectView.layer.masksToBounds = NO;
    _topBarVisualEffectView.layer.shadowOffset = CGSizeMake(0, 3);
    _topBarVisualEffectView.layer.shadowRadius = 4;
    _topBarVisualEffectView.layer.shadowOpacity = 0.5;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTapOnScrollView:)];
    [_chatScrollView addGestureRecognizer:singleFingerTap];
    
    // Do any additional setup after loading the view.
}

- (void)handleSingleTapOnScrollView:(UITapGestureRecognizer *)recognizer {
    [_messageTextView resignFirstResponder];
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    [textView resignFirstResponder];
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    _textEntryAndSubmitViewHeightConstraint.constant = textView.contentSize.height + _textViewAndContentDifference;
    [_textEntryAndSubmitView layoutIfNeeded];
}

- (void)keyboardWillShow: (NSNotification *) notification{
    
    NSDictionary *info = [notification userInfo];
    
    NSValue *v = [info valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrame = [v CGRectValue];
    
    [UIView animateWithDuration:1.0 animations:^{
        [_chatScrollViewBottomConstraint setConstant:keyboardFrame.size.height];
        [_textEntryAndSubmitView layoutIfNeeded];
    }];
}

- (void)keyboardWillHide: (NSNotification *) notification{
    [UIView animateWithDuration:1.0 animations:^{
        [_chatScrollViewBottomConstraint setConstant:0];
        [_textEntryAndSubmitView layoutIfNeeded];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (IBAction)sendMessagedPressed:(id)sender {
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
