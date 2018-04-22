//
//  MainVC.m
//  FreshPizzaApp
//
//  Created by Ivan Kosarev on 12/03/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#import "MainVC.h"
#import "TabBarVC.h"
#import "WhereToDeliverVC.h"
#import "CompanyCell.h"
#import "FireBaseService.h"
#import "Company.h"
#import "CompanyVC.h"
#import <CoreLocation/CoreLocation.h>
#import "SettingsVC.h"
#import "AddressManager.h"

#import "UIViewController+Transitions.h"

@import FirebaseDatabase;
@import Firebase;

#define SORT_BY_RATING @"rating"
#define SORT_BY_DELIVERY_TIME @"deliveryTime"
#define SORT_BY_MIN_ORDER_COST @"minOrderCost"

@interface MainVC ()
{
    NSMutableArray *companiesArray;
    CLLocation *userLocation;
    UIActivityIndicatorView *spinner;
}
@end

@implementation MainVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    self.latitude = [AddressManager instance].latitude;
    self.longtitude = [AddressManager instance].longitude;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    userLocation = [[CLLocation alloc] initWithLatitude:self.latitude longitude:self.longtitude];
    
    [self startLoadingAnimation];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    [[FireBaseService instance] getAllCompanies:^(NSArray * companies) {
        if(companies.count){
            companiesArray = [NSMutableArray arrayWithArray:companies];
            dispatch_async(dispatch_get_main_queue(),^{
                [self.tableView reloadData];
                [self stopLoadingAnimation];
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            });
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView methods

- (NSArray *)sortArray:(NSArray *)unsortedArray By:(NSString *)sortBy{
    NSMutableArray *mutArr = [[NSMutableArray alloc] initWithArray:unsortedArray];
    NSSortDescriptor *sortDescriptor;
    if([sortBy isEqualToString:SORT_BY_RATING]){
        sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey: sortBy
                                        ascending: NO];
    } else {
        sortDescriptor = [[NSSortDescriptor alloc]
                          initWithKey: sortBy
                          ascending: YES
                          selector:@selector(localizedStandardCompare:)];
    }
    NSArray *sortedArray = [mutArr
                                                     sortedArrayUsingDescriptors: [NSArray arrayWithObject:sortDescriptor]];
    return sortedArray;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return companiesArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CompanyCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CompanyCell" forIndexPath: indexPath];
    if (cell != nil){
        Company *company = [companiesArray objectAtIndex:indexPath.row];
        CLLocation* companyLocation = [[CLLocation alloc] initWithLatitude:company.coordinatesLatitude longitude:company.coordinatesLongitude];
        CLLocationDistance distance = [userLocation distanceFromLocation:companyLocation];
        NSString *deliveryTime;
        switch ((int)distance) {
            case 0 ... 5000:
                deliveryTime = @"30 мин";
                break;
            case 5001 ... 10000:
                deliveryTime = @"45 мин";
                break;
            case 10001 ... 15000:
                deliveryTime = @"60 мин";
                break;
            case 15001 ... 20000:
                deliveryTime = @"80 мин";
                break;
            default:
                deliveryTime = @"120 мин";
                break;
        }
        company.deliveryTime = deliveryTime;
        [companiesArray replaceObjectAtIndex:indexPath.row withObject:company];
        [cell configureCellWithCompany:company];
        return cell;
    } else {
        return [[UITableViewCell alloc] init];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CompanyVC *targetVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CompanyVC"];
    targetVC.company = [companiesArray objectAtIndex:indexPath.row];
    
    
    [self presentToRight:targetVC];
}

#pragma mark - SettingsDelegate

-(void)sortingMethodHasChanged:(NSString *)sortingMethod{
    self.sortBy = sortingMethod;
    NSArray *sortedArray = [self sortArray:companiesArray By:self.sortBy];
    companiesArray = [NSMutableArray arrayWithArray:sortedArray];
    [self.tableView reloadData];
}

#pragma mark - Loading spinner

-(void)startLoadingAnimation{
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.transform = CGAffineTransformMakeScale(1.5, 1.5);
    spinner.center = CGPointMake(CGRectGetMidX(self.loaderView.bounds), CGRectGetMidY(self.loaderView.bounds));
    [self.loaderView addSubview:spinner];
    [spinner startAnimating];
    [self.loaderView setHidden:NO];
}

-(void)stopLoadingAnimation{
    [spinner stopAnimating];
    [self.loaderView setHidden:YES];
}

#pragma mark - IBActions

- (IBAction)settingsBtnWasPressed:(id)sender {
    SettingsVC *targetVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingsVC"];
    targetVC.delegate = self;
    targetVC.sortBy = self.sortBy;
    [self presentViewController:targetVC animated:YES completion:nil];
}

- (IBAction)toMapBtnWasPressed:(id)sender {
    WhereToDeliverVC *targetVC = [self.storyboard instantiateViewControllerWithIdentifier:@"WhereToDeliverVC"];
    targetVC.longitude = self.longtitude;
    targetVC.latitude = self.latitude;
    
    [self presentViewController:targetVC animated:YES completion:nil];
}
@end
