//
//  InterfaceController.m
//  Exercise8Group7 WatchKit Extension
//
//  Created by Jared Jones on 11/12/15.
//  Copyright © 2015 cpl.ubicomp. All rights reserved.
//

#import "InterfaceController.h"
@import WatchConnectivity;


@interface InterfaceController()
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *tipPercentageLabel;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *dueLabel;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfacePicker *pickAmountPicker;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceSlider *tipChangeSlider;

@property float totalAmount;
@property float billAmount;
@property float tipAmount;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    if ([WCSession isSupported]) {
        WCSession* session = [WCSession defaultSession];
        session.delegate = self;
        [session activateSession];
        NSLog(@"Watch WCSession Activated");
    }
    
    _billAmount = 1;
    _tipAmount = 15.0;
    
    [_tipPercentageLabel setText:[NSString stringWithFormat:@"Tip: %d%%", (int)_tipAmount]];
    [_tipChangeSlider setValue:_tipAmount];
    
    [self calculateFinalBill];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (NSUInteger i = 0; i < 100; i++){
        WKPickerItem *pItem = [[WKPickerItem alloc]init];
        [pItem setTitle:[@"$" stringByAppendingString:[NSString stringWithFormat:@"%d", i+1]]];
        [pItem setCaption:[NSString stringWithFormat:@"%d", i+1]];
        [arr addObject:pItem];
    }
    
    [_pickAmountPicker setItems:arr];
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (void)calculateFinalBill{
    _totalAmount = _billAmount * _tipAmount/100.0 + _billAmount;
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    NSString *currency = [formatter stringFromNumber:[NSNumber numberWithFloat:_totalAmount]];
    
    [_dueLabel setText:[NSString stringWithFormat:@"Due: %@", currency]];
}

- (IBAction)tipChangeHappened:(float)value {
    _tipAmount = value;
    [_tipPercentageLabel setText:[NSString stringWithFormat:@"Tip: %d%%", (int)_tipAmount]];
    
    [self calculateFinalBill];
}
- (IBAction)pickerSelected:(NSInteger)value {
    _billAmount = (float)value + 1;
    
    [self calculateFinalBill];
}
- (IBAction)saveToPhonePressed {
    NSDictionary *dic = @{@"monetary":[NSNumber numberWithFloat:_totalAmount]};
    
    [[WCSession defaultSession] sendMessage:dic replyHandler:^(NSDictionary<NSString *,id> * _Nonnull replyMessage) {
        
    } errorHandler:^(NSError * _Nonnull error) {
        NSLog(@"%@", [error localizedDescription]);
    }];
}
@end



