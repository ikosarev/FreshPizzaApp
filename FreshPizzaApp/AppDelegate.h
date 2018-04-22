//
//  AppDelegate.h
//  FreshPizzaApp
//
//  Created by Ivan Kosarev on 21/02/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@import FirebaseDatabase;
@import Firebase;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

