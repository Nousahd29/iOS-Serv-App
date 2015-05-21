//
//  AppDelegate.m
//  SERVApp
//
//  Created by Surender Kumar on 22/01/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import "AppDelegate.h"
#import "MFSideMenuContainerViewController.h"
#import "MFSideMenu.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    
    [NSThread sleepForTimeInterval:2.0];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    UINavigationController *navigationController = [storyboard instantiateViewControllerWithIdentifier:@"navigationController"];
    
    UIViewController *leftsideMenuView=[storyboard instantiateViewControllerWithIdentifier:@"leftSideMenuViewController"];
    MFSideMenuContainerViewController *container = [MFSideMenuContainerViewController
                                                    containerWithCenterViewController:navigationController
                                                    leftMenuViewController:leftsideMenuView
                                                    rightMenuViewController:nil];
    
    self.window.rootViewController = container;
    [self.window makeKeyAndVisible];

//    //-- Set Notification
//    if ([application respondsToSelector:@selector(isRegisteredForRemoteNotifications)])
//    {
//        // iOS 8 Notifications
//        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
//        
//        [application registerForRemoteNotifications];
//    }
//    else
//    {
//        // iOS < 8 Notifications
//        [application registerForRemoteNotificationTypes:
//         (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)];
//    }
    
#ifdef __IPHONE_8_0
    //Right, that is the point
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert) categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
#else
    //register to receive notifications
    UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
#endif
    

    //[[UIApplication sharedApplication] setApplicationIconBadgeNumber: 0];

    
    
    self.customLocationManager = [CLLocationManager new];
    self.customLocationManager.delegate = self;
    //  self.mapView.showsUserLocation=YES;
    self.customLocationManager.distanceFilter = kCLDistanceFilterNone;
    self.customLocationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 &&
        [CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse
        //[CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedAlways
        ) {
        // Will open an confirm dialog to get user's approval
        [self.customLocationManager requestWhenInUseAuthorization];
        //[_locationManager requestAlwaysAuthorization];
    } else {
        [self.customLocationManager startUpdatingLocation]; //Will update location immediately
    }
    


    
    
    return YES;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    NSMutableArray *array_notificationData=[[NSMutableArray alloc]init];
    
    array_notificationData =[userInfo objectForKey:@"data"];
    
    NSLog(@"notification Data %@",userInfo);
    
    [[NSUserDefaults standardUserDefaults] setObject:array_notificationData forKey:@"notificationData"];
    
    [notificationAlert dismissWithClickedButtonIndex:0 animated:YES];
    
    if ([[[userInfo objectForKey:@"data"] objectForKey:@"status"]isEqualToString:@"Chat"])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"notificationAlert" object:nil];

    }
    else
    {
        notificationAlert = [[UIAlertView alloc]
                             initWithTitle:@"Alert!" message:[[userInfo objectForKey:@"aps"] objectForKey:@"alert"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [notificationAlert show];
    
    }
    
   // [UIApplication sharedApplication].applicationIconBadgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber + 1;

    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    //    if(alertView.tag == 1)
    //    {
    if (buttonIndex==0)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"notificationAlert" object:nil];
        
    }
    else
    {
        
    }
    // }
}


//-(void)badgeCounts
//{
//    badgeNumber++;
//    [[UIApplication sharedApplication] setApplicationIconBadgeNumber: badgeNumber];
//}

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSLog(@"Device Token %@",token);
    
    if ([token isEqualToString:@""] || [token isEqualToString:@"(null)"])
    {
        [[NSUserDefaults standardUserDefaults] setValue:@"123456" forKey:@"DeviceToken"];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setValue:token forKey:@"DeviceToken"];
    }
    
  //  [UIApplication sharedApplication].applicationIconBadgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber + 1;
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
}

//- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
//{
//    //handle the actions
//    if ([identifier isEqualToString:@"declineAction"]){
//    }
//    else if ([identifier isEqualToString:@"answerAction"]){
//    }
//}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    
}

# pragma mark - Updates user's current location

-(void)updateCurrentLocation {
    [self.customLocationManager startUpdatingLocation];
}

-(void)stopUpdatingCurrentLocation {
    [self.customLocationManager stopUpdatingHeading];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    self.currentUserLocation = newLocation;
    
    [self.customLocationManager stopUpdatingLocation];
    self.currentUserLocation = [[CLLocation alloc] initWithLatitude:newLocation.coordinate.latitude
                                                          longitude:newLocation.coordinate.longitude];
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
  //  [UIApplication sharedApplication].applicationIconBadgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber - 1;
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
   // [[UIApplication sharedApplication] setApplicationIconBadgeNumber: 0];

    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
