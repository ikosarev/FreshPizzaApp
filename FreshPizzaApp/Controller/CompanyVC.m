//
//  ItemVC.m
//  FreshPizzaApp
//
//  Created by Ivan Kosarev on 20/03/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#import "CompanyVC.h"
#import "ItemCell.h"
#import "ItemVC.h"
#import "ShoppingCartVC.h"
#import "TabBarVC.h"
#import "UIViewController+Transitions.h"
#import "UIColor+AppColors.h"
//#import <QuartzCore/QuartzCore.h>
#import <CoreImage/CoreImage.h>

@interface CompanyVC ()
{
    CALayer *blackLayer;
    
    BOOL barStyleLight;
    NSInteger totalCount;
    NSInteger minOrderCost;
    NSInteger totalPrice;
}
@end

@implementation CompanyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    barStyleLight = YES;
    [self setNeedsStatusBarAppearanceUpdate];
    self.companyNameNavBarLbl.text = self.company.name;
    self.companyImage.image = [self getDarkenedImageFromSourceImage:self.company.image];
    self.companyNameLbl.text = self.company.name;
    self.companyLogo.image = self.company.logo;
    self.minOrderCostLbl.text = [NSString stringWithFormat:@"Заказ от %@ ₽", self.company.minOrderCost ];
    self.deliveryTimeLbl.text = self.company.deliveryTime;
    self.deliveryCostLbl.text = @"Доставка бесплатно";
    switch (self.company.rating) {
            // No other cases made for simplicity
        case 3:
            self.companyRatingImg.image = [UIImage imageNamed:@"rating3"];
            break;
        case 4:
            self.companyRatingImg.image = [UIImage imageNamed:@"rating4"];
            break;
        case 5:
            self.companyRatingImg.image = [UIImage imageNamed:@"rating5"];
            break;
        default:
            [self.companyRatingImg setHidden:YES];
            break;
    }
    
    minOrderCost = [self.company.minOrderCost intValue];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.backBtn.tintColor = UIColor.whiteColor;
    
    [self.toCartBtn setEnabled:NO];
    [self.toCartBtn setBackgroundColor:UIColor.appGrayColor];
    self.cartViewConstraint.constant = 0;
    
    self.itemsInCart = [[NSMutableArray alloc] init];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    if (barStyleLight){
        return UIStatusBarStyleLightContent;
    }
    else {
        return UIStatusBarStyleDefault;
    }
}

#pragma mark - UITableView

-(void)scrollViewDidScroll:(UIScrollView*)scrollView {
    if (scrollView.contentOffset.y < 0) {
        self.companyImageConstraint.constant = self.tableView.contentOffset.y;
    }
    if(scrollView.contentOffset.y > self.companyImage.frame.size.height - self.navBarView.frame.size.height ){
        barStyleLight = NO;
        [self setNeedsStatusBarAppearanceUpdate];
        [self.backBtn setImage:[UIImage imageNamed:@"left-arrow"] forState:UIControlStateNormal];
        self.backBtn.tintColor = UIColor.blackColor;
        [self.navBarView setHidden:NO];
    } else {
        barStyleLight = YES;
        [self setNeedsStatusBarAppearanceUpdate];
        [self.backBtn setImage:[UIImage imageNamed:@"left-arrow-white"] forState:UIControlStateNormal];
        [self.navBarView setHidden:YES];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.company.itemArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ItemCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ItemCell" forIndexPath: indexPath];
    if (cell != nil){
        Item *item = [self.company.itemArray objectAtIndex:indexPath.row];
        [cell configureCellWithItem:item];
        cell.delegate = self;
        return cell;
    } else {
        return [[UITableViewCell alloc] init];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ItemVC *targetVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ItemVC"];
    ItemCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    targetVC.item = cell.item;
    targetVC.indexPath = indexPath;
    targetVC.delegate = self;
    [self presentToRight:targetVC];
}

#pragma mark - ItemCellDelegate

-(void)cellItemCountDidChange:(ItemCell *)cell itemCount:(NSInteger)itemcount{
    totalCount = 0;
    totalPrice = 0;
    // Deleting item if it is in itemsInCart array
    if ([self.itemsInCart containsObject:cell.item]){
        [self.itemsInCart removeObject:cell.item];
    }
    // Adding updated item if it's count not equals to zero
    if (cell.item.count != 0 ){
        [self.itemsInCart addObject:cell.item];
    }
    for (Item *item in self.itemsInCart){
        totalCount += item.count;
        totalPrice += (item.price.integerValue * item.count);
    }
    if(minOrderCost - totalPrice > 0){
        [UIView animateWithDuration:0.3 animations:^{
            [self.toCartBtn setBackgroundColor:UIColor.appGrayColor];
        }];
        self.cartViewConstraint.constant = 100;
        [self.view setNeedsLayout];
        [self.view layoutIfNeeded];
        [self.priceToMinOrderCostLbl setHidden:NO];
        self.priceToMinOrderCostLbl.text = [NSString stringWithFormat:@"%ld ₽ до минимальной суммы заказа", minOrderCost - totalPrice];
        [self.toCartBtn setEnabled:NO];
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            [self.toCartBtn setBackgroundColor:UIColor.appRedColor];
        }];
        self.cartViewConstraint.constant = 70;
        [self.view setNeedsLayout];
        [self.view layoutIfNeeded];
        [self.priceToMinOrderCostLbl setHidden:YES];
        [self.toCartBtn setEnabled:YES];
    }
    
    // Getting cell.frame relative to superview
    CGRect cellForSuperView = [self.tableView convertRect:cell.frame toView:self.tableView.superview];
    CGFloat oldOffsetReversed = self.tableView.contentSize.height - self.tableView.contentOffset.y;
    [self.tableView reloadData];
    [self.view layoutIfNeeded];
    // Applying old offset to tableview so it doesn't jump when cartView appears
    CGFloat offset = self.tableView.contentSize.height - oldOffsetReversed;
    self.tableView.contentOffset = CGPointMake(0, offset);
    CGFloat cellBottomY = cellForSuperView.origin.y + cellForSuperView.size.height;
    // If current cell is being obstructed by cartView -> scroll so it's visible
    if(self.cartView.frame.origin.y < cellBottomY) {
        [self.tableView scrollRectToVisible:cell.frame animated:YES];
    }
    
}

#pragma mark - Image filtering

-(UIImage *)getDarkenedImageFromSourceImage:(UIImage *)sourceImage{
    CGSize imageSize = sourceImage.size;
    CGRect imageExtent = CGRectMake(0,0,imageSize.width,imageSize.height);
    
    // Create a context containing the image.
    UIGraphicsBeginImageContext(imageSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.company.image drawAtPoint:CGPointMake(0,0)];
    
    // Apply UIColor on top of the image.
    CGContextSetBlendMode(context, kCGBlendModeDarken);
    [[UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0.25] set];
    UIBezierPath *imagePath = [UIBezierPath bezierPathWithRect:imageExtent];
    [imagePath fill];
    
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return result;
}

#pragma mark - ItemDelegate

-(void)itemCountDidChange:(NSInteger)itemCount atIndexPath:(NSIndexPath *)indexPath{
    ItemCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [self.tableView scrollRectToVisible:cell.frame animated:NO]; // debug
    [self cellItemCountDidChange:cell itemCount:itemCount];
}

#pragma mark - IBActions

- (IBAction)toCartBtnWasPressed:(id)sender {
    TabBarVC *tabBarVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TabBarVC"];
    tabBarVC.selectedIndex = 1;
    NSDictionary *itemData = [[NSDictionary alloc] initWithObjectsAndKeys: self.itemsInCart, @"itemsInCart", self.company, @"company", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"itemData"
                                                        object:self
                                                      userInfo:itemData];
    [self presentToRight:tabBarVC];
}

- (IBAction)backBtnWasPressed:(id)sender {
    for (Item *item in self.company.itemArray){
        item.count = 0; // Clearing item counters
    }
    [self dismissFromRight];
}
@end
