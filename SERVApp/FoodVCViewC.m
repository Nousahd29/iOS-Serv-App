//
//  FoodVCViewC.m
//  SERVApp
//
//  Created by Surender Kumar on 24/01/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import "FoodVCViewC.h"
#import "AppManager.h"
#import "HeaderFile.h"
#import "LocationTrackVC.h"
#import "ResultTableViewCell.h"

@interface FoodVCViewC ()

@end

@implementation FoodVCViewC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [AppManager sharedManager].navCon = self.navigationController;
    
    [self.txtView_foodItems setText:@"Type here what you want"];
    self.txtView_foodItems.textColor = [UIColor lightGrayColor];
    
    arr_dropDwonItems2=[[NSMutableArray alloc]init];
    
    isTouched=YES;

    //Yelp
    
    if (!self.tableViewDisplayDataArray)
    {
        self.tableViewDisplayDataArray = [[NSMutableArray alloc] init];
    }
    
    self.appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [self.appDelegate updateCurrentLocation];
    
    self.txtField_zipCode.returnKeyType = UIReturnKeySearch;
    
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
   // Restaurant *restaurantObj = (Restaurant *)[self.tableViewDisplayDataArray objectAtIndex:indexPath.row];
    
    //    if (restaurantObj.yelpURL) {
    //        UIApplication *app = [UIApplication sharedApplication];
    //        [app openURL:[NSURL URLWithString:restaurantObj.yelpURL]];
    //    }
    
    self.txtField_selectedRestaurent.text=[NSString stringWithFormat:@"%@",[[self.tableViewDisplayDataArray objectAtIndex:indexPath.row ] valueForKey:@"name"]] ;
    
    [self.view_tableBg setHidden:YES];
    
}

# pragma mark - Textfield Delegate Method and Method to handle Button Touch-up Event

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    // if ([self.searchTextField isFirstResponder]) {
    [self.txtField_zipCode resignFirstResponder];
    [self.txtView_foodItems resignFirstResponder];
    // }
    
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // if ([self.searchTextField isFirstResponder]) {
    [self.txtField_zipCode resignFirstResponder];
    // }
}
// Yelp methods
- (NSString *)getYelpCategoryFromSearchText {
    NSString *categoryFilter;
    
    if ([[self.txtField_zipCode.text componentsSeparatedByString:@" restaurant"] count] > 1) {
        NSCharacterSet *separator = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSArray *trimmedWordArray = [[[self.txtField_zipCode.text componentsSeparatedByString:@"restaurant"] firstObject] componentsSeparatedByCharactersInSet:separator];
        
        if ([trimmedWordArray count] > 2) {
            int objectIndex = (int)[trimmedWordArray count] - 2;
            categoryFilter = [trimmedWordArray objectAtIndex:objectIndex];
        }
        
        else {
            categoryFilter = [trimmedWordArray objectAtIndex:0];
        }
    }
    
    else if (([[self.txtField_zipCode.text componentsSeparatedByString:@" restaurant"] count] <= 1)
             && self.txtField_zipCode.text &&  self.txtField_zipCode.text.length > 0){
        categoryFilter = self.txtField_zipCode.text;
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
    
     [self.yelpService searchNearByRestaurantsByFilter:[categoryFilter lowercaseString] atLatitude:self.appDelegate.currentUserLocation.coordinate.latitude andLongitude:self.appDelegate.currentUserLocation.coordinate.longitude];//37.77493,-122.419415
   // [self.yelpService searchNearByRestaurantsByFilter:[categoryFilter lowercaseString] atLatitude:37.77493 andLongitude:-122.419415];
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
  //  NSLog(@"result Array %@",self.tableViewDisplayDataArray);

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

- (IBAction)TappedOnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)TappedOnSubmitBtn:(id)sender
{
    [self.txtField_zipCode resignFirstResponder];
    [self.txtView_foodItems resignFirstResponder];


    if (![self.txtField_address.text isEqualToString:@""] && ![self.txtField_zipCode.text isEqualToString:@""] && ![self.txtField_selectedRestaurent.text isEqualToString:@""] && ![self.txtView_foodItems.text isEqualToString:@"Type here what you want"])
    {
       
        [self webServiceForFood];
        
    }
    else
    {
        alert(@"Alert!", @"Fill all fields are mandatory");
        
        return;
    }
}
-(void)webServiceForFood
{
    //Add parameters to send server
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:
                                       
                                       @{
                                         
                                         @"address" :self.txtField_address.text,
                                         @"phone" :@"123654789",
                                         @"type"  :self.txtField_zipCode.text,
                                         @"restaurant" :self.txtField_selectedRestaurent.text,
                                         @"description" :self.txtView_foodItems,
                                         @"category_id" :@"7",
                                         @"user_id" :[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]
                                         
                                         }];
    
    [[AppManager sharedManager] showHUD:@"Loading..."];
    
    [[AppManager sharedManager] getDataForUrl:@"http://dev414.trigma.us/serv/Webs/customerPostFood?"
     
                                   parameters:parameters
     
                                      success:^(AFHTTPRequestOperation *operation, id responseObject)
     
     {
         
         // Get response from server
         
         NSLog(@"JSON: %@", responseObject);//description
         
         
         str_customerServId=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"customer_servid"]];

         
         if([[responseObject objectForKey:@"message"] isEqualToString:@"Successfully Saved !!!!"])
         {
             [[AppManager sharedManager] hideHUD];
             
             alert(@"Alert", [responseObject objectForKey:@"message"]);
             
             self.txtField_address.text=@"";
             self.txtField_selectedRestaurent.text=@"";
             self.txtField_zipCode.text=@"";
             self.txtView_foodItems.text=@"Type here what you want";
             self.txtView_foodItems.textColor = [UIColor lightGrayColor];

             [self webServiceServiceAvailability];
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
-(void)webServiceServiceAvailability
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:
                                       
                                       @{
                                         
                                         @"service_id" :str_customerServId
                                         
                                         
                                         }];
    
    [[AppManager sharedManager] showHUD:@"Please wait,we are searching for a Food."];
    
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
             
             
             
             
             [[AppManager sharedManager] hideHUD];
             
             return ;
             
         }
         else
         {
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




-(IBAction)TappedOnActionBtns:(UIButton*)sender
{
    if (sender.tag==1) {
        
        [self.txtField_zipCode resignFirstResponder];

        arr_dropDwonItems=[[NSMutableArray alloc]initWithObjects:[[NSUserDefaults standardUserDefaults] objectForKey:@"address"] ,nil];
        
        if(dropDown == nil)
        {
            CGFloat f = 120;
            dropDown = [[NIDropDown alloc]showDropDown:self.txtField_address :&f :arr_dropDwonItems :Nil :@"down"];
            dropDown.delegate = self;
            
        }
        else
        {
            [dropDown hideDropDown:self.txtField_address];
            [self rel];
        }
        
        

    }
    else if (sender.tag==2)
    {
        
        //Tapped onselect your restaurants btn.
        
        [self.txtField_zipCode resignFirstResponder];
        [self.txtView_foodItems resignFirstResponder];

        
        if (![sender isSelected]) {
            
            [sender setSelected:YES];
            
            [[AppManager sharedManager]showHUD:@"Loading..."];
            //[self.lbl_type resignFirstResponder];
            
            [self webServiceForGetRestaurants];
        }
        else
        {
            [sender setSelected:NO];
            [self.view_tableBg setHidden:YES];
        }
/*
        
        if (isTouched)
        {
            
            if (![self.txtField_zipCode.text isEqualToString:@""])
            {
                [[AppManager sharedManager] showHUD:@"Loading..."];
                
//                dispatch_async(GCDBackgroundThread, ^{
//                    
//                    [self webServiceForGetRestaurants];
//                    
//                    
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        
//                        
//                        [[AppManager sharedManager]  hideHUD];
//                        
//                        if(dropDown == nil)
//                        {
//                            
//                            CGFloat f = 120;
//                            dropDown = [[NIDropDown alloc]showDropDown:self.txtField_selectedRestaurent :&f :arr_dropDwonItems2 :Nil :@"down"];
//                            dropDown.delegate = self;
//                            
//                            // isTouched=NO;
//                            isTouched=NO;
//                            
//                        }
//                        else
//                        {
//                            [dropDown hideDropDown:self.txtField_selectedRestaurent];
//                            [self rel];
//                            isTouched=YES;
//                            
//                        }
//                        
//                    });
//                });
                
                NSString *yelpCategoryFilter = [self getYelpCategoryFromSearchText];
                
                // This will find nearby restaurants by category
                [self findNearByRestaurantsFromYelpbyCategory:yelpCategoryFilter];


            }
            else
            {
                alert(@"Alert!", @"Please select Restaurant type.");
            }
 
            
        }
        else
        {
            
            [dropDown hideDropDown:self.txtField_selectedRestaurent];
            [self rel];
            isTouched=YES;
            
        }
        
*/
            
    }
    else if (sender.tag == 3)
    {
        /*
        self.array_restaurantNames=[[NSMutableArray alloc]initWithObjects:@"afghani restaurant",@"african restaurant",@"arabian restaurant",@"austrian restaurant",@"bbq restaurant",@"brazilian restaurant",@"british restaurant",@"combodian restaurant",@"chinese restaurant",@"french restaurant",@"greek restaurant",@"halal restaurant",@"indonesian restaurant",@"italian restaurant",@"japanese restaurant",@"korean restaurant",@"malaysian restaurant",@"mexican restaurant",@"russian restaurant",@"thai restaurant",@"vegitarian restaurant",nil];
        
        // self.array_restaurantNames=[[NSMutableArray alloc]initWithObjects:@"Afghani Restaurant",@"African Restaurant",@"Arabian Restaurant",@"Austrian Restaurant",@"BBQ Restaurant" ,nil];
        
        if(dropDown == nil)
        {
            CGFloat f = 120;
            dropDown = [[NIDropDown alloc]showDropDown:self.txtField_zipCode :&f :self.array_restaurantNames :Nil :@"down"];
            dropDown.delegate = self;
            
        }
        else
        {
            [dropDown hideDropDown:self.txtField_zipCode];
            [self rel];
        }
         */

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


-(void)webServiceForGetRestaurants
{
    
    
    //Add parameters to send server
    //ttps://maps.googleapis.com/maps/api/place/nearbysearch/json?location=37.77493,-122.419415&radius=200000&types=restaurant&name=Mission%20Chinese%20Food&key=AIzaSyCf2Y62tHUKTJb_lrfckHoyDBKl521a_j8
    //  NSString *strName=[NSString stringWithFormat:@"Nojo Restaurant"];
    
    NSString*  unescaped = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%f,%f&radius=10000&types=food&name=&key=AIzaSyCf2Y62tHUKTJb_lrfckHoyDBKl521a_j8",self.appDelegate.currentUserLocation.coordinate.latitude,self.appDelegate.currentUserLocation.coordinate.longitude];
    
    
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


//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    [textField resignFirstResponder];
//    
//    return YES;
//}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    
//    [[AppManager sharedManager] showHUD];
//    
//    dispatch_async(GCDBackgroundThread, ^{
//        
//        [self webServiceForGetRestaurants];
//        
//        
//        
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            
//            [[AppManager sharedManager]  hideHUD];
//        });
//    });

    
    return YES;
    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.txtField_zipCode resignFirstResponder];
    [self.txtView_foodItems resignFirstResponder];
    [self.view_tableBg setHidden:YES];
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if(self.txtView_foodItems.tag == 0)
    {
        self.txtView_foodItems.text = @"";
        self.txtView_foodItems.textColor = [UIColor blackColor];
        self.txtView_foodItems.tag = 1;
    }
    return YES;
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    
    NSLog(@"textViewDoneEditing");
    if([self.txtView_foodItems.text length] == 0)
    {
         self.txtView_foodItems.text = @"Type here what you want";
          self.txtView_foodItems.textColor = [UIColor lightGrayColor];
        self.txtView_foodItems.tag = 0;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
