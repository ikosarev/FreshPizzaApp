//
//  ViewController.m
//  FreshPizzaApp
//
//  Created by Ivan Kosarev on 21/02/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#import "EnterLocationVC.h"
#import "UIViewController+Transitions.h"
#import "WhereToDeliverVC.h"
#import "SearchAddressVC.h"

@interface EnterLocationVC ()

@end

@implementation EnterLocationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toMapBtnWasPressed:(id)sender {
    WhereToDeliverVC *targetVC = [self.storyboard instantiateViewControllerWithIdentifier:@"WhereToDeliverVC"];
    [self presentToRight:targetVC];
}

- (IBAction)toAddressSearchBtnWasPressed:(id)sender {
    SearchAddressVC *targetVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchAddressVC"];
    [self presentToRight:targetVC];
}
@end
