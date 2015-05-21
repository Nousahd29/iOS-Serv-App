//
//  TravelHotelVC.h
//  SERVApp
//
//  Created by Noushad on 26/03/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"


@interface TravelHotelVC : UIViewController<NIDropDownDelegate>
{
    NIDropDown *dropDown;
    NSArray *array_howManyDays;
    NSArray *array_hotelRating;


}



@property(nonatomic,strong)IBOutlet UITextField *txt_state;
@property(nonatomic,strong)IBOutlet UITextField *txt_city;

@property(nonatomic,strong)IBOutlet UITextField *txt_hotelRating;

@property(nonatomic,strong)IBOutlet UITextField *txt_hotel;

@property(nonatomic,strong)IBOutlet UITextField *txt_howManyDays;

@end
