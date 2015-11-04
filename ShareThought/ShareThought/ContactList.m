//
//  ContactList.m
//  ShareThought
//
//  Created by Aidaly Santamaria on 11/3/15.
//  Copyright © 2015 Team7. All rights reserved.
//

#import "ContactList.h"

@interface ContactList ()
@property (weak, nonatomic) IBOutlet UILabel *contactListLabel;
@property (weak, nonatomic) IBOutlet UISearchBar *contactSearchBar;

@end

@implementation ContactList

-(id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:38.0/255.0 green:36.0/255.0 blue:48.0/255.0 alpha:1.0f];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 8, self.bounds.size.width, (self.bounds.size.height)/10)];
        [self setContactListLabel:label];
        
        UISearchBar *search = [[UISearchBar alloc] initWithFrame:CGRectMake(0, (self.bounds.size.height)/10 + 1, self.bounds.size.width, (self.bounds.size.height)/15)];
        [self setContactSearchBar:search];
        
        [self addSubview:_contactListLabel];
        [self addSubview:_contactSearchBar];
    }
    
    return self;
}

-(void)setContactListLabel:(UILabel *)contactListLabel {
    contactListLabel.text = @"Contacts";
    contactListLabel.textColor = [UIColor whiteColor];
    contactListLabel.textAlignment = NSTextAlignmentCenter;
    contactListLabel.numberOfLines = 1;
    contactListLabel.minimumScaleFactor = 0.5;                  //need to resize text accordingly
    contactListLabel.adjustsFontSizeToFitWidth = YES;
    
    _contactListLabel = contactListLabel;
}

-(void) setContactSearchBar:(UISearchBar *)contactSearchBar {
    contactSearchBar.text = @"Search for Contact or Tag";
    contactSearchBar.barTintColor = [UIColor lightGrayColor];
    _contactSearchBar = contactSearchBar;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
