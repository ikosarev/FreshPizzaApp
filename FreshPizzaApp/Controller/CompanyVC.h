//
//  CompanyVC.h
//  FreshPizzaApp
//
//  Created by Ivan Kosarev on 20/03/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Company.h"
#import "Item.h"
#import "ItemDelegate.h"
#import "ItemCellDelegate.h"
#import "RoundedBtn.h"
#import "TopView.h"
#import "RoundedImageView.h"

@interface CompanyVC : UIViewController <UITableViewDataSource, UITableViewDelegate, ItemCellDelegate, ItemDelegate>
@property (strong, nonatomic) Company *company;
@property (strong, nonatomic) NSMutableArray *itemsInCart;

@property (weak, nonatomic) IBOutlet UIImageView *companyImage;
@property (weak, nonatomic) IBOutlet UILabel *companyNameLbl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *companyImageConstraint;
@property (weak, nonatomic) IBOutlet RoundedImageView *companyLogo;
@property (weak, nonatomic) IBOutlet UIImageView *companyRatingImg;
@property (weak, nonatomic) IBOutlet UILabel *deliveryTimeLbl;
@property (weak, nonatomic) IBOutlet UILabel *minOrderCostLbl;
@property (weak, nonatomic) IBOutlet UILabel *deliveryCostLbl;


@property (weak, nonatomic) IBOutlet UILabel *companyNameNavBarLbl;
@property (weak, nonatomic) IBOutlet TopView *navBarView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cartViewConstraint;
@property (weak, nonatomic) IBOutlet UIView *cartView;
@property (weak, nonatomic) IBOutlet UILabel *priceToMinOrderCostLbl;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet RoundedBtn *toCartBtn;
@property (weak, nonatomic) IBOutlet UIView *headerView;


- (IBAction)toCartBtnWasPressed:(id)sender;

- (IBAction)backBtnWasPressed:(id)sender;
@end
