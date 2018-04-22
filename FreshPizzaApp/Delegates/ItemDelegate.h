//
//  ItemDelegate.h
//  FreshPizzaApp
//
//  Created by Ivan Kosarev on 02/04/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"

@protocol ItemDelegate<NSObject>
-(void)itemCountDidChange:(NSInteger)itemCount atIndexPath:(NSIndexPath *)indexPath;
@end
