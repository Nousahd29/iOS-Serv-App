//
//  PersonalChefVC.m
//  SERVApp
//
//  Created by Surender Kumar on 24/01/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import "PersonalChefVC.h"
#import "NIDropDown.h"
#import "AppManager.h"
#import "LocationTrackVC.h"

@interface PersonalChefVC ()

@end

@implementation PersonalChefVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [AppManager sharedManager].navCon = self.navigationController;
    [self.textView_meals setUserInteractionEnabled:NO];


    arr_Need=[[NSMutableArray alloc]initWithObjects:@"Right Now",@"Today",@"Another Date" ,nil];
    [btn_yes setSelected:NO];
    [btn_no setSelected:NO];
    
    [view_dateAndTime setHidden:YES];
    [self.view_picker setHidden:YES];

    
    //[btn_yes setImage:[UIImage imageNamed:@"radio-icon"] forState:UIControlStateNormal];
    //[btn_yes setImage:[UIImage imageNamed:@"radio-icon-active"] forState:UIControlStateSelected];
    
   // [btn_no setImage:[UIImage imageNamed:@"radio-icon"] forState:UIControlStateNormal];
   // [btn_no setImage:[UIImage imageNamed:@"radio-icon-active"] forState:UIControlStateSelected];
    
    
    //self.textView_meals.text = @"Right Some Special Meals";
   // self.textView_meals.textColor = [UIColor lightGrayColor];
    UIToolbar   *keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(3, 0, self.view.bounds.size.width, 44)];
    [keyboardToolbar setBarStyle:UIBarStyleBlackTranslucent];
    
    UIBarButtonItem *extraSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *next = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(switchToNextField:)];
    
    [keyboardToolbar setItems:[[NSArray alloc] initWithObjects: extraSpace, next, nil]];
    self.textView_meals.inputAccessoryView = keyboardToolbar;
    //for status bar color
    [self setNeedsStatusBarAppearanceUpdate];
    
    // Do any additional setup after loading the view.
}
-(IBAction)switchToNextField:(id)sender
{
    // DLog(@"ffgsdsgfsdgsgsdg");
    [self.textView_meals.inputView removeFromSuperview];
    [self.textView_meals resignFirstResponder];
    //    [self.view endEditing:YES];
}

- (IBAction)btn_selectMeal:(UIButton *)sender
{
    mealY=YES;
    if (sender.tag==101) {
        
//        if (![sender isSelected])
//        {
//            mealY=YES;
//
//            [btn_yes setSelected:YES];
//            [btn_no setSelected:NO];
//            [self.textView_meals setUserInteractionEnabled:YES];
//            [self.textView_meals becomeFirstResponder];
//            
//        }
        
        if (![sender isSelected])
        {
            [sender setSelected:YES];
            [self.image_yesIcon setImage:[UIImage imageNamed:@"radio-icon-active.png"]];
            [self.image_noIcon setImage:[UIImage imageNamed:@"radio-icon.png"]];
            UIButton *therapistCheckBtn =   (UIButton*)[self.view viewWithTag:102];
            [therapistCheckBtn setSelected:NO];
            
            [self.textView_meals setUserInteractionEnabled:YES];
            [self.textView_meals becomeFirstResponder];
        }else{
            [self.image_noIcon setImage:[UIImage imageNamed:@"radio-icon.png"]];
        }
        
    }
    else if (sender.tag==102)
    {
//        if (![sender isSelected]) {
//            
//            [btn_no setSelected:YES];
//            [btn_yes setSelected:NO];
//            self.textView_meals.text=nil;
//            [self.textView_meals setUserInteractionEnabled:NO];
//        }
        if (![sender isSelected])
        {
            [sender setSelected:YES];
            [self.image_noIcon setImage:[UIImage imageNamed:@"radio-icon-active.png"]];
            [self.image_yesIcon setImage:[UIImage imageNamed:@"radio-icon.png"]];
            UIButton *therapistCheckBtn =   (UIButton*)[self.view viewWithTag:101];
            [therapistCheckBtn setSelected:NO];
            
            self.textView_meals.text=nil;
              [self.textView_meals setUserInteractionEnabled:NO];
        }else{
            [self.image_yesIcon setImage:[UIImage imageNamed:@"radio-icon.png"]];
        }

        
    }
    
    
//    if(mealY==NO)
//    {
//        [btn_yes setImage:[UIImage imageNamed:@"radio-icon-active"] forState:UIControlStateNormal];
//        [btn_no setImage:[UIImage imageNamed:@"radio-icon"] forState:UIControlStateNormal];
//
//        mealY=YES;
//        str_YN=@"1";
//        [self.textView_meals setUserInteractionEnabled:YES];
//    }
//    else
//    {
//        [btn_yes setImage:[UIImage imageNamed:@"radio-icon"] forState:UIControlStateNormal];
//        [btn_no setImage:[UIImage imageNamed:@"radio-icon-active"] forState:UIControlStateNormal];
//        mealY=NO;
//        self.textView_meals.text=nil;
//        [self.textView_meals setUserInteractionEnabled:NO];
//
//
//    }
    //[view_dateAndTime setHidden:YES];
    [self.view_picker setHidden:YES];
    NSLog(@"Text %@",self.textView_meals.text);

}

- (IBAction)TappedOnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)TappedOnNeed:(id)sender {
    if(dropDown == nil)
    {
        [self.view_picker setHidden:YES];

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
    }
    else if ([lbl_need.text isEqualToString:@"Another Date"])
    {
        [view_dateAndTime setHidden:NO];
        str_serviceDate=@"3";

        
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

- (IBAction)TappedOnSubmitBtn:(id)sender {
    
    NSLog(@"Text %@",self.textView_meals.text);
    [view_dateAndTime setHidden:YES];
    [self.view_picker setHidden:YES];


    if (![self.textField_address.text isEqualToString:@""] && ![lbl_need.text isEqualToString:@""] && ![self.textField_noOfPeople.text isEqualToString:@""])
    {
        if (![btn_no isSelected]) {
            if (![btn_yes isSelected])
            {
                alert(@"Alert!", @"Please select Specific meal in your mind");
                
                return;
            }
            else if (![self.textView_meals.text isEqualToString:@""])
            {
                [self webServiceForPersonalChef];
            }
            else if (![btn_no isSelected])
            {
                [self webServiceForPersonalChef];
                
            }
            
            else
            {
                
                [self.textView_meals becomeFirstResponder];
                alert(@"Alert!", @"Please fill the meals in your mind.");
                
                return;
                
                
            }

        }
        else
        {
            [self webServiceForPersonalChef];

        }
        
    }
    else
    {
        alert(@"Alert!", @"Please fill all mandatory fields.");
        return;
    }
    

}
-(void)webServiceForPersonalChef
{
    //Add parameters to send server
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:
                                       
                                       @{
                                         
                                         @"address" :self.textField_address.text,
                                         @"cookings" :self.textField_noOfPeople.text,
                                         @"meals" :self.textView_meals.text,
                                         @"need" :str_serviceDate,
                                         @"request_time" :txtField_dateAndTime.text,
                                         @"request_date" :txtField_dateAndTime.text,
                                         @"category_id" :@"3",
                                         @"user_id" :[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]
                                                                                  
                                         }];
    
    [[AppManager sharedManager] showHUD:@"Loading..."];

    
    [[AppManager sharedManager] getDataForUrl:@"http://dev414.trigma.us/serv/Webs/customerPostPersonalChef?"
     
                                   parameters:parameters
     
                                      success:^(AFHTTPRequestOperation *operation, id responseObject)
     
     {
         
         // Get response from server
         
         NSLog(@"JSON: %@", responseObject);//description
         
         
         str_customerServId=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"customer_servid"]];
         if ([str_customerServId isEqualToString:@""])
         {
             alert(@"Alert!", @"Your Service Request is Successfully Send. !!!!");
             
             self.textView_meals.text=@"";
             
             lbl_need.text=@"";
             self.textField_address.text=@"";
             self.textField_noOfPeople.text=@"";
             [btn_yes setSelected:NO];
             [[AppManager sharedManager] hideHUD];
             
             [view_dateAndTime setHidden:YES];
            return ;
         }
         else
         {
             [self webServiceServiceAvailability];
             
         }

         
//         if([[responseObject objectForKey:@"message"] isEqualToString:@"Successfully Saved !!!!"])
//         {
//             
//             alert(@"Alert", [responseObject objectForKey:@"message"]);
//             
//             self.textView_meals.text=@"";
//             lbl_need.text=@"";
//             self.textField_address.text=@"";
//             self.textField_noOfPeople.text=@"";
//             
//             [btn_yes setSelected:NO];
//             
//             [[AppManager sharedManager] hideHUD];
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
    
    [[AppManager sharedManager] showHUD:@"Please wait,we are searching for a personal Chef"];
    
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
             
             
             self.textView_meals.text=@"";
             
             lbl_need.text=@"";
             self.textField_address.text=@"";
             self.textField_noOfPeople.text=@"";
             [btn_yes setSelected:NO];
             
             
             
             [[AppManager sharedManager] hideHUD];
             
             return ;
             
         }
         else
         {
             LocationTrackVC *locationTrackView=[self.storyboard instantiateViewControllerWithIdentifier:@"LocationTrackVC"];
             [self.navigationController pushViewController:locationTrackView animated:YES];
             
             self.textView_meals.text=@"";
             
             lbl_need.text=@"";
             self.textField_address.text=@"";
             self.textField_noOfPeople.text=@"";
             [btn_yes setSelected:NO];
             
             
             
//             [self.image_houseClean setImage:[UIImage imageNamed:@"checkbox.png"]];
//             [self.image_deepClean setImage:[UIImage imageNamed:@"checkbox.png"]];
//             [self.image_laundry setImage:[UIImage imageNamed:@"checkbox.png"]];
//             [self.image_dishes setImage:[UIImage imageNamed:@"checkbox.png"]];
//             
//             [array_services removeAllObjects];
             
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


-(IBAction)tappedOnDropDownAcions:(UIButton*)sender
{
    if (sender.tag==1)
    {
       // [view_dateAndTime setHidden:YES];
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
    else if (sender.tag==2)
    {
        arr_NoOfPeople=[[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5" ,@"6",@"7",@"8",@"9",@"10",nil];
       // [view_dateAndTime setHidden:YES];
        [self.view_picker setHidden:YES];
        
        if(dropDown == nil)
        {
            CGFloat f = 120;
            dropDown = [[NIDropDown alloc]showDropDown:self.textField_noOfPeople :&f :arr_NoOfPeople :Nil :@"down"];
            dropDown.delegate = self;
            
        }
        else
        {
            [dropDown hideDropDown:self.textField_noOfPeople];
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
    
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"MM-dd-yyyy / HH:mm"];
//    NSString *strDate = [dateFormatter stringFromDate:datePicker.date];
//    txtField_dateAndTime.text = strDate;
    if (isTime) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH:mm:ss"];
        NSString *strDate = [dateFormatter stringFromDate:datePicker.date];
        txtField_dateAndTime.text = strDate;
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

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if(self.textView_meals.tag == 0) {
        self.textView_meals.text = @"";
        self.textView_meals.textColor = [UIColor blackColor];
        self.textView_meals.tag = 1;
    }
    return YES;
}

-(void)textViewDidEndEditing:(UITextView *)textView
{

    NSLog(@"textViewDoneEditing");
    if([self.textView_meals.text length] == 0)
    {
       // self.textView_meals.text = @"Right Some Special Meals";
      //  self.textView_meals.textColor = [UIColor lightGrayColor];
        self.textView_meals.tag = 0;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.textView_meals resignFirstResponder];
    
   // [view_dateAndTime setHidden:YES];
    [self.view_picker setHidden:YES];

    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
