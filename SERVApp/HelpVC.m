//
//  HelpVC.m
//  SERVApp
//
//  Created by Surender Kumar on 23/01/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import "HelpVC.h"
#import "MFSideMenuContainerViewController.h"
#import "MFSideMenu.h"
#import "AppManager.h"
#import "HeaderFile.h"
#import "MBProgressHUD.h"


@interface HelpVC ()

@end

@implementation HelpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self webServiceHelp];
    // Do any additional setup after loading the view.
}

- (IBAction)TappedOnDrawer:(id)sender
{
    [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
    
}

-(void)webServiceHelp
{
    //Add parameters to send server
    //   http://dev414.trigma.us/serv/Webservices/customerHelp?id=3
    
    NSMutableDictionary *parameters;
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"usertype_id"]isEqualToString:@"6"])
    {
        parameters = [NSMutableDictionary dictionaryWithDictionary:
                                           
                                           @{
                                             
                                             @"id" :@"2"
                                             
                                             }];
    }
    else
    {
    parameters = [NSMutableDictionary dictionaryWithDictionary:
                                       
                                       @{
                                         
                                         @"id" :@"3"
                                        
                                         }];
    }
    
    
    [[AppManager sharedManager] showHUD:@"Loading..."];
    
    
    [[AppManager sharedManager] getDataForUrl:@"http://dev414.trigma.us/serv/Webservices/customerHelp?"
     
                                   parameters:parameters
     
                                      success:^(AFHTTPRequestOperation *operation, id responseObject)
     
     {
         
         // Get response from server
         
         NSLog(@"JSON: %@", responseObject);//description
       
         [self.txtView_help setText:[responseObject objectForKey:@"description"]];
         
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
