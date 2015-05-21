//
//  SpaVC.m
//  SERVApp
//
//  Created by Surender Kumar on 24/01/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import "SpaVC.h"
#import "AppManager.h"

@interface SpaVC ()

@end

@implementation SpaVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [AppManager sharedManager].navCon = self.navigationController;

    
    [self.datePickerView setHidden:YES];
    
    array_services=[[NSMutableArray alloc]init];

    [view_description setHidden:YES];
    // Do any additional setup after loading the view.
}

- (IBAction)TappedOnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnSelectServices:(UIButton *)sender
{
    [view_description setHidden:YES];

    switch ([sender tag])
    {
            
        case 101:
            
            if (![sender isSelected])
            {
                [sender setSelected:YES];
                
                [self.image_manicure setImage:[UIImage imageNamed:@"check-icon.png"]];
                
                //houseCln=YES;
                [array_services addObject:@"Manicure Spa"];
            }else
            {
                [self.image_manicure setImage:[UIImage imageNamed:@"checkbox.png"]];
                
                [sender setSelected:NO];
               // houseCln=NO;
                [array_services removeObject:@"Manicure Spa"];
                
            }
            
            
            break;
        case 102:
            
            
            if (![sender isSelected])
            {
                [sender setSelected:YES];
                
                [self.image_pedicure setImage:[UIImage imageNamed:@"check-icon.png"]];
                
               // houseCln=YES;
                [array_services addObject:@"Pedicure Spa"];
            }else
            {
                [self.image_pedicure setImage:[UIImage imageNamed:@"checkbox.png"]];
                
                [sender setSelected:NO];
                //houseCln=NO;
                [array_services removeObject:@"Pedicure Spa"];
                
            }
            
            break;
            
        case 103:
            
            if (![sender isSelected])
            {
                [sender setSelected:YES];
                
                
                [self.image_massage setImage:[UIImage imageNamed:@"check-icon.png"]];
                
              //  houseCln=YES;
                [array_services addObject:@"Massage Spa"];
            }else
            {
                [self.image_massage setImage:[UIImage imageNamed:@"checkbox.png"]];
                
                [sender setSelected:NO];
               // houseCln=NO;
                [array_services removeObject:@"Massage Spa"];
                
            }
            
            break;
            
        default:
            break;
    }
   // [self.view_picker setHidden:YES];
   // [view_dateAndTime setHidden:YES];
    
    
    str_sevices=[array_services componentsJoinedByString:@","];
    NSLog(@"string %@",str_sevices);
}



- (IBAction)TappedOnActionBtns:(UIButton*)sender
{
    [view_description setHidden:YES];

    if (sender.tag==1)
    { // Address
        
            
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
//    else if(sender.tag==2)
//    {// select Restaurent
//        [self.datePickerView setHidden:YES];
//
//        //Manicure, Pedicure, Massage.
//        //array_services=[[NSMutableArray alloc]initWithObjects:@"Pedicure Spa",@"Pedicures Spa",@"Facial Spa Skin",@"Waxing Spa",@"Spa Medical",@"Traditional Spa",@"Ayurvedi Spa",@"Hammam Spa",nil];
//        
//        array_services=[[NSMutableArray alloc]initWithObjects:@"Manicure Spa",@"Pedicures Spa",@"Massage Spa ",nil];
//
//        
//        if(dropDown == nil)
//        {
//            CGFloat f = 120;
//            dropDown = [[NIDropDown alloc]showDropDown:self.txtField_services :&f :array_services :Nil :@"down"];
//            dropDown.delegate = self;
//            
//        }
//        else
//        {
//            [dropDown hideDropDown:self.txtField_services];
//            [self rel];
//        }
//
//
//    }
    else if(sender.tag==3)
    {// select date
        
        if (![sender isSelected])
        {
            [sender setSelected:YES];
            
            
            [view_description setHidden:YES];
            
            [self.datePickerView setHidden:NO];
            if (IS_IPHONE_5)
            {
                [self.datePickerView setFrame:CGRectMake(23, 320, 272, 164)];
                
            }
            else
            {
                [self.datePickerView setFrame:CGRectMake(40, 370, 300, 164)];
                
            }
            
            
            isDate=YES;
            [self.datePicker addTarget:self action:@selector(datePickerChanged:) forControlEvents:UIControlEventValueChanged];
            
            self.datePicker.datePickerMode=UIDatePickerModeDate;
            [self.datePicker setMinimumDate: [NSDate date]];

        }
        else
        {
            [sender setSelected:NO];
            
            
            //[view_description setHidden:YES];
            
            [self.datePickerView setHidden:YES];

        }

    }
    else if(sender.tag==4)
    {// select time
        
        if (![sender isSelected])
        {
            [sender setSelected:YES];
            
            //
            //            [view_description setHidden:YES];
            //
            //            [self.datePickerView setHidden:NO];
            [view_description setHidden:YES];
            
            isDate=NO;
            [self.datePickerView setHidden:NO];
            
            if (IS_IPHONE_5) {
                
                
                [self.datePickerView setFrame:CGRectMake(23, 360, 270, 164)];
            }
            else
            {
                [self.datePickerView setFrame:CGRectMake(40, 420, 300, 164)];
                
            }
            
            [self.datePicker addTarget:self action:@selector(datePickerChanged:) forControlEvents:UIControlEventValueChanged];
            
            self.datePicker.datePickerMode=UIDatePickerModeTime;
            [self.datePicker setMinimumDate: [NSDate date]];

        }
        else
        {
            [sender setSelected:NO];
            [self.datePickerView setHidden:YES];
        }
    }
    
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
                [view_description setFrame:CGRectMake(110, 205, 151, 33)];
            }
            else
            {
                [view_description setFrame:CGRectMake(140, 235, 151, 33)];

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
                [view_description setFrame:CGRectMake(110, 225, 151, 33)];
            }
            else
            {
                [view_description setFrame:CGRectMake(140, 260, 151, 33)];
                
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
                [view_description setFrame:CGRectMake(110, 251, 151, 33)];
            }
            else
            {
                [view_description setFrame:CGRectMake(140, 295, 151, 33)];
                
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



- (void)datePickerChanged:(UIDatePicker *)datePicker
{
    if (isDate)
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM-dd-yyyy"];
        NSString *strDate = [dateFormatter stringFromDate:datePicker.date];
        self.txtField_date.text = strDate;
    }
    else
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH:mm"];
        NSString *strDate = [dateFormatter stringFromDate:datePicker.date];
        self.txtView_time.text = strDate;
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


- (IBAction)TappedOnSubmitBtn:(id)sender
{
    [self.datePickerView setHidden:YES];

    if (![self.txtField_address.text isEqualToString:@""] && ![self.txtField_date.text isEqualToString:@""] && ![self.txtView_time.text isEqualToString:@""])
    {
        if (![str_sevices isEqualToString:@""])
        {
            [self webServiceForSpa];

        }
        else
        {
            alert(@"Alert!", @"Please select your services.");
            return;

        }
    }
    else
    {
        alert(@"Alert!", @"Please fill all mandatory fields.");
        return;
    }

}

-(void)webServiceForSpa
{
    //Add parameters to send server
    // @"request_time" :txtField_time.text,
  //  @"request_date" :txtField_dateAndTime.text,
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:
                                       
                                       @{
                                         
                                         @"address" :self.txtField_address.text,
                                         @"services" :str_sevices,
                                         @"request_date" :self.txtField_date.text,
                                         @"request_time" :self.txtView_time.text,
                                         @"category_id" :@"8",
                                         @"user_id" :[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]
                                         
                                         
                                         
                                         }];
    
    [[AppManager sharedManager] showHUD:@"Loading..."];
    
    
    [[AppManager sharedManager] getDataForUrl:@"http://dev414.trigma.us/serv/Webs/customerPostSpa?"
     
                                   parameters:parameters
     
                                      success:^(AFHTTPRequestOperation *operation, id responseObject)
     
     {
         
         // Get response from server
         
         NSLog(@"JSON: %@", responseObject);//description
         
         
         if([[responseObject objectForKey:@"message"] isEqualToString:@"Spa Service Successfully Send !!!!"])
         {
             [[AppManager sharedManager] hideHUD];
             
             alert(@"Alert", [responseObject objectForKey:@"message"]);
             
             self.txtField_address.text=@"";
             self.txtField_services.text=@"";
             self.txtField_date.text=@"";
             self.txtView_time.text=@"";
             
             [self.image_manicure setImage:[UIImage imageNamed:@"checkbox.png"]];
             [self.image_pedicure setImage:[UIImage imageNamed:@"checkbox.png"]];
             [self.image_massage setImage:[UIImage imageNamed:@"checkbox.png"]];
             [array_services removeAllObjects];
             
             [btn_manicure setSelected:NO];
             [btn_massage setSelected:NO];
             [btn_pedicure setSelected:NO];
             
             return;
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
    [self.datePickerView setHidden:YES];
    [view_description setHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
