//
//  LocationTrackVC.h
//  SERVApp
//
//  Created by Surender Kumar on 23/01/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import  <MapKit/MapKit.h>
#import "AppDelegate.h"
#import <MessageUI/MessageUI.h>


@interface LocationTrackVC : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate,MKAnnotation,UIAlertViewDelegate,MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate>

{
    CLLocationManager *locationManager;
    CLLocation *location;
    
    CLLocationCoordinate2D coordinate2d;
    NSString *locationNameString;
    float latitude,longitude;
    NSJSONSerialization *json;
    
    NSString *latitude1;
    NSString *longitude1;

    
    NSMutableArray *searchLocationArray;

    
}
@property (strong, nonatomic) AppDelegate *appDelegate;

@property(nonatomic,strong)IBOutlet UIImageView *image_serviceProvider;
@property(nonatomic,strong)IBOutlet UILabel *lbl_nameServiceProvider;
@property(nonatomic,strong)IBOutlet UILabel *lbl_driverLocation;

@property(nonatomic,strong) NSMutableArray *arry_sProviderData;


@property(nonatomic,strong)IBOutlet UIButton *callButton;
@property(nonatomic,strong)IBOutlet UIButton *msgButton;
@property(nonatomic,strong)IBOutlet UIButton *cancelButton;
@property(nonatomic,strong)IBOutlet UIView *ViewCallMessage;








@property(nonatomic,strong)IBOutlet MKMapView *mapView;
//@property(nonatomic,strong) CLLocationManager *locationManager;

- (IBAction)TappenOnBack:(id)sender;

@end
