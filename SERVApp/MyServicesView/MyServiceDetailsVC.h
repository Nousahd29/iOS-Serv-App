//
//  MyServiceDetailsVC.h
//  SERVApp
//
//  Created by Noushad Shah on 10/02/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyServiceDetailsVC : UIViewController

@property(nonatomic,strong)IBOutlet UILabel *lbl_category;
@property(nonatomic,strong)IBOutlet UILabel *lbl_requestTime;
@property(nonatomic,strong)IBOutlet UILabel *lbl_requestDate;
@property(nonatomic,strong)IBOutlet UILabel *lbl_location;
@property(nonatomic,strong)IBOutlet UILabel *lbl_contactNo;
@property(nonatomic,strong)IBOutlet UILabel *lbl_status;
@property(nonatomic,strong)IBOutlet UITextView *txtView_description;

@property(nonatomic,strong) NSString *str_id;




@end
