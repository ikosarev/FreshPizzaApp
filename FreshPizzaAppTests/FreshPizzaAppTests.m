//
//  FreshPizzaAppTests.m
//  FreshPizzaAppTests
//
//  Created by Ivan Kosarev on 10/04/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "JsonParser.h"
#import "StringOperations.h"
#import "HTTPService.h"

@interface FreshPizzaAppTests : XCTestCase

@end

@implementation FreshPizzaAppTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testHTTPGeocodeFromAddressString{
    NSString *address = @"улица Большая Лубянка, 12/1";
    
    [HTTPService getGeocodeJsonFromAddress:address handler:^(NSDictionary *returnedJson, NSError *error) {
        XCTAssert(error == nil, @"Error is not empty");
        XCTAssert(returnedJson != nil, @"Returned Json is empty");
    }];
}

-(void)testHTTPGetAddressForLongitude{
    CGFloat longitude = 37.6250278;
    CGFloat latitude = 55.7557638;
    
    [HTTPService getAddressForLongitude:longitude AndLatitude:latitude handler:^(NSDictionary *returnedJson, NSError *error) {
        XCTAssert(error == nil, @"Error is not empty");
        XCTAssert(returnedJson != nil, @"Returned Json is empty");
    }];
}

- (void)testGetCoordinatesFromAddressJson{
    NSBundle *testBundle = [NSBundle bundleForClass:[self class]];
    NSURL *filePath = [testBundle URLForResource:@"address" withExtension:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfURL:filePath];
    NSDictionary *addressJson = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    [JsonParser getAddressFromAddressJson:addressJson handler:^(BOOL success, NSString *address) {
        XCTAssert(success);
        XCTAssert([address isEqualToString:@"Смольная улица, 25"], @"Returned address wasn't correct");
    }];
}

- (void)testGetAddressFromAddressJson{
    NSBundle *testBundle = [NSBundle bundleForClass:[self class]];
    NSURL *filePath = [testBundle URLForResource:@"address" withExtension:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfURL:filePath];
    NSDictionary *addressJson = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    [JsonParser getCoordinatesFromAddressJson:addressJson handler:^(BOOL statusError,BOOL success, double latitude, double longitude) {
         XCTAssert(!statusError);
        XCTAssert(success);
        XCTAssert(latitude == 55.8498167);
        XCTAssert(longitude == 37.49457);
    }];
    
}

- (void)testPrepareStringForURL{
    NSString *cyrrilicString = @"улица Большая Лубянка, 12/1";
    NSString *preparedString = [StringOperations prepareStringForUrl:cyrrilicString];
    
    XCTAssert([preparedString isEqualToString:@"ulitsa+bol'shaya+lubyanka+12+1"]);
}


@end
