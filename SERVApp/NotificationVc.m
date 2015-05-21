//
//  NotificationVc.m
//  SERVApp
//
//  Created by Surender Kumar on 23/01/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import "NotificationVc.h"
#import "NotificationCell.h"
#import "NotificationDetailVC.h"
#import "MFSideMenuContainerViewController.h"
#import "MFSideMenu.h"
#import "AppManager.h"
#import "UIImageView+WebCache.h"

@interface NotificationVc ()

@end

@implementation NotificationVc

- (void)viewDidLoad {
    [super viewDidLoad];
      [self.menuContainerViewController setPanMode:MFSideMenuPanModeNone];
    
    Arr_notificationList=[[NSMutableArray alloc]init];
    
    [self webServiceNotificationList];
//    [Arr_image  addObject:[UIImage imageNamed:@"notification-img"]];
//    [Arr_image  addObject:[UIImage imageNamed:@"notification-img2"]];
//    [Arr_image  addObject:[UIImage imageNamed:@"notification-img"]];
//    [Arr_image  addObject:[UIImage imageNamed:@"notification-img2"]];
//    [Arr_image  addObject:[UIImage imageNamed:@"notification-img"]];
//    [Arr_image  addObject:[UIImage imageNamed:@"notification-img2"]];
    // Do any additional setup after loading the view.
}

-(void)webServiceNotificationList
{
    //Add parameters to send server
    
    //ttp://dev414.trigma.us/serv/Webservices/customerNotification?user_id=738
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:
                                       
                                       @{
                                         
                                         @"user_id" :[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]
                                         
                                         
                                         }];
    
    [[AppManager sharedManager] showHUD:@"Loading..."];
    
    [[AppManager sharedManager] getDataForUrl:@"http://dev414.trigma.us/serv/Webservices/customerNotification?"
     
                                   parameters:parameters
     
                                      success:^(AFHTTPRequestOperation *operation, id responseObject)
     
     {
         
         // Get response from server
         NSLog(@"JSON: %@", responseObject);//description
         
         Arr_notificationList=[responseObject objectForKey:@"NotificationList"];
         
//         //         array_list=[[[responseObject objectForKey:@"ItemList"] valueForKey:@"Item"] valueForKey:@"Itemname"];
//         
//         array_list=[responseObject objectForKey:@"ItemList"];
//         NSLog(@"ItemName list: %@", array_list);//description  msg = "Item not found.";
//         
//         if ([[responseObject valueForKey:@"msg"]isEqualToString:@"Item not found."])
//         {
//             alert(@"Alert!", [responseObject valueForKey:@"msg"]);
//             return ;
//         }
//         
//         
         [tableVw_notifivation reloadData];
         
         [[AppManager sharedManager] hideHUD];
         
     }
     
                                      failure:^(AFHTTPRequestOperation *operation, NSError *error)
     
     {
         
         NSLog(@"Error: %@", error);
         
         [[AppManager sharedManager] hideHUD];
         
         alert(@"Error", @"");
         
     }];
    
}



#pragma mark --TableView Delegate--
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [Arr_notificationList count];    //count number of row from counting array hear cataGorry is An Array
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 83;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIImageView *imageViewHeader=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 28)];
//    imageViewHeader.image=[UIImage imageNamed:@"post-strip-bg"];
//    UILabel *lbl_ForHeader=[[UILabel alloc]initWithFrame:CGRectMake(10, 0,280,20 )];
//    lbl_ForHeader.backgroundColor=[UIColor clearColor];
//    lbl_ForHeader.textColor=[UIColor colorWithRed:102.0/255 green:102.0/255 blue:104.0/255 alpha:.9f];
//    lbl_ForHeader.font=[UIFont boldSystemFontOfSize:22];
//    // lbl_ForHeader.textAlignment=NSTextAlignmentLeft;
//    lbl_ForHeader.text=@"Posts";
//    [imageViewHeader addSubview:lbl_ForHeader];
//    return imageViewHeader;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Similar to UITableViewCell, but
    static NSString *CellIdentifier = @"CellIdentifier";
    NotificationCell *cell=[tableVw_notifivation dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil)
    {
        
        cell = [[NotificationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
        
        NSArray *topLevelObjects;
        if (IS_IPHONE_5)
        {
            topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"NotificationCell" owner:cell options:nil];
        }
        else
        {
            topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"NotificationCell-iPhone6" owner:cell options:nil];
            
        }
        
        cell=[topLevelObjects objectAtIndex:0];
        cell.selectionStyle=UITableViewCellAccessoryNone;
        
        /*
        cell.lbl_itemName.text=[[[array_list objectAtIndex:indexPath.row]objectForKey:@"Item"]valueForKey:@"Itemname"];
        
        cell.lbl_itemName.marqueeType = MLContinuous;
        cell.lbl_itemName.scrollDuration = 15.0;
        cell.lbl_itemName.animationCurve = UIViewAnimationOptionCurveEaseInOut;
        cell.lbl_itemName.fadeLength = 10.0f;
        cell.lbl_itemName.continuousMarqueeExtraBuffer = 10.0f;
        // self.lbl_location.text = OuestionString;
        cell.lbl_itemName.tag = 101;
        
        cell.lbl_itemPrice.text=[[[array_list objectAtIndex:indexPath.row]objectForKey:@"Item"]valueForKey:@"Pricing"];
        
        */
        UIImageView *imageView;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,96 , 100)];
            
        }
        else
        {
            imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,68 , 68)];
            
        }
        
        //imageView.contentMode=UIViewContentModeScaleAspectFit;
        
        imageView.layer.cornerRadius = 34;
        
        imageView.layer.borderColor=[UIColor clearColor].CGColor;
        
        imageView.clipsToBounds=YES;
        imageView.layer.borderWidth=2;
        
        
        NSURL *newImageURL=[NSURL URLWithString:[[Arr_notificationList objectAtIndex:indexPath.row] valueForKey:@"image"]];
        // [self loadImageFromURL:newImageURL];
        [imageView setImageWithURL:newImageURL placeholderImage:[UIImage imageNamed:@"product-empty.png"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        }];
        
        // cell.img_Entertainer.contentMode = UIViewContentModeScaleAspectFit;
        
        [cell.image_profileImage addSubview:imageView];
        
      //  cell.lbl_description.text=[NSString stringWithFormat:@"%@",[Arr_notificationList valueForKey:@"description"]];
        cell.lbl_time.text =[NSString stringWithFormat:@"%@",[[Arr_notificationList objectAtIndex:indexPath.row]valueForKey:@"days"]];
        cell.lbl_description.text =[NSString stringWithFormat:@"%@",[[Arr_notificationList objectAtIndex:indexPath.row]valueForKey:@"description"]];
        
        
       // [cell.button_addItem addTarget:self action:@selector(AddItemList:) forControlEvents:UIControlEventTouchUpInside];
        
       // cell.button_addItem.tag=indexPath.row;
        
        
        
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        NotificationDetailVC *notificatinDtailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationDetailVC"];

    notificatinDtailVC.str_id=[NSString stringWithFormat:@"%@",[[Arr_notificationList objectAtIndex:indexPath.row]valueForKey:@"id"]];
    
        [self.navigationController pushViewController:notificatinDtailVC animated:YES];
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

- (IBAction)TappedOnDrawer:(id)sender
{
    [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
    
}
@end
