//
//  ReservationVC.h
//  SERVApp
//
//  Created by Surender Kumar on 23/01/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"

@interface ReservationVC : UIViewController<NIDropDownDelegate>
{
    NSMutableArray *array_type;
    NIDropDown *dropDown;

}
@property(nonatomic,strong)IBOutlet UITextField *lbl_Type;
@property(nonatomic,strong)IBOutlet UITextField *lbl_zipCode;



- (IBAction)TappedOnBack:(id)sender;

@end
