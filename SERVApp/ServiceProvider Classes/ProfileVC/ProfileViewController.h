//
//  ProfileViewController.h
//  ServApp_provider
//
//  Created by TRun ShRma on 12/02/15.
//  Copyright (c) 2015 Tarun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate>
{
    NSString *encryptedString;
    UIPopoverController *pop;

    UITextField *currentTextField;
    CGFloat animatedDistance;

}

@property (weak, nonatomic) IBOutlet UITextField *Email_TextField;
@property (weak, nonatomic) IBOutlet UITextField *City_TextField;
@property (weak, nonatomic) IBOutlet UITextField *Address_TextField;
@property (weak, nonatomic) IBOutlet UITextField *State_TextField;
@property (weak, nonatomic) IBOutlet UITextField *ContactNumber_TextField;
@property (strong, nonatomic) IBOutlet UITextField *name_label;
@property (strong, nonatomic) IBOutlet UITextField *userName_label;

@property (strong, nonatomic) IBOutlet UIImageView *img_profileEmployee;

@property (strong, nonatomic) IBOutlet UIImageView *image_appLogo;


@property (strong, nonatomic) IBOutlet UIButton *btn_edit;
@property (strong, nonatomic) IBOutlet UIButton *btn_done;
@property (strong, nonatomic) IBOutlet UIButton *btn_uploadPhoto;






@end
