//
//  WhereToDeliverVCViewController.m
//  FreshPizzaApp
//
//  Created by Ivan Kosarev on 24/02/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#define BETWEEN(value, min, max) (value < max && value > min)

#import "WhereToDeliverVC.h"
#import "EnterLocationVC.h"
#import "SearchAddressVC.h"
#import <GoogleMaps/GoogleMaps.h>
#import "HTTPService.h"
#import "JsonParser.h"
#import "StringOperations.h"
#import "TabBarVC.h"
#import "Constants.h"
#import "UIViewController+Transitions.h"
#import "UIColor+AppColors.h"
#import "AddressManager.h"

@interface WhereToDeliverVC ()
{
    BOOL animatedToLocation;
    BOOL isAddressValid;
    CGFloat cameraXPosition;
    CGFloat cameraYPosition;
    CGPoint centerPoint;
    CLLocationManager *locationManager;
}
@property NSTimer* timer;
@end

@implementation WhereToDeliverVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.addressLbl.text = @"";
    self.mapView.delegate = self;
    locationManager.delegate = self;
    [locationManager requestWhenInUseAuthorization];
    [self.iAmHereBtn setEnabled:NO];
    [self.iAmHereBtn setBackgroundColor:UIColor.appGrayColor];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(!self.latitude && !self.longitude){
        self.latitude = moscowCenterLat;
        self.longitude = moscowCenterLng;
    }
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:self.latitude
                                                            longitude:self.longitude
                                                                 zoom:17];
    self.mapView.camera = camera;
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSURL *styleUrl = [mainBundle URLForResource:@"style" withExtension:@"json"];
    NSError *error;
    
    // Set the map style by passing the URL for style.json.
    GMSMapStyle *style = [GMSMapStyle styleWithContentsOfFileURL:styleUrl error:&error];
    
    if (!style) {
        NSLog(@"The style definition could not be loaded: %@", error);
    }
    self.mapView.mapStyle = style;
    [self.mapView setMyLocationEnabled:YES];
        cameraXPosition = 187;
        cameraYPosition = 257;
        centerPoint = CGPointMake(cameraXPosition, cameraYPosition);
    animatedToLocation = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CLLocation Manager

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse){
        [locationManager startUpdatingLocation];
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *location = [locations firstObject];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:location.coordinate.latitude
                                                            longitude:location.coordinate.longitude
                                                                 zoom:20];
    self.mapView.camera = camera;

    [locationManager stopUpdatingLocation];
}

#pragma mark - GMS MapView

-(void)mapView:(GMSMapView *)mapView idleAtCameraPosition:(GMSCameraPosition *)position{
    if (!animatedToLocation){
        [self startLoadingAnimation];
        [self.iAmHereBtn setEnabled:NO];
        [self.iAmHereBtn setBackgroundColor:UIColor.appGrayColor];
        isAddressValid = NO;
        self.latitude = [mapView.projection coordinateForPoint:centerPoint].latitude;
        self.longitude = [mapView.projection coordinateForPoint:centerPoint].longitude;
        [HTTPService getAddressForLongitude:_longitude AndLatitude:self.latitude handler:^(NSDictionary *returnedJson, NSError * error) {
            if (error){
                animatedToLocation = NO;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.iAmHereBtn setEnabled:NO];
                    [self.iAmHereBtn setBackgroundColor:UIColor.appGrayColor];
                    [self stopLoadingAnimation];
                    self.addressLbl.text = @"Отсутствует интернет соединение";
                });
            } else {
            if(returnedJson){
            [JsonParser getAddressFromAddressJson:returnedJson handler:^(bool success, NSString *address) {
                if(success){
                    NSLog(@"WhereToDeliverVC - address: %@", address);
                        [self stopLoadingAnimation];
                        isAddressValid = YES;
                        if (BETWEEN(self.latitude, moscowBoundsLatMin, moscowBoundsLatMax) && (BETWEEN(self.longitude, moscowBoundsLngMin, moscowBoundsLngMax))){
                            
                            [[AddressManager instance] setAddress:address];
                            [[AddressManager instance] setLatitude:self.latitude];
                            [[AddressManager instance] setLongitude:self.longitude];
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
                            self.addressLbl.text = address;
                            [self.iAmHereBtn setEnabled:YES];
                            [self.iAmHereBtn setBackgroundColor:UIColor.appRedColor];
                            });
                        } else {
                            dispatch_async(dispatch_get_main_queue(), ^{
                            self.addressLbl.text = @"Адрес находится за пределами зоны доставки";
                            [self.iAmHereBtn setEnabled:NO];
                            [self.iAmHereBtn setBackgroundColor:UIColor.appGrayColor];
                            });
                    }
                        isAddressValid = YES;
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.iAmHereBtn setEnabled:NO];
                        [self.iAmHereBtn setBackgroundColor:UIColor.appGrayColor];
                    });
                }
            }];
            [JsonParser getCoordinatesFromAddressJson:returnedJson handler:^(BOOL statusError, BOOL success, double latitude, double longitude) {
                if(!statusError){
                if (success){
                    if (BETWEEN(latitude, moscowBoundsLatMin, moscowBoundsLatMax) && (BETWEEN(longitude, moscowBoundsLngMin, moscowBoundsLngMax))){
                        dispatch_async(dispatch_get_main_queue(), ^{
                            CLLocation *newLocation = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
                            [self.mapView animateToLocation:newLocation.coordinate];
                            animatedToLocation = YES;
                            [self stopLoadingAnimation];
                        });

                    }
                }
                }
            }];
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self stopLoadingAnimation];
                    [self.iAmHereBtn setEnabled:NO];
                    [self.iAmHereBtn setBackgroundColor:UIColor.appGrayColor];
                    self.addressLbl.text = @"Отсутствует интернет соединение";
                });
            }
            }
        }];
    } else {
        animatedToLocation = NO;
    }
}

#pragma mark - Address loading animation

- (void)startLoadingAnimation {
    [self stopLoadingAnimation];
    self.addressLbl.text = @"Ищем вас";
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(updateLoadingLabel) userInfo:nil repeats:YES];
}

- (void)updateLoadingLabel {
    NSString *dots = @"...";
    
    if ([self.addressLbl.text rangeOfString:dots].location == NSNotFound) {
        self.addressLbl.text = [NSString stringWithFormat:@"%@.",self.addressLbl.text];
    } else {
        self.addressLbl.text = @"Ищем вас";
    }
}

- (void)stopLoadingAnimation {
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark - IBActions

- (IBAction)centerViewBtnWasPressed:(id)sender {
    NSLog(@"User's location: %@", self.mapView.myLocation);
    [self.mapView animateToLocation:self.mapView.myLocation.coordinate];
}

- (IBAction)backBtnWasPressed:(id)sender {
    EnterLocationVC *targetVC = [self.storyboard instantiateViewControllerWithIdentifier:@"EnterLocationVC"];
    [self presentToLeft:targetVC];
}

- (IBAction)iAmHereBtnWasPressed:(id)sender {
        if(BETWEEN(self.latitude, moscowBoundsLatMin, moscowBoundsLatMax) && BETWEEN(self.longitude, moscowBoundsLngMin, moscowBoundsLngMax)){
            TabBarVC *targetVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TabBarVC"];
    
            [self presentToRight:targetVC];
        }
}

- (IBAction)anotherAddressBtnWasPressed:(id)sender {
    SearchAddressVC *targetVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchAddressVC"];
    [self presentViewController:targetVC animated:YES completion:nil];
}
@end
