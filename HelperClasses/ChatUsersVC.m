//
//  ChatUsersVC.m
//  SERVApp
//
//  Created by Noushad on 24/03/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import "ChatUsersVC.h"
#import "AppManager.h"
#import "HeaderFile.h"
#import "ChatUsersTableViewCell.h"
#import "PrivateChat.h"
#import "MFSideMenuContainerViewController.h"
#import "MFSideMenu.h"
#import "UIImageView+WebCache.h"

@interface ChatUsersVC ()

@end

@implementation ChatUsersVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.array_myServicesList=[[NSMutableArray alloc]init];
    
    [self webServiceForChatUsersList];
    
    // Do any additional setup after loading the view.
}

-(IBAction)backBtnAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)webServiceForChatUsersList
{
    //Add parameters to send server
   //ttp://dev414.trigma.us/serv/Webservices/onlineEmp?user_id=677
  //ttp://dev414.trigma.us/serv/Webservices/onlineServiceProvider?user_id=727
    
    NSString *str_serviceUrl;
    NSMutableDictionary *parameters;
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"usertype_id"]isEqualToString:@"6"])
    {
        str_serviceUrl=@"http://dev414.trigma.us/serv/Webservices/onlineServiceProvider?";
        parameters = [NSMutableDictionary dictionaryWithDictionary:
                      
                      @{
                        
                        @"user_id" :[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]
                        
                        }];
    }
    else
    {
        str_serviceUrl=@"http://dev414.trigma.us/serv/Webservices/onlineCustomer?";
        parameters = [NSMutableDictionary dictionaryWithDictionary:
                      
                      @{
                        
                        @"emp_id" :[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]
                        
                        }];

    }

    
    
    
    [[AppManager sharedManager] showHUD:@"Loading..."];

    
    [[AppManager sharedManager] getDataForUrl:str_serviceUrl
     
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
             if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"usertype_id"]isEqualToString:@"6"])
             {
             self.array_myServicesList =[responseObject objectForKey:@"onlineServiceProvider"];
             }
             else
             {
                 self.array_myServicesList =[responseObject objectForKey:@"onlineCustomer"];

             }
             NSLog(@"service list array : %@", self.array_myServicesList);//description
             
             [self.table_chatUsers reloadData];
             [[AppManager sharedManager] hideHUD];
             
         }
         
         
         //  NSLog(@"service list array : %@", self.array_numbers);//description
         
         //  [self.Table_myServices reloadData];
         
         
         
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
    return 54;
    // }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    NSLog(@"array count %lu",(unsigned long)self.array_myServicesList.count);
    return [self.array_myServicesList count];
    
    
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   ChatUsersTableViewCell *cell = (ChatUsersTableViewCell *)[self.table_chatUsers dequeueReusableCellWithIdentifier:@"Cell"];
    
    
    if (cell == nil)
    {
        //MyServiceListTableViewCell-iPhone6
        NSArray *nib;
        if (IS_IPHONE_5)
        {
            nib = [[NSBundle mainBundle] loadNibNamed:@"ChatUsersTableViewCell" owner:self options:nil];
            
        }
        else
        {
            nib = [[NSBundle mainBundle] loadNibNamed:@"ChatUsersTableViewCell-iPhone6" owner:self options:nil];
            
        }
        cell = [nib objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.backgroundColor=[UIColor clearColor];
        
        
    }
    
    /*
    if ([str_userType isEqualToString:@"User"])
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
    
    */
    
    UIImageView *imageView;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,96 , 100)];
        
    }
    else
    {
        imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,46 , 46)];
        
    }
    
   // imageView.contentMode=UIViewContentModeScaleAspectFit;
    imageView.layer.cornerRadius = 23;
    
    imageView.layer.borderColor=[UIColor clearColor].CGColor;
    
    imageView.clipsToBounds=YES;
    
    imageView.layer.borderWidth=2;
    
    
    NSURL *newImageURL=[NSURL URLWithString:[[self.array_myServicesList objectAtIndex:indexPath.row] valueForKey:@"image"]];
    // [self loadImageFromURL:newImageURL];
    [imageView setImageWithURL:newImageURL placeholderImage:[UIImage imageNamed:@"product-empty.png"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
    }];
    
    // cell.img_Entertainer.contentMode = UIViewContentModeScaleAspectFit;
    
    [cell.image_profilePic addSubview:imageView];

    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"usertype_id"]isEqualToString:@"6"])
    {
    cell.lbl_Name.text=[NSString stringWithFormat:@"%@",[[self.array_myServicesList objectAtIndex:indexPath.row] valueForKey:@"emp_name"]];
    }
    else
    {
        cell.lbl_Name.text=[NSString stringWithFormat:@"%@",[[self.array_myServicesList objectAtIndex:indexPath.row] valueForKey:@"customer_name"]];

    }
     cell.lbl_serviceORcustomer.text=[NSString stringWithFormat:@"%@",[[self.array_myServicesList objectAtIndex:indexPath.row] valueForKey:@"service"]];
    
    return cell;
     
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    /*
    if ([str_userType isEqualToString:@"User"])
    {
        MyServiceDetailsVC *myDetailView = [self.storyboard instantiateViewControllerWithIdentifier:@"MyServiceDetailsVC"];
        
        myDetailView.str_id=[[self.array_myServicesList objectAtIndex:indexPath.row]objectForKey:@"id"];
        
        [self.navigationController pushViewController:myDetailView animated:YES];
        
    }
    else
    {
        JobDetailsViewController *jobDetailView = [self.storyboard instantiateViewControllerWithIdentifier:@"JobDetailsViewController"];
        
        jobDetailView.str_categoryID=[[self.array_myServicesList objectAtIndex:indexPath.row]objectForKey:@"category_id"];
        
        [self.navigationController pushViewController:jobDetailView animated:YES];
    }*/
    
    
    
    
    PrivateChat *privateChatVC=[self.storyboard instantiateViewControllerWithIdentifier:@"PrivateChat"];
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"usertype_id"]isEqualToString:@"6"])
    {
        privateChatVC.str_serviceProviderId=[[self.array_myServicesList objectAtIndex:indexPath.row] valueForKey:@"emp_id"];
    
    }
    else
    {
        privateChatVC.str_serviceProviderId=[[self.array_myServicesList objectAtIndex:indexPath.row] valueForKey:@"customer_id"];
    }
    
    [self.navigationController pushViewController:privateChatVC animated:YES];
    
}

-(IBAction)slideBtnAction:(id)sender

{
    [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 


@end
