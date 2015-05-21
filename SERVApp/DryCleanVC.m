//
//  DryCleanVC.m
//  SERVApp
//
//  Created by Surender Kumar on 24/01/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import "DryCleanVC.h"
#import "AppManager.h"
#import "HeaderFile.h"
#import "LocationTrackVC.h"

@interface DryCleanVC ()

@end

@implementation DryCleanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.txtView_dryCleaning.text=@"Dry cleanning";
    self.txtView_dryCleaning.textColor = [UIColor lightGrayColor];
    // Do any additional setup after loading the view.
}

- (IBAction)TappedOnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)TappedOnAcionBtns:(UIButton*)sender
{
    if (sender.tag==1)
    {//address
        
        array_address=[[NSMutableArray alloc]initWithObjects:[[NSUserDefaults standardUserDefaults] objectForKey:@"address"] ,nil];
        
        if(dropDown == nil)
        {
            CGFloat f = 120;
            dropDown = [[NIDropDown alloc]showDropDown:self.txtField_address :&f :array_address :Nil :@"down"];
            dropDown.delegate = self;
            
        }
        else
        {
            [dropDown hideDropDown:self.txtField_address];
            [self rel];
        }
        
    }
    else if (sender.tag==2)
    { //Submit Action
        
        str_textView=self.txtView_dryCleaning.text;
        str_textView=[str_textView stringByReplacingOccurrencesOfString:@" " withString:@""];
        if(![self.txtField_address.text isEqualToString:@""]&& ![self.self.txtView_dryCleaning.text isEqualToString:@"Dry cleanning"]&& ![str_textView isEqualToString:@""])
        {
            
            [self webServiceForDryCleaning];
           
        }
        else
        {
            alert(@"Alert!", @"Please fill all mandatory fields.");
            
            self.txtView_dryCleaning.text = @"Dry cleanning";
            self.txtView_dryCleaning.textColor = [UIColor lightGrayColor];
            self.txtView_dryCleaning.tag = 0;
            [self.txtView_dryCleaning resignFirstResponder];
            
            return;
            
        }
        
//        if (self.txtField_address.text.length<=0)
//        {
//            alert(@"Alert!", @"select address.");
//            return;
//            
//        }
//        else if (self.txtView_dryCleaning.text.length<=0)
//        {
//            alert(@"Alert!", @"select item Names.");
//            return;
//            
//        }
        

        
    }
}
- (void) niDropDownDelegateMethod: (NIDropDown *) sender
{
    
    
    [self rel];
}

-(void)rel
{
    dropDown = nil;
}
-(void)webServiceForDryCleaning
{
    //Add parameters to send server
    
    //ttp://dev414.trigma.us/serv/Webs/customerPostDryCleaning?address=chandigarh&dry_cleaning=dryclean.&category_id=12&user_id=268
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:
                                       
                                       @{
                                         
                                         @"address" :self.txtField_address.text,
                                         @"dry_cleaning" :self.txtView_dryCleaning.text,
                                         @"category_id" :@"12",
                                         @"user_id" :[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]
                                         
                                         
                                         
                                         }];
    
    [[AppManager sharedManager] showHUD:@"Loading..."];
    
    [[AppManager sharedManager] getDataForUrl:@"http://dev414.trigma.us/serv/Webs/customerPostDryCleaning?"
     
                                   parameters:parameters
     
                                      success:^(AFHTTPRequestOperation *operation, id responseObject)
     
     {
         
         // Get response from server
         
         NSLog(@"JSON: %@", responseObject);//description
         
         str_customerServId=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"customer_servid"]];
         
         if([[responseObject objectForKey:@"message"] isEqualToString:@"Successfully Saved !!!!"])
         {
             
           //  alert(@"Alert", [responseObject objectForKey:@"message"]);
             
                         [[AppManager sharedManager] hideHUD];
             
             [self webServiceServiceAvailability];

           //  return;
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
    
    [[AppManager sharedManager] showHUD:@"Please wait,we are searching for a Dry cleaner."];
    
    [[AppManager sharedManager] getDataForUrl:@"http://dev414.trigma.us/serv/webs/customerRightNowService?"
     
                                   parameters:parameters
     
                                      success:^(AFHTTPRequestOperation *operation, id responseObject)
     
     {
         
         // Get response from server
         
         NSLog(@"JSON: %@", responseObject);//description//Please wait, we are searching for a maid
         
         if ([[responseObject objectForKey:@"message"]isEqualToString:@"No Service Provider is available right now."])
         {
             alert(@"Alert!", [responseObject objectForKey:@"message"]);
             
             
             self.txtField_address.text=@"";
             self.txtView_dryCleaning.text=@"Dry cleanning";
             self.txtView_dryCleaning.textColor = [UIColor lightGrayColor];

             
             [[AppManager sharedManager] hideHUD];
             
             return ;
             
         }
         else
         {
             self.txtField_address.text=@"";
             self.txtView_dryCleaning.text=@"Dry cleanning";
             self.txtView_dryCleaning.textColor = [UIColor lightGrayColor];

             
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




- (BOOL)textFieldShouldReturn:(UITextView *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.txtView_dryCleaning resignFirstResponder];
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if(self.txtView_dryCleaning.tag == 0)
    {
        self.txtView_dryCleaning.text = @"";
        self.txtView_dryCleaning.textColor = [UIColor blackColor];
        self.txtView_dryCleaning.tag = 1;
    }
    return YES;
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    
    NSLog(@"textViewDoneEditing");
    if([self.txtView_dryCleaning.text length] == 0)
    {
        self.txtView_dryCleaning.text = @"Dry cleanning";
        self.txtView_dryCleaning.textColor = [UIColor lightGrayColor];
        self.txtView_dryCleaning.tag = 0;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
