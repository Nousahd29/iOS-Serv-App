//
//  LoginVC.h
//  SERVApp
//
//  Created by Surender Kumar on 23/01/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginVC : UIViewController
{
    IBOutlet UITextField *txt_userName;
    IBOutlet UITextField *txt_pswd;
    NSMutableArray *json;
    
}
- (IBAction)TappedOnLogin:(id)sender;
- (IBAction)TappedOnBack:(id)sender;

@end
