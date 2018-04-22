//
//  JsonParser.m
//  FreshPizzaApp
//
//  Created by Ivan Kosarev on 16/03/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#import "JsonParser.h"

@implementation JsonParser

+(void) getCoordinatesFromAddressJson:(NSDictionary *) addressJson handler:(void(^)(BOOL statusError,BOOL success, double latitude, double  longitude ))completionHandler{
    NSString *status = [addressJson objectForKey:@"status"];
    if ([status isEqualToString:@"OK"]){
        NSDictionary *results = [[addressJson objectForKey:@"results"] objectAtIndex:0];
        NSString *addressType = [[results objectForKey:@"types"]objectAtIndex:0];
        NSString *partialMatch = [results objectForKey:@"partial_match"];
        if([addressType isEqual:@"street_address"] && partialMatch == nil){
            NSDictionary *location = [[results objectForKey:@"geometry"] objectForKey:@"location"];
            double latitude = [[location objectForKey:@"lat"] doubleValue];
            double longitude = [[location objectForKey:@"lng"] doubleValue];
            if(latitude && longitude){
                completionHandler(NO,YES,latitude,longitude);
            } else {
                completionHandler(NO,NO,0,0);
            }
        } else {
            completionHandler(NO,NO,0,0);
        }
    } else {
        completionHandler(YES,NO,0,0);
    }
    
}

+(void) getAddressFromAddressJson:(NSDictionary *) addressJson handler:(void(^)(BOOL success, NSString* address))completionHandler{
    NSString *status = [addressJson objectForKey:@"status"];
    if ([status isEqualToString:@"OK"]){        
        NSMutableString *address = [NSMutableString string];
        NSDictionary *results = [[addressJson objectForKey:@"results"] objectAtIndex:0];
        NSString *addressType = [[results objectForKey:@"types"]objectAtIndex:0];
        NSString *partialMatch = [results objectForKey:@"partial_match"];
        if([addressType isEqual:@"street_address"] && partialMatch == nil){
            NSArray *addressComponents = [results objectForKey:@"address_components"];
    
            NSDictionary *routeDict = [addressComponents objectAtIndex:1];
            NSString *routeType = [[routeDict objectForKey:@"types"]objectAtIndex:0];
            
            NSDictionary *streetNumberDict = [addressComponents objectAtIndex:0];
            NSString *streetNumberType = [[streetNumberDict objectForKey:@"types"]objectAtIndex:0];
            if([routeType isEqualToString:@"route"] && [streetNumberType isEqualToString:@"street_number"]){
                NSString *routeLongName = [routeDict objectForKey:@"long_name"];
                [address appendString:routeLongName];
                
                NSString *streetNumberLongName = [streetNumberDict objectForKey:@"long_name"];
                [address appendString:@", "];
                [address appendString:streetNumberLongName];
                completionHandler(YES, address);
            } else {
                completionHandler(NO, nil);
            }
        }
    } else {
        completionHandler(NO,nil);
    }
    
}

@end
