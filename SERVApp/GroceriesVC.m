//
//  GroceriesVC.m
//  SERVApp
//
//  Created by Surender Kumar on 24/01/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import "GroceriesVC.h"
#import "GroceriesCell.h"
#import "AppManager.h"
#import "MarqueeLabel.h"
#import "UIImageView+WebCache.h"
#import "NIDropDown.h"
#import "LocationTrackVC.h"
#import "ResultTableViewCell.h"

@interface GroceriesVC ()
{
    NSMutableArray *array_addedList;
    NSString *str_itemsNameList;
    NSMutableArray *array_storeList;
    NSString *str_storeID;
    int minus;
    

}
@end

@implementation GroceriesVC
@synthesize str_index;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    [AppManager sharedManager].navCon = self.navigationController;
    
    self.appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [self.appDelegate updateCurrentLocation];
    
    [self.view_tableBg setHidden:YES];

     array_list=[[NSMutableArray alloc]init];
      array_addedList=[[NSMutableArray alloc]init];
    
    Arr_image=[[NSMutableArray alloc]init];
    Arr_image =[[NSMutableArray alloc]init];
    [Arr_image  addObject:[UIImage imageNamed:@"add-img-01"]];
    [Arr_image  addObject:[UIImage imageNamed:@"add-img-02"]];
    [Arr_image  addObject:[UIImage imageNamed:@"add-img-03"]];
    
    [self webServiceSearchGroceriesStores];
    
    
    // Do any additional setup after loading the view.
}

- (IBAction)TappedOnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)TappedActionBtns:(UIButton*)sender
{
    if (sender.tag == 1)
    {
        // Search button
        isSelectGroceryBtnTapped=NO;

        if (![self.txt_stores.text isEqualToString:@""])
        {
            if (![self.txt_itemSearch.text isEqualToString:@""])
            {
                [self.txt_itemSearch resignFirstResponder];
                [self webServiceSearchGroceries];
            }
            else
            {
                alert(@"Alert!",@"Please fill search item name");
            }
 
            
        }
        else
        {
            alert(@"Alert!",@"Please select Grocery store.");

        }
    }
    else if (sender.tag == 2)
    {// Submit Button
        
        if (![self.txt_zipCode.text isEqualToString:@""])
        {
            
            if (str_itemsNameList == nil )
            {
                alert(@"Alert!", @"No item added...");
                return;


            }
            else if ([array_addedList count]==0)
            {
                alert(@"Alert!", @"No item added.");
                return;
            }
            else
            {
                [self webServiceForSubmit];
            }
        }
        else
        {
            alert(@"Alert!", @"Please fill Zip Code...");
            return;

        }
        
    }
    else if (sender.tag == 3)
    { //Select  groceries store
        
        [self.txt_itemSearch resignFirstResponder];
        if (![sender isSelected]) {
            
            [sender setSelected:YES];
            
            isSelectGroceryBtnTapped=YES;
            
            [[AppManager sharedManager]showHUD:@"Loading..."];
            //[self.lbl_type resignFirstResponder];
            
            [self webServiceForGetStores];
        }
        else
        {
            [sender setSelected:NO];
            [self.view_tableBg setHidden:YES];
        }

        
        
//        [self.txt_zipCode resignFirstResponder];
//        
//        if (![self.txt_zipCode.text isEqualToString:@""])
//        {
//            [self webServiceSearchGroceriesStores];
//            self.txt_stores.text=@"";
//
//        }
//        
//        else
//        {
//            alert(@"Alert!", @"Please fill zip-code.");
//            return;
//        }
        
        
    }
    
}

-(void)webServiceForGetStores
{
    
    
    //Add parameters to send server
    //ttps://maps.googleapis.com/maps/api/place/nearbysearch/json?location=37.77493,-122.419415&radius=200000&types=restaurant&name=Mission%20Chinese%20Food&key=AIzaSyCf2Y62tHUKTJb_lrfckHoyDBKl521a_j8
    //  NSString *strName=[NSString stringWithFormat:@"Nojo Restaurant"];
    
   // NSString*  unescaped = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%f,%f&radius=10000&types=grocery_or_supermarket&name=&key=AIzaSyCf2Y62tHUKTJb_lrfckHoyDBKl521a_j8",self.appDelegate.currentUserLocation.coordinate.latitude,self.appDelegate.currentUserLocation.coordinate.longitude];
    
    NSString*  unescaped = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=37.77493,-122.419415&radius=10000&types=grocery_or_supermarket&name=&key=AIzaSyCf2Y62tHUKTJb_lrfckHoyDBKl521a_j8"];
    
    
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
    
    //     if (IS_IPHONE_5)
    //     {
    //         [self.view_tableBg setFrame:CGRectMake(20, 181, 280, 307)];
    //     }
    //    else
    //    {
    //        [self.view_tableBg setFrame:CGRectMake(25, 200, 300, 307)];
    //
    //    }
    
    if (![self.tableViewDisplayDataArray count]==0) {
        [[AppManager sharedManager]hideHUD];
        
        [self.view_tableBg setHidden:NO];
        
        [self.resultTableView reloadData];
    }
    else
    {
        [[AppManager sharedManager]hideHUD];
        
        alert(@"Alert!", @"No Grocery Store Found.");
    }

    
    
}


-(void)webServiceSearchGroceriesStores
{
    //Add parameters to send server
    
    //ttp://dev414.trigma.us/serv/Webservices/getStoreByZipCode?zip_code=95130
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:
                                       
                                       @{
                                         
                                         @"zip_code" :@"95130"
                                         
                                         }];
    
    [[AppManager sharedManager] showHUD:@"Loading..."];
    
    [[AppManager sharedManager] getDataForUrl:@"http://dev414.trigma.us/serv/Webservices/getStoreByZipCode?"
     
                                   parameters:parameters
     
                                      success:^(AFHTTPRequestOperation *operation, id responseObject)
     
     {
         
         // Get response from server
         NSLog(@"JSON: %@", responseObject);//description
         
         array_storeList=[[responseObject objectForKey:@"StoreList"] valueForKey:@"Store"];
         NSLog(@"store list %@",array_storeList);
         
        // self.txt_stores.text=[NSString stringWithFormat:@"%@",[[array_storeList objectAtIndex:0] valueForKey:@"storename"]];
         
         str_storeID=[NSString stringWithFormat:@"%@",[[array_storeList objectAtIndex:0]valueForKey:@"storeId"]];

         
//         if(dropDown == nil)
//         {
//             CGFloat f = 120;
//             dropDown = [[NIDropDown alloc]showDropDown:self.txt_stores :&f :[array_storeList valueForKey:@"storename"] :Nil :@"down"];
//             dropDown.delegate = self;
//             
//         }
//         else
//         {
//             [dropDown hideDropDown:self.txt_stores];
//             [self rel];
//         }

         
         [[AppManager sharedManager] hideHUD];
         
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

    int i =[[[NSUserDefaults standardUserDefaults]objectForKey:@"indexValue"] intValue];
    
    NSLog(@"indexPath %d",i);

      str_storeID=[NSString stringWithFormat:@"%@",[[array_storeList objectAtIndex:i]valueForKey:@"storeId"]];
       NSLog(@"storeID %@",str_storeID);
    
    
}

-(void)rel
{
    dropDown = nil;
}



-(void)webServiceForSubmit
{
    //Add parameters to send server
    
    //ttp://dev414.trigma.us/serv/Webs/customerPostGrocerie?zip_code=654232&items=item1,item2,item3&category_id=7&user_id=263
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:
                                       
                                       @{
                                         
                                         @"user_id" :[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"] ,
                                         @"category_id" :@"6",
                                         @"zip_code" :self.txt_stores.text,
                                         @"items" :str_itemsNameList
                                         
                                         }];
    
    [[AppManager sharedManager] showHUD:@"Loading..."];
    
    [[AppManager sharedManager] getDataForUrl:@"http://dev414.trigma.us/serv/Webs/customerPostGrocerie?"
     
                                   parameters:parameters
     
                                      success:^(AFHTTPRequestOperation *operation, id responseObject)
     
     {
         
         // Get response from server
         NSLog(@"JSON: %@", responseObject);//description
         
         str_customerServId=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"customer_servid"]];

         if ([[responseObject valueForKey:@"message"]isEqualToString:@"Grocerie Successfully Saved !!!!"])
         {
           //  alert(@"Success", @"Groceries successfully submitted.");
             
             [[AppManager sharedManager] hideHUD];
           //  self.txt_zipCode.text=@"";
           //  self.txt_stores.text=@"";
           //  self.txt_itemSearch.text=@"";
             
            // [array_addedList removeAllObjects];
             
             [[AppManager sharedManager] hideHUD];
             
             [self webServiceServiceAvailability];


             return ;
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
    
    [[AppManager sharedManager] showHUD:@"Please wait,we are searching for a Groceries."];
    
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


-(void)webServiceSearchGroceries
{
    //Add parameters to send server
    
   //ttp://dev414.trigma.us/serv/Webservices/getGroceries?StoreId=dee493ba24&ItemName=Mango
    
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:
                                       
                                       @{
                                         
                                         @"StoreId" :str_storeID,
                                         @"ItemName" :self.txt_itemSearch.text,

                                         
                                         }];
    
    [[AppManager sharedManager] showHUD:@"Loading..."];
    
    [[AppManager sharedManager] getDataForUrl:@"http://dev414.trigma.us/serv/Webservices/getGroceries?"
     
                                   parameters:parameters
     
                                      success:^(AFHTTPRequestOperation *operation, id responseObject)
     
     {
         
         // Get response from server
         NSLog(@"JSON: %@", responseObject);//description
         
         //         array_list=[[[responseObject objectForKey:@"ItemList"] valueForKey:@"Item"] valueForKey:@"Itemname"];

         array_list=[responseObject objectForKey:@"ItemList"];
         
         
         NSLog(@"ItemName list: %@", array_list);//description  msg = "Item not found.";
         
         if ([[responseObject valueForKey:@"msg"]isEqualToString:@"Item not found."])
         {
             alert(@"Alert!", [responseObject valueForKey:@"msg"]);
             [[AppManager sharedManager] hideHUD];

             return ;
         }

         
         [tableVW_groceries reloadData];
         
         [[AppManager sharedManager] hideHUD];
         
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
    [self.txt_itemSearch resignFirstResponder];
    [btn_selectRestaurants setSelected:NO];
    [self.view_tableBg setHidden:YES];
}


#pragma mark --TableView Delegate--
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isSelectGroceryBtnTapped)
    {
        return [self.tableViewDisplayDataArray count];
    }
    else
    return [array_list count];    //count number of row from counting array hear cataGorry is An Array
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 78;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Similar to UITableViewCell, but
    
    if (isSelectGroceryBtnTapped)
    {
        ResultTableViewCell *cell2 = (ResultTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"SearchResultTableViewCell"];
        
        cell2.nameLabel.text = [NSString stringWithFormat:@"%@",[[self.tableViewDisplayDataArray objectAtIndex:indexPath.row ] valueForKey:@"name"]];
        cell2.addressLabel.text = [NSString stringWithFormat:@"%@",[[self.tableViewDisplayDataArray objectAtIndex:indexPath.row ] valueForKey:@"vicinity"]];
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            NSData *thumbImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[[self.tableViewDisplayDataArray objectAtIndex:indexPath.row ] valueForKey:@"icon"]]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                cell2.thumbImage.image = [UIImage imageWithData:thumbImageData];
            });
        });
        
        return cell2;

    }
    else
    {
        [tableView setSeparatorColor:[UIColor clearColor]];
        static NSString *CellIdentifier = @"CellIdentifier";
        GroceriesCell *cell=[tableVW_groceries dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            
            cell = [[GroceriesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
            
            NSArray *topLevelObjects;
            if (IS_IPHONE_5)
            {
                topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"GroceriesCell" owner:cell options:nil];
            }
            else
            {
                topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"GroceriesCell-iPhone6" owner:cell options:nil];
                
            }
            
            cell=[topLevelObjects objectAtIndex:0];
            cell.selectionStyle=UITableViewCellAccessoryNone;
            
            
            cell.lbl_itemName.text=[[[array_list objectAtIndex:indexPath.row]objectForKey:@"Item"]valueForKey:@"Itemname"];
            
            cell.lbl_itemName.marqueeType = MLContinuous;
            cell.lbl_itemName.scrollDuration = 15.0;
            cell.lbl_itemName.animationCurve = UIViewAnimationOptionCurveEaseInOut;
            cell.lbl_itemName.fadeLength = 10.0f;
            cell.lbl_itemName.continuousMarqueeExtraBuffer = 10.0f;
            // self.lbl_location.text = OuestionString;
            cell.lbl_itemName.tag = 101;
            
            cell.lbl_itemPrice.text=[[[array_list objectAtIndex:indexPath.row]objectForKey:@"Item"]valueForKey:@"Pricing"];
            
            
            UIImageView *imageView;
            if (IS_IPHONE_6)
            {
                imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,27 , 39)];
                
            }
            else
            {
                imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,26 , 38)];
                
            }
            
            imageView.contentMode=UIViewContentModeScaleAspectFit;
            
            
            NSURL *newImageURL=[NSURL URLWithString:[[[array_list objectAtIndex:indexPath.row] valueForKey:@"Item"] valueForKey:@"ItemImage"]];
            // [self loadImageFromURL:newImageURL];
            [imageView setImageWithURL:newImageURL placeholderImage:[UIImage imageNamed:@"product-empty.png"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            }];
            
            // cell.img_Entertainer.contentMode = UIViewContentModeScaleAspectFit;
            
            [cell.imageView_item addSubview:imageView];
            
            
            
            
            //        UIButton *btn_fav;
            UIButton *btn_fav = [UIButton buttonWithType:UIButtonTypeCustom];
            
            btn_fav.tag = indexPath.row;
            [btn_fav addTarget:self action:@selector(AddItemList:) forControlEvents:UIControlEventTouchUpInside];
            // [cell addSubview:btn_fav];
            [btn_fav setBackgroundImage:[UIImage imageNamed:@"add-btn.png"] forState:UIControlStateNormal];
            [btn_fav setBackgroundImage:[UIImage imageNamed:@"remove-btn.png"] forState:UIControlStateSelected];
            
            
            if (IS_IPHONE_6)
            {
                
                btn_fav.frame = CGRectMake(312, 41, 43, 22);
                
                
            }
            else
            {
                // [btn_fav setBackgroundImage:[UIImage imageNamed:@"add-btn.png"] forState:UIControlStateNormal];
                // [btn_fav setBackgroundImage:[UIImage imageNamed:@"remove-btn.png"] forState:UIControlStateSelected];
                //
                
                btn_fav.frame = CGRectMake(253, 41, 43, 22);
            }
            
            
            if ([array_addedList containsObject:cell.lbl_itemName.text])
            {
                [btn_fav setSelected:YES];
            }
            else
                [btn_fav setSelected:NO];
            
            
            //}
            [cell addSubview:btn_fav];
            
            
        }

          return cell;
    }
}


-(IBAction)AddItemList:(UIButton *)sender
{
 
////    UIButton *Btn = (UIButton *)sender;
////    NSLog(@"Btn tag %li",(long)Btn.tag);
//    [(UIButton *)[self.view viewWithTag:sender.tag] setBackgroundImage:[UIImage imageNamed:@"remove-btn.png"] forState:UIControlStateSelected];
////    [Btn setBackgroundImage:[UIImage imageNamed:@"remove-btn.png"] forState:UIControlStateSelected];
//    [addOrRemove replaceObjectAtIndex:sender.tag withObject:@"Remove"];
    
    
    
    if ([sender isSelected]) {
        [sender setSelected:NO];
 
        NSLog(@"string Array %@",array_addedList);
      //  NSLog(@"string array %@", [[[array_list objectAtIndex:sender.tag] objectForKey:@"Item"] valueForKey:@"Itemname"]);
        
       // NSString *str_itemNameList = [NSString stringWithFormat:@"%@",[[[array_list objectAtIndex:sender.tag] objectForKey:@"Item"] valueForKey:@"Itemname"]];
        
        [array_addedList removeObject:[[[array_list objectAtIndex:sender.tag] objectForKey:@"Item"] valueForKey:@"Itemname"]];
        NSLog(@"removed array list %@",array_addedList);

        
    }
    else{
        //call service to add in list TherapistId
      //  favStatus = 1;
        
        
                [sender setSelected:YES];
               
     //   NSString *str_itemNameList=[NSString stringWithFormat:@"%@",[[[array_list objectAtIndex:sender.tag] objectForKey:@"Item"] valueForKey:@"Itemname"]];
        
        
        
        [array_addedList addObject:[[[array_list objectAtIndex:sender.tag] objectForKey:@"Item"] valueForKey:@"Itemname"]];
        // NSLog(@"addedList %@",array_addedList);
        
        str_itemsNameList=[array_addedList componentsJoinedByString:@","];
        NSLog(@"string %@",str_itemsNameList);
        NSLog(@"added list%@",array_addedList);

        
    }

    
    [tableVW_groceries reloadData];

  
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isSelectGroceryBtnTapped) {
        self.txt_stores.text=[NSString stringWithFormat:@"%@",[[self.tableViewDisplayDataArray objectAtIndex:indexPath.row ] valueForKey:@"name"]] ;
        
        [btn_selectRestaurants setSelected:NO];
        [self.view_tableBg setHidden:YES];
    }
    else
    {
        
    }
//    NotificationDetailVC *NotificatinDtailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationDetail"];
//    [self.navigationController pushViewController:NotificatinDtailVC animated:YES];
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
