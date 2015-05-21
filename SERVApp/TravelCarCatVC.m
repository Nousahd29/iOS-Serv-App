//
//  TravelCarCatVC.m
//  SERVApp
//
//  Created by Surender Kumar on 24/01/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import "TravelCarCatVC.h"
#import "AppManager.h"

@interface TravelCarCatVC ()

@end

@implementation TravelCarCatVC

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
    if (sender.tag == 1)
    {
        // how many cars
        [self.txt_car resignFirstResponder];

        
        array_howManyCars=[[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",nil];
        
        
        if(dropDown == nil)
        {
            CGFloat f = 120;
            dropDown = [[NIDropDown alloc]showDropDown:self.txt_howManyCars :&f :array_howManyCars :Nil :@"down"];
            dropDown.delegate = self;
            
        }
        else
        {
            [dropDown hideDropDown:self.txt_howManyCars];
            [self rel];
        }
        
        
    }
    else if (sender.tag == 2)
    {
        // type of cars
        [self.txt_car resignFirstResponder];
        
        array_typeOfCar=[[NSMutableArray alloc]initWithObjects:@"Tata Indica",@"Maruti Suzuki",@"Toyota qualis",@"Toyota Innova",@"Honda City",@"Skoda Superb",nil];
        
        
        if(dropDown == nil)
        {
            CGFloat f = 120;
            dropDown = [[NIDropDown alloc]showDropDown:self.txt_typeOfCars :&f :array_typeOfCar :Nil :@"down"];
            dropDown.delegate = self;
            
        }
        else
        {
            [dropDown hideDropDown:self.txt_typeOfCars];
            [self rel];
        }
        
    }
    else if (sender.tag == 3)
    {
        // Book now btn
        
        if (![self.txt_howManyCars.text isEqualToString:@""] && ![self.txt_typeOfCars.text isEqualToString:@""] )
        {
            [self webServiceForCars];
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
- (void) niDropDownDelegateMethod: (NIDropDown *) sender
{
    
    
    [self rel];
}

-(void)rel
{
    dropDown = nil;
}

-(void)webServiceForCars
{
    //Add parameters to send server
    
    //ttp://dev414.trigma.us/serv/Webs/customerPostTravelCar?car=car%202&no_of_cars=3&type_of_cars=3%20seats&category_id=9&user_id=727
    
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:
                                       
                                       @{
                                         
                                         @"car" :@"Air Asia",
                                         @"no_of_cars" :self.txt_howManyCars.text,
                                         @"type_of_cars" :self.txt_typeOfCars.text,
                                         @"category_id" :@"9",
                                         @"user_id" :[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]
                                         
                                         
                                         
                                         }];
    
    [[AppManager sharedManager] showHUD:@"Loading..."];
    
    // [appdelRef showProgress:@"Please wait.."];
    
    
    [[AppManager sharedManager] getDataForUrl:@"http://dev414.trigma.us/serv/Webs/customerPostTravelCar?"
     
                                   parameters:parameters
     
                                      success:^(AFHTTPRequestOperation *operation, id responseObject)
     
     {
         
         // Get response from server
         
         NSLog(@"JSON: %@", responseObject);//description
         
         
         if([[responseObject objectForKey:@"message"] isEqualToString:@"Car Service Successfully Send !!!!"])
         {
             [[AppManager sharedManager] hideHUD];
             
             alert(@"Alert", [responseObject objectForKey:@"message"]);
             
             self.txt_howManyCars.text=@"";
             self.txt_typeOfCars.text=@"";
            
             
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
