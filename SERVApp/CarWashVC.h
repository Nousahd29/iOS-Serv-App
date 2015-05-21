//
//  CarWashVC.h
//  SERVApp
//
//  Created by Surender Kumar on 24/01/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"

@interface CarWashVC : UIViewController<NIDropDownDelegate>
{
    
    IBOutlet UIButton *btn_service1;
    IBOutlet UIButton *btn_service2;
    IBOutlet UIButton *btn_service3;
    IBOutlet UIButton *btn_service4;
    IBOutlet UIButton *btn_service5;
    
    NSString *str_serviceDate;
    NSString *str_customerServId;

    BOOL service1;
    BOOL service2;
    BOOL service3;
    BOOL service4;
    NIDropDown *dropDown;
    NSMutableArray *arr_Need;
    IBOutlet UITextField *lbl_need;
    NSString *str_carWashSevices;
    NSMutableArray *array_carWashService;

    NSMutableArray *arr_address;
    IBOutlet UIView *view_dateAndTime;
    IBOutlet UITextField *txtField_dateAndTime;
    
    
    IBOutlet UITextField *txtField_time;
    
    IBOutlet UIImageView *image_date;
    IBOutlet UIImageView *image_time;
    
    
    //IBOutlet UIView *view_dateAndTime;
    
    IBOutlet UIView *view_description;
    IBOutlet UIButton *btn_questionMark;
    BOOL isTime;


}

@property(nonatomic,strong)IBOutlet UIView *view_picker;
@property(nonatomic,strong)IBOutlet UIDatePicker *picker_dateAndTime;
@property(nonatomic,strong)IBOutlet UITextField *textField_address;

@property(nonatomic,strong)IBOutlet UIImageView *image_serviceOne;
@property(nonatomic,strong)IBOutlet UIImageView *image_servicetwo;

@property(nonatomic,strong)IBOutlet UIImageView *image_serviceThree;

@property(nonatomic,strong)IBOutlet UIImageView *image_serviceFour;
@property(nonatomic,strong)IBOutlet UIImageView *image_serviceFive;


- (IBAction)btnSelectServices:(UIButton *)sender;
- (IBAction)TappedOnBack:(id)sender;
- (IBAction)TappedOnNeed:(id)sender;

@end
