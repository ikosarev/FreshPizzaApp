//
//  RoundedView.m
//  FreshPizzaApp
//
//  Created by Ivan Kosarev on 20/03/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#import "RoundedView.h"

@implementation RoundedView

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setUpView];
}

- (void) setUpView{
    self.layer.cornerRadius = 6.0;
    self.layer.masksToBounds = YES;
}

@end
