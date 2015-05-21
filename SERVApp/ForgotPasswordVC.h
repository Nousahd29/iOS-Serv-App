//
//  ForgotPasswordVC.h
//  SERVApp
//
//  Created by Surender Kumar on 23/01/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgotPasswordVC : UIViewController
{
    IBOutlet UITextField *txt_email;
    NSMutableArray *json;
}

- (IBAction)TappedOnBack:(id)sender;
@end
