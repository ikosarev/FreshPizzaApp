//
//  OrderTVC.m
//  FreshPizzaApp
//
//  Created by Ivan Kosarev on 30/03/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#import "OrderTVC.h"
#import <AKNumericFormatter.h>
#import "UITextField+AKNumericFormatter.h"

#define NAME 0
#define PHONE 1
#define APPARTMENT 2
#define COMMENT 3

@interface OrderTVC ()

@end

@implementation OrderTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // adding gesture recognizer so keyboard will hide when user taps outside textfields
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    self.tableView.allowsSelection = NO;
    self.nameField.delegate = self;
    self.nameField.tag = NAME;
    self.phoneNumberField.delegate = self;
    self.phoneNumberField.numericFormatter = [AKNumericFormatter formatterWithMask:@"+*(***)***-**-**"
                                                              placeholderCharacter:'*'];
    self.phoneNumberField.tag = PHONE;
    self.apartmentField.delegate = self;
    self.apartmentField.numericFormatter = [AKNumericFormatter formatterWithMask:@"****"
                                                              placeholderCharacter:'*'];
    self.apartmentField.tag = APPARTMENT;
    self.commentField.delegate = self;
    self.commentField.tag = COMMENT;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [super numberOfSectionsInTableView:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [super tableView:tableView numberOfRowsInSection:section];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return UITableViewAutomaticDimension; 
}

#pragma mark - UITextFieldDelegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    [self.delegate textFieldDidChange:textField value:newString];
    return YES;
}

-(void)dismissKeyboard
{
    [self.view endEditing:YES];
}


@end
