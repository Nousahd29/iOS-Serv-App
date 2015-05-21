//
//  ShippingVC.h
//  SERVApp
//
//  Created by Surender Kumar on 24/01/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"

@interface ShippingVC : UIViewController<NIDropDownDelegate>
{
    NIDropDown *dropDown;
    
    NSMutableArray *array_address;
    NSString *str_customerServId;
    NSString *str_textView;
}
@property(nonatomic,strong)IBOutlet UITextField *txtField_address;
@property(nonatomic,strong)IBOutlet UITextView *txtView_itemsName;
- (IBAction)TappedOnBack:(id)sender;

@end
