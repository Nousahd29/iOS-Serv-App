//
//  TravelHotelVC.m
//  SERVApp
//
//  Created by Noushad on 26/03/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import "TravelHotelVC.h"
#import "AppManager.h"
#import "NIDropDown.h"
#import "TravelVC.h"

@interface TravelHotelVC ()

@end

@implementation TravelHotelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [AppManager sharedManager].navCon = self.navigationController;
    
    

    // Do any additional setup after loading the view.
}
- (IBAction)TappedOnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)TappedOnSelectedButtons:(UIButton*)sender
{
    
    if (sender.tag == 2)
    {
        // Hotel rating btn
        
        [self.txt_state resignFirstResponder];
        [self.txt_city resignFirstResponder];


        
        array_hotelRating=[[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",nil];
        
        
        if(dropDown == nil)
        {
            CGFloat f = 120;
            dropDown = [[NIDropDown alloc]showDropDown:self.txt_hotelRating :&f :array_hotelRating :Nil :@"down"];
            dropDown.delegate = self;
            
        }
        else
        {
            [dropDown hideDropDown:self.txt_hotelRating];
            [self rel];
        }

        
    }
    else if (sender.tag == 1)
    {
        [self.txt_state resignFirstResponder];
        [self.txt_city resignFirstResponder];
        //hotel How many days click
        array_howManyDays=[[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",nil];
        
        
        if(dropDown == nil)
        {
            CGFloat f = 120;
            dropDown = [[NIDropDown alloc]showDropDown:self.txt_howManyDays :&f :array_howManyDays :Nil :@"down"];
            dropDown.delegate = self;
            
        }
        else
        {
            [dropDown hideDropDown:self.txt_howManyDays];
            [self rel];
        }

    }
    else if (sender.tag == 3)
    {
        //book now btn
        
        if (![self.txt_state.text isEqualToString:@""] && ![self.txt_city.text isEqualToString:@""] && ![self.txt_hotelRating.text isEqualToString:@""] && ![self.txt_howManyDays.text isEqualToString:@""])
        {
            [self webServiceForHotels];
        }
        else
        {
            alert(@"Alert!", @"Please fill all mandatory fields.");
            return;
        }

    }
    else if (sender.tag == 4)
    {
        //Add more btn
        
        [self.navigationController popViewControllerAnimated:YES];
        
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
-(void)webServiceForHotels
{
    //Add parameters to send server
    
    //ttp://dev414.trigma.us/serv/Webs/customerPostTravelHotel?hotel=Jw marriots&city=chandigarh&state=Punjab&hotel_rating=5 Stars&category_id=14&user_id=727
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:
                                       
                                       @{
                                         
                                         @"hotel" :@"GrandPlaza",
                                         @"city" :self.txt_city.text,
                                         @"state" :self.txt_state.text,
                                         
                                         @"hotel_rating" :self.txt_hotelRating.text,
                                         @"days" :self.txt_howManyDays.text,

                                         
                                         @"category_id" :@"14",
                                         @"user_id" :[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]
                                         
                                         
                                         
                                         }];
    
    [[AppManager sharedManager] showHUD:@"Loading..."];
    
    // [appdelRef showProgress:@"Please wait.."];
    
    
    [[AppManager sharedManager] getDataForUrl:@"http://dev414.trigma.us/serv/Webs/customerPostTravelHotel??"
     
                                   parameters:parameters
     
                                      success:^(AFHTTPRequestOperation *operation, id responseObject)
     
     {
         
         // Get response from server
         
         NSLog(@"JSON: %@", responseObject);//description
         
         // message = "Hotel Service Successfully Send !!!!";
         
         if([[responseObject objectForKey:@"message"] isEqualToString:@"Hotel Service Successfully Send !!!!"])
         {
             [[AppManager sharedManager] hideHUD];
             
             alert(@"Alert", [responseObject objectForKey:@"message"]);
             
             self.txt_city.text=@"";
             self.txt_hotelRating.text=@"";
             self.txt_howManyDays.text=@"";
             self.txt_state.text=@"";
             
             [[AppManager sharedManager] hideHUD];

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

-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
    
        [textField resignFirstResponder];
   
    return YES;
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.txt_state    resignFirstResponder];
    [self.txt_city    resignFirstResponder];
   
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
