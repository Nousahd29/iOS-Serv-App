//
//  SpaVC.h
//  SERVApp
//
//  Created by Surender Kumar on 24/01/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"

@interface SpaVC : UIViewController<NIDropDownDelegate>
{
    NIDropDown *dropDown;
    
    NSMutableArray *array_address;
    NSMutableArray *array_services;
    BOOL isDate;
    
    
    IBOutlet UIImageView *image_date;
    IBOutlet UIImageView *image_time;
    
    
    //IBOutlet UIView *view_dateAndTime;
    
    IBOutlet UIView *view_description;
    IBOutlet UIButton *btn_questionMark;
    BOOL isTime;
    
    IBOutlet UIButton *btn_manicure;
    IBOutlet UIButton *btn_pedicure;

    IBOutlet UIButton *btn_massage;


    
   // NSMutableArray *array_services;
    NSString *str_sevices;
}

@property(nonatomic,strong)IBOutlet UIImageView *image_manicure;
@property(nonatomic,strong)IBOutlet UIImageView *image_pedicure;

@property(nonatomic,strong)IBOutlet UIImageView *image_massage;

@property(nonatomic,strong)IBOutlet UITextField *txtField_address;
@property(nonatomic,strong)IBOutlet UITextField *txtField_services;
@property(nonatomic,strong)IBOutlet UITextField *txtField_date;
@property(nonatomic,strong)IBOutlet UITextField *txtView_time;

@property(nonatomic,strong)IBOutlet UIDatePicker *datePicker;
@property(nonatomic,strong)IBOutlet UIView *datePickerView;






- (IBAction)TappedOnBack:(id)sender;

@end
