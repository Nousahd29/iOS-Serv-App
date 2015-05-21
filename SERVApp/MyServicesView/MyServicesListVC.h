//
//  MyServicesListVC.h
//  SERVApp
//
//  Created by Noushad Shah on 10/02/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyServicesListVC : UIViewController
{
   // id responseObject;
    IBOutlet UILabel *lbl_title;
}

@property(nonatomic,strong) NSString *str_userType;

@property(nonatomic,strong)IBOutlet UITableView *Table_myServices;
@property(nonatomic,strong) NSMutableArray *array_myServicesList;
@property(nonatomic,strong) NSMutableArray *array_hrsAgo;

@property(nonatomic,strong) NSMutableArray *array_numbers;


@end
