//
//  Item.m
//  FreshPizzaApp
//
//  Created by Ivan Kosarev on 24/03/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#import "Item.h"

@interface Item ()
@property (readwrite) NSString *name;
@property (readwrite) NSString *desc;
@property (readwrite) NSString *price;
@property (readwrite) NSString *type;
@property (readwrite) NSString *size;
@property (readwrite) UIImage *image;
@end

@implementation Item

- (instancetype)initWithItemName:(NSString *)itemName itemDescription:(NSString *)itemDesc itemPrice:(NSString *)itemPrice itemType:(NSString *)itemType itemSize:(NSString *)itemSize itemImage:(UIImage *)itemImage
{
    self = [super init];
    if (self) {
        self.name = itemName;
        self.desc = itemDesc;
        self.price = itemPrice;
        self.type = itemType;
        self.size = itemSize;
        self.image = itemImage;
    }
    return self;
}

@end
