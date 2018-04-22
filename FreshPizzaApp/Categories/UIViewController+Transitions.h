//
//  UIViewController+Transitions.h
//  FreshPizzaApp
//
//  Created by Ivan Kosarev on 03/04/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Transitions)
-(void)presentToRight:(UIViewController *)viewControllerToPresent;
-(void)presentToLeft:(UIViewController *)viewControllerToPresent;
-(void)dismissFromRight;
@end
