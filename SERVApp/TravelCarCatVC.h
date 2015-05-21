//
//  TravelCarCatVC.h
//  SERVApp
//
//  Created by Surender Kumar on 24/01/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"

@interface TravelCarCatVC : UIViewController<NIDropDownDelegate>
{
    NIDropDown *dropDown;
    NSArray *array_howManyCars;
    NSArray *array_typeOfCar;
}
- (IBAction)TappedOnBack:(id)sender;

@property(nonatomic,strong)IBOutlet UITextField *txt_car;
@property(nonatomic,strong)IBOutlet UITextField *txt_howManyCars;

@property(nonatomic,strong)IBOutlet UITextField *txt_typeOfCars;


@end
