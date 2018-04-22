//
//  RoundedBtn.m
//  FreshPizzaApp
//
//  Created by Ivan Kosarev on 12/03/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#import "RoundedBtn.h"


@implementation RoundedBtn

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
