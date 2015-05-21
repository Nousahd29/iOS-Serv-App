//
//  MaidVC.h
//  SERVApp
//
//  Created by Surender Kumar on 24/01/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"

@interface MaidVC : UIViewController<NIDropDownDelegate>
{
    IBOutlet UIButton *btn_huseCln;
    IBOutlet UIButton *btn_DeepCln;
    IBOutlet UIButton *btn_Laundry;
    IBOutlet UIButton *btn_dishes;
    BOOL houseCln;
    BOOL DeepCln;
    BOOL Laundry;
    BOOL Dishes;
    NIDropDown *dropDown;
    NSMutableArray *arr_Need;
    NSMutableArray *arr_address;
    

    
    NSMutableArray *array_services;
    NSString *str_sevices;
    
    NSString *str_serviceDate;
    NSString *str_customerServId;

    
    IBOutlet UITextField *lbl_need;
    IBOutlet UITextField *txtField_address;
    IBOutlet UITextField *txtField_dateAndTime;
    IBOutlet UITextField *txtField_time;
    
    IBOutlet UIImageView *image_date;
    IBOutlet UIImageView *image_time;

    
    IBOutlet UIView *view_dateAndTime;
    
    IBOutlet UIView *view_description;
    IBOutlet UIButton *btn_questionMark;
    BOOL isTime;




}
@property(nonatomic,strong)IBOutlet UIImageView *image_houseClean;
@property(nonatomic,strong)IBOutlet UIImageView *image_deepClean;

@property(nonatomic,strong)IBOutlet UIImageView *image_laundry;

@property(nonatomic,strong)IBOutlet UIImageView *image_dishes;

@property(nonatomic,strong)IBOutlet UIView *view_picker;
@property(nonatomic,strong)IBOutlet UIDatePicker *picker_dateAndTime;
@property(nonatomic,strong)IBOutlet UILabel *lbl_pickerTitle;


- (IBAction)btnSelectServices:(UIButton *)sender;
- (IBAction)TappedOnBack:(id)sender;

- (IBAction)TappedOnNeed:(id)sender;
@end
