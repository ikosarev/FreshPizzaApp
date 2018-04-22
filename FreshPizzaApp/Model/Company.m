//
//  Company.m
//  FreshPizzaApp
//
//  Created by Ivan Kosarev on 23/03/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#import "Company.h"

@interface Company ()
@property (readwrite) NSString *name;
@property (readwrite) NSString *desc;
@property (readwrite) NSString *minOrderCost;
@property (readwrite) NSString *address;
@property (readwrite) double coordinatesLatitude;
@property (readwrite) double coordinatesLongitude;
@property (readwrite) NSInteger rating;
@property (readwrite) UIImage *image;
@property (readwrite) UIImage *logo;
@property (readwrite) NSArray *itemArray;
@end

@implementation Company

- (instancetype)initWithCompanyName:(NSString *)companyName companyDescription:(NSString *)companyDesc minOrderCost:(NSString *)minOrderCost companyAddress:(NSString *)companyAddress latitude:(double)latitude longitude:(double)longitude rating:(NSInteger)rating companyImage:(UIImage *)companyImage companyLogo:(UIImage *)companyLogo itemArray:(NSArray *)itemArray
{
    self = [super init];
    if (self) {
        self.name = companyName;
        self.desc = companyDesc;
        self.minOrderCost = minOrderCost;
        self.address = companyAddress;
        self.coordinatesLatitude = latitude;
        self.coordinatesLongitude = longitude;
        self.rating = rating;
        self.image = companyImage;
        self.logo = companyLogo;
        self.itemArray = itemArray;
    }
    return self;
}

@end
