//
//  OrderTVC.h
//  FreshPizzaApp
//
//  Created by Ivan Kosarev on 30/03/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDelegate.h"

@interface OrderTVC : UITableViewController <UITextFieldDelegate>
@property (nonatomic, weak) id <OrderDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *commentField;
@property (weak, nonatomic) IBOutlet UILabel *addressLbl;
@property (weak, nonatomic) IBOutlet UITextField *apartmentField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberField;
@property (weak, nonatomic) IBOutlet UITextField *nameField;

@end
