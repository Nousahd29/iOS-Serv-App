        //
//  ViewController.m
//  SERVApp
//
//  Created by Surender Kumar on 22/01/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import "ViewController.h"
#import "MFSideMenuContainerViewController.h"
#import "MFSideMenu.h"
#import "RegisterVC.h"
#import "RegisterViewController.h"
#import "AppManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view_popUp setHidden:YES];
    
    [self.image_serviceProvide setImage:[UIImage imageNamed:@"radio-icon.png"]];
    [self.image_customer setImage:[UIImage imageNamed:@"radio-icon.png"]];

    
    [self.menuContainerViewController setPanMode:MFSideMenuPanModeNone];

    // Do any additional setup after loading the view, typically from a nib.
}

-(IBAction)ActionBtnsTapped:(UIButton*)sender
{
    if (sender.tag == 1)
    { // close popup
        [self.view_popUp setHidden:YES];
    }
    else if(sender.tag == 2)
    { // radio button service provider
        
        self.str_userType = @"serviceProvider";
        if (![sender isSelected])
        {
            [sender setSelected:YES];
            [self.image_serviceProvide setImage:[UIImage imageNamed:@"radio-active-btn.png"]];
            [self.image_customer setImage:[UIImage imageNamed:@"radio-icon.png"]];
            UIButton *therapistCheckBtn =   (UIButton*)[self.view viewWithTag:3];
            [therapistCheckBtn setSelected:NO];
        }else{
            [self.image_customer setImage:[UIImage imageNamed:@"radio-icon.png"]];
        }

        
    }
    else if(sender.tag == 3)
    {// radio button customer
        
        self.str_userType = @"customer";
        if (![sender isSelected])
        {
            
            [sender setSelected:YES];
            [self.image_customer setImage:[UIImage imageNamed:@"radio-active-btn.png"]];
            [self.image_serviceProvide setImage:[UIImage imageNamed:@"radio-icon.png"]];
            UIButton *memberCheckBtn =   (UIButton*)[self.view viewWithTag:2];
            [memberCheckBtn setSelected:NO];
        }
        else{
            [self.image_serviceProvide setImage:[UIImage imageNamed:@"radio-icon.png"]];
        }

        
    }
    else if(sender.tag == 4)
    {// btn countinue.
        
        if ([self.str_userType isEqualToString:@"serviceProvider"])
        {
            RegisterViewController *registerView_serviceProvider=[self.storyboard instantiateViewControllerWithIdentifier:@"RegisterViewController"];
            
            [self.navigationController pushViewController:registerView_serviceProvider animated:YES];
        }
        else if([self.str_userType isEqualToString:@"customer"])
        {
            RegisterVC *registerView_customer=[self.storyboard instantiateViewControllerWithIdentifier:@"RegisterVC"];
            
            [self.navigationController pushViewController:registerView_customer animated:YES];
        }
        else
        {
            alert(@"Alert!", @"Please select your user type.");
        }
        
        
    }
    else if(sender.tag == 5)
    {// Registeration btn.
        
        [self. view_popUp setHidden:NO];
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
