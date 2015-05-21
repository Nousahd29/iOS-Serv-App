//
//  ReservationDetailVC.m
//  SERVApp
//
//  Created by Surender Kumar on 24/01/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import "ReservationDetailVC.h"
#import "AppManager.h"
#import "HeaderFile.h"
#import "ResultTableViewCell.h"

@interface ReservationDetailVC ()

@end

@implementation ReservationDetailVC
@synthesize str_type,str_restaurantName;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [AppManager sharedManager].navCon = self.navigationController;

    
    self.lbl_type.text=self.str_type;
   // self.lbl_zipCode.text=self.str_zipCode;
    
    [self.view_picker setHidden:YES];
    
   NSString *strlat=[NSString stringWithFormat:@"%f",self.appDelegate.currentUserLocation.coordinate.latitude];
    NSLog(@"str lat %@",strlat);
    
       //Yelp
    
    if (!self.tableViewDisplayDataArray)
    {
        self.tableViewDisplayDataArray = [[NSMutableArray alloc] init];
    }
    
    self.appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [self.appDelegate updateCurrentLocation];
  
    self.lbl_type.returnKeyType = UIReturnKeySearch;
    
    [self.view_tableBg setHidden:YES];
    //
    // Do any additional setup after loading the view.
}
# pragma mark - TableView Datasource and Delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tableViewDisplayDataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ResultTableViewCell *cell = (ResultTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"SearchResultTableViewCell"];
    
    NSArray *sortedArray=[[NSArray alloc]init];
    
    
    cell.nameLabel.text = [NSString stringWithFormat:@"%@",[[self.tableViewDisplayDataArray objectAtIndex:indexPath.row ] valueForKey:@"name"]];
    cell.addressLabel.text = [NSString stringWithFormat:@"%@",[[self.tableViewDisplayDataArray objectAtIndex:indexPath.row ] valueForKey:@"vicinity"]];
   
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSData *thumbImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[[self.tableViewDisplayDataArray objectAtIndex:indexPath.row ] valueForKey:@"icon"]]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.thumbImage.image = [UIImage imageWithData:thumbImageData];
        });
    });
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //Restaurant *restaurantObj = (Restaurant *)[self.tableViewDisplayDataArray objectAtIndex:indexPath.row];

   // strPhone=restaurantObj.phoneNumber;
  //  NSLog(@"strPhone%@",strPhone);
    
    self.lbl_restaurent.text=[NSString stringWithFormat:@"%@",[[self.tableViewDisplayDataArray objectAtIndex:indexPath.row ] valueForKey:@"name"]] ;
    
    [self.view_tableBg setHidden:YES];

}

# pragma mark - Textfield Delegate Method and Method to handle Button Touch-up Event

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
        [self.lbl_type resignFirstResponder];
    
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
        [self.lbl_type resignFirstResponder];
}


- (IBAction)TappedOnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)TappedOnActionBtns:(UIButton*)sender
{
    if (sender.tag == 2)
    { //drop down restaurant list...
        if (![sender isSelected]) {
            
            [sender setSelected:YES];
            
            [[AppManager sharedManager]showHUD:@"Loading..."];
            [self.lbl_type resignFirstResponder];
            
            [self webServiceForGetRestaurants];
        }
        else
        {
            [sender setSelected:NO];
            [self.view_tableBg setHidden:YES];
        }
        
        
    }
    else if (sender.tag == 3)
    { // date button
        
        [self.view_picker setHidden:NO];
        self.lbl_pickerTitle.text=@"Select Date";
        
        if (![sender isSelected])
        {
            [self.view_picker setHidden:NO];

            [sender setSelected:YES];
            if (IS_IPHONE_5)
            {
                [self.view_picker setFrame:CGRectMake(24, 234, 272, 174)];
                
            }
            else
            {
                [self.view_picker setFrame:CGRectMake(40, 271, 300, 174)];
                
            }
            
            
            isDate=YES;
            [self.picker_dateAndTime addTarget:self action:@selector(datePickerChanged:) forControlEvents:UIControlEventValueChanged];
            
            self.picker_dateAndTime.datePickerMode=UIDatePickerModeDate;
            [self.picker_dateAndTime setMinimumDate: [NSDate date]];
            
            
        }
        else
        {
            [self.view_picker setHidden:YES];
            [sender setSelected:NO];
        }
        
    }
    else if (sender.tag == 4)
    { // Time button
        
        isDate=NO;
        isBackupTime=NO;
        
        if (![sender isSelected])
        {
            [self.view_picker setHidden:NO];
            [sender setSelected:YES];

            
            self.lbl_pickerTitle.text=@"Select Time";
            
            
            if (IS_IPHONE_5) {
                
                
                [self.view_picker setFrame:CGRectMake(24, 282, 272, 174)];
            }
            else
            {
                [self.view_picker setFrame:CGRectMake(40, 329, 300, 174)];
                
            }
            
            [self.picker_dateAndTime addTarget:self action:@selector(datePickerChanged:) forControlEvents:UIControlEventValueChanged];
            
            self.picker_dateAndTime.datePickerMode=UIDatePickerModeTime;
            [self.picker_dateAndTime setMinimumDate: [NSDate date]];


        }
        else
        {
            [self.view_picker setHidden:YES];
            [sender setSelected:NO];
        }
    }
    else if (sender.tag == 5)
    { // BackUp time button
        
        isDate=NO;
        isBackupTime=YES;
        if (![sender isSelected])
        {
            [self.view_picker setHidden:NO];
            [sender setSelected:YES];
            
            self.lbl_pickerTitle.text=@"Select Backup Time";
            
            if (IS_IPHONE_5) {
                
                
                [self.view_picker setFrame:CGRectMake(24, 335, 272, 174)];
            }
            else
            {
                [self.view_picker setFrame:CGRectMake(40, 390, 300, 174)];
                
            }
            
            [self.picker_dateAndTime addTarget:self action:@selector(datePickerChanged:) forControlEvents:UIControlEventValueChanged];
            
            self.picker_dateAndTime.datePickerMode=UIDatePickerModeTime;
  
        }
        else
        {
            [sender setSelected:NO];
            [self.view_picker setHidden:YES];
        }
        
    }
    else if (sender.tag == 6)
    { // Submit button
        
        if (![self.lbl_type.text isEqualToString:@""] && ![self.lbl_zipCode.text isEqualToString:@""] && ![self.lbl_restaurent.text isEqualToString:@""] && ![self.lbl_date.text isEqualToString:@""] && ![self.lbl_time.text isEqualToString:@""] && ![self.lbl_backUpTime.text isEqualToString:@""])
        {
            [self webServiceForReservation];
        }
        else
        {
            alert(@"Alert!", @"Please fill all mandatory fields");
        }
        
    }
    else if (sender.tag == 7)
    {
        /*
        self.array_restaurantNames=[[NSMutableArray alloc]initWithObjects:@"afghani restaurant",@"african restaurant",@"arabian restaurant",@"austrian restaurant",@"bbq restaurant",@"brazilian restaurant",@"british restaurant",@"combodian restaurant",@"chinese restaurant",@"french restaurant",@"greek restaurant",@"halal restaurant",@"indonesian restaurant",@"italian restaurant",@"japanese restaurant",@"korean restaurant",@"malaysian restaurant",@"mexican restaurant",@"russian restaurant",@"thai restaurant",@"vegitarian restaurant",nil];
        
      // self.array_restaurantNames=[[NSMutableArray alloc]initWithObjects:@"Afghani Restaurant",@"African Restaurant",@"Arabian Restaurant",@"Austrian Restaurant",@"BBQ Restaurant" ,nil];
        
                if(dropDown == nil)
                {
                    CGFloat f = 120;
                    dropDown = [[NIDropDown alloc]showDropDown:self.lbl_type :&f :self.array_restaurantNames :Nil :@"down"];
                    dropDown.delegate = self;
        
                }
                else
                {
                    [dropDown hideDropDown:self.lbl_type];
                    [self rel];
                }

         */
    }
}

- (void)datePickerChanged:(UIDatePicker *)datePicker
{
    if (isDate)
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM-dd-yyyy"];
        NSString *strDate = [dateFormatter stringFromDate:datePicker.date];
        self.lbl_date.text = strDate;
    }
    else
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH:mm"];
        NSString *strDate = [dateFormatter stringFromDate:datePicker.date];
        
        if (!isBackupTime) {
            self.lbl_time.text = strDate;

        }
        else
        {
        self.lbl_backUpTime.text = strDate;
        }
        
    }
    
    
}

// Yelp methods
- (NSString *)getYelpCategoryFromSearchText {
    NSString *categoryFilter;
    
    if ([[self.lbl_type.text componentsSeparatedByString:@" restaurant"] count] > 1) {
        NSCharacterSet *separator = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSArray *trimmedWordArray = [[[self.lbl_type.text componentsSeparatedByString:@"restaurant"] firstObject] componentsSeparatedByCharactersInSet:separator];
        
        if ([trimmedWordArray count] > 2) {
            int objectIndex = (int)[trimmedWordArray count] - 2;
            categoryFilter = [trimmedWordArray objectAtIndex:objectIndex];
        }
        
        else {
            categoryFilter = [trimmedWordArray objectAtIndex:0];
        }
    }
    
    else if (([[self.lbl_type.text componentsSeparatedByString:@" restaurant"] count] <= 1)
             && self.lbl_type.text &&  self.lbl_type.text.length > 0){
        categoryFilter = self.lbl_type.text;
    }
    
    return categoryFilter;
}
/*
- (void)findNearByRestaurantsFromYelpbyCategory:(NSString *)categoryFilter
{
//    if (categoryFilter && categoryFilter.length > 0) {
//        if (([CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied)
//            && self.appDelegate.currentUserLocation &&
//            self.appDelegate.currentUserLocation.coordinate.latitude)
//        {
    
            [self.tableViewDisplayDataArray removeAllObjects];
            [self.resultTableView reloadData];
            
          //  self.messageLabel.text = @"Fetching results..";
         //   self.activityIndicator.hidden = NO;
            
            self.yelpService = [[YelpAPIService alloc] init];
            self.yelpService.delegate = self;
            
            self.searchCriteria = categoryFilter;
            
            // [self.yelpService searchNearByRestaurantsByFilter:[categoryFilter lowercaseString] atLatitude:self.appDelegate.currentUserLocation.coordinate.latitude andLongitude:self.appDelegate.currentUserLocation.coordinate.longitude];//37.77493,-122.419415
            [self.yelpService searchNearByRestaurantsByFilter:[categoryFilter lowercaseString] atLatitude:37.77493 andLongitude:-122.419415];
//        }
//        
//        else {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Location is Disabled"
//                                                            message:@"Enable it in settings and try again"
//                                                           delegate:nil
//                                                  cancelButtonTitle:@"OK"
//                                                  otherButtonTitles:nil];
//            [alert show];
//        }
//    }
}


# pragma mark - Yelp API Delegate Method

-(void)loadResultWithDataArray:(NSArray *)resultArray {
   // self.messageLabel.text = @"Tap on the mic";
   // self.activityIndicator.hidden = YES;
    
    NSLog(@"resultArray %@",resultArray);

    
    if (![resultArray count] == 0)
    {
        
        [self.view_tableBg setHidden:NO];
        
        self.tableViewDisplayDataArray = [resultArray mutableCopy];
        [self.resultTableView reloadData];
        
        [[AppManager sharedManager]hideHUD];
        
        NSLog(@"result Array %@",self.tableViewDisplayDataArray);
    }
    else
    {
        
        alert(@"Alert!", @"No Such Restaurants found,try another.");
        [[AppManager sharedManager]hideHUD];
        [self.view_tableBg setHidden:YES];
        
    }
}


//
 
 */


- (void) niDropDownDelegateMethod: (NIDropDown *) sender
{
    
    
    [self rel];
}

-(void)rel
{
    dropDown = nil;
}

-(void)webServiceForGetRestaurants
{
    

    //Add parameters to send server
    //ttps://maps.googleapis.com/maps/api/place/nearbysearch/json?location=37.77493,-122.419415&radius=200000&types=restaurant&name=Mission%20Chinese%20Food&key=AIzaSyCf2Y62tHUKTJb_lrfckHoyDBKl521a_j8
  //  NSString *strName=[NSString stringWithFormat:@"Nojo Restaurant"];30.7500,76.7800
    
    NSString*  unescaped = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%f,%f&radius=10000&types=restaurant&name=%@&key=AIzaSyCf2Y62tHUKTJb_lrfckHoyDBKl521a_j8",self.appDelegate.currentUserLocation.coordinate.latitude,self.appDelegate.currentUserLocation.coordinate.longitude,self.str_restaurantName];
    
   // NSString*  unescaped = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=37.77493,-122.419415&radius=10000&types=restaurant&name=%@&key=AIzaSyCf2Y62tHUKTJb_lrfckHoyDBKl521a_j8",self.str_restaurantName];
    
    
     unescaped = [unescaped stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
       // Now we can passing this string to NSURL
    
    NSURL *googleRequestURL=[NSURL URLWithString:unescaped];
    NSData* data = [NSData dataWithContentsOfURL:googleRequestURL];
    NSDictionary* json1 = [NSJSONSerialization
                          JSONObjectWithData:data
                          options:kNilOptions
                          error:nil];
    
    self.tableViewDisplayDataArray =[json1 objectForKey:@"results"];
    
    NSLog(@"resutl data %@",self.tableViewDisplayDataArray);
    

    if (![self.tableViewDisplayDataArray count]==0) {
        [[AppManager sharedManager]hideHUD];
        
        [self.view_tableBg setHidden:NO];
        
        [self.resultTableView reloadData];
    }
    else
    {
        [[AppManager sharedManager]hideHUD];

        alert(@"Alert!", @"No Restaurants Found.");
    }
    
    
    
    
}

-(void)webServiceForReservation
{
    //Add parameters to send server
    //ttp://dev414.trigma.us/serv/Webs/customerPostReservation?type=reservation&zip_code=3256452&restaurant=singhresto&date=2015-12-05&time=12:10:10&back_up_time=10:10:10&category_id=1&user_id=12
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:
                                       
                                       @{
                                         
                                         @"type" :self.lbl_type.text,
                                         @"phone" :@"123654",
                                         @"restaurant" :self.lbl_restaurent.text,
                                         @"date" :self.lbl_date.text,
                                         @"time" :self.lbl_time.text,
                                         @"back_up_time" :self.lbl_backUpTime.text,
                                         @"category_id" :@"1",
                                         @"user_id" :[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]
                                         
                                         
                                         
                                         }];
    
    [[AppManager sharedManager] showHUD:@"Loading..."];
    
    [[AppManager sharedManager] getDataForUrl:@"http://dev414.trigma.us/serv/Webs/customerPostReservation?"
     
                                   parameters:parameters
     
                                      success:^(AFHTTPRequestOperation *operation, id responseObject)
     
     {
         
         // Get response from server
         
         NSLog(@"JSON: %@", responseObject);//description
         
         
         // We are making your reserbation. You’ll receive a notification once confirmed.
         
         if([[responseObject objectForKey:@"message"] isEqualToString:@"Reservation Service Successfully Send !!"])
         {
             
             alert(@"We are making your reservation.", @"You’ll receive a notification once confirmed.");
             
             self.lbl_restaurent.text=@"";
             self.lbl_zipCode.text=@"";
             self.lbl_type.text=@"";
             self.lbl_date.text=@"";
             self.lbl_time.text=@"";
             self.lbl_backUpTime.text=@"";
             
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



- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view_picker setHidden:YES];
    
    [self.view_tableBg setHidden:YES];
    
    [self.lbl_type resignFirstResponder];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
