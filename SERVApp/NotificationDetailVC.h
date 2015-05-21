//
//  NotificationDetailVC.h
//  SERVApp
//
//  Created by Surender Kumar on 23/01/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationDetailVC : UIViewController


@property(nonatomic,strong)NSString *str_id;

@property(nonatomic,strong)IBOutlet UIImageView *image_profileImage;

@property(nonatomic,strong)IBOutlet UIImageView *image_appLogo;


@property(nonatomic,strong)IBOutlet UILabel *lbl_categoryName;

@property(nonatomic,strong)IBOutlet UILabel *lbl_requestTime;

@property(nonatomic,strong)IBOutlet UILabel *lbl_acceptedBy;
@property(nonatomic,strong)IBOutlet UILabel *lbl_acceptedTime;


@property(nonatomic,strong)IBOutlet UILabel *lbl_contactNo;
@property(nonatomic,strong)IBOutlet UILabel *lbl_acceptedAndDecliendBy;
@property(nonatomic,strong)IBOutlet UILabel *lbl_acceptedAndDecliendTime;


@end
