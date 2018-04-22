//
//  CoreDataManager.m
//  FreshPizzaApp
//
//  Created by Ivan Kosarev on 09/04/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#import "CoreDataManager.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

@interface CoreDataManager ()
@end

@implementation CoreDataManager
+(CoreDataManager *)instance {
    static CoreDataManager *sharedInstance = nil;
    
    if (sharedInstance == nil) {
        sharedInstance = [[CoreDataManager alloc] init];
    }
    return sharedInstance;
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *managedObjectContext = ((AppDelegate*)[[UIApplication sharedApplication] delegate]).persistentContainer.viewContext;
    return managedObjectContext;
}

-(NSArray *)fetchCoreDataAddressArray{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"UserData"];
    [fetchRequest setReturnsObjectsAsFaults:NO];
    [fetchRequest setReturnsDistinctResults:YES];
    NSArray *addressArray = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] valueForKey:@"address"];
    return addressArray;
}

-(void)addAddressToCoreData:(NSString *)address{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSManagedObject *newData = [NSEntityDescription insertNewObjectForEntityForName:@"UserData" inManagedObjectContext:managedObjectContext];
    [newData setValue:address forKey:@"address"];
    NSError *error = nil;

    if (![managedObjectContext save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
}
@end
