//
//  UserProfileDetailVC.h
//  SERVApp
//
//  Created by Noushad Shah on 05/02/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserProfileDetailVC : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate>
{
    NSString *encryptedString;
    UIPopoverController *pop;
    
    UITextField *currentTextField;
    CGFloat animatedDistance;
    IBOutlet UIImageView *image_servApp;

    
}


@property(nonatomic,strong)IBOutlet UIImageView *imageView_users;
@property(nonatomic,strong)IBOutlet UITextField *txt_Name;
@property(nonatomic,strong)IBOutlet UITextField *txt_userName;
@property(nonatomic,strong)IBOutlet UITextField *txt_location;
@property(nonatomic,strong)IBOutlet UITextField *txt_email;
//@property(nonatomic,strong)IBOutlet UITextField *lbl_address;
@property(nonatomic,strong)IBOutlet UITextField *txtView_address;
@property(nonatomic,strong)IBOutlet UITextField *txt_contactNumber;

@property(nonatomic,strong)IBOutlet UIButton *btn_edit;
@property(nonatomic,strong)IBOutlet UIButton *btn_done;
@property (strong, nonatomic) IBOutlet UIButton *btn_uploadPhoto;








@end
