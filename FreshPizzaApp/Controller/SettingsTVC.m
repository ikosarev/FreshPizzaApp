//
//  SettingTVC.m
//  FreshPizzaApp
//
//  Created by Ivan Kosarev on 31/03/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#import "SettingsTVC.h"

#define SORT_BY_RATING @"rating"
#define SORT_BY_DELIVERY_TIME @"deliveryTime"
#define SORT_BY_MIN_ORDER_COST @"minOrderCost"

@interface SettingsTVC ()

@end

@implementation SettingsTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *options = @[SORT_BY_RATING,SORT_BY_DELIVERY_TIME,SORT_BY_MIN_ORDER_COST];
    NSUInteger item = [options indexOfObject:self.sortBy];
    switch (item){
        case 0:
            [self.ratingCheck setHidden:NO];
            break;
        case 1:
            [self.deliveryTimeCheck setHidden:NO];
            break;
        case 2:
            [self.minOrderCheck setHidden:NO];
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [super numberOfSectionsInTableView:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [super tableView:tableView numberOfRowsInSection:section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.ratingCheck setHidden:YES];
    [self.deliveryTimeCheck setHidden:YES];
    [self.minOrderCheck setHidden:YES];
    switch (indexPath.row) {
        case 0:
            self.sortBy = SORT_BY_RATING;
            [self.ratingCheck setHidden:NO];
            break;
        case 1:
            self.sortBy = SORT_BY_DELIVERY_TIME;
            [self.deliveryTimeCheck setHidden:NO];
            break;
        default:
            self.sortBy = SORT_BY_MIN_ORDER_COST;
            [self.minOrderCheck setHidden:NO];
            break;
    }
    [self.delegate sortingMethodHasChanged:self.sortBy];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
