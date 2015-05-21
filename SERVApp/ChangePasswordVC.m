//
//  ChangePasswordVC.m
//  SERVApp
//
//  Created by Surender Kumar on 23/01/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import "ChangePasswordVC.h"
#import "MFSideMenuContainerViewController.h"
#import "MFSideMenu.h"
#import "AppManager.h"
#import "HeaderFile.h"

@interface ChangePasswordVC ()

@end

@implementation ChangePasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.menuContainerViewController setPanMode:MFSideMenuPanModeDefault];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)TappedOnChangePassword:(id)sender
{
    if(isStringEmpty(self.txt_confirmPassword.text)&& (self.txt_newPassword.text) && (self.txt_oldPassword.text)) {
        
       // [self.txt_oldPassword becomeFirstResponder];
        alert(@"Alert!", @"Please fill all mandatory fields.");
        return;
    }
    else
    {
        [self webServiceChangePassword];

    }
    
}

-(void)webServiceChangePassword
{
    NSURL *urli = [NSURL URLWithString:[NSString stringWithFormat:@"http://dev414.trigma.us/serv/Webservices/customerchangepass?"]];
    NSString *str = [NSString stringWithFormat:@"email=%@&opass=%@&password=%@&cpass=%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"Email"],self.txt_oldPassword.text,self.txt_newPassword.text,self.txt_confirmPassword.text];
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
    if ([strMessage isEqualToString:@"Password updated"])
    {
        alert(@"Successfully", @"Password updated");
        
        self.txt_confirmPassword.text=@"";
        self.txt_newPassword.text=@"";
        self.txt_oldPassword.text=@"";
        return;
        
    }
    else if ([strMessage isEqualToString:@"New password and Confirm password field do not match"])
    {
        alert(@"Alert !", @"New password and Confirm password field do not match");
        
        [self.txt_newPassword becomeFirstResponder];
        self.txt_newPassword.text=nil;
        self.txt_confirmPassword.text=nil;
        return;
        
    }
    else if ([strMessage isEqualToString:@"Your old password did not match."])
    {
        alert(@"Alert !", @"Your old password did not match.");
        [self.txt_oldPassword becomeFirstResponder];

        self.txt_oldPassword.text=nil;
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
    [self.txt_oldPassword resignFirstResponder];
    [self.txt_newPassword resignFirstResponder];

    [self.txt_confirmPassword resignFirstResponder];

}


- (IBAction)TappedOnDrawer:(id)sender
{
    [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];

}
@end
