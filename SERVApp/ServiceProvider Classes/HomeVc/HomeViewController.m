
//
//  HomeViewController.m
//  ServApp_provider
//
//  Created by TRun ShRma on 12/02/15.
//  Copyright (c) 2015 Tarun. All rights reserved.
//

#import "HomeViewController.h"
#import "MFSideMenu.h"
#import "SideMenuViewController.h"
#import "AppManager.h"
#import "JobDetailsViewController.h"
#import "LocationTrackVC.h"

@interface HomeViewController ()

{
    NSMutableArray *array;
}

@end
@implementation HomeViewController
@synthesize SwitchButton_AvailableForJobs;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [AppManager sharedManager].navCon = self.navigationController;

    
    [self.menuContainerViewController setPanMode:MFSideMenuPanModeDefault];
    // Do any additional setup after loading the view.
      array=[[NSMutableArray alloc]init];
    
    array=[[NSUserDefaults standardUserDefaults] objectForKey:@"notificationData"];
    NSLog(@"notificaion Data %@",array);
    
    [self.image_noService setHidden:YES];
    [_NewJob_view setHidden:YES];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(webServiceStatusActive) name:@"notificationAlert" object:nil];

    // Notification fire...
    
    locationManager = [CLLocationManager new];
    locationManager.delegate = self;
  //  self.mapView.showsUserLocation=YES;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 &&
        [CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse
        //[CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedAlways
        ) {
        // Will open an confirm dialog to get user's approval
        [locationManager requestWhenInUseAuthorization];
        //[_locationManager requestAlwaysAuthorization];
    } else {
        [locationManager startUpdatingLocation]; //Will update location immediately
    }



}
#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager*)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined: {
            NSLog(@"User still thinking..");
        } break;
        case kCLAuthorizationStatusDenied: {
            NSLog(@"User hates you");
        } break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        case kCLAuthorizationStatusAuthorizedAlways: {
            [locationManager startUpdatingLocation]; //Will update location immediately
        } break;
        default:
            break;
    }
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    CLLocation *location1 = [locations lastObject];
    NSLog(@"lat%f - lon%f", location1.coordinate.latitude, location1.coordinate.longitude);
    
  // lat=location1.coordinate.latitude;
    
  // lon=location1.coordinate.longitude;
    lon = [NSString stringWithFormat:@"%.8f", location1.coordinate.longitude];
    lat = [NSString stringWithFormat:@"%.8f", location1.coordinate.latitude];
    [[NSUserDefaults standardUserDefaults]setObject:lon forKey:@"long1"];
    [[NSUserDefaults standardUserDefaults]setObject:lat forKey:@"lat1"];

    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"JobOn"])
    {
        [self webServiceStatusActive];
        [self.image_noService setHidden:NO];
        [_NewJob_view setHidden:YES];
        [SwitchButton_AvailableForJobs setOn:YES];
        
    }
    else
    {
        [_NewJob_view setHidden:YES];
        [self.image_noService setHidden:YES];

        [SwitchButton_AvailableForJobs setOn:NO];
    }
    
    [self.imageViewRightNow setImage:[UIImage imageNamed:@"rightnow-active.png"]];
    [self.imageViewFuturJob setImage:[UIImage imageNamed:@"futurejob-inactive.png"]];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)TappedOnDrawer:(id)sender
{
    [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
}

- (IBAction)TappedOnAcceptButton:(id)sender
{
    
    [self webServiceAcceptJob];
    isAccepted =YES;
    
}
- (IBAction)TappedOnDeclineButton:(id)sender
{
    [self webServiceDeclineJob];
    isAccepted =NO;
}
- (IBAction)TappedOnDetailButton:(id)sender
{
    [self webServiceJobDetail];
    
}

- (IBAction)TappedOnRightNowAndFutureBtn:(UIButton*)sender
{
           //Right Now
        if (sender.tag==1)
        {
            if (![sender isSelected])
            {
                [sender setSelected:YES];
             //   self.lbl_status.text=@"Job Completed";
             //   str_jobStatus =@"2";
             //   [[NSUserDefaults standardUserDefaults]setObject:self.lbl_status.text forKey:@"lblStatus"];
                [self.imageViewRightNow setImage:[UIImage imageNamed:@"rightnow-active.png"]];
                [self.imageViewFuturJob setImage:[UIImage imageNamed:@"futurejob-inactive.png"]];
                
                
              //  UIButton *therapistCheckBtn =   (UIButton*)[self.view viewWithTag:2];
             //   [therapistCheckBtn setSelected:NO];
                [self.ButtonFuturJob setSelected:YES];
                [self.buttonRightNow setSelected:NO];
                [self webServiceStatusActive];
                
               // UIButton *therapistCheckBtn1 =   (UIButton*)[self.view viewWithTag:3];
               // [therapistCheckBtn1 setSelected:NO];
            }else
            {
                [self.imageViewFuturJob setImage:[UIImage imageNamed:@"futurejob-inactive.png"]];
                [self.imageViewRightNow setImage:[UIImage imageNamed:@"rightnow-active.png"]];
                [sender setSelected:NO];
                [self webServiceStatusActive];



               // [self.image_pending setImage:[UIImage imageNamed:@"radio-icon.png"]];
            }
            
            
        }
        else if (sender.tag==2)
        {
            if (![sender isSelected])
            {
                [sender setSelected:YES];
              //  self.lbl_status.text=@"Working";
             //   str_jobStatus =@"1";
                
            //    [[NSUserDefaults standardUserDefaults]setObject:self.lbl_status.text forKey:@"lblStatus"];
                
                [self.imageViewRightNow setImage:[UIImage imageNamed:@"rightnow-inactive.png"]];
                [self.imageViewFuturJob setImage:[UIImage imageNamed:@"futurejob-active.png"]];
              //  [self.imageViewRightNow setImage:[UIImage imageNamed:@"radio-icon.png"]];
               // [self.imageViewFuturJob setImage:[UIImage imageNamed:@"radio-active-btn.png"]];
            //    [self.image_pending setImage:[UIImage imageNamed:@"radio-icon.png"]];
                
               // UIButton *therapistCheckBtn =   (UIButton*)[self.view viewWithTag:1];
              //  [therapistCheckBtn setSelected:NO];
                [self.buttonRightNow setSelected:YES];
                [self.ButtonFuturJob setSelected:NO];
                
                [self webServiceStatusActive];
             //   UIButton *therapistCheckBtn1 =   (UIButton*)[self.view viewWithTag:3];
             //   [therapistCheckBtn1 setSelected:NO];
            }else
            {
                [self.imageViewFuturJob setImage:[UIImage imageNamed:@"rightnow-inactive.png"]];
                [self.imageViewFuturJob setImage:[UIImage imageNamed:@"futurejob-active.png"]];
                [sender setSelected:NO];
                [self webServiceStatusActive];


                //[self.image_pending setImage:[UIImage imageNamed:@"radio-icon.png"]];
            }
            
        //[self webServiceStatusActive];

    

        }
}


- (IBAction)switchPressedAction:(id)sender
{
    if(SwitchButton_AvailableForJobs.on)
    {
        //[_NewJob_view setHidden:NO];
        [self webServiceStatusActive];
        [[NSUserDefaults standardUserDefaults] setBool:TRUE forKey:@"JobOn"];
        
        
        
       // [self.buttonRightNow setSelected:YES];
       // [self.ButtonFuturJob setSelected:NO];


       // [[NSUserDefaults standardUserDefaults] setObject:array_notificationData forKey:@"notificationData"];

        
       //  array=[[NSUserDefaults standardUserDefaults] objectForKey:@"notificationData"];
       //  [self.lbl_categoryName setText:[NSString stringWithFormat:@"%@",[array valueForKey:@"categoryname"]]];
       //  [self.lbl_dateTime setText:[NSString stringWithFormat:@"%@",[array valueForKey:@"created"]]];

        
    }
    else
    {
        [_NewJob_view setHidden:YES];
        [self webServiceStatusInActive];
        [[NSUserDefaults standardUserDefaults] setBool:FALSE forKey:@"JobOn"];
    }
}





-(void)webServiceAcceptJob
{
  //ttp://dev414.trigma.us/serv/Webservices/acceptNotifiction?id=25&emp_id=1&status=1&notification_id=2&lat=35.0725&long=75.2345
    
    NSString *UserId = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]];
 //   NSString *str_categoryId=[NSString stringWithFormat:@"%@",[array valueForKey:@"id"]];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:
                                       @{
                                         @"id" :[[array objectAtIndex:0]valueForKey:@"service_id"],
                                         @"emp_id" :UserId,
                                         @"notification_id" :[[array objectAtIndex:0]valueForKey:@"notification_id"],
                                         @"status" :@"1",
                                         @"lat":lat,
                                         @"long":lon
                                         }];
    // [[AppManager sharedManager] showHUD];
    [[AppManager sharedManager] getDataForUrl:@"http://dev414.trigma.us/serv/Webservices/acceptNotifiction?"
                                   parameters:parameters
                                      success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
          NSLog(@"Accepted JSON: %@", responseObject);//description++
         
         
         
         [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"lblStatus"];
         
         [self webServiceStatusActive ];
         
        
        // [self.buttonRightNow setSelected:YES];

         
        // [[AppManager sharedManager] showHUD];


         
     }
                                      failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
         [[AppManager sharedManager] hideHUD];
         alert(@"Error", @"");
     }];
    
    
}


-(void)webServiceDeclineJob
{
//  http://dev414.trigma.us/serv/Webservices/acceptNotifiction?id=25&emp_id=1&status=1
    NSString *UserId = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]];
  //  NSString *str_categoryId=[NSString stringWithFormat:@"%@",[array valueForKey:@"id"]];

    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:
                                       @{
                                         @"id" :[[array objectAtIndex:0]valueForKey:@"service_id"],
                                          @"emp_id" :UserId,
                                         @"notification_id" :[[array objectAtIndex:0]valueForKey:@"notification_id"],
                                          @"status" :@"2"
                                         }];
     //[[AppManager sharedManager] showHUD];
    [[AppManager sharedManager] getDataForUrl:@"http://dev414.trigma.us/serv/Webservices/acceptNotifiction?"
                                   parameters:parameters
                                      success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"JSON: %@", responseObject);//description
         
         [self webServiceStatusActive ];
         
         //[self.buttonRightNow setSelected:YES];

         
        // [[AppManager sharedManager] hideHUD];

     }
        failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
         [[AppManager sharedManager] hideHUD];
         alert(@"Error", @"");
     }];
}


-(void)webServiceJobDetail
{
    //http://dev414.trigma.us/serv/Webservices/newJobDetail?id=25
//    NSString *UserId = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"UserId"]];
//    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:
//                                       @{
//                                         @"id" :UserId,
//                                         }];
//    // [[AppManager sharedManager] showHUD];
//    [[AppManager sharedManager] getDataForUrl:@"http://dev414.trigma.us/serv/Webservices/newJobDetail?"
//                                   parameters:parameters
//                                      success:^(AFHTTPRequestOperation *operation, id responseObject)
//     {
//         NSLog(@"JSON: %@", responseObject);//description
//         
//     }
//        failure:^(AFHTTPRequestOperation *operation, NSError *error)
//     {
//         NSLog(@"Error: %@", error);
//         //[appdelRef hideProgress];
//         alert(@"Error", @"");
//     }];
    
    
    JobDetailsViewController *jobDetailView=[self.storyboard instantiateViewControllerWithIdentifier:@"JobDetailsViewController"];
    jobDetailView.str_categoryID=[NSString stringWithFormat:@"%@",[[array objectAtIndex:0]valueForKey:@"service_id"]];
    
    [self.navigationController pushViewController:jobDetailView animated:YES];
}


-(void)webServiceStatusActive
{
    //http://dev414.trigma.us/serv/Webservices/EmployerStatus?user_id=640&notification_status=1
    NSString *UserId = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]];
   // NSLog(@"userid %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"] );
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:
                                       @{
                                         @"user_id" :UserId,
                                         @"notification_status" :@"1",
                                         }];
    [[AppManager sharedManager] showHUD:@"Loading..."];
    [[AppManager sharedManager] getDataForUrl:@"http://dev414.trigma.us/serv/Webservices/EmployerStatus?"
                                   parameters:parameters
                                      success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
        NSLog(@"JSON: %@", responseObject);//description
         
//         array=[responseObject objectForKey:@"NotificationList1"];
//         NSLog(@"Array : %@",array);
        
         
         if (![self.buttonRightNow isSelected])
         {
            // [self.buttonRightNow setSelected:YES];
            // array=[responseObject objectForKey:@"NotificationList1"];
            // [self.buttonRightNow setSelected:YES];
             
             [self.ButtonFuturJob setSelected:NO];


             array=[responseObject objectForKey:@"NotificationList1"];
             NSLog(@"Array : %@",array);
              NSString *str=[NSString stringWithFormat:@"%@",[[array objectAtIndex:0] valueForKey:@"need"]];
           //  NSString *str=[NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"NotificationList1"] valueForKey:@"need"]];

             
             if ([str isEqualToString:@"1"])
             {
                 
                 
                 [self.lbl_categoryName setText:[NSString stringWithFormat:@"%@",[[array objectAtIndex:0] valueForKey:@"title"]]];
                 [self.lbl_dateTime setText:[NSString stringWithFormat:@"%@",[[array objectAtIndex:0] valueForKey:@"days"]]];
                 
                 NSString *contactNo=[NSString stringWithFormat:@"%@",[[array objectAtIndex:0] valueForKey:@"customer_contact"]];
                 [[NSUserDefaults standardUserDefaults] setObject:contactNo forKey:@"customerContactNo"];
                 
                 [self.image_noService setHidden:YES];
                 [_NewJob_view setHidden:NO];
                 
                 
                 [[AppManager sharedManager] hideHUD];

             }
             else
             {
             
               //  alert(@"Alert!", @"No service available");
                 
                 if (isAccepted)
                 {
                     LocationTrackVC *locationTrackView=[self.storyboard instantiateViewControllerWithIdentifier:@"LocationTrackVC"];
                     // [locationTrackView.arry_sProviderData addObject:responseObject
                     //  NSLog(@"location%@",locationTrackView.arry_sProviderData);
                     [self.navigationController pushViewController:locationTrackView animated:YES];
                     [[AppManager sharedManager] hideHUD];
                     isAccepted =NO;

                 }
                 else
                 {
                     alert(@"Alert!", @"No service available");
                     [self.image_noService setHidden:NO];
                     [_NewJob_view setHidden:NO];
                     [[AppManager sharedManager] hideHUD];

                     
                     return ;
                     
                     //[_NewJob_view setHidden:YES];
                     
                     
                     
                     
                   //  return ;

                 }
                 
                 
             }
 
         }
         else if (![self.ButtonFuturJob isSelected])
         {
             array=[responseObject objectForKey:@"NotificationList"];
             NSLog(@"Array : %@",array);

             [self.buttonRightNow setSelected:NO];
             
              NSString *str=[NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"NotificationList"] valueForKey:@"msg"]];
             if ([str isEqualToString:@"Service Not available"])
             {
                 
                 alert(@"Alert!", @"No service available");
                 [self.image_noService setHidden:NO];
                 [_NewJob_view setHidden:NO];
                 [[AppManager sharedManager] hideHUD];
                 
                 
                 return ;

             }
             else
             {
                 for (int i=0; i<[array count]; i++) {
                     
                 
                 
                 NSString *str=[NSString stringWithFormat:@"%@",[[array objectAtIndex:i] valueForKey:@"need"]];
                 
                 if ([str isEqualToString:@"0"])
                 {
                     [self.lbl_categoryName setText:[NSString stringWithFormat:@"%@",[[array objectAtIndex:0] valueForKey:@"title"]]];
                     [self.lbl_dateTime setText:[NSString stringWithFormat:@"%@",[[array objectAtIndex:0] valueForKey:@"days"]]];
                     
                     [self.image_noService setHidden:YES];
                     [self.buttonRightNow setSelected:YES];

                     [_NewJob_view setHidden:NO];
                     
                     
                     [[AppManager sharedManager] hideHUD];
                     
                 }
                 else if ([str isEqualToString:@"2"])
                 {
                     [self.lbl_categoryName setText:[NSString stringWithFormat:@"%@",[[array objectAtIndex:i] valueForKey:@"title"]]];
                     [self.lbl_dateTime setText:[NSString stringWithFormat:@"%@",[[array objectAtIndex:i] valueForKey:@"days"]]];
                     
                     [self.image_noService setHidden:YES];
                     [self.buttonRightNow setSelected:YES];

                     [_NewJob_view setHidden:NO];
                     
                     
                     [[AppManager sharedManager] hideHUD];
                     
                 }
                 
                 else if ([str isEqualToString:@"3"])
                 {
                     [self.lbl_categoryName setText:[NSString stringWithFormat:@"%@",[[array objectAtIndex:i] valueForKey:@"title"]]];
                     [self.lbl_dateTime setText:[NSString stringWithFormat:@"%@",[[array objectAtIndex:i] valueForKey:@"days"]]];
                     
                     [self.image_noService setHidden:YES];
                     [self.buttonRightNow setSelected:YES];

                     [_NewJob_view setHidden:NO];
                     
                     
                     [[AppManager sharedManager] hideHUD];
                     
                 }


                 else
                 {
                     if (isAccepted)
                     {
                         LocationTrackVC *locationTrackView=[self.storyboard instantiateViewControllerWithIdentifier:@"LocationTrackVC"];
                         // [locationTrackView.arry_sProviderData addObject:responseObject
                         //  NSLog(@"location%@",locationTrackView.arry_sProviderData);
                         [self.navigationController pushViewController:locationTrackView animated:YES];
                         [[AppManager sharedManager] hideHUD];
                         isAccepted =NO;
                         
                     }
                     else
                     {
                         alert(@"Alert!", @"No service available");
                         [self.image_noService setHidden:NO];
                         [_NewJob_view setHidden:NO];
                         [[AppManager sharedManager] hideHUD];
                         
                         
                         return ;
                         
                         //[_NewJob_view setHidden:YES];
                         
                         
                         
                         
                         //  return ;
                         
                     }
                     
                 }
                 
              }
             }
             

             /*
             
             if ([str isEqualToString:@"Today"])
             {
                 
                 
                 [self.lbl_categoryName setText:[NSString stringWithFormat:@"%@",[[array objectAtIndex:0] valueForKey:@"title"]]];
                 [self.lbl_dateTime setText:[NSString stringWithFormat:@"%@",[[array objectAtIndex:0] valueForKey:@"days"]]];
                 
                 [self.image_noService setHidden:YES];
                 [_NewJob_view setHidden:NO];
                 
                 
                 [[AppManager sharedManager] hideHUD];
                 
             }
             else if ([str isEqualToString:@"Another Date"])
             {
                 [self.lbl_categoryName setText:[NSString stringWithFormat:@"%@",[[array objectAtIndex:0] valueForKey:@"title"]]];
                 [self.lbl_dateTime setText:[NSString stringWithFormat:@"%@",[[array objectAtIndex:0] valueForKey:@"days"]]];
                 
                 [self.image_noService setHidden:YES];
                 [_NewJob_view setHidden:NO];
                 
                 
                 [[AppManager sharedManager] hideHUD];
             }
             else
             {
                 
                 alert(@"Alert!", @"No service available");
                 
               //  [self.image_noService setHidden:NO];
                 
                // [_NewJob_view setHidden:YES];
                 
                 [self.image_noService setHidden:NO];
                 [_NewJob_view setHidden:NO];
                 //                 LocationTrackVC *locationTrackView=[self.storyboard instantiateViewControllerWithIdentifier:@"LocationTrackVC"];
                 //                 // [locationTrackView.arry_sProviderData addObject:responseObject
                 //                 //  NSLog(@"location%@",locationTrackView.arry_sProviderData);
                 //                 [self.navigationController pushViewController:locationTrackView animated:YES];
                 
                 
                 [[AppManager sharedManager] hideHUD];
                 
                 return ;
                 
                 
             }

             */
         }
         else
         {
             alert(@"Alert!", @"No service available");
             
             //  [self.image_noService setHidden:NO];
             
             // [_NewJob_view setHidden:YES];
             
             [self.image_noService setHidden:NO];
             [_NewJob_view setHidden:NO];
             //                 LocationTrackVC *locationTrackView=[self.storyboard instantiateViewControllerWithIdentifier:@"LocationTrackVC"];
             //                 // [locationTrackView.arry_sProviderData addObject:responseObject
             //                 //  NSLog(@"location%@",locationTrackView.arry_sProviderData);
             //                 [self.navigationController pushViewController:locationTrackView animated:YES];
             
             
             [[AppManager sharedManager] hideHUD];
             
             return ;

         }
         
         /*
        //// if (![self.buttonRightNow isSelected])
        // {
             if ([[responseObject valueForKey:@"need"]isEqualToString:@"Right Now"])
             
             {
//                 if ([str isEqualToString:@"Service Not available"])
//                 {
//                     
//                     alert(@"Alert!", @"No service available");
//                     
//                     [self.image_noService setHidden:NO];
//                     
//                     [_NewJob_view setHidden:YES];
                 
                     //                 LocationTrackVC *locationTrackView=[self.storyboard instantiateViewControllerWithIdentifier:@"LocationTrackVC"];
                     //                 // [locationTrackView.arry_sProviderData addObject:responseObject];
                     //                 //  NSLog(@"location%@",locationTrackView.arry_sProviderData);
                     //                 [self.navigationController pushViewController:locationTrackView animated:YES];
                     
//                     
//                     [[AppManager sharedManager] hideHUD];
//                     
//                     return ;
//                 }
//                 else
//                     
//                 {
                     [self.lbl_categoryName setText:[NSString stringWithFormat:@"%@",[[array objectAtIndex:0] valueForKey:@"title"]]];
                     [self.lbl_dateTime setText:[NSString stringWithFormat:@"%@",[[array objectAtIndex:0] valueForKey:@"days"]]];
                     
                     [self.image_noService setHidden:YES];
                     [_NewJob_view setHidden:NO];
                     
                     
                     [[AppManager sharedManager] hideHUD];
                     
                // }

             }
             
        // }
       //  else if (self.ButtonFuturJob.tag ==2)
             else if([[responseObject valueForKey:@"need"]isEqualToString:@"Another Date"] || [[responseObject valueForKey:@"need"]isEqualToString:@"Today"])
         {
//             if ([str isEqualToString:@"Service Not available"])
//             {
//                 
//                 alert(@"Alert!", @"No service available");
//                 
//                 [self.image_noService setHidden:NO];
//                 
//                 [_NewJob_view setHidden:YES];
//                 
//                 [[AppManager sharedManager] hideHUD];
//                 
//                 return ;
//             }
            // else
                 
           //  {
                 [self.lbl_categoryName setText:[NSString stringWithFormat:@"%@",[[array objectAtIndex:0] valueForKey:@"title"]]];
                 [self.lbl_dateTime setText:[NSString stringWithFormat:@"%@",[[array objectAtIndex:0] valueForKey:@"days"]]];
                 
                 [self.image_noService setHidden:YES];
                 [_NewJob_view setHidden:NO];
                 
                 
                 [[AppManager sharedManager] hideHUD];
                 
            // }

         }
             else
             {
          */
//                 if ([str isEqualToString:@"Service Not available"])
//                 {
//                     
//                     alert(@"Alert!", @"No service available");
//                     
//                     [self.image_noService setHidden:NO];
//                     
//                     [_NewJob_view setHidden:YES];
//                     
//                     [[AppManager sharedManager] hideHUD];
//                     
//                     return ;
//                 }
//         else
//         {
//             [self.lbl_categoryName setText:[NSString stringWithFormat:@"%@",[[array objectAtIndex:0] valueForKey:@"title"]]];
//             [self.lbl_dateTime setText:[NSString stringWithFormat:@"%@",[[array objectAtIndex:0] valueForKey:@"days"]]];
//             
//             [self.image_noService setHidden:YES];
//             [_NewJob_view setHidden:NO];
//             
//             
//             [[AppManager sharedManager] hideHUD];
//         }
//
           //  }
         }
     
        failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
         [[AppManager sharedManager] hideHUD];
         alert(@"Error", @"");
     }];
}


-(void)webServiceStatusInActive
{
    //http://dev414.trigma.us/serv/Webservices/EmployerStatus?user_id=640&status=1
    
   // ttp://dev414.trigma.us/serv/Webservices/EmployerStatus?user_id=722&notification_status=1
    
    NSString *UserId = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"]];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:
                                       @{
                                         @"user_id" :UserId,
                                         @"notification_status" :@"0",
                                         }];
    [[AppManager sharedManager] showHUD:@"Loading..."];
    [[AppManager sharedManager] getDataForUrl:@"http://dev414.trigma.us/serv/Webservices/EmployerStatus?"
                                   parameters:parameters
                                      success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"JSON: %@", responseObject);//description
         
         [[AppManager sharedManager] hideHUD];
         
         [self.image_noService setHidden:YES];
         [_NewJob_view setHidden:YES];



     }
        failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
         [[AppManager sharedManager] hideHUD];
         alert(@"Error", @"");
     }];
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



@end
