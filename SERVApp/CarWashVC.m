//
//  CarWashVC.m
//  SERVApp
//
//  Created by Surender Kumar on 24/01/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import "CarWashVC.h"
#import "AppManager.h"
#import "HeaderFile.h"
#import "LocationTrackVC.h"

@interface CarWashVC ()

@end

@implementation CarWashVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [AppManager sharedManager].navCon = self.navigationController;

     arr_Need=[[NSMutableArray alloc]initWithObjects:@"Right Now",@"Today",@"Another Date" ,nil];
    
    array_carWashService=[[NSMutableArray alloc]init];
    
    [view_dateAndTime setHidden:YES];
    [self.view_picker setHidden:YES];
    [view_description setHidden:YES];


    // Do any additional setup after loading the view.
}

- (IBAction)TappedOnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnSelectServices:(UIButton *)sender
{
    switch ([sender tag]) {
        case 101:
            
            if (![sender isSelected])
            {
                [sender setSelected:YES];
                
                [self.image_serviceOne setImage:[UIImage imageNamed:@"check-icon.png"]];
                
               // houseCln=YES;
             //   [array_carWashService addObject:@"1"];
                [array_carWashService addObject:@"Deluxe Detail"];

            }else
            {
                [self.image_serviceOne setImage:[UIImage imageNamed:@"checkbox.png"]];
                
                [sender setSelected:NO];
               // houseCln=NO;
               // [array_carWashService removeObject:@"1"];
                [array_carWashService removeObject:@"Deluxe Detail"];

                
            }
            
            
            break;
        case 102:
            
            if (![sender isSelected])
            {
                [sender setSelected:YES];
                
                [self.image_servicetwo setImage:[UIImage imageNamed:@"check-icon.png"]];
                
                // houseCln=YES;
               // [array_carWashService addObject:@"2"];
                [array_carWashService addObject:@"Full Detail"];

            }else
            {
                [self.image_servicetwo setImage:[UIImage imageNamed:@"checkbox.png"]];
                
                [sender setSelected:NO];
                // houseCln=NO;
               // [array_carWashService removeObject:@"2"];
                [array_carWashService removeObject:@"Full Detail"];

                
            }

            

            break;
            
        case 103:
            
            if (![sender isSelected])
            {
                [sender setSelected:YES];
                
                [self.image_serviceThree setImage:[UIImage imageNamed:@"check-icon.png"]];
                
                // houseCln=YES;
               // [array_carWashService addObject:@"3"];
                [array_carWashService addObject:@"Wash & Wax"];

            }else
            {
                [self.image_serviceThree setImage:[UIImage imageNamed:@"checkbox.png"]];
                
                [sender setSelected:NO];
                // houseCln=NO;
               // [array_carWashService removeObject:@"3"];
                [array_carWashService removeObject:@"Wash & Wax"];

                
            }

            

            break;
            
        case 104:
            
            if (![sender isSelected])
            {
                [sender setSelected:YES];
                
                [self.image_serviceFour setImage:[UIImage imageNamed:@"check-icon.png"]];
                
                // houseCln=YES;
               // [array_carWashService addObject:@"4"];
                [array_carWashService addObject:@"Exterior only wash & wax"];

            }else
            {
                [self.image_serviceFour setImage:[UIImage imageNamed:@"checkbox.png"]];
                
                [sender setSelected:NO];
                // houseCln=NO;
               // [array_carWashService removeObject:@"4"];
                [array_carWashService removeObject:@"Exterior only wash & wax"];

                
            }

            
            break;
            
        case 105:
            
            if (![sender isSelected])
            {
                [sender setSelected:YES];
                
                [self.image_serviceFive setImage:[UIImage imageNamed:@"check-icon.png"]];
                
                // houseCln=YES;
//                [array_carWashService addObject:@"5"];
                [array_carWashService addObject:@"Hand Wash only"];

            }else
            {
                [self.image_serviceFive setImage:[UIImage imageNamed:@"checkbox.png"]];
                
                [sender setSelected:NO];
                // houseCln=NO;
//                [array_carWashService removeObject:@"5"];
                [array_carWashService removeObject:@"Hand Wash only"];

                
            }
            
            
            break;

            
        default:
            break;
    }
    str_carWashSevices=[array_carWashService componentsJoinedByString:@","];
    NSLog(@"string %@",str_carWashSevices);
    
  //  [view_dateAndTime setHidden:YES];
    [view_description setHidden:YES];

    [self.view_picker setHidden:YES];
}


-(IBAction)TappedOnQuestionMarkBtn:(UIButton*)sender
{
    if (sender.tag == 1)
    {
        if (![sender isSelected])
        {
            [sender setSelected:YES];
            
            if (IS_IPHONE_5)
            {
                [view_description setFrame:CGRectMake(124, 173, 151, 33)];

            }
            else
            {
                [view_description setFrame:CGRectMake(150, 193, 151, 33)];

            }
            [view_description setHidden:NO];
        }
        else
        {
            [sender setSelected:NO];
            [view_description setHidden:YES];
        }
        
    }
    else if(sender.tag == 2)
    {
        
        if (![sender isSelected])
        {
            [sender setSelected:YES];
            
            if (IS_IPHONE_5)
            {
                [view_description setFrame:CGRectMake(124, 198, 151, 33)];
                
            }
            else
            {
                [view_description setFrame:CGRectMake(150, 230, 151, 33)];
                
            }
            [view_description setHidden:NO];
        }
        else
        {
            [sender setSelected:NO];
            [view_description setHidden:YES];
        }
        
        
        
    }
    else if(sender.tag == 3)
    {
        if (![sender isSelected])
        {
            [sender setSelected:YES];
            
            if (IS_IPHONE_5)
            {
                [view_description setFrame:CGRectMake(124, 219, 151, 33)];
                
            }
            else
            {
                [view_description setFrame:CGRectMake(150, 248, 151, 33)];
                
            }

            [view_description setHidden:NO];
        }
        else
        {
            [sender setSelected:NO];
            [view_description setHidden:YES];
        }
        
        
        
    }
    else if(sender.tag == 4)
    {
        if (![sender isSelected])
        {
            [sender setSelected:YES];
            
            
            if (IS_IPHONE_5)
            {
                [view_description setFrame:CGRectMake(161, 246, 158, 48)];
                
            }
            else
            {
                [view_description setFrame:CGRectMake(200, 285, 151, 33)];
                
            }

            [view_description setHidden:NO];
            
        }
        else
        {
            [sender setSelected:NO];
            [view_description setHidden:YES];
        }
        
    }
    else if(sender.tag == 5)
    {
        if (![sender isSelected])
        {
            [sender setSelected:YES];
            
            
            if (IS_IPHONE_5)
            {
                [view_description setFrame:CGRectMake(142, 270, 158, 48)];
                
            }
            else
            {
                [view_description setFrame:CGRectMake(171, 317, 151, 33)];
                
            }
            [view_description setHidden:NO];
            
        }
        else
        {
            [sender setSelected:NO];
            [view_description setHidden:YES];
        }
        
    }

}

 

- (IBAction)TappedOnaddress:(UIButton*)sender
{
    [view_description setHidden:YES];

    if (sender.tag== 2) {
        
        [view_dateAndTime setHidden:YES];
        [self.view_picker setHidden:YES];
        
        arr_address=[[NSMutableArray alloc]initWithObjects:[[NSUserDefaults standardUserDefaults] objectForKey:@"address"] ,nil];
        if(dropDown == nil)
        {
            CGFloat f = 120;
            dropDown = [[NIDropDown alloc]showDropDown:self.textField_address :&f :arr_address :Nil :@"down"];
            dropDown.delegate = self;
            
        }
        else
        {
            [dropDown hideDropDown:self.textField_address];
            [self rel];
        }

    }
    else if (sender.tag == 3)
    {
        if (![sender isSelected]) {
            [self.view_picker setHidden:NO];
            [sender setSelected:YES];
            
            [self.picker_dateAndTime addTarget:self action:@selector(datePickerChanged:) forControlEvents:UIControlEventValueChanged];
            
            if ([lbl_need.text isEqualToString:@"Today"])
            {
                self.picker_dateAndTime.datePickerMode=UIDatePickerModeTime;
                isTime=YES;
            }
            else
            {
                isTime=NO;
                
                self.picker_dateAndTime.datePickerMode=UIDatePickerModeDate;
                
            }
            [self.picker_dateAndTime setMinimumDate: [NSDate date]];

        }
        else
        {
            [sender setSelected:NO];
            [self.view_picker setHidden:YES];
            
        }

    }
    
}

- (void)datePickerChanged:(UIDatePicker *)datePicker
{
    
    if (isTime) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH:mm:ss"];
        NSString *strDate = [dateFormatter stringFromDate:datePicker.date];
        txtField_time.text = strDate;
//          txtField_dateAndTime.text=@"";
    }
    else
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM-dd-yyyy"];
        NSString *strDate = [dateFormatter stringFromDate:datePicker.date];
        txtField_dateAndTime.text = strDate;
//         txtField_time.text=@"";
    }

    
    
}


- (IBAction)TappedOnNeed:(id)sender {
    if(dropDown == nil)
    {
        [self.view_picker setHidden:YES];
        [view_dateAndTime setHidden:YES];

        CGFloat f = 120;
        dropDown = [[NIDropDown alloc]showDropDown:lbl_need :&f :arr_Need :Nil :@"down"];
        dropDown.delegate = self;
        
    }
    else
    {
        [dropDown hideDropDown:lbl_need];
        [self rel];
    }
}
- (void) niDropDownDelegateMethod: (NIDropDown *) sender
{
    
    if ([lbl_need.text isEqualToString:@"Today"]) {
        [view_dateAndTime setHidden:NO];
        str_serviceDate=@"2";
        txtField_dateAndTime.text=@"";
        
        [txtField_dateAndTime setHidden:YES];
        [image_date setHidden:YES];
        [txtField_time setHidden:NO];
        [image_time setHidden:NO];


    }
    else if ([lbl_need.text isEqualToString:@"Another Date"])
    {
        [view_dateAndTime setHidden:NO];
        str_serviceDate=@"3";
        txtField_time.text=@"";
        
        [txtField_time setHidden:YES];
        [image_time setHidden:YES];
        
        [txtField_dateAndTime setHidden:NO];
        [image_date setHidden:NO];


        
    }
    else
    {
        [view_dateAndTime setHidden:YES];
        str_serviceDate=@"1";

        
    }

    
    [self rel];
}

-(void)rel
{
    dropDown = nil;
}

-(IBAction)TappedOnSubmitBtn:(id)sender
{
    if(isStringEmpty(self.textField_address.text)&& (lbl_need.text)) {
        
        // [self.txt_oldPassword becomeFirstResponder];
        alert(@"Alert!", @"Please fill all mandatory fields.");
        return;
    }
    if (array_carWashService==nil || [array_carWashService count]==0)
    {
        alert(@"Alert!", @"select services.");
        return;
    }
    else
    {
        [self webServiceForCarWash];
        
    }

}

-(void)webServiceForCarWash
{
    //Add parameters to send server
    //request_time=&request_date=category_id
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:
                                       
                                       @{
                                         
                                         @"address" :self.textField_address.text,
                                         @"services" :str_carWashSevices,
                                         @"need" :str_serviceDate,
                                         @"request_time" :txtField_time.text,
                                         @"request_date" :txtField_dateAndTime.text,
                                         @"category_id" :@"4",
                                         @"user_id" :[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]
                                         
                                         
                                         
                                         }];
    
    [[AppManager sharedManager] showHUD:@"Loading..."];
    
    [[AppManager sharedManager] getDataForUrl:@"http://dev414.trigma.us/serv/Webs/customerPostCarWash?"
     
                                   parameters:parameters
     
                                      success:^(AFHTTPRequestOperation *operation, id responseObject)
     
     {
         
         // Get response from server
         
         NSLog(@"JSON: %@", responseObject);//description
         
         str_customerServId=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"customer_servid"]];
         if ([str_customerServId isEqualToString:@""])
         {
             alert(@"Alert!", @"Your Service Request is Successfully Send. !!!!");
             
             self.textField_address.text=@"";
             lbl_need.text=@"";
             txtField_dateAndTime.text=@"";
             [view_dateAndTime setHidden:YES];
             
             [self.image_serviceOne setImage:[UIImage imageNamed:@"checkbox.png"]];
             [self.image_servicetwo setImage:[UIImage imageNamed:@"checkbox.png"]];
             [self.image_serviceThree setImage:[UIImage imageNamed:@"checkbox.png"]];
             [self.image_serviceFour setImage:[UIImage imageNamed:@"checkbox.png"]];
             [self.image_serviceFive setImage:[UIImage imageNamed:@"checkbox.png"]];
             [array_carWashService removeAllObjects];
             
             [btn_service1 setSelected:NO];
             [btn_service2 setSelected:NO];

             [btn_service3 setSelected:NO];

             [btn_service4 setSelected:NO];

             [btn_service5 setSelected:NO];

             
             [[AppManager sharedManager] hideHUD];
             return ;
         }
         else
         {
             [self webServiceServiceAvailability];
             
         }

         
//         if([[responseObject objectForKey:@"message"] isEqualToString:@"Successfully Saved !!!!"])
//         {
//             [[AppManager sharedManager] hideHUD];
//
//             alert(@"Alert", [responseObject objectForKey:@"message"]);
//             
//             self.textField_address.text=@"";
//             lbl_need.text=@"";
//             
//             [self.image_serviceOne setImage:[UIImage imageNamed:@"checkbox.png"]];
//             [self.image_servicetwo setImage:[UIImage imageNamed:@"checkbox.png"]];
//             [self.image_serviceThree setImage:[UIImage imageNamed:@"checkbox.png"]];
//             [self.image_serviceFour setImage:[UIImage imageNamed:@"checkbox.png"]];
//             [self.image_serviceFive setImage:[UIImage imageNamed:@"checkbox.png"]];
//
//             [array_carWashService removeAllObjects];
//
//             return;
//         }
         
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
    
    [[AppManager sharedManager] showHUD:@"Please wait,we are searching for a car wash"];
    
    [[AppManager sharedManager] getDataForUrl:@"http://dev414.trigma.us/serv/webs/customerRightNowService?"
     
                                   parameters:parameters
     
                                      success:^(AFHTTPRequestOperation *operation, id responseObject)
     
     {
         
         // Get response from server
         
         NSLog(@"JSON: %@", responseObject);//description//Please wait, we are searching for a maid
         
         [[NSUserDefaults standardUserDefaults]setObject:responseObject forKey:@"sProviderData"];

         
         if ([[responseObject objectForKey:@"message"]isEqualToString:@"No Service Provider is available right now."])
         {
             alert(@"Alert!", [responseObject objectForKey:@"message"]);
             
             
             self.textField_address.text=@"";
             lbl_need.text=@"";
             [self.image_serviceOne setImage:[UIImage imageNamed:@"checkbox.png"]];
             [self.image_servicetwo setImage:[UIImage imageNamed:@"checkbox.png"]];
             [self.image_serviceThree setImage:[UIImage imageNamed:@"checkbox.png"]];
             [self.image_serviceFour setImage:[UIImage imageNamed:@"checkbox.png"]];
             [self.image_serviceFive setImage:[UIImage imageNamed:@"checkbox.png"]];
             [array_carWashService removeAllObjects];
             
             
             
             [[AppManager sharedManager] hideHUD];
             
             return ;
             
         }
         else
         {
             LocationTrackVC *locationTrackView=[self.storyboard instantiateViewControllerWithIdentifier:@"LocationTrackVC"];
             [self.navigationController pushViewController:locationTrackView animated:YES];
             
             self.textField_address.text=@"";
             lbl_need.text=@"";
             [self.image_serviceOne setImage:[UIImage imageNamed:@"checkbox.png"]];
             [self.image_servicetwo setImage:[UIImage imageNamed:@"checkbox.png"]];
             [self.image_serviceThree setImage:[UIImage imageNamed:@"checkbox.png"]];
             [self.image_serviceFour setImage:[UIImage imageNamed:@"checkbox.png"]];
             [self.image_serviceFive setImage:[UIImage imageNamed:@"checkbox.png"]];
             [array_carWashService removeAllObjects];
             
             
             
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


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    
   // [view_dateAndTime setHidden:YES];
    [self.view_picker setHidden:YES];
    
    [view_description setHidden:YES];
    
   // [dropDown hideDropDown:lbl_need];
  //  [dropDown hideDropDown:self.textField_address];

    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
