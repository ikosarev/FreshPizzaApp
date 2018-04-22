//
//  CoreDataManager.h
//  FreshPizzaApp
//
//  Created by Ivan Kosarev on 09/04/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoreDataManager : NSObject
+(CoreDataManager *)instance;

-(NSArray *)fetchCoreDataAddressArray;
-(void)addAddressToCoreData:(NSString *)address;
@end
