//
//  ForgotPasswordVC.m
//  SERVApp
//
//  Created by Surender Kumar on 23/01/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import "ForgotPasswordVC.h"
#import "MFSideMenuContainerViewController.h"
#import "MFSideMenu.h"
#import "AppManager.h"
#import "HeaderFile.h"

@interface ForgotPasswordVC ()

@end

@implementation ForgotPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [AppManager sharedManager].navCon = self.navigationController;

    [self.menuContainerViewController setPanMode:MFSideMenuPanModeNone];

    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.menuContainerViewController setPanMode:MFSideMenuPanModeNone];
  }

- (IBAction)TappedOnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)TappedOnUpdate:(id)sender
{
    if (txt_email.text.length <=0)
    {
        alert(@"Alert!", @"Please enter the E-mail address.");

    }
    else if (!validateEmailWithString(txt_email.text)) {
            
            [txt_email becomeFirstResponder];
            alert(@"Alert", @"Please enter valid email");
            return;
        }

    else
    {
        [self webServiceForgotPassword];

    }
}


-(void)webServiceForgotPassword
{
    NSURL *urli = [NSURL URLWithString:[NSString stringWithFormat:@"http://dev414.trigma.us/serv/Webservices/customerforgot?"]];
    NSString *str = [NSString stringWithFormat:@"username=%@",txt_email.text];
    NSLog(@"%@",str);
    NSData * postData = [str dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:urli];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSError * error = nil;
    NSURLResponse * response = nil;
    //    NSURLConnection * connec = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if(data)
    {
        json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    }
    // [arr_collectionData addObject:json];
    NSLog(@"%@",response);
    NSLog(@"%@",json);
    NSString *strMessage=[json valueForKey:@"message"];
    if ([strMessage isEqualToString:@"Check Your Email To Reset your password"])
    {
        alert(@"Success", @"Check Your Email To Reset your password");
        
        txt_email.text=@"";
        return;
    }
    else if ([strMessage isEqualToString:@"Email does not exist"])
    {
        alert(@"Alert !", @"Email does not exist");
        
        return;
        
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [txt_email resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
