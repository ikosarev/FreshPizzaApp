//
//  SearchAddressVC.m
//  FreshPizzaApp
//
//  Created by Ivan Kosarev on 24/02/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#import "SearchAddressVC.h"
#import "AddressCell.h"
#import "HTTPService.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "StringOperations.h"
#import "WhereToDeliverVC.h"
#import "JsonParser.h"
#import "MainVC.h"
#import "TabBarVC.h"
#import "Constants.h"
#import "AddressManager.h"
#import "CoreDataManager.h"
#import "UIViewController+Transitions.h"

@interface SearchAddressVC ()
{
    UIActivityIndicatorView *spinner;
    GMSAutocompleteFetcher *fetcher;
    NSMutableArray *addressArray;
    NSArray *coreDataAddressArray;
    NSDictionary *addressJson;
}
@end

@implementation SearchAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.addressSearchBar.delegate = self;
    addressArray = [[NSMutableArray alloc]init];
    // Do any additional setup after loading the view, typically from a nib.
    
    GMSAutocompleteFilter *filter = [[GMSAutocompleteFilter alloc] init];
    filter.type = kGMSPlacesAutocompleteTypeFilterAddress;
    
    // Bounds for Moscow
    CLLocationCoordinate2D neBoundsCorner = CLLocationCoordinate2DMake(moscowBoundsLatMax, moscowBoundsLngMax);
    CLLocationCoordinate2D swBoundsCorner = CLLocationCoordinate2DMake(moscowBoundsLatMin, moscowBoundsLngMin);
    GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] initWithCoordinate:neBoundsCorner
                                                                       coordinate:swBoundsCorner];

    fetcher = [[GMSAutocompleteFetcher alloc] initWithBounds:bounds filter:filter];
    fetcher.autocompleteBoundsMode = kGMSAutocompleteBoundsModeRestrict;
    fetcher.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated{
    coreDataAddressArray = [[CoreDataManager instance] fetchCoreDataAddressArray];
    
    if(coreDataAddressArray.count){
        [self.addressNotFoundView setHidden:YES];
        [addressArray addObjectsFromArray:coreDataAddressArray];
        [self.tableView reloadData];
    } else {
        [self.myAddressesLbl setHidden:YES];
        self.myAddressesHeightConstraint.constant = 0;
        [self.enterAddressView setHidden:NO];
    }
    [super viewWillAppear:animated];
    
}

#pragma mark - GMS Methods

-(void)didAutocompleteWithPredictions:(NSArray<GMSAutocompletePrediction *> *)predictions{
    if (addressArray.count){
    [addressArray removeAllObjects];
    }
    if (predictions.count){
        [self.addressNotFoundView setHidden:YES];
        for (GMSAutocompletePrediction *prediction in predictions) {
            NSString * result = [prediction.attributedFullText string];
            [addressArray addObject:result];
        }
    } else {
        [self.addressNotFoundView setHidden:NO];
    }
    [self.tableView reloadData];
}

-(void)viewController:(GMSAutocompleteViewController *)viewController didFailAutocompleteWithError:(NSError *)error{
    NSLog(@"Error: %@", error.localizedDescription);
}

-(void)wasCancelled:(GMSAutocompleteViewController *)viewController{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)didRequestAutocompletePredictions:(GMSAutocompleteViewController *)viewController{
    UIApplication.sharedApplication.networkActivityIndicatorVisible = YES;
}

-(void)didUpdateAutocompletePredictions:(GMSAutocompleteViewController *)viewController{
    UIApplication.sharedApplication.networkActivityIndicatorVisible = NO;
}

- (void)didFailAutocompleteWithError:(NSError *)error {
    NSLog(@"%@", error.localizedDescription);
    if(error.code == -1){
        [self.enterAddressView setHidden:NO];
        self.notificationLbl.text = @"Отсутствует соединение с сетью";
    }
}

#pragma mark - UISearchBar Methods

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (![searchText isEqual:@""]){
        [self.enterAddressView setHidden:YES];
        [UIView animateWithDuration:0.3 animations:^{
            [self.myAddressesLbl setHidden:YES];
            self.myAddressesHeightConstraint.constant = 0;
            [self.view setNeedsLayout];
            [self.view layoutIfNeeded];
        }];
        [fetcher sourceTextHasChanged:searchText];
    } else {
        [self.addressNotFoundView setHidden:YES];
        if (addressArray.count){
            [addressArray removeAllObjects];
        }
        
        if(coreDataAddressArray.count){
            [self.enterAddressView setHidden:YES];
            [addressArray addObjectsFromArray:coreDataAddressArray];
            [UIView animateWithDuration:0.3 animations:^{
                [self.myAddressesLbl setHidden:NO];
                self.myAddressesHeightConstraint.constant = 66;
                [self.view setNeedsLayout];
                [self.view layoutIfNeeded];
            }];
        } else {
            [self.enterAddressView setHidden:NO];
            self.notificationLbl.text = @"Введите адрес доставки";
        }
        [self.tableView reloadData];
    }
}

#pragma mark - UITableView Methods

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    AddressCell* cell = [tableView dequeueReusableCellWithIdentifier:@"AddressCell" forIndexPath: indexPath];
    if (cell != nil){
        NSString* address = addressArray[indexPath.row];
        
        [cell configureCell:address];
        return cell;
    } else {
        return [[UITableViewCell alloc] init];
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return addressArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *selectedAddress = selectedCell.addressLbl.text;
    //Preparing address for google api
    NSString *preparedAddress = [StringOperations prepareStringForUrl:selectedAddress];
    
    //Getting street name only for filling search bar if street address is not full
    NSArray *addressComponents = [selectedAddress componentsSeparatedByString:@", "];
    NSString *streetName = [NSString stringWithFormat:@"%@, ", [addressComponents objectAtIndex:0]];

    [HTTPService getGeocodeJsonFromAddress:preparedAddress handler:^(NSDictionary * returnedJson, NSError * error) {
        if(error == nil){
        [JsonParser getCoordinatesFromAddressJson:returnedJson handler:^(BOOL statusError, BOOL success, double latitude, double  longitude) {
            if(!statusError){
            if (success){
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [[AddressManager instance] setAddress:selectedCell.addressLbl.text];
                    [[AddressManager instance] setLatitude:latitude];
                    [[AddressManager instance] setLongitude:longitude];
                    
                    TabBarVC *tabBarVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TabBarVC"];
                    
                    [self presentToRight:tabBarVC];
                });
            }
            else {
                NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
                BOOL addressContainsHouseNumber = [nf numberFromString:[addressComponents objectAtIndex:1]] != nil;
                if(addressContainsHouseNumber){
                    dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertController * alert = [UIAlertController
                                                 alertControllerWithTitle:@"Адрес не найден"
                                                 message:@"Адрес введен некорректно или находится вне зоны доставки. Если ошибка повторится, воспользуйтесь поиском по карте."
                                                 preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction* okButton = [UIAlertAction
                                               actionWithTitle:@"Ок"
                                               style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action) {
                                                   [alert dismissViewControllerAnimated:true completion:nil];
                                               }];
                    [alert addAction:okButton];
                    [self presentViewController:alert animated:YES completion:nil];
                    });
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.addressSearchBar.text = streetName;
                    });
                }
            }
        }
        }];
        } else {
            [self.enterAddressView setHidden:NO];
            self.notificationLbl.text = @"Отсутствует соединение с сетью";
        }
    }];
    
}


#pragma mark - IBActions

- (IBAction)toTheMapBtnWasPressed:(id)sender {
    WhereToDeliverVC *targetVC = [self.storyboard instantiateViewControllerWithIdentifier:@"WhereToDeliverVC"];
    [self presentViewController:targetVC animated:YES completion:nil];
}

- (IBAction)backBtnWasPressed:(id)sender {
    [self dismissFromRight];
}



@end
