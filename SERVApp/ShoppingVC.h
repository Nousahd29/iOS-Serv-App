//
//  ShoppingVC.h
//  SERVApp
//
//  Created by Surender Kumar on 24/01/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"

@interface ShoppingVC : UIViewController<NIDropDownDelegate>
{
    NIDropDown *dropDown;
    
    NSMutableArray *array_selectService;
    NSMutableArray *array_location;
    NSMutableArray *array_address;
    NSString *str_customerServId;
    NSString *str_textView;

}

@property(nonatomic,strong)IBOutlet UITextField *txtField_purchasesAndReturn;
@property(nonatomic,strong)IBOutlet UITextField *txtField_location;
@property(nonatomic,strong)IBOutlet UITextField *txtField_address;
@property(nonatomic,strong)IBOutlet UITextView *txtView_itemTypes;
- (IBAction)TappedOnBack:(id)sender;

@end
