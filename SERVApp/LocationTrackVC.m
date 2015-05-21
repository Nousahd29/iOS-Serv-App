//
//  LocationTrackVC.m
//  SERVApp
//
//  Created by Surender Kumar on 23/01/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import "LocationTrackVC.h"
#import "MFSideMenuContainerViewController.h"
#import "MFSideMenu.h"
#import "HeaderFile.h"
#import "AppDelegate.h"

BOOL isStartDateSelected, isLocationGot;
BOOL isGPSEnable;


@interface LocationTrackVC ()

@end

@implementation LocationTrackVC
@synthesize mapView,arry_sProviderData;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    isLocationGot = FALSE;
    
  //  [[NSUserDefaults standardUserDefaults] setObject:contactNo forKey:@"customerContactNo"];

    
   //[lbl_destinationLocation setHidden:YES];
   // [self.imageDestination setHidden:YES];
    //[lbl_setDestinationLocation setHidden:YES];
    
   // [[NSUserDefaults standardUserDefaults]setObject:responseObject forKey:@"sProviderData"];

    NSLog(@"sProviderData %@",[[NSUserDefaults standardUserDefaults]objectForKey:@"sProviderData"]);
    
    latitude1=[NSString stringWithFormat:@"%@",[[[NSUserDefaults standardUserDefaults] objectForKey:@"sProviderData"] valueForKey:@"lat"]];
    longitude1=[NSString stringWithFormat:@"%@",[[[NSUserDefaults standardUserDefaults] objectForKey:@"sProviderData"] valueForKey:@"long"]];
    
   // self.image_serviceProvider.image =[[[NSUserDefaults standardUserDefaults]objectForKey:@"sProviderData"] valueForKey:@"image"];
    
    NSString *strUrl=[NSString stringWithFormat:@"%@",[[[NSUserDefaults standardUserDefaults] objectForKey:@"sProviderData"] valueForKey:@"image"]];
    NSURL *newImageURL=[NSURL URLWithString:strUrl];
    NSData *imageData=[NSData dataWithContentsOfURL:newImageURL];
    self.image_serviceProvider.image=[UIImage imageWithData:imageData];
    
    self.image_serviceProvider.layer.cornerRadius = 24;
    
    self.image_serviceProvider.layer.borderColor=[UIColor clearColor].CGColor;
    
    self.image_serviceProvider.clipsToBounds=YES;
    
    self.image_serviceProvider.layer.borderWidth=2;
    
   // encryptedString = [imageData base64EncodedStringWithOptions:0];
    

    self.lbl_nameServiceProvider.text =[[[NSUserDefaults standardUserDefaults]objectForKey:@"sProviderData"] valueForKey:@"username"];
    
   // latitude=[[[NSUserDefaults standardUserDefaults] objectForKey:@"sProviderData"] valueForKey:@"lat"];
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    self.appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [self.appDelegate updateCurrentLocation];
    
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"sProviderData"] == 0) {
        
        [self.ViewCallMessage setHidden:NO];
       // [[NSUserDefaults standardUserDefaults]setObject:location1 forKey:@"locaionDriver"];
       
        
       // latitude1=[]

        
    }
    else
        [self.ViewCallMessage setHidden:YES];
    
    // getting current location
//    locationManager = [[CLLocationManager alloc] init];
//    [locationManager requestWhenInUseAuthorization];
//    
//    locationManager.delegate = self;
//   // mapView.showsUserLocation = YES;
//    
//    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//    locationManager.distanceFilter = kCLDistanceFilterNone;
//    [locationManager startUpdatingLocation];
    
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
        
          //  self.lbl_driverLocation.text = [NSString stringWithFormat:@"%@",[[searchLocationArray valueForKey:@"addressName"] objectAtIndex:0]];
        
        
        latString = [NSString stringWithFormat:@"%f",[[[searchLocationArray valueForKey:@"latitude"] objectAtIndex:0] floatValue]];
        longString = [NSString stringWithFormat:@"%f",[[[searchLocationArray valueForKey:@"longitude"] objectAtIndex:0] floatValue]];
        
      //  latitude = [latString floatValue];
       // longitude = [longString floatValue];
        
        longitude1 =latString;
        longitude1= longString;
        
        [self setMapToCenter];
    }
    
    [mapView setNeedsDisplay];
    
    
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
    
    
    [self setMapToCenter];
    
    [self getAddressFromLatLong :[latitude1 floatValue] :[longitude1 floatValue]];
    
    
//    CLLocationCoordinate2D currentCoordinate;
//    currentCoordinate.latitude = currentLat floalt;
//    currentCoordinate.longitude = currentLong;
//    
//    CLLocationCoordinate2D annotationCoordinate;
//    annotationCoordinate.latitude = latitude1;
//    annotationCoordinate.longitude = longitude1;
    
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:self.appDelegate.currentUserLocation.coordinate.latitude longitude:self.appDelegate.currentUserLocation.coordinate.longitude];
    CLLocation *loc2;
    
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"sProviderData"] == 0)
    {
      //  [[NSUserDefaults standardUserDefaults]setObject:lon forKey:@"long1"];
       // [[NSUserDefaults standardUserDefaults]setObject:lat forKey:@"lat1"];
        loc2 = [[CLLocation alloc] initWithLatitude:[[[NSUserDefaults standardUserDefaults] valueForKey:@"lat1"] integerValue] longitude:[[[NSUserDefaults standardUserDefaults] valueForKey:@"lat1"] integerValue] ];

        CLLocationDistance distInMeters = [loc distanceFromLocation:loc2];
        NSString *distance=[NSString stringWithFormat:@"%.2f",distInMeters/1000*3];
        //  NSString *timeTacken=[NSString stringWithFormat:@"%.2f ",distance*3];// distance*3;
        
        self.lbl_driverLocation.text = [NSString stringWithFormat:@"%@ time will take.",distance];
    }
    else
    {
        loc2 = [[CLLocation alloc] initWithLatitude:[latitude1 floatValue] longitude:[longitude1 floatValue] ];

    }

}

- (void)viewWillDisappear:(BOOL)animated
{
   // [rememberTimer invalidate];
  //  rememberTimer = nil;
}
-(IBAction)backBtnAction:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];

}



/*
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

*/


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
            
            
                self.lbl_driverLocation.text = [NSString stringWithFormat:@"%@",addressString];
                    }
    }
}

//- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
//{
//    NSLog(@"willAnimated");
//}

//- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
//{
//    NSLog(@"regionDidChangeAnimated");
//   // [self performSelectorInBackground:@selector(GetAddressFromLatiLong) withObject:nil];
//}

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

//- (IBAction)AddStartTime:(id)sender
//{
//    isStartDateSelected = TRUE;
//    fadedView.hidden = NO;
//    [UIView animateWithDuration:0.50
//                     animations:^{
//                         datePickerView.frame = CGRectMake(0, 200, 320, 192);
//                     }];
//}
//
//- (IBAction)AddEndTime:(id)sender
//{
//    isStartDateSelected = FALSE;
//    fadedView.hidden = NO;
//    [UIView animateWithDuration:0.50
//                     animations:^{
//                         datePickerView.frame = CGRectMake(0, 200, 320, 192);
//                     }];
//}

//- (IBAction)GetCurrentLocation:(id)sender
//{
//    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(mapView.userLocation.coordinate, 1000, 1000);
//    
//    MKCoordinateSpan span;
//    span.latitudeDelta = 0.02;
//    span.longitudeDelta = 0.02;
//    
//    coordinate2d = mapView.userLocation.location.coordinate;
//    region.span = span;
//    region.center = coordinate2d;
//    
//    [mapView setRegion:[mapView regionThatFits:region] animated:YES];
//    
//    latitude = mapView.userLocation.coordinate.latitude;
//    longitude = mapView.userLocation.coordinate.latitude;
//    
//    [self getAddressFromLatLong :latitude :longitude];
//    
//}

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
        [self getAddressFromLatLong :[latitude1 floatValue] :[longitude1 floatValue]];
    }
}

- (void)setMapToCenter
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(mapView.userLocation.coordinate, 1000, 1000);
    
    MKCoordinateSpan span;
    span.latitudeDelta = 0.02;
    span.longitudeDelta = 0.02;
    
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = [latitude1 floatValue];
    coordinate.longitude = [longitude1 floatValue];
    
    region.span = span;
    region.center = coordinate;
    
    [mapView setRegion:[mapView regionThatFits:region] animated:YES];
}



-(IBAction)CallMessageAndCancelBtn:(UIButton*)sender
{
    if (sender.tag ==1)
    {
        // Cancel job
        
    }
    else if (sender.tag == 2)
    {
        //Message
        
        MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
        if([MFMessageComposeViewController canSendText])
        {
            controller.body = @"Hello from Serv App";
            controller.recipients = [NSArray arrayWithObjects:@"+919876543210",nil];
            controller.messageComposeDelegate = self;
            [self presentModalViewController:controller animated:YES];
        }
        
        
    }
    else if (sender.tag == 3)
    {
        // Call
        
        //        NSString *phoneNumber = @"281-661-8180"; // dynamically assigned
        //        NSString *phoneURLString = [NSString stringWithFormat:@"tel:%@", phoneNumber];
        //        NSURL *phoneURL = [NSURL URLWithString:phoneURLString];
        //        [[UIApplication sharedApplication] openURL:phoneURL];
        
        NSString *phNo = @"+919876543210";
        NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];
        
        if ([[UIApplication sharedApplication] canOpenURL:phoneUrl])
        {
            [[UIApplication sharedApplication] openURL:phoneUrl];
        }
        else
        {
            UIAlertView * calert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Call facility is not available!!!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [calert show];
        }
        
        
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    switch (result) {
        case MessageComposeResultCancelled:
            NSLog(@"Cancelled");
            break;
        case MessageComposeResultFailed:
            //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"MyApp" message:@"Unknown Error"
            //                                                           delegate:self cancelButtonTitle:@”OK” otherButtonTitles: nil];
            //            [alert show];
            // [alert release];
            break;
        case MessageComposeResultSent:
            
            break;
        default:
            break;
    }
    
    [self dismissModalViewControllerAnimated:YES];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end