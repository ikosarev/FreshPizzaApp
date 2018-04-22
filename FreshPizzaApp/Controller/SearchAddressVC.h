//
//  SearchAddressVC.h
//  FreshPizzaApp
//
//  Created by Ivan Kosarev on 24/02/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GooglePlaces/GooglePlaces.h>

@interface SearchAddressVC : UIViewController <UITableViewDelegate, UITableViewDataSource,  GMSAutocompleteFetcherDelegate,UISearchDisplayDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *addressSearchBar;
@property (weak, nonatomic) IBOutlet UILabel *myAddressesLbl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *myAddressesHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *addressNotFoundView;
@property (weak, nonatomic) IBOutlet UIView *enterAddressView;
@property (weak, nonatomic) IBOutlet UILabel *notificationLbl;


- (IBAction)toTheMapBtnWasPressed:(id)sender;
- (IBAction)backBtnWasPressed:(id)sender;

@end
