//
//  ItemVC.h
//  FreshPizzaApp
//
//  Created by Ivan Kosarev on 25/03/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"
#import "ItemCell.h"
#import "RoundedBtn.h"
#import "ItemDelegate.h"

@interface ItemVC : UIViewController
@property (strong, nonatomic) Item *item;
@property (strong, nonatomic) NSIndexPath *indexPath;
@property (weak, nonatomic) id <ItemDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *itemImg;
@property (weak, nonatomic) IBOutlet UILabel *itemNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *itemDescLbl;
@property (weak, nonatomic) IBOutlet RoundedBtn *addBtn;
@property (weak, nonatomic) IBOutlet UILabel *itemCountLbl;
@property (weak, nonatomic) IBOutlet UILabel *itemPriceLbl;
@property (weak, nonatomic) IBOutlet UIStackView *itemCounter;

- (IBAction)minusBtnWasPressed:(id)sender;
- (IBAction)plusBtnWasPressed:(id)sender;
- (IBAction)closeBtnWasPressed:(id)sender;
- (IBAction)addBtnWasPressed:(id)sender;

@end
