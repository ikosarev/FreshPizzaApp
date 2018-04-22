//
//  WhereToDeliverVCViewController.h
//  FreshPizzaApp
//
//  Created by Ivan Kosarev on 24/02/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "RoundedBtn.h"

@interface WhereToDeliverVC : UIViewController <GMSMapViewDelegate, CLLocationManagerDelegate> 
@property (nonatomic)double latitude;
@property (nonatomic)double longitude;
@property (weak, nonatomic) IBOutlet GMSMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *addressLbl;
@property (weak, nonatomic) IBOutlet RoundedBtn *iAmHereBtn;


- (IBAction)centerViewBtnWasPressed:(id)sender;
- (IBAction)backBtnWasPressed:(id)sender;
- (IBAction)iAmHereBtnWasPressed:(id)sender;
- (IBAction)anotherAddressBtnWasPressed:(id)sender;
@end
