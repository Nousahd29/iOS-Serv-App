//
//  MyServiceListTableViewCell.h
//  SERVApp
//
//  Created by Noushad Shah on 10/02/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyServiceListTableViewCell : UITableViewCell


@property(nonatomic,strong)IBOutlet UILabel *lbl_numbers;
@property(nonatomic,strong)IBOutlet UILabel *lbl_servicesName;

@property(nonatomic,strong)IBOutlet UILabel *lbl_hoursAgo;


@end
