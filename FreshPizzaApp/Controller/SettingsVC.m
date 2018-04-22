//
//  SettingsVC.m
//  FreshPizzaApp
//
//  Created by Ivan Kosarev on 24/03/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#import "SettingsVC.h"
#import "SettingsTVC.h"

#define SORT_BY_RATING @"rating"
#define SORT_BY_DELIVERY_TIME @"deliveryTime"
#define SORT_BY_MIN_ORDER_COST @"minOrderCost"

@interface SettingsVC ()
{
    SettingsTVC *settingsTVC;
}

@end

@implementation SettingsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIViewController *destinationVC = segue.destinationViewController;
    settingsTVC = (SettingsTVC *)destinationVC;
    settingsTVC.sortBy = self.sortBy;
    settingsTVC.delegate = self.delegate;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backBtnWasPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
