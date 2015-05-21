//
//  RegisterVC.m
//  SERVApp
//
//  Created by Surender Kumar on 23/01/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import "RegisterVC.h"
#import "MFSideMenuContainerViewController.h"
#import "MFSideMenu.h"
#import "AppManager.h"
#import "HeaderFile.h"
#import "HomeVC.h"
#import "Base64.h"
#import "TermsAndPolicyVC.h"

@interface RegisterVC ()

@end

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 150;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.1;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.1;
double animatedDistance;

@implementation RegisterVC

UIImage* imageFromView(UIImage* srcImage, CGRect* rect)
{
    CGImageRef cr = CGImageCreateWithImageInRect(srcImage.CGImage, *rect);
    UIImage* cropped = [UIImage imageWithCGImage:cr];
    
    CGImageRelease(cr);
    return cropped;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    if (IS_IPHONE_5)
    {
        [scrollVW_Register setContentSize:CGSizeMake(320, 720)];

    }
    else
    {
        [scrollVW_Register setContentSize:CGSizeMake(375, 720)];

    }
    
    UIToolbar   *keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(3, 0, self.view.bounds.size.width, 44)];
    [keyboardToolbar setBarStyle:UIBarStyleBlackTranslucent];
    
    UIBarButtonItem *extraSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *next = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(switchToNextField:)];
    
    [keyboardToolbar setItems:[[NSArray alloc] initWithObjects: extraSpace, next, nil]];
    txt_contactNo.inputAccessoryView = keyboardToolbar;
    //for status bar color
    [self setNeedsStatusBarAppearanceUpdate];

}
-(IBAction)switchToNextField:(id)sender
{
   // DLog(@"ffgsdsgfsdgsgsdg");
    [txt_contactNo.inputView removeFromSuperview];
    [txt_contactNo resignFirstResponder];
    //    [self.view endEditing:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [AppManager sharedManager].navCon = self.navigationController;

     [self.menuContainerViewController setPanMode:MFSideMenuPanModeNone];
        
}

- (IBAction)TappedOnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)termsAndPrivacyAction:(id)sender
{
//    alert(@"Alert!", @"Coming Soon...");
//    return;
    
    TermsAndPolicyVC *termAndPolicyView=[self.storyboard instantiateViewControllerWithIdentifier:@"TermsAndPolicyVC"];
    [self.navigationController pushViewController:termAndPolicyView animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)TappedOnAddPhoto:(id)sender {
    
    UIAlertView  *alert = [[UIAlertView alloc] initWithTitle:@"Image Alert" message:@"Please Select one option" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Camera",@"Gallery",nil];
    alert.tag = 1;
    [alert show];
    
}
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
                [self presentModalViewController:ip animated:YES];
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
    self.imageView_profile.image = chosenImage;
    NSLog(@"%@",myimage);
    
    
    
    NSData* data = UIImageJPEGRepresentation(chosenImage, 1.0f);
    [Base64 initialize];
    strEncoded = [Base64 encode:data];
    
    
   // self.imageView_profile.image =myimage ;
    
    self.imageView_profile.layer.cornerRadius = 31;
    
    self.imageView_profile.layer.borderColor=[UIColor clearColor].CGColor;
    
    self.imageView_profile.clipsToBounds=YES;
    
    self.imageView_profile.layer.borderWidth=2;
    
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

- (IBAction)TappedOnTerms:(id)sender
{
    
}

- (IBAction)TappedOnPrivatePolicy:(id)sender
{
    
}

- (IBAction)TappedOnRegister:(id)sender
{
    
//    if(isStringEmpty(txt_name.text) || (txt_userName.text) || (txt_email.text)|| (txt_pswd.text)|| (txt_cnfrmPswd.text)|| (txt_address.text)|| (txt_city.text)|| (txt_state.text)|| (txt_contactNo.text) || (txt_zipcode.text))
//    {
//        
//        alert(@"Alert!", @"Please fill all mandatory fields.");
//        return;
//    }
    if (![txt_name.text isEqualToString:@""] && ![txt_userName.text isEqualToString:@""]&& ![txt_email.text isEqualToString:@""]&& ![txt_pswd.text isEqualToString:@""]&& ![txt_cnfrmPswd.text isEqualToString:@""]&& ![txt_address.text isEqualToString:@""]&& ![txt_city.text isEqualToString:@""]&& ![txt_state.text isEqualToString:@""]&& ![txt_contactNo.text isEqualToString:@""]&& ![txt_zipcode.text isEqualToString:@""])
    {
       
        if (!validateEmailWithString(txt_email.text))
        {
            alert(@"Alert!", @"Please enter valid email");
            return;
        }
        else if (![txt_pswd.text isEqual:txt_cnfrmPswd.text])
        {
            alert(@"Alert!", @"Your Password and confirm Password do not match.");
            return;
        }
        else if (strEncoded == nil)
        {
            alert(@"Alert!", @"Please upload photo.");
            return;
        }
        else if (txt_contactNo.text.length !=10)
        {
            alert(@"Alert!", @"Please enter valid contact number.");
            return;
        }
        else
        {
            [self webServiceSignUp];
        }
    
    
    }
    else
    {
        alert(@"Alert!", @"Please fill all mandatory fields.");
                return;
    }
    
    

}
-(void)webServiceSignUp
{
    //Add parameters to send server
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:
                                       
                                       @{
                                         
                                         @"name"     :txt_name.text,
                                         
                                         @"username"     :txt_userName.text,
                                         
                                         @"email"     :txt_email.text,
                                         
                                         @"image"       :strEncoded,
                                         
                                         @"usertype_id" : @"6",
                                         
                                         @"password"     :txt_pswd.text,
                                         
                                         @"contact"       :txt_contactNo.text,
                                         
                                         @"address"     :txt_address.text,
                                         
                                         @"city"     :txt_city.text,
                                         
                                         @"state"     :txt_state.text,
                                         
                                         @"zip_code"     :txt_zipcode.text,
                                        @"device_token"    :[[NSUserDefaults standardUserDefaults] valueForKey:@"DeviceToken"]
                                         
                                         }];
    
    
    
    [[AppManager sharedManager] showHUD:@"Loading..."];
    
    [[AppManager sharedManager] getDataForUrl:@"http://dev414.trigma.us/serv/Webservices/customersignup?"
     
                                   parameters:parameters
     
                                      success:^(AFHTTPRequestOperation *operation, id responseObject)
     
     {
         
         // Get response from server
         
         NSLog(@"JSON: %@", responseObject);
         
         if([[responseObject objectForKey:@"message"] isEqualToString:@"You have successfully registered as customer"]){
             
             alert(@"Alert", [responseObject objectForKey:@"message"]);
             [[AppManager sharedManager] hideHUD];
             
             
             NSString *strUserID = [responseObject objectForKey:@"user_id"];
             NSLog(@"strUserID: %@", strUserID);
             [[NSUserDefaults standardUserDefaults] setObject:strUserID forKey:@"userID"];

             //[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]
             
             NSString *strUserAddress = [responseObject objectForKey:@"address"];
             NSLog(@"strAddress: %@", strUserAddress);
             [[NSUserDefaults standardUserDefaults] setObject:strUserAddress forKey:@"address"];
             
             NSString *strUserEmail = [responseObject objectForKey:@"email"];
             NSLog(@"strEmail: %@", strUserEmail);
             [[NSUserDefaults standardUserDefaults] setObject:strUserEmail forKey:@"Email"];
             
             
             [[NSNotificationCenter defaultCenter] postNotificationName:@"updateProfile" object:responseObject];
             
             NSString *strUserType = [responseObject objectForKey:@"usertype_id"];
             NSLog(@"strUserType: %@", strUserType);
             [[NSUserDefaults standardUserDefaults] setObject:strUserType forKey:@"usertype_id"];
             
             HomeVC *homeViewContorller=[self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
             [self.navigationController pushViewController:homeViewContorller animated:YES];
             
             return;
         }

         
         if([[responseObject objectForKey:@"message"] isEqualToString:@"Username exist, please try another username"]){
             
             alert(@"Alert", [responseObject objectForKey:@"message"]);
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

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"begin");
    
    CGRect textFieldRect = [self.view.window convertRect:self.view.bounds fromView:self.view];
    CGRect viewRect = [self.view.window convertRect:self.view.bounds fromView:self.view];
    
    CGFloat midline = textFieldRect.origin.y + 3.0 * textFieldRect.size.height;
    CGFloat numerator = midline - viewRect.origin.y - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator = (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION) * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    
    if(heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if(heightFraction > 1.0)
    {
        heightFraction = 0.4;
    }
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    if(orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    else
    {
        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
    
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"textViewDoneEditing");
   // [txt_contactNo    resignFirstResponder];

    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
    
}
-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    } else {
        // Not found, so remove keyboard.
        [textField resignFirstResponder];
    }
    return NO; // We do not want UITextField to insert line-breaks.
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [txt_name    resignFirstResponder];
    [txt_userName    resignFirstResponder];
    [txt_email    resignFirstResponder];
    [txt_pswd    resignFirstResponder];
    [txt_cnfrmPswd    resignFirstResponder];
    [txt_address    resignFirstResponder];
    [txt_city    resignFirstResponder];
    [txt_state    resignFirstResponder];
    [txt_contactNo    resignFirstResponder];
    [txt_zipcode    resignFirstResponder];

    
}

     
@end
