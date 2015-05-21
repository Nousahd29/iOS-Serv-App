//
//  RegisterViewController.m
//  ServApp_provider
//
//  Created by TRun ShRma on 11/02/15.
//  Copyright (c) 2015 Tarun. All rights reserved.
//

#import "RegisterViewController.h"
#import "AppManager.h"
#import "MFSideMenuContainerViewController.h"
#import "MFSideMenu.h"
#import "HomeViewController.h"
#import "CategoryTableViewCell.h"
#import "TermsAndPolicyVC.h"
#import "Base64.h"

@interface RegisterViewController ()
{
    NSMutableArray *array_addedCatogry;
}

@end

@implementation RegisterViewController

- (void)viewDidLoad
{
     [AppManager sharedManager].navCon = self.navigationController;
    
    [self.menuContainerViewController setPanMode:MFSideMenuPanModeNone];
    [super viewDidLoad];
    
    array_addedCatogry=[[NSMutableArray alloc]init];
   self.arr_categoryID =[[NSMutableArray alloc]init];

    
     NSArray *arr_category = [[NSArray alloc]initWithObjects:@"Maid",@"Personal chef",@"Car Wash",@"Driver",@"Groceries",@"Food",@"Shopping",@"Shipping",@"Dry Cleaning", nil];
    
    self.array_categoryList =[[NSMutableArray alloc]init];
    [self.array_categoryList addObjectsFromArray:arr_category];
    
    [self.view_table setHidden:YES];
    
    
    UIToolbar   *keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(3, 0, self.view.bounds.size.width, 44)];
    [keyboardToolbar setBarStyle:UIBarStyleBlackTranslucent];
    
    UIBarButtonItem *extraSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *next = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(switchToNextField:)];
    
    [keyboardToolbar setItems:[[NSArray alloc] initWithObjects: extraSpace, next, nil]];
    _ContactNumber_textfield.inputAccessoryView = keyboardToolbar;
    //for status bar color
    [self setNeedsStatusBarAppearanceUpdate];

    
    // Do any additional setup after loading the view.
}

-(IBAction)switchToNextField:(id)sender
{
    // DLog(@"ffgsdsgfsdgsgsdg");
    [_ContactNumber_textfield.inputView removeFromSuperview];
    [_ContactNumber_textfield resignFirstResponder];
    //    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    [_ScrollView setContentSize:CGSizeMake(320, self.view.frame.size.height+50)];
}


- (IBAction)AddImage_button:(id)sender
{
    UIAlertView  *alert = [[UIAlertView alloc] initWithTitle:@"Image Alert" message:@"Please Select one option" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Camera",@"Gallery",nil];
    alert.tag = 1;
    [alert show];
}

#pragma Upload image functions

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 1)
    {
        if (buttonIndex==1)
        {			{
            
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
                
            {
                {
                    NSArray *media = [UIImagePickerController
                                      availableMediaTypesForSourceType: UIImagePickerControllerSourceTypeCamera];
                    
                    if ([media containsObject:(NSString*)kUTTypeImage] == YES) {
                        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                        //picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
                        [picker setMediaTypes:[NSArray arrayWithObject:(NSString *)kUTTypeImage]];
                        picker.allowsEditing=true;
                        picker.delegate = self;
                        [self presentModalViewController:picker animated:YES];
                        //[picker release];
                        
                    }
                }
            }
            else
            {
                UIAlertView    *alert1 = [[UIAlertView alloc] initWithTitle:@"Camera Alert" message:@"Camera is not Available" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil,nil];
                [alert1 show];
                
            }
        }
        }
        if(buttonIndex ==2)
        {
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
                
                CGRect frame=CGRectMake(300,500, 320, 407);
                UIImagePickerController *ip=[[UIImagePickerController alloc] init];
                ip.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
                
                ip.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
                ip.delegate=self;
                ip.allowsEditing=true;
                pop = [[UIPopoverController alloc] initWithContentViewController:ip];
                pop.delegate=self;
                [pop presentPopoverFromRect:frame inView:self.view
                   permittedArrowDirections:UIPopoverArrowDirectionDown
                                   animated:YES];
                
            }
            else {
                UIImagePickerController *ip=[[UIImagePickerController alloc] init];
                ip.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
                ip.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
                ip.allowsEditing=true;
                ip.delegate=self;
                // [self presentModalViewController:ip animated:YES];
                [self presentViewController:ip animated:YES completion:nil];
            }
            
        }
        
    }
}

#pragma imagePickerDelegats

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    NSString *mediaType = [info valueForKey:UIImagePickerControllerMediaType];
    
    if([mediaType isEqualToString:(NSString*)kUTTypeImage]) {
        UIImage *photoTaken = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            
            //Save Photo to library only if it wasnt already saved i.e. its just been taken
            if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
                UIImageWriteToSavedPhotosAlbum(photoTaken, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
                //  [picker dismissModalViewControllerAnimated:YES];
                [picker dismissViewControllerAnimated:YES completion:nil];
                
            }
            
        }
        else
        {
            
            //[self dismissModalViewControllerAnimated:YES];
            [picker dismissViewControllerAnimated:YES completion:nil];
            
            
            
        }
        
    }
    UIImage *myimage=[info objectForKey: UIImagePickerControllerEditedImage];
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.profilePic.image = chosenImage;
    NSLog(@"%@",myimage);
    
    
    
    NSData* data = UIImageJPEGRepresentation(chosenImage, 1.0f);
    [Base64 initialize];
    encryptedString = [Base64 encode:data];
    
    
    // self.imageView_profile.image =myimage ;
    
    self.profilePic.layer.cornerRadius = 31;
    
    self.profilePic.layer.borderColor=[UIColor clearColor].CGColor;
    
    self.profilePic.clipsToBounds=YES;
    
    self.profilePic.layer.borderWidth=2;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        [pop dismissPopoverAnimated:YES];
    }else
    {
        // [picker dismissModalViewControllerAnimated:YES];
        [picker dismissViewControllerAnimated:YES completion:nil];
        
    }
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    UIAlertView *alert;
    
    if (error) {
        alert = [[UIAlertView alloc] initWithTitle:@"Error!"
                                           message:[error localizedDescription]
                                          delegate:nil
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil];
        [alert show];
    }
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    //  [picker dismissModalViewControllerAnimated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        // Found next responder, so set it.
        if (nextTag == 2) {
            [self.UserName_textfield becomeFirstResponder];

        }
        else
        [nextResponder becomeFirstResponder];
    } else {
        // Not found, so remove keyboard.
        [textField resignFirstResponder];
    }
    return NO; // We do not want UITextField to insert line-breaks.
}



-(void)TakePhotoFromCamera
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:nil];
}


-(void)webServiceForServiceProviderRegistation
{
//Add parameters to send server
    //ttp://dev414.trigma.us/serv/Webservices/EmployerSignup?name=lavkush123&username=lavkush123&category_id=12,10,11,16&email=lavkush.ramtripathi@trigma.in&image=profileimage2.png&password=123456&contact=9041387172&address=chandigarh&city=chandigarh&state=punjab&zip_code=273212&device_token=399692f6be2b07a956d808b2413ec034a44848d094464e8d195923efbbb40a7c
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:
                                       @{
                                         @"name" :self.Name_textfield.text,
                                         @"username" :self.UserName_textfield.text,
                                         @"category_id" :self.str_categoryID,
                                         @"email" :self.Email_textfield.text,
                                         @"image" :encryptedString,
                                         @"password" :self.Password_textfield.text,
                                         @"city" :self.City_textfield.text,
                                         @"state" :self.State_textfield.text,
                                         @"zip_code" :self.ZipCode_textfield.text,
                                         @"contact" :self.ContactNumber_textfield.text,
                                         @"address" :self.Address_textfield.text,
                                         @"device_token" :[[NSUserDefaults standardUserDefaults] valueForKey:@"DeviceToken"]
                                         }];
    
    [[AppManager sharedManager] showHUD:@"Loading..."];
    
     [[NSUserDefaults standardUserDefaults] setValue:_Email_textfield.text forKey:@"emailId"];

     [[AppManager sharedManager] getDataForUrl:@"http://dev414.trigma.us/serv/Webservices/EmployerSignup?"
                                   parameters:parameters
                                    success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         // Get response from server
         NSLog(@"JSON: %@", responseObject);//description
         
         if([[responseObject objectForKey:@"message"] isEqualToString:@"You have successfully registered as Employer"]){
             
             alert(@"Alert", @"You have successfully registered as Service Provider.");
             
             NSString *strUserID = [responseObject objectForKey:@"user_id"];
             NSLog(@"strUserID: %@", strUserID);
             
             [[NSUserDefaults standardUserDefaults] setObject:strUserID forKey:@"userID"];
             
             [[NSNotificationCenter defaultCenter] postNotificationName:@"updateProfile" object:responseObject];
             
             NSString *strUserEmail = [responseObject objectForKey:@"email"];
             NSLog(@"strEmail: %@", strUserEmail);
             [[NSUserDefaults standardUserDefaults] setObject:strUserEmail forKey:@"Email"];
             
             NSString *strUserType = [responseObject objectForKey:@"usertype_id"];
             NSLog(@"strUserType: %@", strUserType);
             [[NSUserDefaults standardUserDefaults] setObject:strUserType forKey:@"usertype_id"];
             
             [[AppManager sharedManager] hideHUD];

             HomeViewController *homeViewContorller=[self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
             [self.navigationController pushViewController:homeViewContorller animated:YES];
             

             return;
         }
         
         if ([[responseObject objectForKey:@"message"] isEqualToString:@"Email id exist, please try another email"]) {
             alert(@"Alert", [responseObject objectForKey:@"message"]);
             [self.Email_textfield becomeFirstResponder];
             
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

- (IBAction)TappedOnRegisterButton:(id)sender
{
    if (![self.Name_textfield.text isEqualToString:@""] && ![self.UserName_textfield.text isEqualToString:@""] && ![self.Category_textfield.text isEqualToString:@""]&& ![self.Password_textfield.text isEqualToString:@""]&& ![self.ConfirmPassword_textfield.text isEqualToString:@""] && ![self.City_textfield.text isEqualToString:@""]&& ![self.State_textfield.text isEqualToString:@""]&& ![self.ZipCode_textfield.text isEqualToString:@""]&& ![self.ContactNumber_textfield.text isEqualToString:@""]&& ![self.Address_textfield.text isEqualToString:@""] && ![self.Email_textfield.text isEqualToString:@""])
    {
        
        if (!validateEmailWithString(self.Email_textfield.text))
        {
            alert(@"Alert!", @"Please enter valid email");
            return;
        }
//        else if (![txt_pswd.text isEqual:txt_cnfrmPswd.text])
//        {
//            alert(@"Alert!", @"Your Password and confirm Password do not match.");
//            return;
//        }
        else if (encryptedString == nil)
        {
            alert(@"Alert!", @"Please upload photo.");
            return;
        }
        else if (self.ContactNumber_textfield.text.length !=10)
        {
            alert(@"Alert!", @"Please enter valid contact number.");
            return;
        }
        else
        {
            [self webServiceForServiceProviderRegistation];
        }
        
        
    }
    else
    {
        alert(@"Alert!", @"Please fill all mandatory fields.");
        return;
    }
    

    
}
- (IBAction)tapped_on_TermsPolicy:(id)sender
{
    TermsAndPolicyVC *termAndPolicyView=[self.storyboard instantiateViewControllerWithIdentifier:@"TermsAndPolicyVC"];
    [self.navigationController pushViewController:termAndPolicyView animated:YES];
}

- (IBAction)tapped_on_back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)TappedOnCategoryDropDown:(id)sender
{
    [self.view_table setHidden:NO];
    
    [self.view endEditing:YES];
    
    
    
}
-(IBAction)tableViewDoneBtn:(UIButton*)sender
{
    if (sender.tag == 1)
    {
        self.Category_textfield.text=self.str_categoryList;
        [self.view_table setHidden:YES];
    }
    else if(sender.tag == 2)
    {
        [self.view_table setHidden:YES];
    }
    
}

#pragma mark - UiTableView Delegate Method

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        return 44;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.array_categoryList count];
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    CategoryTableViewCell *cell = (CategoryTableViewCell *)[self.table_category dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil)
    {
        NSArray *nib;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            nib = [[NSBundle mainBundle] loadNibNamed:@"ReviewsTableViewCell-iPad" owner:self options:nil];
        }
        else
        {
            nib = [[NSBundle mainBundle] loadNibNamed:@"CategoryTableViewCell" owner:self options:nil];
        }
        
        // NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ReviewsTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.backgroundColor=[UIColor clearColor];
        
    }
    
    cell.lbl_categoryName.text=[self.array_categoryList objectAtIndex:indexPath.row];
    
    btnTap=NO;
    
    for (int i=0; i<[array_addedCatogry count]; i++)
    {
        NSString *str_id=[NSString stringWithFormat:@"%@",[self.array_categoryList objectAtIndex:indexPath.row]];
        
        if ([str_id isEqualToString:[array_addedCatogry objectAtIndex:i]])
        {
            btnTap=YES;
            
        }
        
    }

    
    UIButton *btn_fav = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_fav.tag = indexPath.row;
    
    
    [btn_fav addTarget:self action:@selector(AddInYourFavList:) forControlEvents:UIControlEventTouchUpInside];
    
        [btn_fav setBackgroundImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
        [btn_fav setBackgroundImage:[UIImage imageNamed:@"check-icon.png"] forState:UIControlStateSelected];
        
        if (btnTap)
        {
            [btn_fav setBackgroundImage:[UIImage imageNamed:@"check-icon.png"] forState:UIControlStateSelected];
            [btn_fav setSelected:YES];
        }
        else
        {
            [btn_fav setBackgroundImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
            [btn_fav setSelected:NO];
        }
        
        btn_fav.frame = CGRectMake(13,14,20,20);
    
       [cell addSubview:btn_fav];

    
   // }

    
    return cell;
}

-(IBAction)AddInYourFavList:(UIButton *)sender
{
    
    NSInteger favStatus;
    if ([sender isSelected])
    {
        [sender setSelected:NO];
        favStatus = 0;
        
        [array_addedCatogry removeObject:[self.array_categoryList objectAtIndex:sender.tag]];
       // NSLog(@"cat list %@",array_addedCatogry);
        
        if ([[self.array_categoryList objectAtIndex:sender.tag] isEqualToString:@"Reservations"])
        {
            [self.arr_categoryID removeObject:@"1"];
            
        }
        else if ([[self.array_categoryList objectAtIndex:sender.tag] isEqualToString:@"Maid"])
        {
            [self.arr_categoryID removeObject:@"2"];

        }
        else if ([[self.array_categoryList objectAtIndex:sender.tag] isEqualToString:@"Personal chef"])
        {
            [self.arr_categoryID removeObject:@"3"];

        }
        else if ([[self.array_categoryList objectAtIndex:sender.tag] isEqualToString:@"Car Wash"])
        {
            [self.arr_categoryID removeObject:@"4"];

        }
        else if ([[self.array_categoryList objectAtIndex:sender.tag] isEqualToString:@"Driver"])
        {
            [self.arr_categoryID removeObject:@"5"];

        }
        else if ([[self.array_categoryList objectAtIndex:sender.tag] isEqualToString:@"Groceries"])
        {
            [self.arr_categoryID removeObject:@"6"];

        }
        else if ([[self.array_categoryList objectAtIndex:sender.tag] isEqualToString:@"Food"])
        {
            [self.arr_categoryID removeObject:@"7"];

        }
        else if ([[self.array_categoryList objectAtIndex:sender.tag] isEqualToString:@"Spa"])
        {
            [self.arr_categoryID removeObject:@"8"];

        }
        else if ([[self.array_categoryList objectAtIndex:sender.tag] isEqualToString:@"Travel"])
        {
            [self.arr_categoryID removeObject:@"9"];
            
        }
        else if ([[self.array_categoryList objectAtIndex:sender.tag] isEqualToString:@"Shopping"])
        {
            [self.arr_categoryID removeObject:@"10"];
            
        }
        else if ([[self.array_categoryList objectAtIndex:sender.tag] isEqualToString:@"Shipping"])
        {
            [self.arr_categoryID removeObject:@"11"];
            
        }
        else if ([[self.array_categoryList objectAtIndex:sender.tag] isEqualToString:@"Dry Cleaning"])
        {
            [self.arr_categoryID removeObject:@"12"];
            
        }
        
        
    }
    else{
        //call service to add in list TherapistId
        favStatus = 1;
        [sender setSelected:YES];
        
        [array_addedCatogry addObject:[self.array_categoryList objectAtIndex:sender.tag]];
        
        NSLog(@"cat list %@",array_addedCatogry);
        
        //@"Reservations",@"Maid",@"Personal chef",@"Car Wash",@"Food",@"Spa",@"Travel",@"Shopping", nil];
        
        if ([[self.array_categoryList objectAtIndex:sender.tag] isEqualToString:@"Reservations"])
        {
            [self.arr_categoryID addObject:@"1"];

        }
        else if ([[self.array_categoryList objectAtIndex:sender.tag] isEqualToString:@"Maid"])
        {
            [self.arr_categoryID addObject:@"2"];

        }
        else if ([[self.array_categoryList objectAtIndex:sender.tag] isEqualToString:@"Personal chef"])
        {
            [self.arr_categoryID addObject:@"3"];

        }
        else if ([[self.array_categoryList objectAtIndex:sender.tag] isEqualToString:@"Car Wash"])
        {
            [self.arr_categoryID addObject:@"4"];

        }
        else if ([[self.array_categoryList objectAtIndex:sender.tag] isEqualToString:@"Driver"])
        {
            [self.arr_categoryID addObject:@"5"];

        }
        else if ([[self.array_categoryList objectAtIndex:sender.tag] isEqualToString:@"Groceries"])

        {
            [self.arr_categoryID addObject:@"6"];

        }
        else if ([[self.array_categoryList objectAtIndex:sender.tag] isEqualToString:@"Food"])

        {
            [self.arr_categoryID addObject:@"7"];

        }
        else if ([[self.array_categoryList objectAtIndex:sender.tag] isEqualToString:@"Spa"])

        {
            [self.arr_categoryID addObject:@"8"];

        }
        else if ([[self.array_categoryList objectAtIndex:sender.tag] isEqualToString:@"Travel"])

        {
            [self.arr_categoryID addObject:@"9"];
            
        }
        else if ([[self.array_categoryList objectAtIndex:sender.tag] isEqualToString:@"Shopping"])

        {
            [self.arr_categoryID addObject:@"10"];
            
        }
        else if ([[self.array_categoryList objectAtIndex:sender.tag] isEqualToString:@"Shipping"])

        {
            [self.arr_categoryID addObject:@"11"];
            
        }
        else if ([[self.array_categoryList objectAtIndex:sender.tag] isEqualToString:@"Dry Cleaning"])

        {
            [self.arr_categoryID addObject:@"12"];
            
        }

    }
    self.str_categoryList=[array_addedCatogry componentsJoinedByString:@","];
    self.str_categoryID=[self.arr_categoryID componentsJoinedByString:@","];
    
    
    NSLog(@"category list %@",self.str_categoryList);

    NSLog(@"category ID list %@",self.str_categoryID);



}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view_table setHidden:YES];
    
    
    [self.Name_textfield    resignFirstResponder];
    [self.UserName_textfield    resignFirstResponder];
    [self.Email_textfield    resignFirstResponder];
    [self.Password_textfield    resignFirstResponder];
    [self.ConfirmPassword_textfield    resignFirstResponder];
    [self.City_textfield    resignFirstResponder];
    [self.State_textfield    resignFirstResponder];
    [self.ContactNumber_textfield    resignFirstResponder];
    [self.ZipCode_textfield    resignFirstResponder];
    [self.Address_textfield    resignFirstResponder];

}



@end
