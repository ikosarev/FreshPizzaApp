//
//  ShoppingCartVC.h
//  FreshPizzaApp
//
//  Created by Ivan Kosarev on 12/03/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemCellDelegate.h"
#import "ItemDelegate.h"
#import "RoundedBtn.h"
#import "RoundedImageView.h"
#import "Company.h"

@interface ShoppingCartVC : UIViewController <UITableViewDelegate, UITableViewDataSource, ItemCellDelegate, ItemDelegate>

@property (strong, nonatomic) Company *company;
@property (nonatomic, strong) NSMutableArray *itemsInCart;
@property (nonatomic, strong) NSMutableArray *itemsInCartCount;

@property (weak, nonatomic) IBOutlet UIView *emptyCartView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *companyNameLbl;
@property (weak, nonatomic) IBOutlet RoundedBtn *makeOrderBtn;
@property (weak, nonatomic) IBOutlet UILabel *totalLbl;
@property (weak, nonatomic) IBOutlet UIButton *clearCartBtn;
@property (weak, nonatomic) IBOutlet RoundedImageView *companyLogo;


- (IBAction)makeOrderBtnWasPressed:(id)sender;
- (IBAction)clearCartBtnWasPressed:(id)sender;
- (IBAction)toMainVCBtnWasPressed:(id)sender;

@end
