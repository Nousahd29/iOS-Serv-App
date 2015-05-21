//
//  JobsViewController.h
//  ServApp_provider
//
//  Created by TRun ShRma on 12/02/15.
//  Copyright (c) 2015 Tarun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JobsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *SomeArray;
}
@property (strong, nonatomic) IBOutlet UITableView *JobTableView;
@end
