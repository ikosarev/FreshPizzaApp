//
//  JsonParser.h
//  FreshPizzaApp
//
//  Created by Ivan Kosarev on 16/03/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonParser : NSObject
+(void) getCoordinatesFromAddressJson:(NSDictionary *) addressJson handler:(void(^)(BOOL statusError,BOOL success, double latitude, double  longtitude ))completionHandler;
+(void) getAddressFromAddressJson:(NSDictionary *) addressJson handler:(void(^)(BOOL success, NSString* address))completionHandler;
@end
