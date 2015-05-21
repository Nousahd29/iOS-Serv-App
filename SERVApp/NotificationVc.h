//
//  NotificationVc.h
//  SERVApp
//
//  Created by Surender Kumar on 23/01/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationVc : UIViewController
{
    IBOutlet UITableView *tableVw_notifivation;
    NSMutableArray *Arr_notificationList;
}
- (IBAction)TappedOnBack:(id)sender;
@end
