//
//  MaidVC.m
//  SERVApp
//
//  Created by Surender Kumar on 24/01/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import "MaidVC.h"
#import "NIDropDown.h"
#import "AppManager.h"
#import "HeaderFile.h"
#import "LocationTrackVC.h"

@interface MaidVC ()

@end

@implementation MaidVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [AppManager sharedManager].navCon = self.navigationController;

    
    array_services=[[NSMutableArray alloc]init];
    [self.view_picker setHidden:YES];
    [view_dateAndTime setHidden:YES];
    
    [view_description setHidden:YES];
   // [btn_questionMark setHidden:YES];

    
    // Do any additional setup after loading the view.
}

- (IBAction)btnSelectServices:(UIButton *)sender
{
    switch ([sender tag])
    {
            
        case 101:
            
            if (![sender isSelected])
            {
                [sender setSelected:YES];
                
               // [btn_questionMark setHidden:NO];
             //   [btn_questionMark setFrame:CGRectMake(219, 176, 17, 22   )];

                
                [self.image_houseClean setImage:[UIImage imageNamed:@"check-icon.png"]];

                houseCln=YES;
                [array_services addObject:@"houseCleaning"];
            }else
            {
                [self.image_houseClean setImage:[UIImage imageNamed:@"checkbox.png"]];

                [sender setSelected:NO];
              //  [btn_questionMark setHidden:YES];
              //  [view_description setHidden:YES];
                houseCln=NO;
                [array_services removeObject:@"houseCleaning"];
            
            }

            
            break;
        case 102:
            
            
            if (![sender isSelected])
            {
                [sender setSelected:YES];
               // [btn_questionMark setHidden:YES];
             //   [btn_questionMark setFrame:CGRectMake(219, 201, 17, 22   )];
              //  [btn_questionMark setTag:2];
             //   [view_description setHidden:YES];
                
                [self.image_deepClean setImage:[UIImage imageNamed:@"check-icon.png"]];
                
                houseCln=YES;
                [array_services addObject:@"deepCleaning"];
            }else
            {
                [self.image_deepClean setImage:[UIImage imageNamed:@"checkbox.png"]];
                
                [sender setSelected:NO];
                houseCln=NO;
                [array_services removeObject:@"deepCleaning"];
                
            }

            break;
            
        case 103:
            
            if (![sender isSelected])
            {
                [sender setSelected:YES];
            //    [btn_questionMark setFrame:CGRectMake(219, 226, 17, 22   )];
           //     [btn_questionMark setTag:3];
           //     [view_description setHidden:YES];



                
                [self.image_laundry setImage:[UIImage imageNamed:@"check-icon.png"]];
                
                houseCln=YES;
                [array_services addObject:@"laundary"];
            }else
            {
                [self.image_laundry setImage:[UIImage imageNamed:@"checkbox.png"]];
                
                [sender setSelected:NO];
                houseCln=NO;
                [array_services removeObject:@"laundary"];
                
            }

            break;
            
        case 104:
            
            if (![sender isSelected])
            {
                [sender setSelected:YES];
             //   [btn_questionMark setFrame:CGRectMake(219, 251, 17, 22   )];
              //  [btn_questionMark setTag:4];
             //   [view_description setHidden:YES];


                
                [self.image_dishes setImage:[UIImage imageNamed:@"check-icon.png"]];
                
                houseCln=YES;
                [array_services addObject:@"dishes"];
            }else
            {
                [self.image_dishes setImage:[UIImage imageNamed:@"checkbox.png"]];
                
                [sender setSelected:NO];
                houseCln=NO;
                [array_services removeObject:@"dishes"];
                
            }

            

            break;
            
        default:
            break;
    }
    [self.view_picker setHidden:YES];
    //[view_dateAndTime setHidden:YES];

    
    str_sevices=[array_services componentsJoinedByString:@","];
    NSLog(@"string %@",str_sevices);
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
                [view_description setFrame:CGRectMake(144, 194, 151, 33)];

            }
            else
            {
                [view_description setFrame:CGRectMake(170, 222, 151, 33)];

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
                [view_description setFrame:CGRectMake(144, 215, 151, 33)];
            }
            else
            {
                [view_description setFrame:CGRectMake(170, 255, 151, 33)];
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
            [view_description setFrame:CGRectMake(144, 235, 151, 33)];
            }
            else
            {
                [view_description setFrame:CGRectMake(170, 275, 151, 33)];

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
                [view_description setFrame:CGRectMake(144, 264, 158, 48)];
            }
            else
            {
                [view_description setFrame:CGRectMake(170, 315, 158, 48)];

            }
            [view_description setHidden:NO];

        }
        else
        {
            [sender setSelected:NO];
            [view_description setHidden:YES];
        }
        
    }
    [sender setSelected:NO];

}

- (IBAction)TappedOnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)TappedOnDropdownActions:(UIButton*)sender
{
    if (sender.tag==1)
    {
        [self.view_picker setHidden:YES];
       // [view_dateAndTime setHidden:YES];

        arr_address=[[NSMutableArray alloc]initWithObjects:[[NSUserDefaults standardUserDefaults] objectForKey:@"address"] ,nil];
        if(dropDown == nil)
        {
            CGFloat f = 120;
            dropDown = [[NIDropDown alloc]showDropDown:txtField_address :&f :arr_address :Nil :@"down"];
            dropDown.delegate = self;
            
        }
        else
        {
            [dropDown hideDropDown:txtField_address];
            [self rel];
        }

    }
    else if (sender.tag==2)
    {
        [self.view_picker setHidden:YES];

        arr_Need=[[NSMutableArray alloc]initWithObjects:@"Right Now ",@"Today",@"Another Date" ,nil];

        if(dropDown == nil)
        {
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
    else if (sender.tag==3)
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
       // self.picker_dateAndTime.datePickerMode=UIDatePickerModeDate;

    }
}

- (void)datePickerChanged:(UIDatePicker *)datePicker
{
    if (isTime) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH:mm:ss"];
        NSString *strDate = [dateFormatter stringFromDate:datePicker.date];
        txtField_time.text = strDate;
      //  txtField_dateAndTime.text=@"";
    }
    else
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM-dd-yyyy"];
        NSString *strDate = [dateFormatter stringFromDate:datePicker.date];
        txtField_dateAndTime.text = strDate;
      //  txtField_time.text=@"";
    }
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view_picker setHidden:YES];
    [view_description setHidden:YES];
}

- (void) niDropDownDelegateMethod: (NIDropDown *) sender
{
    if ([lbl_need.text isEqualToString:@"Today"])
    {
        str_serviceDate=@"2";
        [view_dateAndTime setHidden:NO];
        
        [txtField_dateAndTime setHidden:YES];
        [image_date setHidden:YES];
        [txtField_time setHidden:NO];
        [image_time setHidden:NO];
        
        txtField_dateAndTime.text=@"";
    }
    else if ([lbl_need.text isEqualToString:@"Another Date"])
    {
        str_serviceDate=@"3";

        [view_dateAndTime setHidden:NO];
        
        [txtField_time setHidden:YES];
        [image_time setHidden:YES];
        
        [txtField_dateAndTime setHidden:NO];
        [image_date setHidden:NO];
        
        txtField_time.text=@"";
        
    }
    else
    {
        str_serviceDate=@"1";

        [view_dateAndTime setHidden:YES];
        
    }
    
    
    [self rel];
}

-(void)rel
{
    dropDown = nil;
}

-(IBAction)submitBtnAction:(id)sender
{
    
    if(isStringEmpty(txtField_address.text)&& (lbl_need.text)) {
        
        // [txt_userName becomeFirstResponder];
        alert(@"Alert!", @"Please fill all mandatory fields.");
        return;
    }
    else if (array_services==nil || [array_services count]==0)
    {
        alert(@"Alert!", @"select services");
        return;

    }
    else if (txtField_address.text.length<=0)
    {
        alert(@"Alert!", @"select Address.");
        return;

    }
    else if (lbl_need.text.length<=0)
    {
        alert(@"Alert!", @"select when you need.");
        return;

    }
    else
    {
        [self webServiceForMaid];

    }
}

-(void)webServiceForMaid
{
    //Add parameters to send server
    
    //ttp://dev414.trigma.us/serv/Webs/customerPostMaid?address=chandigarh&services=housecleaning&need=1&request_time=&request_date=category_id=2&user_id=12
      
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:
                                       
                                       @{
                                         
                                         @"address" :txtField_address.text,
                                         @"services" :str_sevices,
                                         @"need" :str_serviceDate,
                                         @"request_time" :txtField_time.text,
                                         @"request_date" :txtField_dateAndTime.text,
                                         @"category_id" :@"2",
                                         @"user_id" :[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]
                                        
                                         
                                         
                                         }];
    
    [[AppManager sharedManager] showHUD:@"Loading..."];
    
    [[AppManager sharedManager] getDataForUrl:@"http://dev414.trigma.us/serv/Webs/customerPostMaid?"
     
                                   parameters:parameters
     
                                      success:^(AFHTTPRequestOperation *operation, id responseObject)
     
     {
         
         // Get response from server
         
         NSLog(@"JSON: %@", responseObject);//description//Please wait, we are searching for a maid
         
         str_customerServId=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"customer_servid"]];
         if ([str_customerServId isEqualToString:@""])
         {
             alert(@"Alert!", @"Your Service Request is Successfully Send. !!!!");
             txtField_address.text=@"";
             lbl_need.text=@"";
             txtField_dateAndTime.text=@"";
             [view_dateAndTime setHidden:YES];
             
             
           //  LocationTrackVC *locationTrackView=[self.storyboard instantiateViewControllerWithIdentifier:@"LocationTrackVC"];
            // [self.navigationController pushViewController:locationTrackView animated:YES];
             
             [self.image_houseClean setImage:[UIImage imageNamed:@"checkbox.png"]];
             [self.image_deepClean setImage:[UIImage imageNamed:@"checkbox.png"]];
             [self.image_laundry setImage:[UIImage imageNamed:@"checkbox.png"]];
             [self.image_dishes setImage:[UIImage imageNamed:@"checkbox.png"]];
             
             [btn_DeepCln setSelected:NO];
             [btn_dishes setSelected:NO];
             [btn_huseCln setSelected:NO];
             [btn_Laundry setSelected:NO];
             
             [[AppManager sharedManager] hideHUD];
             [array_services removeAllObjects];
             return ;
         }
         else
         {
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
    
    [[AppManager sharedManager] showHUD:@"Please wait,we are searching for a maid"];
    
    [[AppManager sharedManager] getDataForUrl:@"http://dev414.trigma.us/serv/webs/customerRightNowService?"
     
                                   parameters:parameters
     
                                      success:^(AFHTTPRequestOperation *operation, id responseObject)
     
     {
         
         // Get response from server
         
         NSLog(@"JSON: %@", responseObject);//description//Please wait, we are searching for a maid
         
         NSMutableArray *array_serviceProviderData=[[NSMutableArray alloc]init];
         
         [array_serviceProviderData addObject:responseObject];
         NSLog(@"array_serviceProviderData %@",array_serviceProviderData);
         
         [[NSUserDefaults standardUserDefaults]setObject:responseObject forKey:@"sProviderData"];
         
         
         if ([[responseObject objectForKey:@"message"]isEqualToString:@"No Service Provider is available right now."])
         {
             alert(@"Alert!", [responseObject objectForKey:@"message"]);
             
             
             txtField_address.text=@"";
             lbl_need.text=@"";
             
             
            // LocationTrackVC *locationTrackView=[self.storyboard instantiateViewControllerWithIdentifier:@"LocationTrackVC"];
            // [self.navigationController pushViewController:locationTrackView animated:YES];
             
             
             [self.image_houseClean setImage:[UIImage imageNamed:@"checkbox.png"]];
             [self.image_deepClean setImage:[UIImage imageNamed:@"checkbox.png"]];
             [self.image_laundry setImage:[UIImage imageNamed:@"checkbox.png"]];
             [self.image_dishes setImage:[UIImage imageNamed:@"checkbox.png"]];
             
             [array_services removeAllObjects];
             
             [[AppManager sharedManager] hideHUD];
             
             return ;

         }
         else
         {
             LocationTrackVC *locationTrackView=[self.storyboard instantiateViewControllerWithIdentifier:@"LocationTrackVC"];
            // [locationTrackView.arry_sProviderData addObject:responseObject];
           //  NSLog(@"location%@",locationTrackView.arry_sProviderData);
             [self.navigationController pushViewController:locationTrackView animated:YES];
             
             txtField_address.text=@"";
             lbl_need.text=@"";
             
             
             
             [self.image_houseClean setImage:[UIImage imageNamed:@"checkbox.png"]];
             [self.image_deepClean setImage:[UIImage imageNamed:@"checkbox.png"]];
             [self.image_laundry setImage:[UIImage imageNamed:@"checkbox.png"]];
             [self.image_dishes setImage:[UIImage imageNamed:@"checkbox.png"]];
             
             [array_services removeAllObjects];
             
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
