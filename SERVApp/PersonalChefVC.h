//
//  PersonalChefVC.h
//  SERVApp
//
//  Created by Surender Kumar on 24/01/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"

@interface PersonalChefVC : UIViewController<NIDropDownDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    IBOutlet UIButton *btn_yes;
    IBOutlet UIButton *btn_no;
    BOOL mealY;
    NIDropDown *dropDown;
    NSMutableArray *arr_Need;
    NSMutableArray *arr_address;

    NSMutableArray *arr_NoOfPeople;

    NSString *str_serviceDate;
    NSString *str_customerServId;
    
    IBOutlet UITextField *lbl_need;
    
    NSString *str_YN;
    
    IBOutlet UIView *view_dateAndTime;
    IBOutlet UITextField *txtField_dateAndTime;
    BOOL isTime;


}
@property(nonatomic,strong)IBOutlet UIView *view_picker;
@property(nonatomic,strong)IBOutlet UIDatePicker *picker_dateAndTime;

@property(nonatomic,strong)IBOutlet UITextField *textField_address;
@property(nonatomic,strong)IBOutlet UITextField *textField_noOfPeople;

@property(nonatomic,strong)IBOutlet UIImageView *image_yesIcon;
@property(nonatomic,strong)IBOutlet UIImageView *image_noIcon;

@property(nonatomic,strong)IBOutlet UITextView *textView_meals;
- (IBAction)btn_selectMeal:(UIButton *)sender;
- (IBAction)TappedOnBack:(id)sender;


@end
