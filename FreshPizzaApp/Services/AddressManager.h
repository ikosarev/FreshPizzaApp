//
//  AddressManager.h
//  FreshPizzaApp
//
//  Created by Ivan Kosarev on 06/04/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressManager : NSObject
+(AddressManager *)instance;

@property (strong, nonatomic) NSString * address;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;

@end
