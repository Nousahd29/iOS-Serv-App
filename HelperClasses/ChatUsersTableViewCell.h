//
//  ChatUsersTableViewCell.h
//  SERVApp
//
//  Created by Noushad on 25/03/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatUsersTableViewCell : UITableViewCell


@property(nonatomic,strong)IBOutlet UIImageView *image_profilePic;
@property(nonatomic,strong)IBOutlet UILabel *lbl_Name;
@property(nonatomic,strong)IBOutlet UILabel *lbl_serviceORcustomer;



@end
