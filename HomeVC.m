//
//  HomeVC.m
//  SERVApp
//
//  Created by Surender Kumar on 23/01/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import "HomeVC.h"
#import "MFSideMenu.h"
#import "MFSideMenuContainerViewController.h"

@interface HomeVC ()

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.menuContainerViewController setPanMode:MFSideMenuPanModeDefault];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)TappedOnDrawer:(id)sender
{
     [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
}
@end
