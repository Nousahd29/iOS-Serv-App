//
//  NotificationDetailVC.m
//  SERVApp
//
//  Created by Surender Kumar on 23/01/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import "NotificationDetailVC.h"
#import "MFSideMenuContainerViewController.h"
#import "MFSideMenu.h"
#import "AppManager.h"

@interface NotificationDetailVC ()

@end

@implementation NotificationDetailVC

@synthesize str_id;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"str id%@",str_id);
      [self.menuContainerViewController setPanMode:MFSideMenuPanModeNone];
    [self webServiceNotificationListDetails];
    // Do any additional setup after loading the view.
}

-(IBAction)backBtnAction:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)webServiceNotificationListDetails
{
    //Add parameters to send server
    
    //ttp://dev414.trigma.us/serv/Webservices/customerNotificationDetails?id=5
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:
                                       
                                       @{
                                         
                                         @"id" :str_id
                                         
                                         
                                         }];
    
    [[AppManager sharedManager] showHUD:@"Loading..."];
    
    [[AppManager sharedManager] getDataForUrl:@"http://dev414.trigma.us/serv/Webservices/customerNotificationDetails?"
     
                                   parameters:parameters
     
                                      success:^(AFHTTPRequestOperation *operation, id responseObject)
     
     {
         
         // Get response from server
         NSLog(@"JSON: %@", responseObject);//description
         
         
         NSURL *newImageURL=[NSURL URLWithString:[responseObject objectForKey:@"image"]];
         NSData *imageData=[NSData dataWithContentsOfURL:newImageURL];
         self.image_profileImage.image=[UIImage imageWithData:imageData];
         
         self.image_profileImage.layer.cornerRadius = 51;
         
         self.image_profileImage.layer.borderColor=[UIColor clearColor].CGColor;
         
         self.image_profileImage.clipsToBounds=YES;
         
         self.image_profileImage.layer.borderWidth=2;
         
         //encryptedString = [imageData base64EncodedStringWithOptions:0];
         
         self.lbl_categoryName.text=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"service_name"]];
         self.lbl_requestTime.text=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"created"]];

         self.lbl_acceptedBy.text=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"emp_name"]];

         self.lbl_acceptedTime.text=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"created"]];

         self.lbl_contactNo.text=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"contact"]];
         
         if ([[responseObject objectForKey:@"status"]isEqualToString:@"1"])
         {
             self.lbl_acceptedAndDecliendBy.text=@"Accepted By";
             self.lbl_acceptedAndDecliendTime.text=@"Accepted Time";


         }
         else{
             self.lbl_acceptedAndDecliendBy.text=@"Declined By";
             self.lbl_acceptedAndDecliendTime.text=@"Declined Time";
         }


         

         [self.image_appLogo setHidden:YES];
         
         [[AppManager sharedManager] hideHUD];
         
     }
     
                                      failure:^(AFHTTPRequestOperation *operation, NSError *error)
     
     {
         
         NSLog(@"Error: %@", error);
         
         [[AppManager sharedManager] hideHUD];
         
         alert(@"Error", @"");
         
     }];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
