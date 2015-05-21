//
//  HomeViewController.h
//  ServApp_provider
//
//  Created by TRun ShRma on 12/02/15.
//  Copyright (c) 2015 Tarun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MessageUI/MessageUI.h>


@interface HomeViewController : UIViewController<CLLocationManagerDelegate,MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate>
{
    CLLocationManager *locationManager;
    CLLocation *location;
    
    CLLocationCoordinate2D coordinate2d;
    NSString *locationNameString;
    float latitude,longitude;
    
    NSString * lat,*lon;
    BOOL isAccepted;

}

@property (strong, nonatomic) IBOutlet UIView *NewJob_view;
@property (weak, nonatomic) IBOutlet UISwitch *SwitchButton_AvailableForJobs;
@property (strong, nonatomic) IBOutlet UILabel *lbl_categoryName;
@property (strong, nonatomic) IBOutlet UILabel *lbl_dateTime;

@property (strong, nonatomic) IBOutlet UIImageView *image_noService;
@property (strong, nonatomic) IBOutlet UIButton *buttonRightNow;

@property (strong, nonatomic) IBOutlet UIButton *ButtonFuturJob;

@property (strong, nonatomic) IBOutlet UIImageView *imageViewRightNow;

@property (strong, nonatomic) IBOutlet UIImageView *imageViewFuturJob;







@end
