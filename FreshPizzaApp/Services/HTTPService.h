//
//  GoogleService.h
//  FreshPizzaApp
//
//  Created by Ivan Kosarev on 14/03/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTTPService : NSObject
+(void) getGeocodeJsonFromAddress:(NSString *)addressString handler:(void(^)(NSDictionary*, NSError *))callback;
+(void) getAddressForLongitude:(CGFloat)longitude AndLatitude:(CGFloat)latitude handler:(void(^)(NSDictionary *, NSError * error))callback;
@end
