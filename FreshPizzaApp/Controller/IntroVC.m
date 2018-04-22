//
//  IntroVC.m
//  FreshPizzaApp
//
//  Created by Ivan Kosarev on 24/02/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#import "IntroVC.h"
#import "UIViewController+Transitions.h"
#import "EnterLocationVC.h"

@interface IntroVC ()

@end

@implementation IntroVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [self setNeedsStatusBarAppearanceUpdate];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


- (IBAction)nextBtnWasPressed:(id)sender {
    EnterLocationVC *targetVC = [self.storyboard instantiateViewControllerWithIdentifier:@"EnterLocationVC"];
    [self presentToRight:targetVC];
}
@end
