//
//  TopView.m
//  FreshPizzaApp
//
//  Created by Ivan Kosarev on 08/04/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#import "TopView.h"

@implementation TopView

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setUpView];
}

- (void) setUpView{
    self.layer.shadowColor = [UIColor colorWithRed:242.0f/255.0f green:242.0f/255.0f blue:242.0f/255.0f alpha:1].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 1.0);
    self.layer.shadowOpacity = 1.0;
    self.layer.shadowRadius = 0.0;
}

@end
