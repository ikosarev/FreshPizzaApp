//
//  StringOperations.m
//  FreshPizzaApp
//
//  Created by Ivan Kosarev on 15/03/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#import "StringOperations.h"

@implementation StringOperations
+(NSString*)prepareStringForUrl:(NSString* )unpreparedString{
    
    unpreparedString = [unpreparedString stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    unpreparedString = [unpreparedString stringByReplacingOccurrencesOfString:@"/" withString:@"+"];
    unpreparedString = [unpreparedString stringByReplacingOccurrencesOfString:@"," withString:@""];
    unpreparedString = [unpreparedString stringByReplacingOccurrencesOfString:@"`" withString:@""];
    unpreparedString = [unpreparedString stringByReplacingOccurrencesOfString:@"(" withString:@""];
    unpreparedString = [unpreparedString stringByReplacingOccurrencesOfString:@")" withString:@""];
    
    NSMutableString *newString = [NSMutableString string];
    NSRange range;
    NSString *symbol;
    NSString *newSymbol;
    
    for (NSUInteger i = 0; i < [unpreparedString length]; i ++)
    {
        range = NSMakeRange(i, 1);
        symbol = [unpreparedString substringWithRange:range];
        newSymbol = [self transliterateCyrrilicCharToLatin:symbol];
        if (newSymbol != nil)
        {
            [newString appendString:newSymbol];
        }
        else
        {
            [newString appendString:symbol];
        }
    }
    return [NSString stringWithString:newString];
}

+ (NSString *)transliterateCyrrilicCharToLatin:(NSString *)symbol
{
    
    NSArray *cyrillicChars = @[@"а", @"б", @"в", @"г", @"д", @"е", @"ё", @"ж", @"з", @"и", @"й", @"к", @"л", @"м", @"н", @"о", @"п", @"р", @"с", @"т", @"у", @"ф", @"х", @"ц", @"ч", @"ш", @"щ", @"ъ", @"ы", @"ь", @"э", @"ю", @"я"];
    NSArray *latinChars = @[@"a", @"b", @"v", @"g", @"d", @"e", @"yo", @"zh", @"z", @"i", @"y", @"k", @"l", @"m", @"n", @"o", @"p", @"r", @"s", @"t", @"u", @"f", @"h", @"ts", @"ch", @"sh", @"shch", @"'", @"y", @"'", @"e", @"yu", @"ya"];
    NSDictionary *convertDict = [NSDictionary dictionaryWithObjects:latinChars
                                                            forKeys:cyrillicChars];
    return [convertDict valueForKey:[symbol lowercaseString]];
}


@end















