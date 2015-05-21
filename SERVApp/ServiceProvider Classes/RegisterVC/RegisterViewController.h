//
//  RegisterViewController.h
//  ServApp_provider
//
//  Created by TRun ShRma on 11/02/15.
//  Copyright (c) 2015 Tarun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate>
{
    NSString *encryptedString;
    BOOL btnTap;
    UIPopoverController *pop;
    
}
@property (strong, nonatomic) IBOutlet UIImageView *profilePic;
@property (strong, nonatomic) IBOutlet UITextField *Name_textfield;
@property (strong, nonatomic) IBOutlet UITextField *UserName_textfield;
@property (strong, nonatomic) IBOutlet UITextField *Email_textfield;
@property (strong, nonatomic) IBOutlet UITextField *Category_textfield;
@property (strong, nonatomic) IBOutlet UITextField *ContactNumber_textfield;
@property (strong, nonatomic) IBOutlet UITextField *Password_textfield;
@property (strong, nonatomic) IBOutlet UITextField *ConfirmPassword_textfield;
@property (strong, nonatomic) IBOutlet UITextField *Address_textfield;
@property (strong, nonatomic) IBOutlet UITextField *State_textfield;
@property (strong, nonatomic) IBOutlet UITextField *City_textfield;
@property (strong, nonatomic) IBOutlet UITextField *ZipCode_textfield;
@property (strong, nonatomic) IBOutlet UIScrollView *ScrollView;

@property (strong, nonatomic) IBOutlet UITableView *table_category;

@property (strong, nonatomic) IBOutlet UIView *view_table;


@property (strong, nonatomic) NSMutableArray *array_categoryList;

@property (nonatomic, weak)   IBOutlet  UIView          *myView_selectLaung;
@property (nonatomic, strong)           NSMutableArray  *arr_languageList;
@property (nonatomic, strong)           NSString  *str_categoryList;

@property (nonatomic, strong)           NSMutableArray  *arr_categoryID;
@property (nonatomic, strong)           NSString  *str_categoryID;








@end
