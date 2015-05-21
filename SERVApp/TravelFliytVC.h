//
//  TravelFliytVC.h
//  SERVApp
//
//  Created by Surender Kumar on 24/01/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TravelFliytVC : UIViewController
{
    NSArray *array_howManyDays;
    NSArray *array_hotelRating;
    BOOL isDate;

}
- (IBAction)TappedOnBack:(id)sender;

@property(nonatomic,strong)IBOutlet UITextField *txt_flight;
@property(nonatomic,strong)IBOutlet UITextField *txt_from;

@property(nonatomic,strong)IBOutlet UITextField *txt_destination;

@property(nonatomic,strong)IBOutlet UITextField *txt_date;

@property(nonatomic,strong)IBOutlet UITextField *txt_returnDate;

@property(nonatomic,strong)IBOutlet UIDatePicker *datePicker;
@property(nonatomic,strong)IBOutlet UIView *datePickerView;

@end
