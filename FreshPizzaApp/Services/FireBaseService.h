//
//  FireBaseService.h
//  FreshPizzaApp
//
//  Created by Ivan Kosarev on 21/03/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Company.h"
#import "Item.h"
#import "StringOperations.h"
@import FirebaseDatabase;
@import Firebase;

@interface FireBaseService : NSObject
+(FireBaseService *)instance;

-(void)getAllCompanies:(void(^)(NSArray*))completionHandler;
-(void)createOrderWithName:(NSString *)name address:(NSString *)address apartment:(NSString *)apartment phoneNumber:(NSString *)phoneNumber comment:(NSString *)comment itemsArray:(NSArray *)itemsArray handler:(void(^)(BOOL))completionHandler;
@end
