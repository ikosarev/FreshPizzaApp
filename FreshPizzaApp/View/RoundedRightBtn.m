//
//  RoundedRightBtn.m
//  FreshPizzaApp
//
//  Created by Ivan Kosarev on 21/04/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#import "RoundedRightBtn.h"

@implementation RoundedRightBtn

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setUpView];
}

- (void) setUpView{
    CAShapeLayer * maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect: self.bounds byRoundingCorners: UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii: (CGSize){6.0, 6.0}].CGPath;
    
    self.layer.mask = maskLayer;
    self.layer.masksToBounds = YES;
}

@end
