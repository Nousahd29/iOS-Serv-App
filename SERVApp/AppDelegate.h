//
//  AppDelegate.h
//  SERVApp
//
//  Created by Surender Kumar on 22/01/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,UIAlertViewDelegate,CLLocationManagerDelegate>
{
    UIAlertView *notificationAlert;
    int badgeNumber;

}

@property (strong, nonatomic) CLLocationManager *customLocationManager;
@property (strong, nonatomic) CLLocation *currentUserLocation;

- (void)updateCurrentLocation;
- (void)stopUpdatingCurrentLocation;
- (void)setupSpeechKitConnection;

@property (strong, nonatomic) UIWindow *window;


@end

