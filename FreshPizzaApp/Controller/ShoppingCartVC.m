//
//  ShoppingCartVC.m
//  FreshPizzaApp
//
//  Created by Ivan Kosarev on 12/03/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#import "ShoppingCartVC.h"
#import "TabBarVC.h"
#import "ItemCell.h"
#import "ItemVC.h"
#import "OrderVC.h"
#import "MainVC.h"
#import "UIViewController+Transitions.h"
#import "AddressManager.h"

@interface ShoppingCartVC ()
{
    NSInteger totalCount;
    NSInteger minOrderCost;
    NSInteger totalPrice;
}
@end

@implementation ShoppingCartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotification:)
                                                 name:@"itemData"
                                               object:nil];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.clearCartBtn setHidden:YES];
    [self.emptyCartView setHidden:NO];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)handleNotification:(NSNotification *)notification{
    self.itemsInCart = [[NSMutableArray alloc] initWithArray:[notification.userInfo objectForKey:@"itemsInCart"]];
    self.company = [notification.userInfo objectForKey:@"company"];
    self.companyNameLbl.text = self.company.name;
    self.companyLogo.image = self.company.logo;
    minOrderCost = [self.company.minOrderCost integerValue];
    for (Item *item in self.itemsInCart){
        totalCount = totalCount + item.count;
        totalPrice = totalPrice + item.price.integerValue * item.count;
    }
    [[self.tabBarController.tabBar.items objectAtIndex:1] setBadgeValue: [NSString stringWithFormat:@"%ld", totalCount]];
    self.totalLbl.text = [NSString stringWithFormat:@"Итого: %ld рублей", totalPrice];
    [self.tableView reloadData];
    [self.clearCartBtn setHidden:NO];
    [self.emptyCartView setHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.itemsInCart.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ItemCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ItemCell" forIndexPath: indexPath];
    if (cell != nil){
        Item *item = [self.itemsInCart objectAtIndex:indexPath.row];
        NSLog(@"item count for %@ = %ld", item.name, item.count);
        if (item.count != 0){
            [cell configureCellWithItem:item];
            cell.delegate = self;
            return cell;
        } else {
            return [[UITableViewCell alloc] init];
        }
    } else {
        return [[UITableViewCell alloc] init];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ItemVC *targetVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ItemVC"];
    ItemCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    targetVC.item = cell.item;
    targetVC.delegate = self;
    targetVC.indexPath = indexPath;
    [self presentViewController:targetVC animated:YES completion:nil];
}

#pragma mark - ItemCellDelegate methods

-(void)cellItemCountDidChange:(ItemCell *)cell itemCount:(NSInteger)itemCount{
    cell.item.count = itemCount;
    NSLog(@"Item count of %@ = %ld", cell.itemNameLbl.text, cell.item.count );
    [self.itemsInCart removeAllObjects];
    [self.itemsInCartCount removeAllObjects];
    totalCount = 0;
    totalPrice = 0;
    for (NSInteger i = 0 ; i < [self.tableView numberOfRowsInSection:0]; i++){
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        ItemCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        if (cell.item.count != 0){
            totalCount = totalCount + cell.item.count;
            totalPrice = totalPrice + [cell.item.price intValue] * totalCount;
            [self.itemsInCart addObject:cell.item];
            [self.itemsInCartCount addObject:[NSNumber numberWithInteger:cell.item.count]];
        }
    }
     if (totalCount != 0){
        [[self.tabBarController.tabBar.items objectAtIndex:1] setBadgeValue: [NSString stringWithFormat:@"%ld", totalCount]];
    } else {
        [[self.tabBarController.tabBar.items objectAtIndex:1] setBadgeValue:nil];
        [self.clearCartBtn setHidden:YES];
        [self.emptyCartView setHidden:NO];
    }
    if(minOrderCost - totalPrice > 0){
        self.totalLbl.text = [NSString stringWithFormat:@"%ld рублей до минимальной суммы заказа", minOrderCost - totalPrice];
        [self.makeOrderBtn setEnabled:NO];
        [self.makeOrderBtn setBackgroundColor:[UIColor colorWithRed:180.0f/255.0f green:180.0f/255.0f blue:180.0f/255.0f alpha:1]];
    } else {
        self.totalLbl.text = [NSString stringWithFormat:@"Итого: %ld рублей", totalPrice];
        [self.makeOrderBtn setEnabled:YES];
        [self.makeOrderBtn setBackgroundColor:[UIColor colorWithRed:237.0f/255.0f green:116.0f/255.0f blue:106.0f/255.0f alpha:1]];
    }
    [self.tableView reloadData];
}

#pragma mark - ItemDelegate

-(void)itemCountDidChange:(NSInteger)itemCount atIndexPath:(NSIndexPath *)indexPath{
    ItemCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [self cellItemCountDidChange:cell itemCount:itemCount];
}

#pragma mark - IBActions

- (IBAction)makeOrderBtnWasPressed:(id)sender {
    OrderVC *targetVC = [self.storyboard instantiateViewControllerWithIdentifier:@"OrderVC"];
    targetVC.itemsInCart = self.itemsInCart;
    [self presentToRight:targetVC];
}

- (IBAction)clearCartBtnWasPressed:(id)sender {
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Очистить корзину?"
                                 message:nil
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* cancelButton = [UIAlertAction
                                   actionWithTitle:@"Отмена"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       [alert dismissViewControllerAnimated:true completion:nil];
                                   }];
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:@"Ок"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   [alert dismissViewControllerAnimated:true completion:nil];
                                   [self.itemsInCart removeAllObjects];
                                   [self.tableView reloadData];
                                   [[self.tabBarController.tabBar.items objectAtIndex:1] setBadgeValue:nil];
                                   [self.clearCartBtn setHidden:YES];
                                   [self.emptyCartView setHidden:NO];
                               }];
    [alert addAction:cancelButton];
    [alert addAction:okButton];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)toMainVCBtnWasPressed:(id)sender {
    TabBarVC *tabBarVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TabBarVC"];
    tabBarVC.selectedIndex = 0;
    [self presentToLeft:tabBarVC];
}
@end
