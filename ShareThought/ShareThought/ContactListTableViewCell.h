//
//  ContactListTableViewCell.h
//  Sharethought
//
//  Created by Aidaly Santamaria on 11/23/15.
//  Copyright © 2015 Team7. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ContactListTableCellDelegate <NSObject>

-(void)deleteButtonActionForContact:(NSString *)contactName;
-(void)chatButtonAction:(id)sender withContactName:(NSString *)contactName;

@end

@interface ContactListTableViewCell : UITableViewCell <UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSString *contactName;
@property (nonatomic, strong) NSString *contactDesc;
//@property (nonatomic, strong) UIColor *theLabelColor;
@property (nonatomic, weak) id <ContactListTableCellDelegate> delegate;


@end
