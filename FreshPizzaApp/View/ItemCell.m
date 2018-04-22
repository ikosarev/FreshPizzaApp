//
//  ItemCell.m
//  FreshPizzaApp
//
//  Created by Ivan Kosarev on 24/03/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#import "ItemCell.h"


@implementation ItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    //[super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(void)configureCellWithItem:(Item *)item{
    self.item = item;
    self.itemNameLbl.text = item.name;
    self.priceLbl.text = [NSString stringWithFormat:@"%@₽",item.price ];
    self.item.count = item.count;
    self.countLbl.text = [NSString stringWithFormat:@"%ld",item.count];
    if(item.count == 0){
        [self.addToCartBtn setHidden:NO];
        [self.countStackView setHidden:YES];
    } else {
        [self.addToCartBtn setHidden:YES];
        [self.countStackView setHidden:NO];
    }
    self.itemImg.image = item.image;
}

- (IBAction)addToCartBtnWasPressed:(UIButton *)sender {
    self.item.count = 1;
    [self.addToCartBtn setHidden:YES];
    [self.countStackView setHidden:NO];
    self.countLbl.text = [NSString stringWithFormat:@"%ld",self.item.count];
    [self.delegate cellItemCountDidChange:self itemCount:self.item.count];
}

- (IBAction)minusBtnWasPressed:(UIButton *)sender {
    self.item.count = self.item.count - 1;
    self.countLbl.text = [NSString stringWithFormat:@"%ld",self.item.count];
    
    [self.delegate cellItemCountDidChange:self itemCount:self.item.count];
    
    if(self.item.count == 0){
        [self.addToCartBtn setHidden:NO];
        [self.countStackView setHidden:YES];
    }
}

- (IBAction)plusBtnWasPressed:(UIButton *)sender {
    self.item.count = self.item.count + 1;
    self.countLbl.text = [NSString stringWithFormat:@"%ld",self.item.count];
    
    [self.delegate cellItemCountDidChange:self itemCount:self.item.count];
    }

@end
