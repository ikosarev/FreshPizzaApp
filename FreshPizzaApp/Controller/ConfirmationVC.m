//
//  ConfirmationVC.m
//  FreshPizzaApp
//
//  Created by Ivan Kosarev on 20/03/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#import "ConfirmationVC.h"
#import "TabBarVC.h"

@interface ConfirmationVC ()

@end

@implementation ConfirmationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (IBAction)backToMainPageBtnWasPressed:(id)sender {
    TabBarVC *targetVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TabBarVC"];
    [self presentViewController:targetVC animated:YES completion:nil];
}
@end
