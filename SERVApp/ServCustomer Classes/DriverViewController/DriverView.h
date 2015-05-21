//
//  DriverView.h
//  SERVApp
//
//  Created by Noushad on 03/04/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@interface DriverView : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate,MKAnnotation,UIAlertViewDelegate>


{
    IBOutlet UIView *datePickerView;
    IBOutlet UIView *fadedView;
    NSString *dateString;
    
    CLLocationManager *locationManager;
    CLLocation *location;
    
    CLLocationCoordinate2D coordinate2d;
    NSJSONSerialization *json;
    
    NSString *locationNameString;
    
    float latitude,longitude;
    NSMutableArray *searchLocationArray;
    
    UIAlertView *notificationAlert;
    NSTimer *rememberTimer;
    
    UIAlertView *errorAlertView;
    
    IBOutlet UILabel *lbl_setDestinationLocation;
    IBOutlet UILabel *lbl_pikUpLocation;
    IBOutlet UILabel *lbl_destinationLocation;

    BOOL isDestination;
    NSString *str_customerServId;
    
    IBOutlet UIView *view_setLocation;

}

@property (strong, nonatomic) IBOutlet UILabel *labelMapLocation;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;


/*
@property (strong, nonatomic) IBOutlet UIButton *btnGetRememberedLocations;
@property (strong, nonatomic) IBOutlet UIButton *btnGoToSettings;
@property (strong, nonatomic) IBOutlet UIButton *btnGetCurrentLocation;
@property (strong, nonatomic) IBOutlet UIButton *btnGoToSearchLocation;
@property (strong, nonatomic) IBOutlet UIButton *btnRememberLocation;
@property (strong, nonatomic) IBOutlet UIButton *btnAddStartTime;
@property (strong, nonatomic) IBOutlet UIButton *btnAddEndTime;
@property (strong, nonatomic) IBOutlet UILabel *labelStart;
@property (strong, nonatomic) IBOutlet UILabel *labelEnd;
@property (strong, nonatomic) IBOutlet UILabel *labelStartTime;
@property (strong, nonatomic) IBOutlet UILabel *labelEndTime;
@property (strong, nonatomic) IBOutlet UIButton *btnStartTime;
@property (strong, nonatomic) IBOutlet UIButton *btnEndTime;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UIButton *btnPicDate;
 */

@property (strong, nonatomic) IBOutlet UIImageView *imagePickup;
@property (strong, nonatomic) IBOutlet UIImageView *imageDestination;



/*

- (IBAction)PicDate:(id)sender;
- (IBAction)getDateFomDatePicker:(id)sender;
- (IBAction)GetRememberedLocations:(id)sender;
- (IBAction)GoToSettings:(id)sender;
- (IBAction)GetCurrentLocation:(id)sender;
- (IBAction)GoToSearchLocation:(id)sender;
- (IBAction)RememberLocation:(id)sender;
- (IBAction)AddStartTime:(id)sender;
- (IBAction)AddEndTime:(id)sender;

 
 */
@end
