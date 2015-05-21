//
//  ChangePasswordVC.h
//  SERVApp
//
//  Created by Surender Kumar on 23/01/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePasswordVC : UIViewController
{
    NSMutableArray *json;
}

@property(nonatomic,strong)IBOutlet UITextField *txt_oldPassword;
@property(nonatomic,strong)IBOutlet UITextField *txt_newPassword;

@property(nonatomic,strong)IBOutlet UITextField *txt_confirmPassword;



@end
