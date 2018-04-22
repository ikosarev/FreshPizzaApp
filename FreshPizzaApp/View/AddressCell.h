//
//  AddressCell.h
//  FreshPizzaApp
//
//  Created by Ivan Kosarev on 13/03/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *addressLbl;

- (void)configureCell:(NSString *) address;

@end
