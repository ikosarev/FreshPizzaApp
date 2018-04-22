//
//  GoogleService.m
//  FreshPizzaApp
//
//  Created by Ivan Kosarev on 14/03/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#import "HTTPService.h"
#import "Constants.h"
#import "StringOperations.h"

@implementation HTTPService
+(void) getGeocodeJsonFromAddress:(NSString *)addressString handler:(void(^)(NSDictionary *, NSError *))callback{
    NSMutableString* geocodeUrlString = [[NSMutableString alloc] initWithString:googleGeocodeUrl];
    
    NSString* addressStringRefined = [StringOperations prepareStringForUrl:addressString];
    
    [geocodeUrlString appendFormat:@"address=%@&key=%@&language=RU",addressStringRefined,googleApiKey];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:geocodeUrlString]];

    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if(httpResponse.statusCode == 200)
        {
            NSError *parseError = nil;
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            callback(result, nil);
        }
        else
        {
            callback(@{}, error);
        }
    }];
    [dataTask resume];
}

+(void) getAddressForLongitude:(CGFloat)longitude AndLatitude:(CGFloat)latitude handler:(void(^)(NSDictionary *, NSError * error))callback{
    NSMutableString* geocodeUrlString = [[NSMutableString alloc] initWithString:googleGeocodeUrl];
    
    [geocodeUrlString appendFormat:@"latlng=%f,%f&key=%@&language=RU&result_type=street_address",latitude,longitude,googleApiKey];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:geocodeUrlString]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if(httpResponse.statusCode == 200)
        {
            NSError *parseError = nil;
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            callback(result, nil);
        }
        else
        {
            callback(@{}, error);
        }
    }];
    [dataTask resume];
}

@end
