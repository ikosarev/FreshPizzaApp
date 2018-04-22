//
//  SettingTVC.h
//  FreshPizzaApp
//
//  Created by Ivan Kosarev on 31/03/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsDelegate.h"

@interface SettingsTVC : UITableViewController
@property (nonatomic, weak) id <SettingsDelegate> delegate;
@property (strong, nonatomic) NSString *sortBy;
@property (weak, nonatomic) IBOutlet UIImageView *ratingCheck;
@property (weak, nonatomic) IBOutlet UIImageView *deliveryTimeCheck;
@property (weak, nonatomic) IBOutlet UIImageView *minOrderCheck;


@end
