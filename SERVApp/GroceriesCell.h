//
//  GroceriesCell.h
//  SERVApp
//
//  Created by Surender Kumar on 24/01/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MarqueeLabel.h"

@interface GroceriesCell : UITableViewCell
{
    
}
@property (strong, nonatomic) IBOutlet UIImageView *imageView_item;
@property (strong, nonatomic) IBOutlet MarqueeLabel *lbl_itemName;

@property (strong, nonatomic) IBOutlet UILabel *lbl_itemPrice;
@property (strong, nonatomic) IBOutlet UIButton *button_addItem;




@end
