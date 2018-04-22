//
//  SettingsVC.h
//  FreshPizzaApp
//
//  Created by Ivan Kosarev on 24/03/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsDelegate.h"

@interface SettingsVC : UIViewController
@property (nonatomic, weak) id <SettingsDelegate> delegate;
@property (strong, nonatomic) NSString *sortBy;


- (IBAction)backBtnWasPressed:(id)sender;
@end
