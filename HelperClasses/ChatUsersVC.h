//
//  ChatUsersVC.h
//  SERVApp
//
//  Created by Noushad on 24/03/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatUsersVC : UIViewController


@property(nonatomic,strong)IBOutlet UITableView *table_chatUsers;
@property(nonatomic,strong) NSMutableArray *array_myServicesList;
@end
