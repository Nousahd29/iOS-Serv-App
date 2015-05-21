//
//  UserProfileDetailVC.m
//  SERVApp
//
//  Created by Noushad Shah on 05/02/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import "UserProfileDetailVC.h"
#import "AppManager.h"
#import "HeaderFile.h"
#import "MFSideMenuContainerViewController.h"
#import "MFSideMenu.h"
#import "Base64.h"


@interface UserProfileDetailVC ()

@end


static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.4;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 250;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;


@implementation UserProfileDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [AppManager sharedManager].navCon = self.navigationController;

    
    
    [self.btn_done setHidden:YES];
   
    
    [self.txt_Name setUserInteractionEnabled:NO];
    [self.txt_userName setUserInteractionEnabled:NO];
    [self.txt_email setUserInteractionEnabled:NO];
    [self.txt_location setUserInteractionEnabled:NO];
    [self.txt_contactNumber setUserInteractionEnabled:NO];
    [self.txtView_address setUserInteractionEnabled:NO];
    
    [self.btn_uploadPhoto setUserInteractionEnabled:NO];
    
    [self webServiceProfileDetail];

    UIToolbar   *keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(3, 0, self.view.bounds.size.width, 44)];
    [keyboardToolbar setBarStyle:UIBarStyleBlackTranslucent];
    
    UIBarButtonItem *extraSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *next = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(switchToNextField:)];
    
    [keyboardToolbar setItems:[[NSArray alloc] initWithObjects: extraSpace, next, nil]];
    self.txt_contactNumber.inputAccessoryView = keyboardToolbar;
    //for status bar color
    [self setNeedsStatusBarAppearanceUpdate];

    // Do any additional setup after loading the view.
}
-(IBAction)switchToNextField:(id)sender
{
    // DLog(@"ffgsdsgfsdgsgsdg");
    [self.txt_contactNumber.inputView removeFromSuperview];
    [self.txt_contactNumber resignFirstResponder];
    //    [self.view endEditing:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
   // [image_servApp setHidden:NO];

}

-(IBAction)tapButtonAction:(UIButton*)sender
{
    if (sender.tag==0)
    {
        [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
    }
    else if (sender.tag==1)
    {//edit btn
        [self.txt_Name setUserInteractionEnabled:YES];
        [self.txt_userName setUserInteractionEnabled:YES];
        [self.txt_location setUserInteractionEnabled:YES];
        [self.txt_contactNumber setUserInteractionEnabled:YES];
        [self.txtView_address setUserInteractionEnabled:YES];

        
        [self.txt_Name becomeFirstResponder];
        [self.btn_done setHidden:NO];

        [self.btn_edit setHidden:YES];
        
        [self.btn_uploadPhoto setUserInteractionEnabled:YES];

    }
    else if (sender.tag==2)
    {//Done Button
        
        [self.txt_Name resignFirstResponder];
        [self.txt_userName resignFirstResponder];
        [self.txt_location resignFirstResponder];
        [self.txt_contactNumber resignFirstResponder];
        
        [self.view endEditing:YES];
        
       // [self webServiceEditUserProfile];
        
        if (![self.txt_Name.text isEqualToString:@""] && ![self.txt_userName.text isEqualToString:@""] && ![self.txt_location.text isEqualToString:@""] && ![self.txt_contactNumber.text isEqualToString:@""] && ![self.txtView_address.text isEqualToString:@""] )
        {
            
            if (self.txt_contactNumber.text.length !=10)
            {
                alert(@"Alert!", @"Please enter valid contact number.");
                return;
            }
            else
            {
                
                [image_servApp setHidden:YES];
                [self.btn_done setHidden:YES];
                [self.btn_edit setHidden:NO];
                
                [self.txt_Name setUserInteractionEnabled:NO];
                [self.txt_userName setUserInteractionEnabled:NO];
                [self.txt_location setUserInteractionEnabled:NO];
                [self.txt_contactNumber setUserInteractionEnabled:NO];
                [self.txtView_address setUserInteractionEnabled:NO];
                
                [self.btn_done setHidden:YES];
                [self.btn_edit setHidden:NO];
                
                [self webServiceEditUserProfile];
            }
        }
        else
        {
            
            alert(@"Alert!", @"Please fill all mandatory fields.");
            return;
            
        }

    }
    else if (sender.tag==3)
    {//upload photo
        
        UIAlertView  *alert = [[UIAlertView alloc] initWithTitle:@"Image Alert" message:@"Please Select one option" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Camera",@"Gallery",nil];
        alert.tag = 1;
        [alert show];
    }
    
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
    self.imageView_users.image = chosenImage;
    NSLog(@"%@",myimage);
    
    
    
    NSData* data = UIImageJPEGRepresentation(chosenImage, 1.0f);
    [Base64 initialize];
    encryptedString = [Base64 encode:data];
    
    
    // self.imageView_profile.image =myimage ;
    
    self.imageView_users.layer.cornerRadius = 51;
    
    self.imageView_users.layer.borderColor=[UIColor clearColor].CGColor;
    
    self.imageView_users.clipsToBounds=YES;
    
    self.imageView_users.layer.borderWidth=2;
    
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
-(void)TakePhotoFromCamera
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:nil];
}

-(void)webServiceEditUserProfile
{
    //Add parameters to send server
    //ttp://dev414.trigma.us/serv/Webservices/profile_edit?id=203&username=lavm2&first_name=lavkush&profile_image=images.png&city=chandigarh&state=punjab&address=sector-18&contact=9546356
    //NSString *UserId = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"UserId"]];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:
                                       @{
                                         
                                         @"id" :[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"],
                                         @"first_name"     :self.txt_Name.text,
                                         
                                         @"username"     :self.txt_userName.text,
                                         
                                         @"profile_image"       :encryptedString,
                                         
                                         
                                         @"contact"       :self.txt_contactNumber.text,
                                         
                                         @"address"     :self.txtView_address.text,
                                         
                                         @"city"     :@"Unkonwn"
                                         
                                         
                                         
                                         
                                         
                                         }];
    
    [[AppManager sharedManager] showHUD:@"Loading..."];
    [[AppManager sharedManager] getDataForUrl:@"http://dev414.trigma.us/serv/Webservices/profile_edit?"
                                   parameters:parameters
                                      success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"JSON: %@", responseObject);//description
         
         [[NSNotificationCenter defaultCenter] postNotificationName:@"updateProfile" object:responseObject];
         
         if ([[responseObject valueForKey:@"message"]isEqualToString:@"The details has been updated"])
         {
             alert(@"Successfully", [responseObject valueForKey:@"message"] );
             [[AppManager sharedManager] hideHUD];
             
             NSString *str_address=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"address"]];
             [[NSUserDefaults standardUserDefaults] setObject:str_address forKey:@"address"];
             
             // Notification fire...
             [[NSNotificationCenter defaultCenter] postNotificationName:@"updateProfile" object:responseObject];
             
             return ;
         }

         [[AppManager sharedManager] hideHUD];
         
         
     }
                                      failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
         [[AppManager sharedManager] showHUD:@"Loading..."];
         alert(@"Error", @"");
     }];
}


-(void)webServiceProfileDetail
{
    //Add parameters to send server
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:
                                       
                                       @{
                                         
                                         @"id" :[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]
                                         
                                         }];
    
    [[AppManager sharedManager] showHUD:@"Loading..."];
    
    [[AppManager sharedManager] getDataForUrl:@"http://dev414.trigma.us/serv/Webservices/myProfile?"
     
                                   parameters:parameters
     
                                      success:^(AFHTTPRequestOperation *operation, id responseObject)
     
     {
         
         // Get response from server
         NSLog(@"JSON: %@", responseObject);//description
         
         NSURL *newImageURL=[NSURL URLWithString:[responseObject objectForKey:@"profile_image"]];
         NSData *imageData=[NSData dataWithContentsOfURL:newImageURL];
         self.imageView_users.image=[UIImage imageWithData:imageData];
         
         self.imageView_users.layer.cornerRadius = 51;
         
         self.imageView_users.layer.borderColor=[UIColor clearColor].CGColor;
         
         self.imageView_users.clipsToBounds=YES;
         
         self.imageView_users.layer.borderWidth=2;
         
         encryptedString = [imageData base64EncodedStringWithOptions:0];


         
         self.txt_Name.text=[responseObject objectForKey:@"name"];
         self.txt_userName.text=[responseObject objectForKey:@"username"];
         self.txt_email.text=[responseObject objectForKey:@"email"];

         self.txtView_address.text=[responseObject objectForKey:@"address"];
        // self.txt_location.text=[responseObject objectForKey:@"city"];
         self.txt_contactNumber.text=[responseObject objectForKey:@"contact"];
         
        // [[NSUserDefaults standardUserDefaults]setObject:self.txtView_address.text forKey:@"address"];
         //[[NSUserDefaults standardUserDefaults] objectForKey:@"address"]
         
         [image_servApp setHidden:YES];
         [[AppManager sharedManager] hideHUD];

     }
     
        failure:^(AFHTTPRequestOperation *operation, NSError *error)
     
     {
         
         NSLog(@"Error: %@", error);
         
         
         alert(@"Error", @"");
         
         [[AppManager sharedManager] hideHUD];

         
     }];
    
}



/*
#pragma mark Action Sheet

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (popup.tag) {
        case 1: {
            switch (buttonIndex)
            {
                case 0:
                    [self getImageFromGallery];
                    break;
                case 1:
                    [self TakePhotoFromCamera];
                    break;
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }
}

#pragma mark Image From gallery
-(void)getImageFromGallery
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.allowsEditing = YES;
    [picker setDelegate:self];
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    CGSize newSize = CGSizeMake(100.0f, 100.0f);
    UIGraphicsBeginImageContext(newSize);
    NSData *imageData = UIImageJPEGRepresentation(chosenImage, 0.2f);
    self.imageView_users.image = chosenImage;
    
    self.imageView_users.layer.cornerRadius = 51;
    
    self.imageView_users.layer.borderColor=[UIColor clearColor].CGColor;
    
    self.imageView_users.clipsToBounds=YES;
    
    self.imageView_users.layer.borderWidth=2;
    
    encryptedString = [imageData base64EncodedStringWithOptions:0];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)TakePhotoFromCamera
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:nil];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
*/
//
//-(BOOL)textFieldShouldReturn:(UITextField*)textField;
//{
////    NSInteger nextTag = textField.tag + 1;
////    // Try to find next responder
////    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
////    if (nextResponder) {
////        // Found next responder, so set it.
////        [nextResponder becomeFirstResponder];
////    } else {
////        // Not found, so remove keyboard.
////        [textField resignFirstResponder];
////    }
//    [textField resignFirstResponder];
//    return YES; // We do not want UITextField to insert line-breaks.
//}
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
//    
//    [self.txt_Name    resignFirstResponder];
//    [self.txt_userName    resignFirstResponder];
//    [self.txtView_address    resignFirstResponder];
//    [self.txt_contactNumber    resignFirstResponder];
//    [self.txt_location    resignFirstResponder];
//    
//}

#pragma mark - touches 
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [currentTextField resignFirstResponder];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    currentTextField =textField;
    
    if  (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    //textField.text=@"";
    
    CGRect textFieldRect;
    CGRect viewRect;
    
    textFieldRect =[self.view.window convertRect:textField.bounds fromView:textField];
    viewRect =[self.view.window convertRect:self.view.bounds fromView:self.view];
    
    
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator = midline - viewRect.origin.y - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator = (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION) * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    
    if (heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0)
    {
        heightFraction = 1.0;
    }
    
    UIInterfaceOrientation orientation =[[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }
    else
    {
        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    
    CGRect viewFrame;
    
    viewFrame= self.view.frame;
    viewFrame.origin.y -= animatedDistance;
    
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
    
    static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
    CGRect viewFrame;
    
    viewFrame= self.view.frame;
    //  viewFrame=[self.view setBackgroundColor:[UIColor whiteColor]];
    viewFrame.origin.y += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
    
    /*
    if (textField == self.txt_ContactNumber) {
        if ([self checkPhoneNo:self.txt_ContactNumber.text])
        {
            
        }else{
            self.txt_ContactNumber.text = @"";
            [UIAlertView showAlertWithTitle:@"Alert!" message:@"Please enter correct Phone number."];
        }
    }
    
    if (textField == self.txt_Password) {
        if ([self checkForPassword:self.txt_Password.text])
        {
            
        }else{
            self.txt_Password.text = @"";
            [UIAlertView showAlertWithTitle:@"Alert!" message:@"Password need to be 6 digit with a minimum 1 number."];
        }
    }
     */
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    
    [theTextField resignFirstResponder];
    [self.view endEditing:YES];

    return YES;
}


//-(BOOL)textFieldShouldReturn:(UITextField*)textField
//{
//    NSInteger nextTag = textField.tag + 1;
//    // Try to find next responder
//    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
//    if (nextResponder) {
//        // Found next responder, so set it.
//        //        if (nextTag == 2) {
//        //            [self.UserName_textfield becomeFirstResponder];
//        //
//        //        }
//        //        else
//        [nextResponder becomeFirstResponder];
//    }
//    else
//    {
//        // Not found, so remove keyboard.
//        [textField resignFirstResponder];
//    }
//    
//    [self.view endEditing:YES];
//
//    return NO; // We do not want UITextField to insert line-breaks.
//}


#define kOFFSET_FOR_KEYBOARD 0.0
////////////////////////////////////////////////////////////////////////////////////keyboard up
-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
