//
//  JobsViewController.m
//  ServApp_provider
//  Created by TRun ShRma on 12/02/15.
//  Copyright (c) 2015 Tarun. All rights reserved.
//

#import "JobsViewController.h"
#import "MFSideMenu.h"
#import "SideMenuViewController.h"
#import "AppManager.h"

@interface JobsViewController ()
@end
@implementation JobsViewController

- (void)viewDidLoad
{
    [self.menuContainerViewController setPanMode:MFSideMenuPanModeDefault];
      SomeArray = [NSMutableArray arrayWithObjects:@"Contact 1",@"Contact 2",@"Contact 3",@"Contact 4",@"Contact 5",@"Contact 6",@"Contact 7",@"Contact 8",@"Contact 9",@"Contact 10",nil];
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self webServiceGetJobList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Mark TableView Delegates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [SomeArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:MyIdentifier];
    }
   UIImageView *imv = [[UIImageView alloc]initWithFrame:CGRectMake(15,10, 60, 60)];
   //NSString *imageString = [[SomeArray valueForKey:@"yellow-rect"] objectAtIndex:indexPath.row];
   //NSURL *url = [NSURL URLWithString:imageString];
   //NSData * imageData = [[NSData alloc] initWithContentsOfURL:url];
   //imv.image = [UIImage imageWithData: imageData];
    
   //imv.layer.backgroundColor=[[UIColor clearColor] CGColor];
   //imv.layer.cornerRadius=30;
   //imv.layer.borderWidth=2.0;
   //imv.layer.masksToBounds = YES;
   //imv.layer.borderColor=[[UIColor grayColor] CGColor];
    
    UILabel *ContactName = [[UILabel alloc]initWithFrame:CGRectMake(85, 18, 120, 20)];
    UILabel *CompanyName = [[UILabel alloc]initWithFrame:CGRectMake(100, 35, 120, 20)];
    
//    ContactName.text = [[SomeArray valueForKey:@"name"] objectAtIndex:indexPath.row];
//    [ContactName setFont:[UIFont systemFontOfSize:15]];
//    ContactName.textColor = [UIColor blackColor];
//    CompanyName.text = [[SomeArray valueForKey:@"company"] objectAtIndex:indexPath.row];
//    CompanyName.textColor = [UIColor lightGrayColor];
//    [CompanyName setFont:[UIFont systemFontOfSize:10]];
    
    UIImageView *BoxImage = [[UIImageView alloc]initWithFrame:CGRectMake(15,15, 50 , 50)];
    BoxImage.image=[UIImage imageNamed:@"yellow-rect"];
    UIImageView *ArrowImage = [[UIImageView alloc]initWithFrame:CGRectMake(280,40, 12 , 15)];
    ArrowImage.image=[UIImage imageNamed:@"next-greyarrow"];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bar.png"]];
    [cell.contentView addSubview:imv];
    [cell.contentView addSubview:BoxImage];
    [cell.contentView addSubview:ArrowImage];
    [cell.contentView addSubview:ContactName];
    [cell.contentView addSubview:CompanyName];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSString *selectedIndexString = [NSString stringWithFormat:@"%d",indexPath.row];
//    [[NSUserDefaults standardUserDefaults] setValue:selectedIndexString forKey:@"SelectedIndexValue"];
//    NSString *PersonID = [[jsonDict valueForKey:@"id"] objectAtIndex:indexPath.row];
//    [[NSUserDefaults standardUserDefaults]setValue:PersonID forKey:@"PersonID"];
//    [exportValuesArray addObject:selectedIndexString];
//    ShareViewController *Obj_ShareViewController = [[ShareViewController alloc]init];
//    [self.navigationController pushViewController:Obj_ShareViewController animated:YES];
}



- (IBAction)TappedOnDrawer:(id)sender
{
    [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
}



-(void)webServiceGetJobList
{
   //Add parameters to send server
  //http://dev414.trigma.us/serv/Webservices/EmployerJob?emp_id=25
    NSString *UserId = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"UserId"]];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:
                                         @{
                                         @"emp_id" :UserId,
                                         }];
    // [[AppManager sharedManager] showHUD];
    [[AppManager sharedManager] getDataForUrl:@"http://dev414.trigma.us/serv/Webservices/EmployerJob?"
                                   parameters:parameters
                                      success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
         NSLog(@"JSON: %@", responseObject);//description
        NSString *StatusString = [[responseObject valueForKey:@"status"] stringValue];
        if ([StatusString isEqualToString:@"1"])
        {
            alert(@"Error", @"");
            [_JobTableView setHidden:NO];

        }
        else
        {
            NSString *messageString = [responseObject valueForKey:@"message"];
            [_JobTableView setHidden:YES];
            alert(messageString, @"");
        }
    }
        failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
         //[appdelRef hideProgress];
         alert(@"Error", @"");
     }];
}




@end
