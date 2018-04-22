//
//  PizzaCell.h
//  FreshPizzaApp
//
//  Created by Ivan Kosarev on 20/03/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Company.h"

@interface CompanyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *companyNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *deliveryTimeLbl;
@property (weak, nonatomic) IBOutlet UIImageView *companyImg;
@property (weak, nonatomic) IBOutlet UIImageView *companyRatingImg;
@property (weak, nonatomic) IBOutlet UIImageView *companyLogo;
@property (weak, nonatomic) IBOutlet UILabel *deliveryPriceLbl;
@property (weak, nonatomic) IBOutlet UILabel *minOrderPriceLbl;

- (void)configureCellWithCompany:(Company *)company;

@end
