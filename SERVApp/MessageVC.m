//
//  MessageVC.m
//  SERVApp
//
//  Created by Surender Kumar on 23/01/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import "MessageVC.h"
#import "MFSideMenuContainerViewController.h"
#import "MFSideMenu.h"

@interface MessageVC ()

@end

@implementation MessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
       [self.menuContainerViewController setPanMode:MFSideMenuPanModeDefault];
    // Do any additional setup after loading the view.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)TappedOnBack:(id)sender
{
    [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];

}
@end
