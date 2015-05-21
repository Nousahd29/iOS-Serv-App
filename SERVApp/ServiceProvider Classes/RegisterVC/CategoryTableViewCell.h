//
//  CategoryTableViewCell.h
//  SERVApp
//
//  Created by Noushad on 21/02/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryTableViewCell : UITableViewCell

@property(nonatomic,strong)IBOutlet UIImageView *image_checkBox;
@property(nonatomic,strong)IBOutlet UILabel *lbl_categoryName;
@property(nonatomic,strong)IBOutlet UIButton *btn_checkBox;


@end
