//
//  LoginVC.m
//  SERVApp
//
//  Created by Surender Kumar on 23/01/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import "LoginVC.h"
#import "MFSideMenuContainerViewController.h"
#import "MFSideMenu.h"
#import "AppManager.h"
#import "HeaderFile.h"
#import "HomeVC.h"
#import "HomeViewController.h"


@interface LoginVC ()

@end

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 150;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.1;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.1;
double animatedDistance;



@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [AppManager sharedManager].navCon = self.navigationController;

    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
   [self.menuContainerViewController setPanMode:MFSideMenuPanModeNone];
//    txt_userName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Username" attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
//    
//    txt_pswd.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
   
}

- (IBAction)TappedOnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)TappedOnLogin:(id)sender
{
    // Check TextField is empty or not
    if(isStringEmpty(txt_userName.text)&& (txt_pswd.text) ) {
        
        [txt_userName becomeFirstResponder];
        alert(@"Alert!", @"Please enter email and password");
        return;
    }
    else if (!validateEmailWithString(txt_userName.text)) {
        
        [txt_userName becomeFirstResponder];
        alert(@"Alert", @"Please enter valid email");
        return;
    }
    else
    {
        [txt_userName resignFirstResponder];
        [txt_pswd resignFirstResponder];
        
        [self webServiceLogin];

    }
}

-(void)webServiceLogin
{
    //Add parameters to send server
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:
                                       
                                       @{
                                         
                                         @"username"     :txt_userName.text,
                                         
                                         @"password"     :txt_pswd.text
                                         
                                         
                                         
                                         }];
    
    
    
    [[AppManager sharedManager] showHUD:@"Loading..."];
    
    // [appdelRef showProgress:@"Please wait.."];
    
    // "http://dev414.trigma.us/serv/Webservices/customersignup?name=%@&username=%@&email=%@&image=profileimage2.png&usertype_id=7&password=123456&contact=9041387172&address=chandigarh&city=chandigarh&state=punjab&zip_code=273212"
    
    [[AppManager sharedManager] getDataForUrl:@"http://dev414.trigma.us/serv/Webservices/customerlogin?"
     
                                   parameters:parameters
     
                                      success:^(AFHTTPRequestOperation *operation, id responseObject)
     
     {
         
         // Get response from server
         
         NSLog(@"JSON: %@", responseObject);
         
         if([[responseObject objectForKey:@"message"] isEqualToString:@"Invalid username and password"])
         {
             
             alert(@"Alert", [responseObject objectForKey:@"message"]);
             
             [[AppManager sharedManager]hideHUD];

             return;
         }
         else if ([[responseObject objectForKey:@"message"] isEqualToString:@"Invalid Password"])
         {
             alert(@"Alert", [responseObject objectForKey:@"message"]);
             [[AppManager sharedManager]hideHUD];

             return;
         }
         
         NSString *strUserID = [responseObject objectForKey:@"user_id"];
         NSLog(@"strUserID: %@", strUserID);
         
         [[NSUserDefaults standardUserDefaults] setObject:strUserID forKey:@"userID"];
         
         NSString *strUserAddress = [responseObject objectForKey:@"address"];
         NSLog(@"strAddress: %@", strUserAddress);
         [[NSUserDefaults standardUserDefaults] setObject:strUserAddress forKey:@"address"];
         
         NSString *strUserEmail = [responseObject objectForKey:@"email"];
         NSLog(@"strEmail: %@", strUserEmail);
         [[NSUserDefaults standardUserDefaults] setObject:strUserEmail forKey:@"Email"];//user_type
         
         NSString *strUserType = [responseObject objectForKey:@"usertype_id"];
         NSLog(@"strUserType: %@", strUserType);
         
         [[NSUserDefaults standardUserDefaults] setObject:strUserType forKey:@"usertype_id"];

         
        // alert(@"Success", [responseObject objectForKey:@"message"]);
         
         [[AppManager sharedManager]hideHUD];
         
         
         // Notification fire...
         [[NSNotificationCenter defaultCenter] postNotificationName:@"updateProfile" object:responseObject];
         
         if ([[responseObject objectForKey:@"usertype_id"] isEqualToString:@"6"])
         {
             //Customer home view
             [[NSUserDefaults standardUserDefaults] setObject:strUserType forKey:@"usertype_id"];

             HomeVC *homeViewContorller=[self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
             [self.navigationController pushViewController:homeViewContorller animated:YES];
             
         }
         else if([[responseObject objectForKey:@"usertype_id"] isEqualToString:@"7"])
         {
             //Service provider home view
             [[NSUserDefaults standardUserDefaults] setObject:strUserType forKey:@"usertype_id"];

             HomeViewController *homeVC_serviceProvider=[self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
             [self.navigationController pushViewController:homeVC_serviceProvider animated:YES];
         }
         else
         {
             alert(@"Alert!", @"Your account has been blocked by Administrator");
             return;
         }

         
        
     }
     
           failure:^(AFHTTPRequestOperation *operation, NSError *error)
     
     {
         
         NSLog(@"Error: %@", error);
         
         // [appdelRef hideProgress];
         [[AppManager sharedManager]hideHUD];

         
         alert(@"Error", @"");
         
     }];
    
}


 -(void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"begin");
    
    UIColor *color=[UIColor lightGrayColor];
    
    if (txt_userName.text.length==0)
    {
        
        txt_userName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"E-mail"
                                                                             attributes:@{NSForegroundColorAttributeName: color}];
    }
    if (txt_pswd.text.length==0)
    {
        
        txt_pswd.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password"
                                                                             attributes:@{NSForegroundColorAttributeName: color}];
    }
    
    
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
    
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [txt_userName resignFirstResponder];
    [txt_pswd resignFirstResponder];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
