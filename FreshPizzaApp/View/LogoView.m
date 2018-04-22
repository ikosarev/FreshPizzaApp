//
//  LogoView.m
//  FreshPizzaApp
//
//  Created by Ivan Kosarev on 21/04/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#import "LogoView.h"

@implementation LogoView

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setUpView];
}

- (void) setUpView{
    self.layer.cornerRadius = 6.0;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = 1;
}

@end
