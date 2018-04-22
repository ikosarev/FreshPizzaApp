//
//  AddressManager.m
//  FreshPizzaApp
//
//  Created by Ivan Kosarev on 06/04/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#import "AddressManager.h"

@interface AddressManager()
@end

@implementation AddressManager
+(AddressManager *)instance {
    static AddressManager *sharedInstance = nil;
    
    if (sharedInstance == nil) {
        sharedInstance = [[AddressManager alloc] init];
    }
    return sharedInstance;
}

@end
