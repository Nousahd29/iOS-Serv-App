//
//  JobDetailsViewController.m
//  ServApp_provider
//
//  Created by TRun ShRma on 12/02/15.
//  Copyright (c) 2015 Tarun. All rights reserved.
//

#import "JobDetailsViewController.h"
#import "MFSideMenuContainerViewController.h"
#import "MFSideMenu.h"
#import "AppManager.h"


#define IS_IPHONE4 (([[UIScreen mainScreen] bounds].size.height-480)?NO:YES)
#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)
#define IS_IPHONE_6 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)667) < DBL_EPSILON)
#define IS_IPHONE_6_PLUS (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)736) < DBL_EPSILON)

@interface JobDetailsViewController ()

@end

@implementation JobDetailsViewController
@synthesize str_categoryID;

- (void)viewDidLoad
{
    [self.menuContainerViewController setPanMode:MFSideMenuPanModeDefault];

    [super viewDidLoad];
    
    [AppManager sharedManager].navCon = self.navigationController;

    
    [ChangeStatusView setHidden:YES];
    //[[NSUserDefaults standardUserDefaults]setValue:self.lbl_status forKey:@"lblStatus"];

    self.lbl_status.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"lblStatus"];
    
    [self.image_completed setImage:[UIImage imageNamed:@"radio-icon.png"]];
    [self.image_underProcess setImage:[UIImage imageNamed:@"radio-icon.png"]];
    [self.image_pending setImage:[UIImage imageNamed:@"radio-icon.png"]];
    
    [self webServiceJobDetails];
    
    self.lbl_status.text=@"Pending";
    str_jobStatus =@"3";
    
    


    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tapped_on_back:(id)sender
{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"lblStatus"];
    [self.navigationController popViewControllerAnimated:YES];

}

-(void)webServiceJobDetails
{
    //Add parameters to send server
    //ttp://dev414.trigma.us/serv/Webservices/newJobDetail?id=25
    //NSString *UserId = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"UserId"]];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:
                                       @{
                                         @"id" :self.str_categoryID
                                         
                                         }];
    
    [[AppManager sharedManager] showHUD:@"Loading..."];
    [[AppManager sharedManager] getDataForUrl:@"http://dev414.trigma.us/serv/Webservices/newJobDetail?"
                                   parameters:parameters
                                      success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"JSON: %@", responseObject);//description
         
         
         self.lbl_coterogy.text=[responseObject objectForKey:@"category_name"];
         self.lbl_requestTime.text=[responseObject objectForKey:@"request_time"];
         self.lbl_requestDate.text=[responseObject objectForKey:@"request_date"];
         self.lbl_location.text=[responseObject objectForKey:@"user_address"];
          self.lbl_contactNo.text=[responseObject objectForKey:@"user_contact"];
         self.txtView_description.text=[responseObject objectForKey:@"description"];

       
       //  [self.lbl_coterogy setText:[responseObject objectForKey:@"username"]];
         
         [[AppManager sharedManager] hideHUD];
         
         
     }
                                      failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
         [[AppManager sharedManager] showHUD:@"Loading..."];
         alert(@"Error", @"");
     }];
}



- (IBAction)Option_One:(id)sender
{
    UIImage *image = [UIImage imageNamed:@"radio-btn.png"];
    UIImage *image1 = [UIImage imageNamed:@"radio-active-btn.png"];
    [_option_btnOne setImage:image1 forState:UIControlStateNormal];
    [_option_btntwo setImage:image forState:UIControlStateNormal];
    [_option_btnthree setImage:image forState:UIControlStateNormal];
}

- (IBAction)Option_two:(id)sender
{
    UIImage *image = [UIImage imageNamed:@"radio-btn.png"];
    UIImage *image1 = [UIImage imageNamed:@"radio-active-btn.png"];
    [_option_btnOne setImage:image forState:UIControlStateNormal];
    [_option_btntwo setImage:image1 forState:UIControlStateNormal];
    [_option_btnthree setImage:image forState:UIControlStateNormal];
}

- (IBAction)Option_three:(id)sender
{
    UIImage *image = [UIImage imageNamed:@"radio-btn.png"];
    UIImage *image1 = [UIImage imageNamed:@"radio-active-btn.png"];
    [_option_btnOne setImage:image forState:UIControlStateNormal];
    [_option_btntwo setImage:image forState:UIControlStateNormal];
    [_option_btnthree setImage:image1 forState:UIControlStateNormal];
}

- (IBAction)ChangeStatus_button:(UIButton*)sender
{
    [ChangeStatusView setHidden:NO];
    
    if (sender.tag==1)
    {
        if (![sender isSelected])
        {
            [sender setSelected:YES];
            self.lbl_status.text=@"Job Completed";
            str_jobStatus =@"2";
            [[NSUserDefaults standardUserDefaults]setObject:self.lbl_status.text forKey:@"lblStatus"];
            
            [self.image_completed setImage:[UIImage imageNamed:@"radio-active-btn.png"]];
            [self.image_underProcess setImage:[UIImage imageNamed:@"radio-icon.png"]];
            [self.image_pending setImage:[UIImage imageNamed:@"radio-icon.png"]];

            UIButton *therapistCheckBtn =   (UIButton*)[self.view viewWithTag:2];
            [therapistCheckBtn setSelected:NO];
            UIButton *therapistCheckBtn1 =   (UIButton*)[self.view viewWithTag:3];
            [therapistCheckBtn1 setSelected:NO];
        }else
        {
            [self.image_underProcess setImage:[UIImage imageNamed:@"radio-icon.png"]];
            [self.image_pending setImage:[UIImage imageNamed:@"radio-icon.png"]];
        }

        
    }
    else if (sender.tag==2)
    {
        if (![sender isSelected])
        {
            [sender setSelected:YES];
            self.lbl_status.text=@"Working";
            str_jobStatus =@"1";

            [[NSUserDefaults standardUserDefaults]setObject:self.lbl_status.text forKey:@"lblStatus"];


            [self.image_completed setImage:[UIImage imageNamed:@"radio-icon.png"]];
            [self.image_underProcess setImage:[UIImage imageNamed:@"radio-active-btn.png"]];
            [self.image_pending setImage:[UIImage imageNamed:@"radio-icon.png"]];
            
            UIButton *therapistCheckBtn =   (UIButton*)[self.view viewWithTag:1];
            [therapistCheckBtn setSelected:NO];
            UIButton *therapistCheckBtn1 =   (UIButton*)[self.view viewWithTag:3];
            [therapistCheckBtn1 setSelected:NO];
        }else
        {
            [self.image_completed setImage:[UIImage imageNamed:@"radio-icon.png"]];
            [self.image_pending setImage:[UIImage imageNamed:@"radio-icon.png"]];
        }

        
    }
    else if (sender.tag==3)
    {
        if (![sender isSelected])
        {
            [sender setSelected:YES];
            self.lbl_status.text=@"Pending";
            str_jobStatus =@"3";

            [[NSUserDefaults standardUserDefaults]setObject:self.lbl_status.text forKey:@"lblStatus"];


            [self.image_completed setImage:[UIImage imageNamed:@"radio-icon.png"]];
            [self.image_underProcess setImage:[UIImage imageNamed:@"radio-icon.png"]];
            [self.image_pending setImage:[UIImage imageNamed:@"radio-active-btn.png"]];
            
            UIButton *therapistCheckBtn =   (UIButton*)[self.view viewWithTag:1];
            [therapistCheckBtn setSelected:NO];
            UIButton *therapistCheckBtn1 =   (UIButton*)[self.view viewWithTag:2];
            [therapistCheckBtn1 setSelected:NO];
        }else
        {
            [self.image_completed setImage:[UIImage imageNamed:@"radio-icon.png"]];
            [self.image_underProcess setImage:[UIImage imageNamed:@"radio-icon.png"]];
        }

    }
    
//    if (IS_IPHONE5)
//    {
//        [UIView animateWithDuration:0.5
//                              delay:0.0
//                            options: UIViewAnimationCurveEaseInOut
//                         animations:^{
//                             ChangeStatusView.frame = CGRectMake(0, 0, 320, 568);
//                             [ChangeStatusView addSubview:CloseViewButton];
//                         }
//                         completion:^(BOOL finished){
//                         }];
//    }
//    else if (IS_IPHONE_6)
//    {
//        [UIView animateWithDuration:0.5
//                              delay:0.0
//                            options: UIViewAnimationCurveEaseInOut
//                         animations:^{
//                             ChangeStatusView.frame = CGRectMake(0, 0, 380, 667);
//                             [ChangeStatusView addSubview:CloseViewButton];
//                         }
//                         completion:^(BOOL finished){
//                         }];
//    }
}

- (IBAction)Hide_StatusButton:(id)sender
{
    
    [ChangeStatusView setHidden:YES];
    
    [self webServiceJobStatusChange];
//    [UIView animateWithDuration:0.5
//                          delay:0.0
//                        options: UIViewAnimationCurveEaseInOut
//                     animations:^{
//                         ChangeStatusView.frame = CGRectMake(0, 800, 320, 568);;
//                     }
//                     completion:^(BOOL finished){
//                         NSLog(@"Done!");
//                     }];
}

-(void)webServiceJobStatusChange
{
    //Add parameters to send server
    //   http://dev414.trigma.us/serv/Webservices/customerHelp?id=3
    //ttp://dev414.trigma.us/serv/Webservices/jobStatus?id=25&status=2
    
    NSMutableDictionary *parameters;
    
        parameters = [NSMutableDictionary dictionaryWithDictionary:
                      
                      @{
                        
                        @"id" :self.str_categoryID,
                        @"status" :str_jobStatus
                        
                        }];
    
    
    [[AppManager sharedManager] showHUD:@"Loading..."];
    
    
    [[AppManager sharedManager] getDataForUrl:@"http://dev414.trigma.us/serv/Webservices/jobStatus?"
     
                                   parameters:parameters
     
                                      success:^(AFHTTPRequestOperation *operation, id responseObject)
     
     {
         
         // Get response from server
         
         NSLog(@"JSON: %@", responseObject);//description
         
        // [self.lbl_status setText:[responseObject objectForKey:@"description"]];
         
         [[AppManager sharedManager] hideHUD];
     }
     
                                      failure:^(AFHTTPRequestOperation *operation, NSError *error)
     
     {
         
         NSLog(@"Error: %@", error);
         
         [[AppManager sharedManager] hideHUD];
         
         alert(@"Error", @"");
         
     }];
    
}


@end
