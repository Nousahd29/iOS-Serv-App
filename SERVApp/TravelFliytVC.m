//
//  TravelFliytVC.m
//  SERVApp
//
//  Created by Surender Kumar on 24/01/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import "TravelFliytVC.h"
#import "AppManager.h"

@interface TravelFliytVC ()

@end

@implementation TravelFliytVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [AppManager sharedManager].navCon = self.navigationController;
    

   [self.datePickerView setHidden:YES];

    // Do any additional setup after loading the view.
}

- (IBAction)TappedOnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)TappedOnSelectedButtons:(UIButton*)sender
{
    if (sender.tag == 1)
    {
        // flight date
        
        [self.txt_from resignFirstResponder];
        [self.txt_destination resignFirstResponder];
        
        [self.datePickerView setHidden:NO];
        if (IS_IPHONE_5)
        {
            [self.datePickerView setFrame:CGRectMake(21, 243, 272, 164)];
            
        }
        else
        {
            [self.datePickerView setFrame:CGRectMake(40, 285, 300, 164)];
            
        }
        
        
       isDate=YES;
        [self.datePicker addTarget:self action:@selector(datePickerChanged:) forControlEvents:UIControlEventValueChanged];
        
        self.datePicker.datePickerMode=UIDatePickerModeDate;
        
    }
    else if (sender.tag == 2)
    {
        //return date
        
        [self.txt_from resignFirstResponder];
        [self.txt_destination resignFirstResponder];
        [self.datePickerView setHidden:NO];
        if (IS_IPHONE_5)
        {
            [self.datePickerView setFrame:CGRectMake(21, 260, 272, 164)];
            
        }
        else
        {
            [self.datePickerView setFrame:CGRectMake(40, 350, 300, 164)];
            
        }
        
        
        isDate=NO;
        [self.datePicker addTarget:self action:@selector(datePickerChanged:) forControlEvents:UIControlEventValueChanged];
        
        self.datePicker.datePickerMode=UIDatePickerModeDate;
    }
    else if (sender.tag == 3)
    {
        // Book now btn
        
        if (![self.txt_date.text isEqualToString:@""] && ![self.txt_destination.text isEqualToString:@""] && ![self.txt_from.text isEqualToString:@""] && ![self.txt_returnDate.text isEqualToString:@""])
        {
            [self webServiceForFlights];
        }
        else
        {
            alert(@"Alert!", @"Please fill all mandatory fields.");
            return;
        }
        
    }
    else if (sender.tag == 4)
    {
        // Add more btn
        [self.navigationController popViewControllerAnimated:YES];

        
    }


    
}

- (void)datePickerChanged:(UIDatePicker *)datePicker
{
    
    if (isDate)
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd-MM-yyyy"];
        NSString *strDate = [dateFormatter stringFromDate:datePicker.date];
        self.txt_date.text = strDate;
    }
    else
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd-MM-yyyy"];
        NSString *strDate = [dateFormatter stringFromDate:datePicker.date];
        self.txt_returnDate.text = strDate;
    }
    
    
}


-(void)webServiceForFlights
{
    //Add parameters to send server
    
     //ttp://dev414.trigma.us/serv/Webs/customerPostTravelFlight?flight=Air%20Asia&from=chandigarh&destination=Delhi&date=2015-03-26&days=3%20days%20&return_date=2015-03-28&category_id=15&user_id=727

    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:
                                       
                                       @{
                                         
                                         @"flight" :@"Air Asia",
                                         @"from" :self.txt_from.text,
                                         @"destination" :self.txt_destination.text,
                                         
                                         @"date" :self.txt_date.text,
                                         @"return_date" :self.txt_returnDate.text,
                                         @"category_id" :@"15",
                                         @"user_id" :[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]
                                         
                                         
                                         
                                         }];
    
    [[AppManager sharedManager] showHUD:@"Loading..."];
    
    // [appdelRef showProgress:@"Please wait.."];
    
    
    [[AppManager sharedManager] getDataForUrl:@"http://dev414.trigma.us/serv/Webs/customerPostTravelFlight?"
     
                                   parameters:parameters
     
                                      success:^(AFHTTPRequestOperation *operation, id responseObject)
     
     {
         
         // Get response from server
         
         NSLog(@"JSON: %@", responseObject);//description
         
         
         if([[responseObject objectForKey:@"message"] isEqualToString:@"Flight Service Successfully Send !!!!"])
         {
             [[AppManager sharedManager] hideHUD];
             
             alert(@"Alert", [responseObject objectForKey:@"message"]);
             
             self.txt_from.text=@"";
             self.txt_destination.text=@"";
             self.txt_date.text=@"";
             self.txt_returnDate.text=@"";
             
             return;
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



-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
    
    [self.txt_from resignFirstResponder];
    [self.txt_destination resignFirstResponder];

    
    return YES;
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.txt_from    resignFirstResponder];
    [self.txt_destination    resignFirstResponder];
    [self.datePickerView setHidden:YES];

    
    
    
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
