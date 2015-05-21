//
//  MyServicesListVC.m
//  SERVApp
//
//  Created by Noushad Shah on 10/02/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import "MyServicesListVC.h"
#import "MyServiceListTableViewCell.h"
#import "AppManager.h"
#import "MyServiceDetailsVC.h"
#import "MFSideMenuContainerViewController.h"
#import "MFSideMenu.h"
#import "JobDetailsViewController.h"

@interface MyServicesListVC ()

@end

@implementation MyServicesListVC
@synthesize str_userType;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.array_myServicesList=[[NSMutableArray alloc]init];
    self.array_numbers=[[NSMutableArray alloc]init];
    
    [self.menuContainerViewController setPanMode:MFSideMenuPanModeDefault];


    if([[[NSUserDefaults standardUserDefaults]valueForKey:@"usertype_id"]isEqualToString:@"6"])
    
    {
        [self webServiceMyServicesList];
        lbl_title.text=@"My Services";

    }
    else
    {
        [self webServiceMyJobs];
        lbl_title.text=@"My Jobs";

    }
    // Do any additional setup after loading the view.
}
- (IBAction)TappedOnDrawer:(id)sender
{
    [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
    
}

-(void)webServiceMyServicesList
{
    //Add parameters to send server
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:
                                       
                                       @{
                                         
                                         @"user_id" :[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]
                                         
                                         }];
    
    [[AppManager sharedManager] showHUD:@"Loading..."];
    
    [[AppManager sharedManager] getDataForUrl:@"http://dev414.trigma.us/serv/Webservices/customerServices?"
     
                                   parameters:parameters
     
                                      success:^(AFHTTPRequestOperation *operation, id responseObject)
     
     {
         // Get response from server
         
         NSLog(@"JSON: %@", responseObject);//description
         
         NSString *str=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]];
         
         if ([str isEqualToString:@"customer service does not exist."])
         {
             
             alert(@"Alert!", @"customer service does not exist.");
              [[AppManager sharedManager] hideHUD];
             return;
         }
         else
         {
             self.array_myServicesList =[responseObject objectForKey:@"MyServices"];
             NSLog(@"service list array : %@", self.array_myServicesList);//description
             
             [self.Table_myServices reloadData];
             [[AppManager sharedManager] hideHUD];

         }
        
         
     }
     
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
     
     {
         
         NSLog(@"Error: %@", error);
         
         [[AppManager sharedManager] hideHUD];
         
         alert(@"Error", @"");
         
     }];
    
}

-(void)webServiceMyJobs
{
    //Add parameters to send server
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:
                                       
                                       @{
                                         
                                         @"emp_id" :[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]

                                         
                                         }];
    
    [[AppManager sharedManager] showHUD:@"Loading..."];
    
    [[AppManager sharedManager] getDataForUrl:@"http://dev414.trigma.us/serv/Webservices/EmployerJob?"
     
                                   parameters:parameters
     
                                      success:^(AFHTTPRequestOperation *operation, id responseObject)
     
     {
         // Get response from server
         
         NSLog(@"JSON: %@", responseObject);//description
         
         NSString *str=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]];
         
         if ([str isEqualToString:@"customer service does not exist."])
         {
             
             alert(@"Alert!", @"No jobs avialble.");
             [[AppManager sharedManager] hideHUD];
             return;
         }
         else
         {
             self.array_myServicesList =[responseObject objectForKey:@"MyJob"];
             NSLog(@"service list array : %@", self.array_myServicesList);//description
             
             [self.Table_myServices reloadData];
             [[AppManager sharedManager] hideHUD];
             
         }
         
     }
     
                                      failure:^(AFHTTPRequestOperation *operation, NSError *error)
     
     {
         
         NSLog(@"Error: %@", error);
         
         [[AppManager sharedManager] hideHUD];
         
         alert(@"Error", @"");
         
     }];
    
}

#pragma mark - UiTableView Delegate Method

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//    {
//        return 113;
//    }
//    else
//    {
        return 52;
   // }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    NSLog(@"array count %lu",(unsigned long)self.array_myServicesList.count);
    return [self.array_myServicesList count];
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyServiceListTableViewCell *cell = (MyServiceListTableViewCell *)[self.Table_myServices dequeueReusableCellWithIdentifier:@"Cell"];
    
    
    if (cell == nil)
    {
        //MyServiceListTableViewCell-iPhone6
        NSArray *nib;
        if (IS_IPHONE_5)
        {
          nib = [[NSBundle mainBundle] loadNibNamed:@"MyServiceListTableViewCell" owner:self options:nil];

        }
        else
        {
            nib = [[NSBundle mainBundle] loadNibNamed:@"MyServiceListTableViewCell-iPhone6" owner:self options:nil];

        }
            cell = [nib objectAtIndex:0];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.backgroundColor=[UIColor clearColor];
            
        
    }
    
    
   // if ([str_userType isEqualToString:@"User"])
    if([[[NSUserDefaults standardUserDefaults]valueForKey:@"usertype_id"]isEqualToString:@"6"])
    {
    
        cell.lbl_servicesName.text=[[self.array_myServicesList objectAtIndex:indexPath.row]objectForKey:@"category_name"];
        
        cell.lbl_hoursAgo.text=[[self.array_myServicesList objectAtIndex:indexPath.row] objectForKey:@"days"];
        
        cell.lbl_numbers.text=[NSString stringWithFormat:@"%@",[[self.array_myServicesList objectAtIndex:indexPath.row] objectForKey:@"num"]];
    
    }
    else
    {
        cell.lbl_servicesName.text=[[self.array_myServicesList objectAtIndex:indexPath.row]objectForKey:@"category name"];
        
        cell.lbl_hoursAgo.text=[[self.array_myServicesList objectAtIndex:indexPath.row] objectForKey:@"days"];
        
        cell.lbl_numbers.text=[NSString stringWithFormat:@"%@",[[self.array_myServicesList objectAtIndex:indexPath.row] objectForKey:@"num"]];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if ([str_userType isEqualToString:@"User"])
    {
        MyServiceDetailsVC *myDetailView = [self.storyboard instantiateViewControllerWithIdentifier:@"MyServiceDetailsVC"];
        
        myDetailView.str_id=[[self.array_myServicesList objectAtIndex:indexPath.row]objectForKey:@"id"];
        
        [self.navigationController pushViewController:myDetailView animated:YES];
   
    }
    else
    {
        JobDetailsViewController *jobDetailView = [self.storyboard instantiateViewControllerWithIdentifier:@"JobDetailsViewController"];
        
        jobDetailView.str_categoryID=[[self.array_myServicesList objectAtIndex:indexPath.row]objectForKey:@"id"];
        
        [self.navigationController pushViewController:jobDetailView animated:YES];
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
