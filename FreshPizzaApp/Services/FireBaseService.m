//
//  FireBaseService.m
//  FreshPizzaApp
//
//  Created by Ivan Kosarev on 21/03/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#import "FireBaseService.h"
#import "Item.h"


@implementation FireBaseService
{
    FIRDatabaseReference* rootRef;
}
+(FireBaseService *)instance {
    static FireBaseService *sharedInstance = nil;
    
    if (sharedInstance == nil) {
        sharedInstance = [[FireBaseService alloc] init];
    }
    
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        rootRef = [[FIRDatabase database] reference];
    }
    return self;
}

-(void)getAllCompanies:(void(^)(NSArray*))completionHandler{
    [[rootRef child:@"companies"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        NSArray *dataSnapshot = snapshot.children.allObjects;
        NSMutableArray *companies = [[NSMutableArray alloc] init];
        for (FIRDataSnapshot *companySnapshot in dataSnapshot){
            NSMutableArray *items = [[NSMutableArray alloc] init];
            NSString *companyName = [[companySnapshot childSnapshotForPath:@"name"]value];
            NSString *companyDesc = [[companySnapshot childSnapshotForPath:@"description"]value];
            NSInteger rating = [[[companySnapshot childSnapshotForPath:@"rating"]value]integerValue];
            NSDictionary *location = [[[companySnapshot childSnapshotForPath:@"location"]value] objectAtIndex:0];
            NSString *companyAddress = [location objectForKey:@"address"];
            double latitude = [[location objectForKey:@"latitude"] doubleValue];
            double longitude = [[location objectForKey:@"longitude"] doubleValue];
            NSString *minOrderCost = [[companySnapshot childSnapshotForPath:@"minOrderCost"]value];
            NSString *companyimageString = [[companySnapshot childSnapshotForPath:@"image"]value];
            NSURL *companyimageUrl = [NSURL URLWithString:companyimageString];
            NSData *companyimageData = [NSData dataWithContentsOfURL:companyimageUrl];
            UIImage *companyImg = [UIImage imageWithData:companyimageData];
            NSString *companyLogoString = [[companySnapshot childSnapshotForPath:@"logo"]value];
            NSURL *companyLogoUrl = [NSURL URLWithString:companyLogoString];
            NSData *companyLogoData = [NSData dataWithContentsOfURL:companyLogoUrl];
            UIImage *companyLogo = [UIImage imageWithData:companyLogoData];
            NSArray *itemArray = [[companySnapshot childSnapshotForPath:@"foods"]value];
            for (NSDictionary *item in itemArray){
                NSString *itemName = [item objectForKey:@"name"];
                NSString *itemDesc = [item objectForKey:@"description"];
                NSString *itemPrice = [item objectForKey:@"price"];
                NSString *itemType = [item objectForKey:@"type"];
                NSString *itemSize = [item objectForKey:@"size"];
                NSString *itemImageString = [item objectForKey:@"image"];
                NSURL *itemImageUrl = [NSURL URLWithString:itemImageString];
                NSData *itemImageData = [NSData dataWithContentsOfURL:itemImageUrl];
                UIImage *itemImage = [UIImage imageWithData:itemImageData];
                Item *item = [[Item alloc] initWithItemName:itemName itemDescription:itemDesc itemPrice:itemPrice itemType:itemType itemSize:itemSize itemImage:itemImage];
                [items addObject:item];
                [itemImageUrl removeAllCachedResourceValues];
            }
            [companyimageUrl removeAllCachedResourceValues];
            Company *company = [[Company alloc] initWithCompanyName:companyName companyDescription:companyDesc minOrderCost:minOrderCost companyAddress:companyAddress latitude:latitude longitude:longitude rating:rating companyImage:companyImg companyLogo:companyLogo itemArray:items];
            [companies addObject:company];
        }
        completionHandler(companies);
    }];
}

-(void)createOrderWithName:(NSString *)name address:(NSString *)address apartment:(NSString *)apartment phoneNumber:(NSString *)phoneNumber comment:(NSString *)comment itemsArray:(NSArray *)itemsArray handler:(void(^)(BOOL))completionHandler{
    FIRDatabaseReference *orderReference = [[rootRef child:@"orders"] childByAutoId];
    [orderReference updateChildValues:@{@"customerName" : name, @"address" : address, @"apartment" : apartment, @"phoneNumber" : phoneNumber, @"comment" : comment}];
    for (Item *item in itemsArray){
        [[[orderReference child:@"items"] childByAutoId] updateChildValues:@{@"name" : item.name, @"count" : [NSNumber numberWithInteger:item.count], @"price" : item.price}];
    }
    completionHandler(YES);
}

@end
