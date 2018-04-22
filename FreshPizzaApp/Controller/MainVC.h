//
//  MainVC.h
//  FreshPizzaApp
//
//  Created by Ivan Kosarev on 12/03/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsDelegate.h"

@interface MainVC : UIViewController <UITableViewDelegate, UITableViewDataSource, SettingsDelegate>
@property (nonatomic)double latitude;
@property (nonatomic)double longtitude;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSString *sortBy;
@property (weak, nonatomic) IBOutlet UIView *loaderView;


- (IBAction)settingsBtnWasPressed:(id)sender;
- (IBAction)toMapBtnWasPressed:(id)sender;

@end
