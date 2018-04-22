//
//  OrderVC.h
//  FreshPizzaApp
//
//  Created by Ivan Kosarev on 20/03/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDelegate.h"
#import "RoundedBtn.h"
#import "Company.h"

@interface OrderVC : UIViewController <OrderDelegate>

@property (nonatomic, strong) NSArray *itemsInCart;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *apartment;
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *userPhone;
@property (strong, nonatomic) NSString *comment;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *makeOrderViewBottomConstraint;
@property (weak, nonatomic) IBOutlet RoundedBtn *makeOrderBtn;

- (IBAction)makeOrderBtnWasPressed:(id)sender;
- (IBAction)backBtnWasPressed:(id)sender;

@end
