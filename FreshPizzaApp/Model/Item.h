//
//  Item.h
//  FreshPizzaApp
//
//  Created by Ivan Kosarev on 24/03/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Item : NSObject

@property (readonly) NSString *name;
@property (readonly) NSString *desc;
@property (readonly) NSString *price;
@property (readonly) NSString *type;
@property (readonly) NSString *size;
@property (readonly) UIImage *image;

@property NSInteger count;

- (instancetype)initWithItemName:(NSString *)itemName itemDescription:(NSString *)itemDesc itemPrice:(NSString *)itemPrice itemType:(NSString *)itemType itemSize:(NSString *)itemSize itemImage:(UIImage *)itemImage;

@end
