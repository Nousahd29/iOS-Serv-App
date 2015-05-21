//
//  ShoppingVC.m
//  SERVApp
//
//  Created by Surender Kumar on 24/01/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import "ShoppingVC.h"
#import "AppManager.h"
#import "HeaderFile.h"
#import "LocationTrackVC.h"

@interface ShoppingVC ()

@end

@implementation ShoppingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [AppManager sharedManager].navCon = self.navigationController;

    
    self.txtView_itemTypes.text=@"Type here what you want to buy/return";
    self.txtView_itemTypes.textColor = [UIColor lightGrayColor];
    // Do any additional setup after loading the view.
}

- (IBAction)TappedOnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)TappedOnActionsBtns:(UIButton*)sender
{
    
    if (sender.tag==1)
    { // service type
        [self.txtView_itemTypes resignFirstResponder];

        
        array_selectService=[[NSMutableArray alloc]initWithObjects:@"Purchase",@"Return",nil];
        
        
        if(dropDown == nil)
        {
            CGFloat f = 120;
            dropDown = [[NIDropDown alloc]showDropDown:self.txtField_purchasesAndReturn :&f :array_selectService :Nil :@"down"];
            dropDown.delegate = self;
            
        }
        else
        {
            [dropDown hideDropDown:self.txtField_purchasesAndReturn];
            [self rel];
        }

        
    }
    else if(sender.tag==2)
    {// select location
        
        array_location=[[NSMutableArray alloc]initWithObjects:@"location1",@"location2",nil];
        
        
        if(dropDown == nil)
        {
            CGFloat f = 120;
            dropDown = [[NIDropDown alloc]showDropDown:self.txtField_location :&f :array_location :Nil :@"down"];
            dropDown.delegate = self;
            
        }
        else
        {
            [dropDown hideDropDown:self.txtField_location];
            [self rel];
        }

        
        
    }
    else if(sender.tag==3)
    {// select address
        
        [self.txtView_itemTypes resignFirstResponder];

        
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
    else if(sender.tag==4)
    { //Submit Action
        

        
        str_textView=self.txtView_itemTypes.text;
        str_textView=[str_textView stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        if (![self.txtField_address.text isEqualToString:@""] && ![self.txtField_purchasesAndReturn.text isEqualToString:@""] && ![self.txtView_itemTypes.text isEqualToString:@"Type here what you want to buy/return"]&&![str_textView isEqualToString:@""])
        {
            [self webServiceForShopping];
        }
        else
        {
            alert(@"Alert!", @"Please fill all mandatory fields.");
            self.txtView_itemTypes.text = @"ype here what you want to buy/return";
            self.txtView_itemTypes.textColor = [UIColor lightGrayColor];
            self.txtView_itemTypes.tag = 0;
            [self.txtView_itemTypes resignFirstResponder];
            return;
            
            
        }

    }

}
-(void)webServiceForShopping
{
    //Add parameters to send server
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:
                                       
                                       @{
                                         
                                         @"shopping" :self.txtField_purchasesAndReturn.text,
                                         @"items_description" :self.txtView_itemTypes.text,
                                         @"location" :@"",

                                         @"address" :self.txtField_address.text,
                                         @"category_id" :@"10",
                                         @"user_id" :[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]
                                         
                                         
                                         
                                         }];
    
    [[AppManager sharedManager] showHUD:@"Loading..."];
    
    // [appdelRef showProgress:@"Please wait.."];
    
    
    [[AppManager sharedManager] getDataForUrl:@"http://dev414.trigma.us/serv/Webs/customerPostShopping?"
     
                                   parameters:parameters
     
                                      success:^(AFHTTPRequestOperation *operation, id responseObject)
     
     {
         
         // Get response from server
         
         NSLog(@"JSON: %@", responseObject);//description
         
         str_customerServId=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"customer_servid"]];
         
         if([[responseObject objectForKey:@"message"] isEqualToString:@"Successfully Saved !!!!"])
         {
             
           //  alert(@"Success", @"Successfully Placed Your orders.");
             
             
             [[AppManager sharedManager] hideHUD];
             
             [self webServiceServiceAvailability];

            // return;
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
    
    [[AppManager sharedManager] showHUD:@"Please wait,we are searching for a Shopping."];
    
    [[AppManager sharedManager] getDataForUrl:@"http://dev414.trigma.us/serv/webs/customerRightNowService?"
     
                                   parameters:parameters
     
                                      success:^(AFHTTPRequestOperation *operation, id responseObject)
     
     {
         
         // Get response from server
         
         NSLog(@"JSON: %@", responseObject);//description//Please wait, we are searching for a maid
         
         if ([[responseObject objectForKey:@"message"]isEqualToString:@"No Service Provider is available right now."])
         {
             alert(@"Alert!", [responseObject objectForKey:@"message"]);
             
             
             self.txtView_itemTypes.text=@"";
             self.txtField_address.text=@"";
             
             self.txtField_purchasesAndReturn.text=@"";

             
             [[AppManager sharedManager] hideHUD];
             
             return ;
             
         }
         else
         {
             
             self.txtView_itemTypes.text=@"";
             self.txtField_address.text=@"";
             
             self.txtField_purchasesAndReturn.text=@"";

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

- (void) niDropDownDelegateMethod: (NIDropDown *) sender
{
    
    
    [self rel];
}

-(void)rel
{
    dropDown = nil;
}

#pragma Text Fields Delegates

- (BOOL)textFieldShouldReturn:(UITextView *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.txtView_itemTypes resignFirstResponder];
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if(self.txtView_itemTypes.tag == 0)
    {
        self.txtView_itemTypes.text = @"";
        self.txtView_itemTypes.textColor = [UIColor blackColor];
        self.txtView_itemTypes.tag = 1;
    }
    return YES;
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    
    NSLog(@"textViewDoneEditing");
    if([self.txtView_itemTypes.text length] == 0)
    {
        self.txtView_itemTypes.text = @"Type here what you want to buy/return";
        self.txtView_itemTypes.textColor = [UIColor lightGrayColor];
        self.txtView_itemTypes.tag = 0;
    }
}




@end
