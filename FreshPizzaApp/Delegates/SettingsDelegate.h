//
//  SettingsDelegate.h
//  FreshPizzaApp
//
//  Created by Ivan Kosarev on 31/03/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SettingsDelegate<NSObject>
-(void)sortingMethodHasChanged:(NSString *)sortingMethod;
@end
