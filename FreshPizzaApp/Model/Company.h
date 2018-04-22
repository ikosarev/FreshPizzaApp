//
//  Company.h
//  FreshPizzaApp
//
//  Created by Ivan Kosarev on 23/03/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Company : NSObject

@property (readonly) NSString *name;
@property (readonly) NSString *desc;
@property (readonly) NSString *minOrderCost;
@property (readonly) NSString *address;
@property (readonly) double coordinatesLatitude;
@property (readonly) double coordinatesLongitude;
@property (readonly) NSInteger rating;
@property (readonly) UIImage *image;
@property (readonly) UIImage *logo;
@property (readonly) NSArray *itemArray;
@property  NSString *deliveryTime;

- (instancetype)initWithCompanyName:(NSString *)companyName companyDescription:(NSString *)companyDesc minOrderCost:(NSString *)minOrderCost companyAddress:(NSString *)companyAddress latitude:(double)latitude longitude:(double)longitude rating:(NSInteger)rating companyImage:(UIImage *)companyImage companyLogo:(UIImage *)companyLogo itemArray:(NSArray *)itemArray;

@end
