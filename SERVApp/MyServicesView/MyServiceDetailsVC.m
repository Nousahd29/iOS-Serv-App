//
//  MyServiceDetailsVC.m
//  SERVApp
//
//  Created by Noushad Shah on 10/02/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import "MyServiceDetailsVC.h"
#import "AppManager.h"

@interface MyServiceDetailsVC ()

@end

@implementation MyServiceDetailsVC
@synthesize str_id;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"Service id %@",str_id);
    // Do any additional setup after loading the view.
    
    [self webServiceForServiceDetails];
}
-(IBAction)backBtnAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)webServiceForServiceDetails
{
    //Add parameters to send server
    
    
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:
                                       
                                       @{
                                         
                                         @"service_id" :str_id
                                         
                                         }];
    
    [[AppManager sharedManager] showHUD:@"Loading..."];
    
    [[AppManager sharedManager] getDataForUrl:@"http://dev414.trigma.us/serv/Webservices/customerServiceDetails?"
     
                                   parameters:parameters
     
                                      success:^(AFHTTPRequestOperation *operation, id responseObject)
     
     {
         
         // Get response from server
         
         NSLog(@"JSON: %@", responseObject);//description
         
         self.lbl_category.text=[responseObject objectForKey:@"service_name"];
         
         self.lbl_requestTime.text=[responseObject objectForKey:@"request_time"];

         self.lbl_requestDate.text=[responseObject objectForKey:@"request_date"];

         self.lbl_location.text=[responseObject objectForKey:@"location"];

         self.lbl_contactNo.text=[responseObject objectForKey:@"contact"];
         self.txtView_description.text=[responseObject objectForKey:@"description"];
         
         if ([[responseObject objectForKey:@"status"] isEqualToString:@"0"])
         {
             self.lbl_status.text=@"Declined";

         }
         else if([[responseObject objectForKey:@"status"]isEqualToString:@"1"])
         {
             self.lbl_status.text=@"Accepted";

         }
         else
         {
             self.lbl_status.text=@"Pending";

         }
         
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


@end
