//
//  AddressCell.m
//  FreshPizzaApp
//
//  Created by Ivan Kosarev on 13/03/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#import "AddressCell.h"

@implementation AddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configureCell:(NSString*)address{
    self.addressLbl.text = address;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
