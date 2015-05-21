//
//  SideMenuViewController.m
//  MFSideMenuDemo
//
//  Created by Michael Frederick on 3/19/12.

#import "SideMenuViewController.h"
#import "MFSideMenu.h"
//#import "constant.h"
//#import "AsyncImageView.h"
#import "MessageVC.h"
#import "ChangePasswordVC.h"
#import "HelpVC.h"
#import "LoginVC.h"
#import "UserProfileDetailVC.h"
#import "HomeVC.h"
#import "AppManager.h"
#import "ViewController.h"
#import "MyServicesListVC.h"
#import "HomeViewController.h"
#import "JobDetailsViewController.h"
#import "ProfileViewController.h"
#import "JobsViewController.h"
#import "PrivateChat.h"
#import "ChatUsersVC.h"
//#import "DriverViewController.h"
#import "NotificationVc.h"

@interface SideMenuViewController(){
    
    NSDictionary *userDetails;
}

@end

@implementation SideMenuViewController

#pragma mark -
#pragma mark - UITableViewDataSource

- (void)viewDidLoad
{
    NSLog(@"First Name %@", [userDetails objectForKey:@"name"]);

    
    arr_For_firstSection=[[NSMutableArray alloc]init];
    [arr_For_firstSection addObject:[UIImage imageNamed:@"homeBtn"]];
    [arr_For_firstSection addObject:[UIImage imageNamed:@"servicesBtn"]];
    [arr_For_firstSection addObject:[UIImage imageNamed:@"messageBtn"]];
    [arr_For_firstSection addObject:[UIImage imageNamed:@"ProfileBtn"]];
    [arr_For_firstSection addObject:[UIImage imageNamed:@"notification-btn"]];

    [arr_For_firstSection addObject:[UIImage imageNamed:@"passwordBtn"]];
    [arr_For_firstSection addObject:[UIImage imageNamed:@"helpBtn"]];
    [arr_For_firstSection addObject:[UIImage imageNamed:@"logoutBtn"]];
   
    
   // arrSideView_serviceProvider=[[NSMutableArray alloc]init];
    arrSideView_serviceProvider=[[NSMutableArray alloc]init];
    [arrSideView_serviceProvider addObject:[UIImage imageNamed:@"homeBtn"]];
    [arrSideView_serviceProvider addObject:[UIImage imageNamed:@"my-jobs-btn"]];
    [arrSideView_serviceProvider addObject:[UIImage imageNamed:@"messageBtn"]];
    [arrSideView_serviceProvider addObject:[UIImage imageNamed:@"ProfileBtn"]];
   // [arrSideView_serviceProvider addObject:[UIImage imageNamed:@"notification-btn"]];

    [arrSideView_serviceProvider addObject:[UIImage imageNamed:@"passwordBtn"]];
    [arrSideView_serviceProvider addObject:[UIImage imageNamed:@"helpBtn"]];
    [arrSideView_serviceProvider addObject:[UIImage imageNamed:@"logoutBtn"]];

}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
   
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateProfile:) name:@"updateProfile" object:nil];
}

-(void) updateProfile:(id)user{
    userDetails = [user valueForKey:@"object"];
    
    [tableVw_side reloadData];
    
}

#pragma mark  Table delegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSLog(@"First Name %@", [userDetails objectForKey:@"name"]);
    
    if ([[userDetails objectForKey:@"usertype_id"] isEqualToString:@"6"])
    {
    
    ProfileView=[[UIView alloc]initWithFrame:CGRectMake(0, 22, 180, 165)];
    //ProfileView.backgroundColor=[UIColor colorWithRed:30.0/255 green:44.0/255 blue:96.0/255 alpha:1.0f];
    ProfileView.backgroundColor=[UIColor clearColor];
    
    UIView * ProfileView1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 190, 20)];
    ProfileView1.backgroundColor=[UIColor blackColor];
    
    profileImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 22, 180, 165)];
   // profileImage.image=[UIImage imageNamed:@"sidebar-user-icon"];
    
    //    profileImage.layer.cornerRadius=profileImage.frame.size.height/2;
    //    profileImage.clipsToBounds = YES;
    
    ProfileView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    
    UIImageView *nameImage=[[UIImageView alloc]initWithFrame:CGRectMake(28, 135, 116, 23)];
    nameImage.image=[UIImage imageNamed:@"sidebar-name-bg"];
    
    UILabel *lbl_name=[[UILabel alloc]initWithFrame:CGRectMake(9, 2, 100, 20)];
    lbl_name.text = [userDetails objectForKey:@"name"];
    [lbl_name setTextAlignment:NSTextAlignmentCenter];
    lbl_name.font=[UIFont fontWithName:@"ufonts.com_engravers-gothic-bt" size:12.0f];
        //[UIFont fontWithName:@"HelveticaNeue" size:36]
    
    [nameImage addSubview:lbl_name];
    
    [profileImage addSubview:nameImage];
    
    
    [ProfileView addSubview:profileImage];
    
    
    UIImageView *imageView      = [[UIImageView alloc] initWithFrame:CGRectMake(28, 135, 116, 23)];
    imageView.autoresizingMask  = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    dispatch_async(GCDBackgroundThread, ^{
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", [userDetails objectForKey:@"image"]]];
        NSData *imgData = [NSData dataWithContentsOfURL:url];
        if (imgData) {
            UIImage *image = [UIImage imageWithData:imgData];
            if (image) {
                dispatch_async(GCDMainThread, ^{
                    
                    profileImage.image = image;
                    
                });
            }
        }
    });
        
    }
    else
    {
        // service provider side view...
        
        ProfileView=[[UIView alloc]initWithFrame:CGRectMake(0, 22, 180, 165)];
        //ProfileView.backgroundColor=[UIColor colorWithRed:30.0/255 green:44.0/255 blue:96.0/255 alpha:1.0f];
        ProfileView.backgroundColor=[UIColor clearColor];
        
        UIView * ProfileView1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 190, 20)];
        ProfileView1.backgroundColor=[UIColor blackColor];
        
        profileImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 22, 180, 165)];
        // profileImage.image=[UIImage imageNamed:@"sidebar-user-icon"];
        
        //    profileImage.layer.cornerRadius=profileImage.frame.size.height/2;
        //    profileImage.clipsToBounds = YES;
        
        ProfileView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
        
        UIImageView *nameImage=[[UIImageView alloc]initWithFrame:CGRectMake(28, 135, 116, 23)];
        nameImage.image=[UIImage imageNamed:@"sidebar-name-bg"];
        
        UILabel *lbl_name=[[UILabel alloc]initWithFrame:CGRectMake(9, 2, 100, 20)];
        lbl_name.text = [userDetails objectForKey:@"name"];
        [lbl_name setTextAlignment:NSTextAlignmentCenter];
        lbl_name.font=[UIFont fontWithName:@"ufonts.com_engravers-gothic-bt" size:12.0f];
        
        [nameImage addSubview:lbl_name];
        
        [profileImage addSubview:nameImage];
        
        
        [ProfileView addSubview:profileImage];
        
        
        UIImageView *imageView      = [[UIImageView alloc] initWithFrame:CGRectMake(28, 135, 116, 23)];
        imageView.autoresizingMask  = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        dispatch_async(GCDBackgroundThread, ^{
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", [userDetails objectForKey:@"image"]]];
            NSData *imgData = [NSData dataWithContentsOfURL:url];
            if (imgData) {
                UIImage *image = [UIImage imageWithData:imgData];
                if (image) {
                    dispatch_async(GCDMainThread, ^{
                        
                        profileImage.image = image;
                        
                    });
                }
            }
        });
        
    }
    
    return  ProfileView;

}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 190.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([[userDetails objectForKey:@"usertype_id"] isEqualToString:@"6"])
    {
        return [arr_For_firstSection count];
    }
    else
    {
        return [arrSideView_serviceProvider count];

    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    tableView.scrollEnabled = NO;
    [tableView setSeparatorColor:[UIColor clearColor]];
     [tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sidebar-bg"]] ];
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [sideView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    UIImageView *imagView = [[UIImageView alloc]initWithFrame:CGRectMake(12, 5, 157, 32)];
    
    if ([[userDetails objectForKey:@"usertype_id"] isEqualToString:@"6"])
    {
        imagView.image=[arr_For_firstSection objectAtIndex:indexPath.row];

    }
    else
    {
        imagView.image=[arrSideView_serviceProvider objectAtIndex:indexPath.row];

    }

    cell.backgroundView = [[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"sidebar-bg"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0] ];
    
    [cell.contentView addSubview:imagView];
   // cell.backgroundColor=[UIColor clearColor];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *footer=[[UIView alloc] initWithFrame:CGRectMake(0,0,55,61)];
    footer.backgroundColor=[UIColor clearColor];

    UIImageView *nameImage=[[UIImageView alloc]initWithFrame:CGRectMake(55, 10, 56, 61)];
    nameImage.image=[UIImage imageNamed:@"black-logo"];

    [footer addSubview:nameImage];
    return footer;
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath.section==0)
    {
        switch ([indexPath row])
        {
             case 0:
            {
                
                UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
                if ([[userDetails objectForKey:@"usertype_id"] isEqualToString:@"6"])
                {
                HomeVC *homeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];

                NSArray *controllers = [NSArray arrayWithObject:homeVC];
                
                navigationController.viewControllers = controllers;
                }
                else
                {
                    HomeViewController *homeVC_serviceProvider = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
                    
                    NSArray *controllers = [NSArray arrayWithObject:homeVC_serviceProvider];
                    
                    navigationController.viewControllers = controllers;
                }

                [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
                
            }
                break;
                
            case 1:
            {
                MyServicesListVC *myServiceVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MyServicesListVC"];
               // accountVC.title = [NSString stringWithFormat:@"Demo #%d-%d", indexPath.section, indexPath.row];
                UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
                NSArray *controllers = [NSArray arrayWithObject:myServiceVC];
                navigationController.viewControllers = controllers;
                
                myServiceVC.str_userType=[NSString stringWithFormat:@"%@",[userDetails objectForKey:@"user_type"]];
                [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
            }
                break;
                
            case 2:
            {
                ChatUsersVC *mesaageVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ChatUsersVC"];
                //changePswd.title = [NSString stringWithFormat:@"Demo #%d-%d", indexPath.section, indexPath.row];
                UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
                NSArray *controllers = [NSArray arrayWithObject:mesaageVC];
                navigationController.viewControllers = controllers;
                [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
            }
                break;
                
            case 3:
            {
                
               // profileDetailVC.title = [NSString stringWithFormat:@"Demo #%d-%d", indexPath.section, indexPath.row];
                
                UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
                if ([[userDetails objectForKey:@"usertype_id"] isEqualToString:@"6"])
                {
                    UserProfileDetailVC *profileDetailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"UserProfileDetailVC"];
                
                NSArray *controllers = [NSArray arrayWithObject:profileDetailVC];
                navigationController.viewControllers = controllers;
                }
                else
                {
                    ProfileViewController *profileVC_serviceProvider = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
                    
                    NSArray *controllers = [NSArray arrayWithObject:profileVC_serviceProvider];
                    navigationController.viewControllers = controllers;
                }
                [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
            }
                break;
                
            case 4:
            {
                //Notification List view
                if ([[userDetails objectForKey:@"usertype_id"] isEqualToString:@"6"])
                {
                NotificationVc *notificationView = [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationVc"];
                
                UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
                NSArray *controllers = [NSArray arrayWithObject:notificationView];
                navigationController.viewControllers = controllers;
                [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
                }
                else
                {
                    ChangePasswordVC *chanePswVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangePswd"];
                    
                    UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
                    NSArray *controllers = [NSArray arrayWithObject:chanePswVC];
                    navigationController.viewControllers = controllers;
                    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
                }
            }
                break;
            case 5:
            {
                if ([[userDetails objectForKey:@"usertype_id"] isEqualToString:@"6"])
                {
                                ChangePasswordVC *chanePswVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangePswd"];
                
                                UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
                                NSArray *controllers = [NSArray arrayWithObject:chanePswVC];
                                navigationController.viewControllers = controllers;
                                [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
                }
                else
                {
                    HelpVC *HelpVC = [self.storyboard instantiateViewControllerWithIdentifier:@"HelpVC"];
                    
                    UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
                    NSArray *controllers = [NSArray arrayWithObject:HelpVC];
                    navigationController.viewControllers = controllers;
                    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
                }
            }
                break;
                
            case 6:
            {
                if ([[userDetails objectForKey:@"usertype_id"] isEqualToString:@"6"])
                {
                HelpVC *HelpVC = [self.storyboard instantiateViewControllerWithIdentifier:@"HelpVC"];
                
                UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
                NSArray *controllers = [NSArray arrayWithObject:HelpVC];
                navigationController.viewControllers = controllers;
                [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
                }
                else
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:@"You really want to logout." delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
                    [alert show];
                }
            }
                break;
                
            case 7:
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:@"You really want to logout." delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
                [alert show];
                
                
            }
                break;
                
                default:
                break;
                
        }
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if(alertView.tag == 1)
//    {
        if (buttonIndex==1)
        {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userID"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"address"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Email"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"usertype_id"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"lblStatus"];



            ViewController *MainVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
            
            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
            NSArray *controllers = [NSArray arrayWithObject:MainVC];
            navigationController.viewControllers = controllers;
            [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
        }
        else
        {
            
        }
   // }
}
@end
