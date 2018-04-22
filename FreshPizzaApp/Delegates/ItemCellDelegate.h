//
//  ItemCellProtocol.h
//  FreshPizzaApp
//
//  Created by Ivan Kosarev on 26/03/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ItemCellDelegate<NSObject>
-(void)cellItemCountDidChange:(UITableViewCell*)cell itemCount:(NSInteger)itemCount;
@end
