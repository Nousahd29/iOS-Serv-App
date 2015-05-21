//
//  ProfileViewController.m
//  ServApp_provider
//
//  Created by TRun ShRma on 12/02/15.
//  Copyright (c) 2015 Tarun. All rights reserved.
//

#import "ProfileViewController.h"
#import "MFSideMenu.h"
#import "SideMenuViewController.h"
#import "AppManager.h"
#import "Base64.h"

@interface ProfileViewController ()

@end

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.4;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 250;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

@implementation ProfileViewController

- (void)viewDidLoad {
    [AppManager sharedManager].navCon = self.navigationController;

    
    [self.menuContainerViewController setPanMode:MFSideMenuPanModeDefault];
    [super viewDidLoad];
    
    [self.btn_done setHidden:YES];
    
    [self.btn_uploadPhoto setUserInteractionEnabled:NO];
    // Do any additional setup after loading the view.
    
    [self  webServiceGetUserProfile];

}


-(void)viewDidAppear:(BOOL)animated
{
    [_Email_TextField setUserInteractionEnabled:NO];
    [_City_TextField setUserInteractionEnabled:NO];
    [_Address_TextField setUserInteractionEnabled:NO];
    [_State_TextField setUserInteractionEnabled:NO];
    [_ContactNumber_TextField setUserInteractionEnabled:NO];
    [_userName_label setUserInteractionEnabled:NO];
    [self.name_label setUserInteractionEnabled:NO];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)webServiceGetUserProfile
{
    //Add parameters to send server
    // http://dev414.trigma.us/serv/Webservices/EmployerProfile?id=203
    //NSString *UserId = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"UserId"]];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:
                                       @{
                                         @"id" :[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]

                                         }];
    
    [[AppManager sharedManager] showHUD:@"Loading..."];
    [[AppManager sharedManager] getDataForUrl:@"http://dev414.trigma.us/serv/Webservices/EmployerProfile?"
                                   parameters:parameters
                                      success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"JSON: %@", responseObject);//description
         
         NSURL *newImageURL=[NSURL URLWithString:[responseObject objectForKey:@"profile_image"]];
         NSData *imageData=[NSData dataWithContentsOfURL:newImageURL];
         self.img_profileEmployee.image=[UIImage imageWithData:imageData];
         
         self.img_profileEmployee.layer.cornerRadius = 51;
         
         self.img_profileEmployee.layer.borderColor=[UIColor clearColor].CGColor;
         
         self.img_profileEmployee.clipsToBounds=YES;
         
         self.img_profileEmployee.layer.borderWidth=2;
         
         encryptedString = [imageData base64EncodedStringWithOptions:0];
         

         [self.image_appLogo setHidden:YES];
         
         [_Email_TextField setText:[responseObject objectForKey:@"email"]];
         [_City_TextField setText:[responseObject objectForKey:@"city"]];
         [_Address_TextField setText:[responseObject objectForKey:@"address"]];
         [_State_TextField setText:[responseObject objectForKey:@"state"]];
         [_ContactNumber_TextField setText:[responseObject objectForKey:@"contact"]];
         [_name_label setText:[responseObject objectForKey:@"name"]];
         [_userName_label setText:[responseObject objectForKey:@"username"]];
         
         [[AppManager sharedManager] hideHUD];


     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
         [[AppManager sharedManager] showHUD:@"Loading..."];
         alert(@"Error", @"");
     }];
}

- (IBAction)TappedOnDrawer:(id)sender
{
    [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
}

- (IBAction)TappedOnEditAndDoneBtn:(UIButton*)sender
{
    if (sender.tag==1)
    {
        // Edit Profile
        
        [_City_TextField setUserInteractionEnabled:YES];
        [_Address_TextField setUserInteractionEnabled:YES];
        [_State_TextField setUserInteractionEnabled:YES];
        [_ContactNumber_TextField setUserInteractionEnabled:YES];
        [_userName_label setUserInteractionEnabled:YES];
        [self.name_label setUserInteractionEnabled:YES];
        
        
        //[_Email_TextField resignFirstResponder];
        
        [self.btn_uploadPhoto setUserInteractionEnabled:YES];

        
        [_name_label becomeFirstResponder];

        
        [self.btn_done setHidden:NO];
        [self.btn_edit setHidden:YES];


    }
    else if (sender.tag==2)
    {
        // Done edit profile
        
        
        
        
        
        
        [_City_TextField resignFirstResponder];
        [_Address_TextField resignFirstResponder];
        [_State_TextField resignFirstResponder];
        [_ContactNumber_TextField resignFirstResponder];
        [_userName_label resignFirstResponder];
        [_name_label resignFirstResponder];
        
        if (![self.name_label.text isEqualToString:@""] && ![self.userName_label.text isEqualToString:@""] && ![self.Address_TextField.text isEqualToString:@""] && ![self.State_TextField.text isEqualToString:@""] && ![self.ContactNumber_TextField.text isEqualToString:@""] )
        {
            
            if (self.ContactNumber_TextField.text.length !=10)
            {
                alert(@"Alert!", @"Please enter valid contact number.");
                return;
            }
            else
            {
                [_Email_TextField setUserInteractionEnabled:NO];
                [_City_TextField setUserInteractionEnabled:NO];
                [_Address_TextField setUserInteractionEnabled:NO];
                [_State_TextField setUserInteractionEnabled:NO];
                [_ContactNumber_TextField setUserInteractionEnabled:NO];
                [_userName_label setUserInteractionEnabled:NO];
                
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
    {// upload photo
        
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
    self.img_profileEmployee.image = chosenImage;
    NSLog(@"%@",myimage);
    
    
    
    NSData* data = UIImageJPEGRepresentation(chosenImage, 1.0f);
    [Base64 initialize];
    encryptedString = [Base64 encode:data];
    
    
    // self.imageView_profile.image =myimage ;
    
    self.img_profileEmployee.layer.cornerRadius = 51;
    
    self.img_profileEmployee.layer.borderColor=[UIColor clearColor].CGColor;
    
    self.img_profileEmployee.clipsToBounds=YES;
    
    self.img_profileEmployee.layer.borderWidth=2;
    
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
                                         @"first_name"     :self.name_label.text,
                                         
                                         @"username"     :self.userName_label.text,
                                         
                                         @"profile_image"       :encryptedString,
                                         
                                         
                                         @"contact"       :self.ContactNumber_TextField.text,
                                         
                                         @"address"     :self.Address_TextField.text,
                                         
                                         @"city"     :self.City_TextField.text,
                                         
                                         @"state"     :self.State_TextField.text,
                                         
                                        
                                         
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
             alert(@"Sucessfully", [responseObject valueForKey:@"message"] );
             [[AppManager sharedManager] hideHUD];

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
#pragma mark - touches 
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
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

//-(BOOL)textFieldShouldReturn:(UITextField*)textField
//{
//    NSInteger nextTag = textField.tag + 1;
//    // Try to find next responder
//    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
//    if (nextResponder) {
//        // Found next responder, so set it.
////        if (nextTag == 2) {
////            [self.UserName_textfield becomeFirstResponder];
////            
////        }
////        else
//            [nextResponder becomeFirstResponder];
//    }
//    else
//    {
//        // Not found, so remove keyboard.
//        [textField resignFirstResponder];
//    }
//    return NO; // We do not want UITextField to insert line-breaks.
//}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    
    [theTextField resignFirstResponder];
    [self.view endEditing:YES];
    
    return YES;
}

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



@end
