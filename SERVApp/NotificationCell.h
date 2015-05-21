//
//  NotificationCell.h
//  SERVApp
//
//  Created by Noushad on 01/04/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationCell : UITableViewCell


@property(nonatomic,strong)IBOutlet UIImageView *image_profileImage;
@property(nonatomic,strong)IBOutlet UILabel *lbl_description;

@property(nonatomic,strong)IBOutlet UILabel *lbl_time;


@end
