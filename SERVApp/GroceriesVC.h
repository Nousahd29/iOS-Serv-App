//
//  GroceriesVC.h
//  SERVApp
//
//  Created by Surender Kumar on 24/01/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"
#import "AppDelegate.h"

@interface GroceriesVC : UIViewController<NIDropDownDelegate>
{
    
    IBOutlet UITableView *tableVW_groceries;
    NSMutableArray *Arr_image;
    NSMutableArray *array_list;
    NIDropDown *dropDown;
    NSMutableArray *indexingArray;

    BOOL btnTap;
    NSString *str_customerServId;
    BOOL isSelectGroceryBtnTapped;
    
    IBOutlet UIButton *btn_selectRestaurants;

}
- (IBAction)TappedOnBack:(id)sender;

@property(nonatomic,strong)IBOutlet UITextField *txt_stores;
@property(nonatomic,strong)IBOutlet UITextField *txt_itemSearch;
@property(nonatomic,strong)IBOutlet UITextField *txt_zipCode;

@property (strong, nonatomic) NSMutableArray *array_restaurantNames;


@property (strong, nonatomic) IBOutlet  UIView *view_tableBg;

@property (weak, nonatomic) IBOutlet UITableView *resultTableView;

@property (strong, nonatomic) AppDelegate *appDelegate;
@property (strong, nonatomic) NSMutableArray *tableViewDisplayDataArray;

@property(nonatomic,strong) NSString *str_index;




@end
