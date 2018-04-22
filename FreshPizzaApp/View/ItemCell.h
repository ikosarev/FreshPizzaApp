//
//  ItemCell.h
//  FreshPizzaApp
//
//  Created by Ivan Kosarev on 24/03/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemCellDelegate.h"
#import "Item.h"

@interface ItemCell : UITableViewCell
@property (strong, nonatomic) Item *item;
@property (nonatomic, weak) id <ItemCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *itemImg;
@property (weak, nonatomic) IBOutlet UILabel *itemNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *priceLbl;
@property (weak, nonatomic) IBOutlet UILabel *countLbl;
@property (weak, nonatomic) IBOutlet UIStackView *countStackView;
@property (weak, nonatomic) IBOutlet UIButton *addToCartBtn;

- (IBAction)addToCartBtnWasPressed:(UIButton *)sender;
- (IBAction)minusBtnWasPressed:(UIButton *)sender;
- (IBAction)plusBtnWasPressed:(UIButton *)sender;

-(void)configureCellWithItem:(Item *)item;

@end
