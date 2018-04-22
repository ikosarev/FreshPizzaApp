//
//  PizzaCell.m
//  FreshPizzaApp
//
//  Created by Ivan Kosarev on 20/03/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#import "CompanyCell.h"

@implementation CompanyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)configureCellWithCompany:(Company *)company{
    self.companyNameLbl.text = company.name;
    self.deliveryTimeLbl.text = company.deliveryTime;
    self.deliveryPriceLbl.text = @"Доставка бесплатно";
    self.minOrderPriceLbl.text = [NSString stringWithFormat:@"Заказ от %@ ₽",company.minOrderCost];
    self.companyImg.image = company.image;
    self.companyLogo.image = company.logo;
    switch (company.rating) {
            // No other cases made for simplicity
        case 3:
            self.companyRatingImg.image = [UIImage imageNamed:@"rating3"];
            break;
        case 4:
            self.companyRatingImg.image = [UIImage imageNamed:@"rating4"];
            break;
        case 5:
            self.companyRatingImg.image = [UIImage imageNamed:@"rating5"];
            break;
        default:
            [self.companyRatingImg setHidden:YES];
            break;
    }
}

@end
