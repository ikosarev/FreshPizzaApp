//
//  ItemVC.m
//  FreshPizzaApp
//
//  Created by Ivan Kosarev on 25/03/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#import "ItemVC.h"
#import "UIViewController+Transitions.h"

@interface ItemVC ()

@end

@implementation ItemVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.itemNameLbl.text = self.item.name;
    self.itemDescLbl.text = self.item.desc;
    self.itemImg.image = self.item.image;
    self.itemPriceLbl.text = [NSString stringWithFormat:@"%@ ₽",self.item.price];
    // Applying simple layer for darkening image is ok here because image is static
    CALayer *blackLayer = [CALayer layer];
    blackLayer.frame = self.itemImg.bounds;
    blackLayer.backgroundColor = [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.2f].CGColor;
    [self.itemImg.layer insertSublayer:blackLayer atIndex:0];
    self.itemCountLbl.text = [NSString stringWithFormat:@"%ld",self.item.count];
    [self setNeedsStatusBarAppearanceUpdate];
    if(self.item.count == 0){
        [self.addBtn setHidden:NO];
        [self.itemCounter setHidden:YES];
    } else {
        [self.addBtn setHidden:YES];
        [self.itemCounter setHidden:NO];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)minusBtnWasPressed:(id)sender {
    if (self.item.count != 1){
        self.item.count --;
        self.itemCountLbl.text = [NSString stringWithFormat:@"%ld",self.item.count];
    } else {
        self.item.count = 0;
        [self.itemCounter setHidden:YES];
        [self.addBtn setHidden:NO];
    }
}

- (IBAction)plusBtnWasPressed:(id)sender {
    self.item.count ++;
    self.itemCountLbl.text = [NSString stringWithFormat:@"%ld",self.item.count];
}

- (IBAction)closeBtnWasPressed:(id)sender {
    [self.delegate itemCountDidChange:self.item.count atIndexPath:self.indexPath];
    [self dismissFromRight];
}

- (IBAction)addBtnWasPressed:(id)sender {
    self.item.count = 1;
    [self.addBtn setHidden:YES];
    [self.itemCounter setHidden:NO];
}
@end
