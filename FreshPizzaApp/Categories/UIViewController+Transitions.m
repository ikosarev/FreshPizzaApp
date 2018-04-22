//
//  UIViewController+Transitions.m
//  FreshPizzaApp
//
//  Created by Ivan Kosarev on 03/04/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#import "UIViewController+Transitions.h"

@implementation UIViewController (Transitions)

-(void)presentToRight:(UIViewController *)viewControllerToPresent{
    CATransition *transition = [[CATransition alloc] init];
    transition.duration = 0.25;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:transition forKey:kCATransition];
    
    [self presentViewController:viewControllerToPresent animated:NO completion:nil];
}

-(void)presentToLeft:(UIViewController *)viewControllerToPresent{
    CATransition *transition = [[CATransition alloc] init];
    transition.duration = 0.25;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:transition forKey:kCATransition];
    
    [self presentViewController:viewControllerToPresent animated:NO completion:nil];
}

-(void)dismissFromRight{
    CATransition *transition = [[CATransition alloc] init];
    transition.duration = 0.25;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:transition forKey:kCATransition];
    
    [self dismissViewControllerAnimated:NO completion:nil];
}
@end
