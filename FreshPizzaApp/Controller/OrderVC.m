//
//  OrderVC.m
//  FreshPizzaApp
//
//  Created by Ivan Kosarev on 20/03/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#import "OrderVC.h"
#import "OrderTVC.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "FireBaseService.h"
#import "ConfirmationVC.h"
#import "UIViewController+Transitions.h"
#import "UIColor+AppColors.h"
#import "AddressManager.h"
#import "CoreDataManager.h"

#define NAME 0
#define PHONE 1
#define APPARTMENT 2
#define COMMENT 3

@interface OrderVC ()
{
 OrderTVC *orderTVC;
}
@end

@implementation OrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.address = [AddressManager instance].address;
    orderTVC.addressLbl.text = self.address;
    self.userName = @"";
    self.userPhone = @"";
    self.apartment = @"";
    self.comment = @"";
    [self.makeOrderBtn setEnabled:NO];
    [self.makeOrderBtn setBackgroundColor:UIColor.appGrayColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIViewController *destinationVC = segue.destinationViewController;
    orderTVC = (OrderTVC *)destinationVC;
    orderTVC.delegate = self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self registerForKeyboardNotifications];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)textFieldDidChange:(UITextField *)textField value:(NSString *)value{
    switch (textField.tag) {
        case NAME :
            self.userName = value;
            break;
        case PHONE :
            self.userPhone = value;
            break;
        case APPARTMENT :
            self.apartment = value;
            break;
        case COMMENT :
            self.comment = value;
            break;
        default:
            break;
    }
    if (![self.userName isEqualToString:@""] && ![self.userPhone isEqualToString:@""] && ![self.apartment isEqualToString:@""]){
        [UIView animateWithDuration:0.3 animations:^{
            [self.makeOrderBtn setBackgroundColor:UIColor.appRedColor];
        }];
        [self.makeOrderBtn setEnabled:YES];
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            [self.makeOrderBtn setBackgroundColor:UIColor.appGrayColor];
        }];
        [self.makeOrderBtn setEnabled:NO];
    }
}

#pragma mark - Keyboard handling

-(void) registerForKeyboardNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)keyboardWillShow:(NSNotification *)notification{
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    CGRect frame = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.makeOrderViewBottomConstraint.constant = frame.size.height;
        [self.view setNeedsLayout];
        [self.view layoutIfNeeded];
    } completion:nil];
}

-(void)keyboardWillHide:(NSNotification *)notification{
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.makeOrderViewBottomConstraint.constant = 0.0;
        [self.view setNeedsLayout];
        [self.view layoutIfNeeded];
    } completion:nil];
    
}

#pragma mark - IBActions

- (IBAction)makeOrderBtnWasPressed:(id)sender {
    
    NSArray *coreDataAddressArray = [[CoreDataManager instance] fetchCoreDataAddressArray];
    
    if([coreDataAddressArray containsObject:self.address]){
    [[CoreDataManager instance] addAddressToCoreData:self.address];
    }
        
    [[FireBaseService instance] createOrderWithName:self.userName address:self.address apartment:self.apartment phoneNumber:self.userPhone comment:self.comment itemsArray:self.itemsInCart handler:^(BOOL success){
        if(success){
            NSLog(@"Successfully posted order to Firebase");
            ConfirmationVC *targetVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ConfirmationVC"];
            [self presentViewController:targetVC animated:YES completion:nil];
        } else {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@"Ошибка"
                                         message:@"Проверьте подключение к сети и попробуйте еще раз."
                                         preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* okButton = [UIAlertAction
                                           actionWithTitle:@"Ок"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction * action) {
                                               [alert dismissViewControllerAnimated:true completion:nil];
                                           }];
            [alert addAction:okButton];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
}

- (IBAction)backBtnWasPressed:(id)sender {
    [self dismissFromRight];
}
@end
