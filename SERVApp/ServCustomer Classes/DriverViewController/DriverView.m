//
//  DriverView.m
//  SERVApp
//
//  Created by Noushad on 03/04/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import "DriverView.h"
#import "AppManager.h"
#import "LocationTrackVC.h"


BOOL isStartDateSelected, isLocationGot;
BOOL isGPSEnable;

@interface DriverView ()



@end

@implementation DriverView

//@synthesize datePicker;
@synthesize mapView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    isLocationGot = FALSE;
    
    [lbl_destinationLocation setHidden:YES];
    [self.imageDestination setHidden:YES];
    //[lbl_setDestinationLocation setHidden:YES];
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    // getting current location
    locationManager = [[CLLocationManager alloc] init];
    [locationManager requestWhenInUseAuthorization];
    
    locationManager.delegate = self;
    mapView.showsUserLocation = YES;
    
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
    
    
    }



- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

//- (BOOL)prefersStatusBarHidden
//{
//    return YES;
//}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
    
    //    _btnRememberLocation.frame = CGRectMake(self.view.frame.size.width - _btnRememberLocation.frame.size.width - 8, self.view.frame.size.height - 70 - 10, self.view.frame.size.width - 16, 70);
    
    //    _btnRememberLocation.frame = CGRectMake(8, self.view.frame.size.height - 70 - 8, self.view.frame.size.width - 16, 70);
}

-(IBAction)btnSetLocationAction:(UIButton*)sender
{
    if (sender.tag == 1)
    {
        if ([sender isSelected])
        {
            [sender setSelected:NO];
            
            [lbl_pikUpLocation setHidden:YES];
            [self.imagePickup setHidden:YES];

            [lbl_destinationLocation setHidden:NO];
            [self.imageDestination setHidden:NO];

            //isDestination=YES;
        }
        else
        {
            [sender setSelected:YES];
            isDestination=YES;

            

        }
        
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"LocationDetailArray"])
    {
        NSString *latString,*longString;
        latString = [[NSString alloc] init];
        longString = [[NSString alloc] init];
        
        searchLocationArray = [[NSMutableArray alloc] init];
        searchLocationArray = [[NSUserDefaults standardUserDefaults] valueForKey:@"LocationDetailArray"];
        [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"LocationDetailArray"];
        
        // update location name on label and move map to this location
        if (isDestination) {
            lbl_setDestinationLocation.text = [NSString stringWithFormat:@"%@",[[searchLocationArray valueForKey:@"addressName"] objectAtIndex:0]];

        }
        else
        {
        _labelMapLocation.text = [NSString stringWithFormat:@"%@",[[searchLocationArray valueForKey:@"addressName"] objectAtIndex:0]];
        }
        
        latString = [NSString stringWithFormat:@"%f",[[[searchLocationArray valueForKey:@"latitude"] objectAtIndex:0] floatValue]];
        longString = [NSString stringWithFormat:@"%f",[[[searchLocationArray valueForKey:@"longitude"] objectAtIndex:0] floatValue]];
        
        latitude = [latString floatValue];
        longitude = [longString floatValue];
        
        [self setMapToCenter];
    }
    
    [mapView setNeedsDisplay];
    
    
    //    notificationAlert = [[UIAlertView alloc]
    //                         initWithTitle:@"Alert!" message:@"You are near to Remembered location." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //    [notificationAlert show];
    //
    //    [self performSelector:@selector(dismissAlertView) withObject:nil afterDelay:5.0f];
    
    
    isGPSEnable = [CLLocationManager locationServicesEnabled];
    
    if (isGPSEnable == 1)
    {
//        rememberTimer = [NSTimer scheduledTimerWithTimeInterval:5.0
//                                                         target:self
//                                                       selector:@selector(startTimer:)
//                                                       userInfo:nil
//                                                        repeats:YES];
    }
    else
    {
        UIAlertView *GPSAlert = [[UIAlertView alloc]
                                 initWithTitle:@"Alert!" message:@"You GPS is not enabled." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [GPSAlert show];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [rememberTimer invalidate];
    rememberTimer = nil;
}

-(IBAction)submitBtnAtion:(UIButton*)sender
{
    // Submit Btn Acion
    if (sender.tag==1)
    {
        [self webServiceBookDriver];
    }
    else
    //Back btn Acion
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

-(void)webServiceBookDriver
{
    //Add parameters to send server
    
    //ttp://dev414.trigma.us/serv/Webs/customerPostCarDriver?pick_up=chandigarh&destination=mohali&category_id=5&user_id=741
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:
                                       
                                       @{
                                         
                                         @"user_id" :[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"] ,
                                         @"category_id" :@"5",
                                         @"pick_up" :lbl_pikUpLocation.text,
                                         @"destination" :lbl_destinationLocation.text
                                         
                                         }];
    
    [[AppManager sharedManager] showHUD:@"Loading..."];
    
    [[AppManager sharedManager] getDataForUrl:@"http://dev414.trigma.us/serv/Webs/customerPostCarDriver?"
     
                                   parameters:parameters
     
                                      success:^(AFHTTPRequestOperation *operation, id responseObject)
     
     {
         
         // Get response from server
         NSLog(@"JSON: %@", responseObject);//description
         
         str_customerServId=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"customer_servid"]];

         
         if ([[responseObject valueForKey:@"message"]isEqualToString:@"No Service Provider is available right now."])
         {
             alert(@"Success", [responseObject objectForKey:@"message"]);
             
             [[AppManager sharedManager] hideHUD];
             
             [lbl_pikUpLocation setHidden:NO];
             [self.imagePickup setHidden:NO];
             [lbl_destinationLocation setHidden:YES];
             [self.imageDestination setHidden:YES];

             return ;
             
            
         }
         else{
         
         [lbl_pikUpLocation setHidden:NO];
         [self.imagePickup setHidden:NO];
         [lbl_destinationLocation setHidden:YES];
         [self.imageDestination setHidden:YES];
         
         [[AppManager sharedManager] hideHUD];
             
             [self webServiceServiceAvailability];
         }
         
     }
     
                                      failure:^(AFHTTPRequestOperation *operation, NSError *error)
     
     {
         
         NSLog(@"Error: %@", error);
         
         [[AppManager sharedManager] hideHUD];
         
         alert(@"Error", @"");
         
     }];
    
}

-(void)webServiceServiceAvailability
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:
                                       
                                       @{
                                         
                                         @"service_id" :str_customerServId
                                         
                                         
                                         }];
    
    [[AppManager sharedManager] showHUD:@"Please wait,we are searching for a Driver."];
    
    [[AppManager sharedManager] getDataForUrl:@"http://dev414.trigma.us/serv/webs/customerRightNowService?"
     
                                   parameters:parameters
     
                                      success:^(AFHTTPRequestOperation *operation, id responseObject)
     
     {
         
         // Get response from server
         
         NSLog(@"JSON: %@", responseObject);//description//Please wait, we are searching for a maid
         
         if ([[responseObject objectForKey:@"message"]isEqualToString:@"No Service Provider is available right now."])
         {
             alert(@"Alert!", [responseObject objectForKey:@"message"]);
             
             
             
             [[AppManager sharedManager] hideHUD];
             
             return ;
             
         }
         else
         {
             LocationTrackVC *locationTrackView=[self.storyboard instantiateViewControllerWithIdentifier:@"LocationTrackVC"];
             [self.navigationController pushViewController:locationTrackView animated:YES];
             
            
             
             
             
             
             [[AppManager sharedManager] hideHUD];
             
         }
         
     }
     
                                      failure:^(AFHTTPRequestOperation *operation, NSError *error)
     
     {
         
         NSLog(@"Error: %@", error);
         
         [[AppManager sharedManager] hideHUD];
         
         
         alert(@"Error", @"");
         
     }];
    
}




//- (void)startTimer:(id)sender
//{
//    [self performSelectorInBackground:@selector(CallWSToCheckRememberLocation) withObject:nil];
//}

//- (void)dismissAlertView
//{
//    [notificationAlert dismissWithClickedButtonIndex:0 animated:YES];
//}

- (void)getAddressFromLatLong :(float)lati :(float)longi
{
    NSURL *urli = [NSURL URLWithString:[NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%f,%f&sensor=true_or_false",lati,longi]];
    NSString *str = [NSString stringWithFormat:@""];
    
    NSData *postData = [str dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:urli];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSError *error = nil;
    NSURLResponse *response = nil;
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if(data)
    {
        json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    }
    
    NSLog(@"%@",response);
    
    if (json != nil)
    {
        NSArray *jsonResultArray = [json valueForKey:@"results"];
        NSString *addressString = [[NSString alloc] init];
        
        if ([jsonResultArray count] != 0)
        {
            addressString = [[jsonResultArray valueForKey:@"formatted_address"] objectAtIndex:0];
            
            if (isDestination) {
                 lbl_setDestinationLocation.text = [NSString stringWithFormat:@"%@",addressString];
            }
            else
            {
            _labelMapLocation.text = [NSString stringWithFormat:@"%@",addressString];
            }
        }
    }
}

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    NSLog(@"willAnimated");
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    NSLog(@"regionDidChangeAnimated");
    [self performSelectorInBackground:@selector(GetAddressFromLatiLong) withObject:nil];
}

- (void)GetAddressFromLatiLong
{
    //    MKCoordinateRegion mapRegion;
    //    mapRegion.center = mapView.centerCoordinate;
    //
    //    mapRegion.span.latitudeDelta = 0.3;
    //    mapRegion.span.longitudeDelta = 0.3;
    
    //    CLLocationCoordinate2D coordinate = mapView.centerCoordinate;
    //    coordinate.latitude = latitude;
    //    coordinate.longitude = longitude;
    
    latitude = mapView.centerCoordinate.latitude;
    longitude = mapView.centerCoordinate.longitude;
    
    NSLog(@"%f,---%f---",latitude,longitude);
    
    
    // get the lat & lng of the map region
    //    latitude = mapRegion.center.latitude;
    //    longitude = mapRegion.center.longitude;
    
    [self getAddressFromLatLong :latitude :longitude];
}

- (IBAction)AddStartTime:(id)sender
{
    isStartDateSelected = TRUE;
    fadedView.hidden = NO;
    [UIView animateWithDuration:0.50
                     animations:^{
                         datePickerView.frame = CGRectMake(0, 200, 320, 192);
                     }];
}

- (IBAction)AddEndTime:(id)sender
{
    isStartDateSelected = FALSE;
    fadedView.hidden = NO;
    [UIView animateWithDuration:0.50
                     animations:^{
                         datePickerView.frame = CGRectMake(0, 200, 320, 192);
                     }];
}

- (IBAction)GetCurrentLocation:(id)sender
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(mapView.userLocation.coordinate, 1000, 1000);
    
    MKCoordinateSpan span;
    span.latitudeDelta = 0.02;
    span.longitudeDelta = 0.02;
    
    coordinate2d = mapView.userLocation.location.coordinate;
    region.span = span;
    region.center = coordinate2d;
    
    [mapView setRegion:[mapView regionThatFits:region] animated:YES];
    
    latitude = mapView.userLocation.coordinate.latitude;
    longitude = mapView.userLocation.coordinate.latitude;
    
    [self getAddressFromLatLong :latitude :longitude];
    
    }

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Unable to get your location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    latitude = newLocation.coordinate.latitude;
    longitude = newLocation.coordinate.longitude;
    
    NSLog(@"Latitude :  %f", newLocation.coordinate.latitude);
    NSLog(@"Longitude :  %f", newLocation.coordinate.longitude);
    
    if (isLocationGot == FALSE)
    {
        isLocationGot = TRUE;
        [self setMapToCenter];
        [self getAddressFromLatLong :latitude :longitude];
    }
}

- (void)setMapToCenter
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(mapView.userLocation.coordinate, 1000, 1000);
    
    MKCoordinateSpan span;
    span.latitudeDelta = 0.02;
    span.longitudeDelta = 0.02;
    
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = latitude;
    coordinate.longitude = longitude;
    
    region.span = span;
    region.center = coordinate;
    
    [mapView setRegion:[mapView regionThatFits:region] animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end