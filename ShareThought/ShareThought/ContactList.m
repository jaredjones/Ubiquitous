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
@property (weak, nonatomic) IBOutlet UITableView *contactTableView;

@end

@implementation ContactList

-(id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:74.0/255.0f green:71.0/255.0f blue:79.0/255.0 alpha:0.0f];
        //x         y       width       height
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 8, self.bounds.size.width, (self.bounds.size.height/10))];
        [self setContactListLabel:label];
        
        UISearchBar *search = [[UISearchBar alloc] initWithFrame:CGRectMake(0, (self.bounds.size.height/10), self.bounds.size.width, (self.bounds.size.height/15))];
        [self setContactSearchBar:search];
        
        //calculate table bounds/height
        float tableY = label.bounds.size.height + search.bounds.size.height;
        float tableHeight = self.bounds.size.height - tableY;
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, tableY, self.bounds.size.width, tableHeight) style:UITableViewStyleGrouped];
        [self setContactTableView:tableView];
        
        
        [self addSubview:_contactListLabel];
        [self addSubview:_contactSearchBar];
        [self addSubview:_contactTableView];
    }
    
    return self;
}

-(void)setContactListLabel:(UILabel *)contactListLabel {
    contactListLabel.text = @"Contacts";
    contactListLabel.textColor = [UIColor whiteColor];
    contactListLabel.textAlignment = NSTextAlignmentCenter;
    contactListLabel.backgroundColor = [UIColor colorWithRed:74.0/255.0f green:71.0/255.0f blue:79.0/255.0 alpha:0.0f];
    contactListLabel.numberOfLines = 1;
    contactListLabel.minimumScaleFactor = 0.5;
    contactListLabel.adjustsFontSizeToFitWidth = YES;
    
    _contactListLabel = contactListLabel;
}

-(void)setContactSearchBar:(UISearchBar *)contactSearchBar {
    contactSearchBar.text = @"Search for Contact or Tag";
    contactSearchBar.barTintColor = [UIColor colorWithRed:116.0/255.0f green:114.0/255.0f blue:120.0/255.0 alpha:0.0f];
    
    _contactSearchBar = contactSearchBar;
}

-(void)setContactTableView:(UITableView *)contactTableView {
    contactTableView.backgroundColor = [UIColor darkGrayColor];
    _contactTableView = contactTableView;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
