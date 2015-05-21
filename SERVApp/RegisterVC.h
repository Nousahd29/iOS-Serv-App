//
//  RegisterVC.h
//  SERVApp
//
//  Created by Surender Kumar on 23/01/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"

@interface RegisterVC : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate>
{
    IBOutlet TPKeyboardAvoidingScrollView *scrollVW_Register;
    IBOutlet UITextField *txt_name;
    IBOutlet UITextField *txt_userName;
    IBOutlet UITextField *txt_email;
    IBOutlet UITextField *txt_pswd;
    IBOutlet UITextField *txt_cnfrmPswd;
    IBOutlet UITextField *txt_address;
    IBOutlet UITextField *txt_city;
    IBOutlet UITextField *txt_state;
    IBOutlet UITextField *txt_zipcode;
    IBOutlet UITextField *txt_contactNo;
    NSMutableArray *json;
    UIPopoverController *pop;
    
    NSString *strEncoded;
}

@property(nonatomic,strong)IBOutlet UIImageView *imageView_profile;


- (IBAction)TappedOnTerms:(id)sender;
- (IBAction)TappedOnPrivatePolicy:(id)sender;
- (IBAction)TappedOnRegister:(id)sender;
- (IBAction)TappedOnBack:(id)sender;



@end
