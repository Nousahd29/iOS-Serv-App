//
//  PrivateChat.m
//  Havoc
//
//  Created by Preeti Malhotra on 7/26/14.
//  Copyright (c) 2014 Preeti Malhotra. All rights reserved.
//

#import "PrivateChat.h"
#define myfont @"Verdana"
#import "AsyncImageView.h"

#define kSEARCH_RESULT_LOCATION_KEY @"searchResultLocationKey"
#define kSEARCH_RESULT_CONTEXT_STRING_KEY @"searchResultContextStringKey"
#define kSEARCH_RESULT_CONTEXT_LOCATION_KEY @"searchResultContextLocationKey"
#define kSEARCH_RESULT_LOCATION_IN_CONTEXT_KEY @"searchResultLocationInContextKey"
#define CHAR_COUNT_PRECEDING_RESULT 0
#define CHAR_COUNT_FOLLOWING_RESULT 0

@interface PrivateChat ()

@end

@implementation PrivateChat
@synthesize str_serviceProviderId;


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {
        
        [_txtx_view resignFirstResponder];
        // Return FALSE so that the final '\n' character doesn't get added
        return NO;
    }
    // For any other character return TRUE so that the text gets added to the view
    return YES;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _photo_view.hidden=YES;
    camera_pop_up.hidden=YES;
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    
     _txtx_view.autocorrectionType = UITextAutocorrectionTypeNo;
    
    int stickerheight = 10;
    
    
    
    chattable.separatorColor=[UIColor clearColor];
    [self scrollToBottom];
    //chattable.contentOffset = CGPointMake(0.0f, 390.0f);
    _txtx_view.layer.cornerRadius=5;
    
    
    chattable.delegate=self;
    chattable.dataSource=self;
    
    
    _txtx_view.delegate=self;
    
    heightarray = [[NSMutableArray alloc]init];
    [heightarray addObject:@"0"];
    // Do any additional setup after loading the view.
    self.bottom_View.backgroundColor=[UIColor blackColor];
    
    
    [self retrivechat];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    [self retrivechat];
    ShowImageView.hidden = YES;
    
   // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(webServiceStatusActive) name:@"notificationAlert" object:nil];

    
}
-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(retrivechat) name:@"notificationAlert" object:nil];
}
-(IBAction)backBtnAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dismissKeyboard
{
    [_txtx_view endEditing:YES];
}


-(void)retrivechat
{
    //id,friend_id,message_type
    
    //  str_friend_id=[[NSUserDefaults standardUserDefaults]valueForKey:@"FRNDID"];
    
    NSURL *urli = [NSURL URLWithString:[NSString stringWithFormat:@"http://dev414.trigma.us/serv/Webservices/chat?"]];
    NSString * str = [NSString stringWithFormat:@"sender_id=%@&receiver_id=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"],self.str_serviceProviderId];
    NSLog(@"%@",str);
    NSData * postData = [str dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:urli];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSError * error = nil;
    NSURLResponse * response = nil;
    //    NSURLConnection * connec = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSDictionary* jsonData;
    if(data)
    {
        jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    }
    
    NSLog(@"%@",response);
    NSLog(@"%@",jsonData);
    
    
    //NSMutableString *arr_channel_name;msg = No Chat Found
    
//    if ([[response valueForKey:@"msg"]isEqualToString:@"No Chat Found"]) {
//        
//        alert(@"Alert!", @"No Chat Found");
//    }
//    else
//    {
    
    messages=[[NSMutableArray alloc]init];
    
    
    // [self.messages removeObjectAtIndex:0];
    
    sortedArray=[[NSMutableArray alloc]init];
    sortedArray=[jsonData objectForKey:@"chatHistory"];
    
    
    
    arr_msg_type=[[NSMutableArray alloc]init];
    arr_msg_type=[sortedArray valueForKey:@"message_type"];

    
    
    messages=[sortedArray valueForKey:@"message"];
    //  NSLog(@"%@.....",messages);
    chatter_name =[sortedArray valueForKey:@"name"];
    //  NSLog(@"%@",chatter_name);
    
    [chattable reloadData];
    [self scrollToBottom];
   // }
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [messages count];
    
    //count number of row from counting array hear cataGorry is An Array
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    chattable.separatorStyle=UITableViewCellSeparatorStyleNone;
    [cell setUserInteractionEnabled:NO];
    
    
    if (cell==nil)
    {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    
    for(UIView *cellView in [cell.contentView subviews])
    {
        if (![cellView isKindOfClass:[UIImageView class]] || ![cellView isKindOfClass:[UILabel class]])
        {
            [cellView removeFromSuperview];
        }
    }
    
    [cell setUserInteractionEnabled:YES];
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor colorWithRed:255.0/242.0 green:255.0/242.0 blue:255.0/242.0 alpha:1];
   // cell.backgroundColor=[UIColor darkGrayColor];
  
    if ([[[sortedArray valueForKey:@"Is_User_Chat"] objectAtIndex:indexPath.row ] isEqualToString:@"In"])
    {
        
        if ([[arr_msg_type objectAtIndex:indexPath.row]isEqualToString:@"image"])
        {
            CGRect screenRect = [[UIScreen mainScreen] bounds];
            CGFloat screenHeight = screenRect.size.height;
            if(screenHeight == 568)
            {
                
            profile_picture = [[UIImageView alloc] initWithFrame:CGRectMake(10, 50, 35, 35)];
            profile_picture.backgroundColor = [UIColor lightGrayColor];
            profile_picture.layer.cornerRadius = profile_picture.frame.size.width/2;
            profile_picture.layer.borderColor = [UIColor whiteColor].CGColor;
            profile_picture.layer.borderWidth = 0.0f;
            profile_picture.clipsToBounds = YES;
            [cell.contentView addSubview:profile_picture];
            
            Imageview=[[UIImageView alloc]initWithFrame:CGRectMake(40,40,270,80)];
            Imageview.image=[UIImage imageNamed:@"grey-message-bg.png"];
            [cell.contentView addSubview:Imageview];
            
            camera_image = [[UIImageView alloc] initWithFrame:CGRectMake(120,5, 60, 70)];
            camera_image.layer.cornerRadius=5;
            camera_image.clipsToBounds=YES;
            
            camera_image.imageURL=[NSURL URLWithString:[[sortedArray objectAtIndex:indexPath.row] valueForKey:@"message"]];
            url = [NSString stringWithFormat:@"%@",[[sortedArray objectAtIndex:indexPath.row] valueForKey:@"message"]];
            ImageButton.tag = indexPath.row;
            [ImageButton addTarget:self action:@selector(ImageButtn:) forControlEvents:UIControlEventTouchUpInside];
            camera_image.contentMode=UIViewContentModeScaleAspectFit;
            ImageButtn = [[UIButton alloc] initWithFrame:CGRectMake(140,10, 150, 140)];
            ImageButtn.tag = indexPath.row;
            [cell.contentView addSubview:ImageButtn];
            
            
            [Imageview addSubview:camera_image];
            [cell.contentView addSubview:ImageButton];
            
            ImageButton.tag = indexPath.row;
            
            namelbl=[[UILabel alloc] init];
            namelbl.frame = CGRectMake(8, 10, 100, 15);
            namelbl.backgroundColor = [UIColor clearColor];
            namelbl.textColor = [UIColor blackColor];
            namelbl.font=[UIFont fontWithName:@"Helvetica" size:12.0];
            [Imageview addSubview:namelbl];
            
            
            NameButton=[[UIButton alloc] init];
            NameButton.frame = CGRectMake(20,50, 100, 15);
            NameButton.backgroundColor = [UIColor clearColor];
            NameButton.titleLabel.textColor = [UIColor clearColor];
            NameButton.titleLabel.font=[UIFont fontWithName:@"Helvetica" size:12.0];
            NameButton.titleLabel.textAlignment = NSTextAlignmentRight;
            [NameButton addTarget:self action:@selector(openprofile) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:NameButton];
            namelbl.text=[chatter_name objectAtIndex:indexPath.row];
            
            NSString *strLocalTime = [sortedArray valueForKey:@"chat_time"][indexPath.row];
            timeLbl1 = [[UILabel alloc]init];
            timeLbl1.backgroundColor = [UIColor clearColor];
            timeLbl1.textColor = [UIColor blackColor];
            timeLbl1.textAlignment = NSTextAlignmentCenter;
            timeLbl1.font=[UIFont fontWithName:@"Helvetica" size:12.0];
            timeLbl1.text = strLocalTime;
            timeLbl1.frame = CGRectMake(140,Imageview.frame.size.height+40,140,10);
            namelbl.text=[chatter_name objectAtIndex:indexPath.row];
            [cell.contentView addSubview:timeLbl1];

            NSMutableArray * result= [[NSMutableArray alloc]init];
            result=[sortedArray valueForKey:@"user_pic"];
            profile_picture.imageURL=[NSURL URLWithString:[result objectAtIndex:indexPath.row]];
                
            profile_picture.frame=CGRectMake(10, Imageview.frame.size.height, 35, 35);
                
            }
            else if (screenHeight == 667)
            {
                
                
                profile_picture = [[UIImageView alloc] initWithFrame:CGRectMake(10, 50, 35, 35)];
                profile_picture.backgroundColor = [UIColor lightGrayColor];
                profile_picture.layer.cornerRadius = profile_picture.frame.size.width/2;
                profile_picture.layer.borderColor = [UIColor whiteColor].CGColor;
                profile_picture.layer.borderWidth = 0.0f;
                profile_picture.clipsToBounds = YES;
                [cell.contentView addSubview:profile_picture];
                
                Imageview=[[UIImageView alloc]initWithFrame:CGRectMake(47,40,310,80)];
                Imageview.image=[UIImage imageNamed:@"grey-message-bg.png"];
                [cell.contentView addSubview:Imageview];
                
                camera_image = [[UIImageView alloc] initWithFrame:CGRectMake(120,5, 60, 70)];
                camera_image.layer.cornerRadius=5;
                camera_image.clipsToBounds=YES;
                
                camera_image.imageURL=[NSURL URLWithString:[[sortedArray objectAtIndex:indexPath.row] valueForKey:@"message"]];
                url = [NSString stringWithFormat:@"%@",[[sortedArray objectAtIndex:indexPath.row] valueForKey:@"message"]];
                ImageButton.tag = indexPath.row;
                [ImageButton addTarget:self action:@selector(ImageButtn:) forControlEvents:UIControlEventTouchUpInside];
                camera_image.contentMode=UIViewContentModeScaleAspectFit;
                ImageButtn = [[UIButton alloc] initWithFrame:CGRectMake(140,10, 150, 140)];
                ImageButtn.tag = indexPath.row;
                [cell.contentView addSubview:ImageButtn];
                
                
                [Imageview addSubview:camera_image];
                [cell.contentView addSubview:ImageButton];
                ImageButton.tag = indexPath.row;
                
                namelbl=[[UILabel alloc] init];
                namelbl.frame = CGRectMake(8, 10, 100, 15);
                namelbl.backgroundColor = [UIColor clearColor];
                namelbl.textColor = [UIColor blackColor];
                namelbl.font=[UIFont fontWithName:@"Helvetica" size:12.0];
                [Imageview addSubview:namelbl];
                
                
                NameButton=[[UIButton alloc] init];
                NameButton.frame = CGRectMake(20,50, 100, 15);
                NameButton.backgroundColor = [UIColor clearColor];
                NameButton.titleLabel.textColor = [UIColor clearColor];
                NameButton.titleLabel.font=[UIFont fontWithName:@"Helvetica" size:12.0];
                NameButton.titleLabel.textAlignment = NSTextAlignmentRight;
                [NameButton addTarget:self action:@selector(openprofile) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:NameButton];
                namelbl.text=[chatter_name objectAtIndex:indexPath.row];
                
                NSString *strLocalTime = [sortedArray valueForKey:@"chat_time"][indexPath.row];
                timeLbl1 = [[UILabel alloc]init];
                timeLbl1.backgroundColor = [UIColor clearColor];
                timeLbl1.textColor = [UIColor blackColor];
                timeLbl1.textAlignment = NSTextAlignmentCenter;
                timeLbl1.font=[UIFont fontWithName:@"Helvetica" size:12.0];
                timeLbl1.text = strLocalTime;
                timeLbl1.frame = CGRectMake(190,Imageview.frame.size.height+40,140,10);
                namelbl.text=[chatter_name objectAtIndex:indexPath.row];
                [cell.contentView addSubview:timeLbl1];
                
                NSMutableArray * result= [[NSMutableArray alloc]init];
                result=[sortedArray valueForKey:@"user_pic"];
                profile_picture.imageURL=[NSURL URLWithString:[result objectAtIndex:indexPath.row]];
                
                profile_picture.frame=CGRectMake(15, Imageview.frame.size.height, 35, 35);
                
                
            }
            
        }

         else  if ([[arr_msg_type objectAtIndex:indexPath.row]isEqualToString:@"text"])
        {
            
            CGRect screenRect = [[UIScreen mainScreen] bounds];
            CGFloat screenHeight = screenRect.size.height;
           if(screenHeight == 568)
           {

            profile_picture = [[UIImageView alloc] initWithFrame:CGRectMake(10, 50, 35, 35)];
            profile_picture.backgroundColor = [UIColor lightGrayColor];
            profile_picture.layer.cornerRadius = profile_picture.frame.size.width/2;
            profile_picture.layer.borderColor = [UIColor whiteColor].CGColor;
            profile_picture.layer.borderWidth = 0.0f;
            profile_picture.clipsToBounds = YES;
            [cell.contentView addSubview:profile_picture];

            
            
            arrowImgVw = [[UIImageView alloc] initWithFrame:CGRectMake(56, 8, 15, 15)];
            [cell.contentView addSubview:arrowImgVw];
            msgLblContainer = [[UIView alloc] initWithFrame:CGRectMake(70, 25, 245, 40)];
            [cell.contentView addSubview:msgLblContainer];
            [cell.contentView bringSubviewToFront:arrowImgVw];
            
            
            personImgVw = [[UIImageView alloc]init];
            personImgVw.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:personImgVw];
        
            
            namelbl=[[UILabel alloc] init];
            namelbl.backgroundColor = [UIColor clearColor];
            namelbl.textColor = [UIColor blackColor];
            namelbl.font=[UIFont fontWithName:@"Helvetica" size:12.0];
            namelbl.textAlignment = NSTextAlignmentCenter;
            [msgLblContainer addSubview:namelbl];
            
            
            
            
            msgLbl = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 230, 30)];
            msgLbl.backgroundColor = [UIColor clearColor];
            msgLbl.textAlignment = NSTextAlignmentLeft;
            msgLbl.font = [UIFont fontWithName:@"Verdana" size:13.0];
            msgLbl.textColor = [UIColor darkGrayColor];
            [msgLblContainer addSubview:msgLbl];
            
            
            timeLbl=[[UILabel alloc] init];
            timeLbl.backgroundColor = [UIColor clearColor];
            timeLbl.textColor = [UIColor blackColor];
            timeLbl.textAlignment = NSTextAlignmentCenter;
            timeLbl.font=[UIFont fontWithName:@"Helvetica" size:12.0];
            
            [cell.contentView addSubview:timeLbl];
            
            CGSize size = [[sortedArray valueForKey:@"message"][indexPath.row] sizeWithFont:msgLbl.font constrainedToSize:CGSizeMake(225, 99999)];
            
            NSString *strLocalTime = [sortedArray valueForKey:@"chat_time"][indexPath.row];
            NSLog(@"strLocalTime:=%@",strLocalTime);
            [heightarray addObject:[NSString stringWithFormat:@"%f",size.height]];
            [[NSUserDefaults standardUserDefaults] setObject:heightarray forKey:@"HGTARY"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            timeLbl.text=strLocalTime;
            
            timeLbl.backgroundColor=[UIColor clearColor];
            namelbl.frame = CGRectMake(15, 5, 200, 15);
            namelbl.textAlignment=NSTextAlignmentLeft;
            timeLbl.textAlignment=NSTextAlignmentRight;
            
            
            msgLbl.numberOfLines = size.height/msgLbl.font.lineHeight;
            msgLbl.frame = CGRectMake(15, 20, size.width+10, size.height+10);
            msgLbl.text =  [sortedArray valueForKey:@"message"][indexPath.row];

//            if ([messages objectAtIndex:indexPath.row] == [NSNull null]) {
//                profile_picture.image = [UIImage imageNamed:@"userwithimg.png"];
//            }
//            else
//            {
                NSMutableArray * result= [[NSMutableArray alloc]init];
                result=[sortedArray valueForKey:@"user_pic"];
                profile_picture.imageURL=[NSURL URLWithString:[result objectAtIndex:indexPath.row]];
                //   NSLog(@"%@",result);

          //  }

            msgLblContainer.frame = CGRectMake(40,40,
                                               270,
                                               msgLbl.frame.size.height+20);

            timeLbl.textColor=[UIColor blackColor];
            timeLbl.frame = CGRectMake(140, msgLblContainer.frame.size.height+40,
                                       140,
                                      10);

            personImgVw.frame=CGRectMake(5, 50, 5, 9);

            if(msgLbl.numberOfLines == 1)
                msgLblContainer.frame = CGRectMake(40,40,
                                                   270,
                                                   msgLbl.frame.size.height+20);

            profile_picture.frame=CGRectMake(10, msgLbl.frame.size.height+20, 35, 35);
            
            timeLbl.textAlignment=NSTextAlignmentRight;

            personImgVw.frame=CGRectMake(15, 50, 5, 9);

            //personImgVw.image=[UIImage imageNamed:@"arrow@2x.png"];

            UIGraphicsBeginImageContext(msgLblContainer.frame.size);
            [[UIImage imageNamed:@"grey-message-bg.png"] drawInRect:msgLblContainer.bounds];


            UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();



            msgLblContainer.backgroundColor = [UIColor colorWithPatternImage:image];


           namelbl.text=[chatter_name objectAtIndex:indexPath.row];
                   
                   
               
           }
            else if(screenHeight == 667)
            {
               
                profile_picture = [[UIImageView alloc] initWithFrame:CGRectMake(10, 50, 35, 35)];
                profile_picture.backgroundColor = [UIColor lightGrayColor];
                profile_picture.layer.cornerRadius = profile_picture.frame.size.width/2;
                profile_picture.layer.borderColor = [UIColor whiteColor].CGColor;
                profile_picture.layer.borderWidth = 0.0f;
                profile_picture.clipsToBounds = YES;
                [cell.contentView addSubview:profile_picture];
                
                
                
                arrowImgVw = [[UIImageView alloc] initWithFrame:CGRectMake(56, 8, 15, 15)];
                [cell.contentView addSubview:arrowImgVw];
                
                msgLblContainer = [[UIView alloc] initWithFrame:CGRectMake(70, 25, 295, 40)];
                [cell.contentView addSubview:msgLblContainer];
                [cell.contentView bringSubviewToFront:arrowImgVw];
                
                
                personImgVw = [[UIImageView alloc]init];
                personImgVw.backgroundColor = [UIColor clearColor];
                [cell.contentView addSubview:personImgVw];
                
                
                namelbl=[[UILabel alloc] init];
                namelbl.backgroundColor = [UIColor clearColor];
                namelbl.textColor = [UIColor blackColor];
                namelbl.font=[UIFont fontWithName:@"Helvetica" size:12.0];
                namelbl.textAlignment = NSTextAlignmentCenter;
                [msgLblContainer addSubview:namelbl];
                
                
                
                
                msgLbl = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 280, 30)];
                msgLbl.backgroundColor = [UIColor clearColor];
                msgLbl.textAlignment = NSTextAlignmentLeft;
                msgLbl.font = [UIFont fontWithName:@"Verdana" size:13.0];
                msgLbl.textColor = [UIColor darkGrayColor];
                [msgLblContainer addSubview:msgLbl];
                
                
                timeLbl=[[UILabel alloc] init];
                timeLbl.backgroundColor = [UIColor clearColor];
                timeLbl.textColor = [UIColor blackColor];
                timeLbl.textAlignment = NSTextAlignmentCenter;
                timeLbl.font=[UIFont fontWithName:@"Helvetica" size:12.0];
                
                [cell.contentView addSubview:timeLbl];
                
                CGSize size = [[sortedArray valueForKey:@"message"][indexPath.row] sizeWithFont:msgLbl.font constrainedToSize:CGSizeMake(225, 99999)];
                
                NSString *strLocalTime = [sortedArray valueForKey:@"chat_time"][indexPath.row];
                NSLog(@"strLocalTime:=%@",strLocalTime);
                [heightarray addObject:[NSString stringWithFormat:@"%f",size.height]];
                [[NSUserDefaults standardUserDefaults] setObject:heightarray forKey:@"HGTARY"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                timeLbl.text=strLocalTime;
                
                timeLbl.backgroundColor=[UIColor clearColor];
                namelbl.frame = CGRectMake(15, 5, 200, 15);
                namelbl.textAlignment=NSTextAlignmentLeft;
                timeLbl.textAlignment=NSTextAlignmentRight;
                
                
                msgLbl.numberOfLines = size.height/msgLbl.font.lineHeight;
                msgLbl.frame = CGRectMake(15, 20, size.width+10, size.height+10);
                msgLbl.text =  [sortedArray valueForKey:@"message"][indexPath.row];
                
                //            if ([messages objectAtIndex:indexPath.row] == [NSNull null]) {
                //                profile_picture.image = [UIImage imageNamed:@"userwithimg.png"];
                //            }
                //            else
                //            {
                NSMutableArray * result= [[NSMutableArray alloc]init];
                result=[sortedArray valueForKey:@"user_pic"];
                profile_picture.imageURL=[NSURL URLWithString:[result objectAtIndex:indexPath.row]];
                //   NSLog(@"%@",result);
                
                //  }
                
                msgLblContainer.frame = CGRectMake(40,40,
                                                   320,
                                                   msgLbl.frame.size.height+20);
                
                timeLbl.textColor=[UIColor blackColor];
                timeLbl.frame = CGRectMake(190, msgLblContainer.frame.size.height+40,
                                           140,
                                           10);
                
                personImgVw.frame=CGRectMake(5, 50, 5, 9);
                
                if(msgLbl.numberOfLines == 1)
                    msgLblContainer.frame = CGRectMake(40,40,
                                                       320,
                                                       msgLbl.frame.size.height+20);
                
                profile_picture.frame=CGRectMake(10, msgLbl.frame.size.height+20, 35, 35);
                
                timeLbl.textAlignment=NSTextAlignmentRight;
                
                personImgVw.frame=CGRectMake(15, 50, 5, 9);
                
                //personImgVw.image=[UIImage imageNamed:@"arrow@2x.png"];
                
                UIGraphicsBeginImageContext(msgLblContainer.frame.size);
                [[UIImage imageNamed:@"grey-message-bg.png"] drawInRect:msgLblContainer.bounds];
                
                
                UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                
                
                
                msgLblContainer.backgroundColor = [UIColor colorWithPatternImage:image];
                
                
                namelbl.text=[chatter_name objectAtIndex:indexPath.row];
                
                
            }
            
        }
        
        
    }
    else
    {
        
        if ([[arr_msg_type objectAtIndex:indexPath.row]isEqualToString:@"image"])
        {
            CGRect screenRect = [[UIScreen mainScreen] bounds];
            CGFloat screenHeight = screenRect.size.height;
            if(screenHeight == 568)
            {
                
                profile_picture = [[UIImageView alloc] initWithFrame:CGRectMake(275, 49, 35, 35)];
                profile_picture.backgroundColor = [UIColor lightGrayColor];
                profile_picture.layer.cornerRadius = profile_picture.frame.size.width/2;
                profile_picture.layer.borderColor = [UIColor whiteColor].CGColor;
                profile_picture.layer.borderWidth = 0.0f;
                profile_picture.clipsToBounds = YES;
                [cell.contentView addSubview:profile_picture];
                
                Imageview=[[UIImageView alloc]initWithFrame:CGRectMake(30 ,40, 250, 80)];
                Imageview.image=[UIImage imageNamed:@"yellow-message-bg.png"];
                [cell.contentView addSubview:Imageview];
                
                camera_image = [[UIImageView alloc] initWithFrame:CGRectMake(120,5, 60, 70)];
                camera_image.layer.cornerRadius=5;
                camera_image.clipsToBounds=YES;
                
                camera_image.imageURL=[NSURL URLWithString:[[sortedArray objectAtIndex:indexPath.row] valueForKey:@"message"]];
                url = [NSString stringWithFormat:@"%@",[[sortedArray objectAtIndex:indexPath.row] valueForKey:@"message"]];
                ImageButton.tag = indexPath.row;
                [ImageButton addTarget:self action:@selector(ImageButtn:) forControlEvents:UIControlEventTouchUpInside];
                camera_image.contentMode=UIViewContentModeScaleAspectFit;
                ImageButtn = [[UIButton alloc] initWithFrame:CGRectMake(140,10, 150, 140)];
                ImageButtn.tag = indexPath.row;
                [cell.contentView addSubview:ImageButtn];
                
                
                [Imageview addSubview:camera_image];
                [cell.contentView addSubview:ImageButton];
                
                ImageButton.tag = indexPath.row;
                
                namelbl=[[UILabel alloc] init];
                namelbl.frame = CGRectMake(8, 10, 100, 15);
                namelbl.backgroundColor = [UIColor clearColor];
                namelbl.textColor = [UIColor blackColor];
                namelbl.font=[UIFont fontWithName:@"Helvetica" size:12.0];
                [Imageview addSubview:namelbl];
                
                
                NameButton=[[UIButton alloc] init];
                NameButton.frame = CGRectMake(20,50, 100, 15);
                NameButton.backgroundColor = [UIColor clearColor];
                NameButton.titleLabel.textColor = [UIColor clearColor];
                NameButton.titleLabel.font=[UIFont fontWithName:@"Helvetica" size:12.0];
                NameButton.titleLabel.textAlignment = NSTextAlignmentRight;
                [NameButton addTarget:self action:@selector(openprofile) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:NameButton];
                namelbl.text=[chatter_name objectAtIndex:indexPath.row];
                
                NSString *strLocalTime = [sortedArray valueForKey:@"chat_time"][indexPath.row];
                timeLbl1 = [[UILabel alloc]init];
                timeLbl1.backgroundColor = [UIColor clearColor];
                timeLbl1.textColor = [UIColor blackColor];
                timeLbl1.textAlignment = NSTextAlignmentCenter;
                timeLbl1.font=[UIFont fontWithName:@"Helvetica" size:12.0];
                timeLbl1.text = strLocalTime;
                timeLbl1.frame = CGRectMake(140,Imageview.frame.size.height+40,140,10);
                namelbl.text=[chatter_name objectAtIndex:indexPath.row];
                [cell.contentView addSubview:timeLbl1];
                
                NSMutableArray * result= [[NSMutableArray alloc]init];
                result=[sortedArray valueForKey:@"user_pic"];
                profile_picture.imageURL=[NSURL URLWithString:[result objectAtIndex:indexPath.row]];
                
                profile_picture.frame=CGRectMake(277, Imageview.frame.size.height, 35, 35);
                
            }
            else if (screenHeight == 667)
            {
                profile_picture = [[UIImageView alloc] initWithFrame:CGRectMake(275, 49, 35, 35)];
                profile_picture.backgroundColor = [UIColor lightGrayColor];
                profile_picture.layer.cornerRadius = profile_picture.frame.size.width/2;
                profile_picture.layer.borderColor = [UIColor whiteColor].CGColor;
                profile_picture.layer.borderWidth = 0.0f;
                profile_picture.clipsToBounds = YES;
                [cell.contentView addSubview:profile_picture];
                
                Imageview=[[UIImageView alloc]initWithFrame:CGRectMake(30 ,40, 300, 80)];
                Imageview.image=[UIImage imageNamed:@"yellow-message-bg.png"];
                [cell.contentView addSubview:Imageview];
                
                camera_image = [[UIImageView alloc] initWithFrame:CGRectMake(120,5, 60, 70)];
                camera_image.layer.cornerRadius=5;
                camera_image.clipsToBounds=YES;
                
                camera_image.imageURL=[NSURL URLWithString:[[sortedArray objectAtIndex:indexPath.row] valueForKey:@"message"]];
                url = [NSString stringWithFormat:@"%@",[[sortedArray objectAtIndex:indexPath.row] valueForKey:@"message"]];
                ImageButton.tag = indexPath.row;
                [ImageButton addTarget:self action:@selector(ImageButtn:) forControlEvents:UIControlEventTouchUpInside];
                camera_image.contentMode=UIViewContentModeScaleAspectFit;
                ImageButtn = [[UIButton alloc] initWithFrame:CGRectMake(140,10, 150, 140)];
                ImageButtn.tag = indexPath.row;
                [cell.contentView addSubview:ImageButtn];
                
                
                [Imageview addSubview:camera_image];
                [cell.contentView addSubview:ImageButton];
                
                ImageButton.tag = indexPath.row;
                
                namelbl=[[UILabel alloc] init];
                namelbl.frame = CGRectMake(8, 10, 100, 15);
                namelbl.backgroundColor = [UIColor clearColor];
                namelbl.textColor = [UIColor blackColor];
                namelbl.font=[UIFont fontWithName:@"Helvetica" size:12.0];
                [Imageview addSubview:namelbl];
                
                
                NameButton=[[UIButton alloc] init];
                NameButton.frame = CGRectMake(20,50, 100, 15);
                NameButton.backgroundColor = [UIColor clearColor];
                NameButton.titleLabel.textColor = [UIColor clearColor];
                NameButton.titleLabel.font=[UIFont fontWithName:@"Helvetica" size:12.0];
                NameButton.titleLabel.textAlignment = NSTextAlignmentRight;
                [NameButton addTarget:self action:@selector(openprofile) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:NameButton];
                namelbl.text=[chatter_name objectAtIndex:indexPath.row];
                
                NSString *strLocalTime = [sortedArray valueForKey:@"chat_time"][indexPath.row];
                timeLbl1 = [[UILabel alloc]init];
                timeLbl1.backgroundColor = [UIColor clearColor];
                timeLbl1.textColor = [UIColor blackColor];
                timeLbl1.textAlignment = NSTextAlignmentCenter;
                timeLbl1.font=[UIFont fontWithName:@"Helvetica" size:12.0];
                timeLbl1.text = strLocalTime;
                timeLbl1.frame = CGRectMake(140,Imageview.frame.size.height+40,140,10);
                namelbl.text=[chatter_name objectAtIndex:indexPath.row];
                [cell.contentView addSubview:timeLbl1];
                
                NSMutableArray * result= [[NSMutableArray alloc]init];
                result=[sortedArray valueForKey:@"user_pic"];
                profile_picture.imageURL=[NSURL URLWithString:[result objectAtIndex:indexPath.row]];
                
                profile_picture.frame=CGRectMake(277, Imageview.frame.size.height, 35, 35);
                
                
            }
        
        }
        
    else if([[arr_msg_type objectAtIndex:indexPath.row]isEqualToString:@"text"])
        
      {
            CGRect screenRect = [[UIScreen mainScreen] bounds];
            CGFloat screenHeight = screenRect.size.height;
            if(screenHeight == 568)
            {
            profile_picture = [[UIImageView alloc] initWithFrame:CGRectMake(275, 49, 35, 35)];
            profile_picture.backgroundColor = [UIColor lightGrayColor];
            profile_picture.layer.cornerRadius = profile_picture.frame.size.width/2;
            profile_picture.layer.borderColor = [UIColor whiteColor].CGColor;
            profile_picture.layer.borderWidth = 0.0f;
            profile_picture.clipsToBounds = YES;
            [cell.contentView addSubview:profile_picture];
            
            
            arrowImgVw = [[UIImageView alloc] initWithFrame:CGRectMake(56, 8, 15, 15)];
            [cell.contentView addSubview:arrowImgVw];
            msgLblContainer = [[UIView alloc] initWithFrame:CGRectMake(70, 25, 245, 40)];
            [cell.contentView addSubview:msgLblContainer];
            [cell.contentView bringSubviewToFront:arrowImgVw];
            
            
            personImgVw = [[UIImageView alloc]init];
            personImgVw.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:personImgVw];
            
            
            namelbl=[[UILabel alloc] init];
            namelbl.backgroundColor = [UIColor clearColor];
            namelbl.textColor = [UIColor blackColor];
            namelbl.font=[UIFont fontWithName:@"Helvetica" size:12.0];
            namelbl.textAlignment = NSTextAlignmentCenter;
            [msgLblContainer addSubview:namelbl];
            
            
            
            
            msgLbl = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 230, 30)];
            msgLbl.backgroundColor = [UIColor clearColor];
            msgLbl.textAlignment = NSTextAlignmentLeft;
            msgLbl.font = [UIFont fontWithName:@"Verdana" size:13.0];
            msgLbl.textColor = [UIColor darkGrayColor];
            [msgLblContainer addSubview:msgLbl];
            
            timeLbl=[[UILabel alloc] init];
            timeLbl.backgroundColor = [UIColor clearColor];
            timeLbl.textColor = [UIColor blackColor];
            timeLbl.textAlignment = NSTextAlignmentCenter;
            timeLbl.font=[UIFont fontWithName:@"Helvetica" size:12.0];
            
            [cell.contentView addSubview:timeLbl];

            CGSize size = [[sortedArray valueForKey:@"message"][indexPath.row] sizeWithFont:msgLbl.font constrainedToSize:CGSizeMake(225, 99999)];
            
            NSString *strLocalTime = [sortedArray valueForKey:@"chat_time"][indexPath.row];
            //NSLog(@"strLocalTime:=%@",strLocalTime);
            [heightarray addObject:[NSString stringWithFormat:@"%f",size.height]];
            [[NSUserDefaults standardUserDefaults] setObject:heightarray forKey:@"HGTARY"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            timeLbl.text=strLocalTime;
            timeLbl.backgroundColor=[UIColor clearColor];
            
            namelbl.frame = CGRectMake(15, 5, 200, 15);
            namelbl.textAlignment=NSTextAlignmentLeft;
            timeLbl.textAlignment=NSTextAlignmentLeft;

            msgLbl.numberOfLines = size.height/msgLbl.font.lineHeight;
            msgLbl.frame = CGRectMake(5, 20, size.width+10, size.height+10);
            msgLbl.text =  [sortedArray valueForKey:@"message"][indexPath.row];
//
//            if ([messages objectAtIndex:indexPath.row] == [NSNull null])
//            {
//                profile_picture.image = [UIImage imageNamed:@"userwithimg.png"];
//            }
//            else
//            {
                NSMutableArray * result= [[NSMutableArray alloc]init];
                result=[sortedArray valueForKey:@"user_pic"];
                
                // NSLog(@"%@",result);
                profile_picture.imageURL=[NSURL URLWithString:[result objectAtIndex:indexPath.row]];
//            }
            
        msgLblContainer.frame = CGRectMake(20,40,260,msgLbl.frame.size.height+20);

        timeLbl.frame = CGRectMake(25,msgLblContainer.frame.size.height+40,180,10);

        personImgVw.frame=CGRectMake(msgLblContainer.frame.size.width+20, 50, 5, 9);

        if(msgLbl.numberOfLines == 1)
        msgLblContainer.frame = CGRectMake(20,40,260,msgLbl.frame.size.height+20);
            
        profile_picture.frame=CGRectMake(275, msgLbl.frame.size.height+20, 35, 35);

        //personImgVw.image=[UIImage imageNamed:@"yellowarrow@2x.png"];

        UIGraphicsBeginImageContext(msgLblContainer.frame.size);
        [[UIImage imageNamed:@"yellow-message-bg.png"] drawInRect:msgLblContainer.bounds];

        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();

        msgLblContainer.backgroundColor = [UIColor colorWithPatternImage:image];

                namelbl.text=[chatter_name objectAtIndex:indexPath.row];
                
            }
          else if (screenHeight == 667)
        {
            
            profile_picture = [[UIImageView alloc] initWithFrame:CGRectMake(275, 49, 35, 35)];
            profile_picture.backgroundColor = [UIColor lightGrayColor];
            profile_picture.layer.cornerRadius = profile_picture.frame.size.width/2;
            profile_picture.layer.borderColor = [UIColor whiteColor].CGColor;
            profile_picture.layer.borderWidth = 0.0f;
            profile_picture.clipsToBounds = YES;
            [cell.contentView addSubview:profile_picture];
            
            
            arrowImgVw = [[UIImageView alloc] initWithFrame:CGRectMake(56, 8, 15, 15)];
            [cell.contentView addSubview:arrowImgVw];
            msgLblContainer = [[UIView alloc] initWithFrame:CGRectMake(70, 25, 285, 40)];
            [cell.contentView addSubview:msgLblContainer];
            [cell.contentView bringSubviewToFront:arrowImgVw];
            
            
            personImgVw = [[UIImageView alloc]init];
            personImgVw.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:personImgVw];
            
            
            namelbl=[[UILabel alloc] init];
            namelbl.backgroundColor = [UIColor clearColor];
            namelbl.textColor = [UIColor blackColor];
            namelbl.font=[UIFont fontWithName:@"Helvetica" size:12.0];
            namelbl.textAlignment = NSTextAlignmentCenter;
            [msgLblContainer addSubview:namelbl];
            
            
            
            
            msgLbl = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 270, 30)];
            msgLbl.backgroundColor = [UIColor clearColor];
            msgLbl.textAlignment = NSTextAlignmentLeft;
            msgLbl.font = [UIFont fontWithName:@"Verdana" size:13.0];
            msgLbl.textColor = [UIColor darkGrayColor];
            [msgLblContainer addSubview:msgLbl];
            
            timeLbl=[[UILabel alloc] init];
            timeLbl.backgroundColor = [UIColor clearColor];
            timeLbl.textColor = [UIColor blackColor];
            timeLbl.textAlignment = NSTextAlignmentCenter;
            timeLbl.font=[UIFont fontWithName:@"Helvetica" size:12.0];
            
            [cell.contentView addSubview:timeLbl];
            
            CGSize size = [[sortedArray valueForKey:@"message"][indexPath.row] sizeWithFont:msgLbl.font constrainedToSize:CGSizeMake(225, 99999)];
            
            NSString *strLocalTime = [sortedArray valueForKey:@"chat_time"][indexPath.row];
            //NSLog(@"strLocalTime:=%@",strLocalTime);
            [heightarray addObject:[NSString stringWithFormat:@"%f",size.height]];
            [[NSUserDefaults standardUserDefaults] setObject:heightarray forKey:@"HGTARY"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            timeLbl.text=strLocalTime;
            timeLbl.backgroundColor=[UIColor clearColor];
            
            namelbl.frame = CGRectMake(15, 5, 200, 15);
            namelbl.textAlignment=NSTextAlignmentLeft;
            timeLbl.textAlignment=NSTextAlignmentLeft;
            
            msgLbl.numberOfLines = size.height/msgLbl.font.lineHeight;
            msgLbl.frame = CGRectMake(5, 20, size.width+10, size.height+10);
            msgLbl.text =  [sortedArray valueForKey:@"message"][indexPath.row];
            //
            //            if ([messages objectAtIndex:indexPath.row] == [NSNull null])
            //            {
            //                profile_picture.image = [UIImage imageNamed:@"userwithimg.png"];
            //            }
            //            else
            //            {
            NSMutableArray * result= [[NSMutableArray alloc]init];
            result=[sortedArray valueForKey:@"user_pic"];
            
            // NSLog(@"%@",result);
            profile_picture.imageURL=[NSURL URLWithString:[result objectAtIndex:indexPath.row]];
            //            }
            
            msgLblContainer.frame = CGRectMake(20,40,300,msgLbl.frame.size.height+20);
            
            timeLbl.frame = CGRectMake(25,msgLblContainer.frame.size.height+40,180,10);
            
            personImgVw.frame=CGRectMake(msgLblContainer.frame.size.width+20, 50, 5, 9);
            
            if(msgLbl.numberOfLines == 1)
                msgLblContainer.frame = CGRectMake(20,40,300,msgLbl.frame.size.height+20);
            
            profile_picture.frame=CGRectMake(320, msgLbl.frame.size.height+20, 35, 35);
            
            //personImgVw.image=[UIImage imageNamed:@"yellowarrow@2x.png"];
            
            UIGraphicsBeginImageContext(msgLblContainer.frame.size);
            [[UIImage imageNamed:@"yellow-message-bg.png"] drawInRect:msgLblContainer.bounds];
            
            UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            msgLblContainer.backgroundColor = [UIColor colorWithPatternImage:image];
            
            namelbl.text=[chatter_name objectAtIndex:indexPath.row];
            
            
        }
    }
        
    }

    return cell;
}

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    
    if ([[[sortedArray valueForKey:@"message_type"]objectAtIndex:indexPath.row]isEqualToString:@"image"])
    {
        height=150;
    }
    
 else if ([[[sortedArray valueForKey:@"message_type"]objectAtIndex:indexPath.row]isEqualToString:@"text"])
    {
        NSString* msg = [[sortedArray objectAtIndex:indexPath.row]valueForKey:@"message"];
        CGRect rect = [msg boundingRectWithSize:CGSizeMake(225, 99999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:myfont size:13]} context:nil];
        CGSize size = rect.size;
        height = 50.0 + size.height + 40.0;
        if(height < 80)
        {
            height = 80;
        }
    }
    return height;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [chattable endEditing:YES];
    [_txtx_view resignFirstResponder];
}


- (IBAction)send_message:(id)sender
{
 
if (item == 1)
    
{
    camera_pop_up.hidden=YES;
    
    NSURL *urli = [NSURL URLWithString:[NSString stringWithFormat:@"http://dev414.trigma.us/serv/Webservices/chat?"]];
    NSString * str = [NSString stringWithFormat:@"sender_id=%@&receiver_id=%@&page=1&message=%@&type=image",[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"],self.str_serviceProviderId,encryptedString];
    NSLog(@"%@",str);
    NSData * postData = [str dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:urli];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSError * error = nil;
    NSURLResponse * response = nil;
    //    NSURLConnection * connec = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSDictionary* json;
    if(data)
    {
        json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    }
    
    NSLog(@"%@",response);
    NSLog(@"%@",json);
    
    
    _txtx_view.text=nil;
    
    [self retrivechat];
    [chattable reloadData];
    
    item=0;
    
    
    }

   else
   {
    if (_txtx_view.text==0) {
        
    }
    else
    {
    NSURL *urli = [NSURL URLWithString:[NSString stringWithFormat:@"http://dev414.trigma.us/serv/Webservices/chat?"]];
    NSString * str = [NSString stringWithFormat:@"sender_id=%@&receiver_id=%@&page=1&message=%@&type=text",[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"],self.str_serviceProviderId,_txtx_view.text ];
    NSLog(@"%@",str);
    NSData * postData = [str dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:urli];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSError * error = nil;
    NSURLResponse * response = nil;
    //    NSURLConnection * connec = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSDictionary* json;
    if(data)
    {
        json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    }
    
    NSLog(@"%@",response);
    NSLog(@"%@",json);
    }
    
    
    _txtx_view.text=nil;

        [self retrivechat];
        [chattable reloadData];
        
   }
    
}
-(IBAction)open_View
{
    
    [_photo_view setHidden:NO];
    [camera_pop_up setHidden:NO];
}

-(IBAction) getPhoto:(id) sender
{
    UIImagePickerController *picker1 = [[UIImagePickerController alloc]init];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        if (picker1 == nil)
        {
            picker1 = [[UIImagePickerController alloc] init];
            picker1.allowsEditing = NO;
        }
        picker1.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker1.delegate = self;
        [self presentViewController:picker1 animated:YES completion:nil];
    }
}

-(IBAction)camera:(id) sender
{
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
	picker.delegate = self;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType =  UIImagePickerControllerSourceTypeCamera;
        picker.allowsEditing = NO;
        [self presentViewController:picker animated:YES completion:nil];
    }
    
    
}
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary*)info
{
    dataImage = UIImageJPEGRepresentation([info objectForKey:@"UIImagePickerControllerOriginalImage"],.1);
    
    encryptedString = [dataImage base64EncodedStringWithOptions:0];
    
    [_photo_view setHidden:YES];
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
     item=1;
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self performSelector: @selector(send_message:) withObject:self afterDelay: 0.0];
}


-(IBAction)canclee
{
    [_photo_view setHidden:YES];
    [camera_pop_up setHidden:YES];
    
}

-(void)buttonAction:(UIButton *)sender
{
    NSLog(@"%ld",(long)sender.tag);
    item = 2;
    stickername = [NSString stringWithFormat:@"sticker%ld",(long)sender.tag];
    [self performSelector: @selector(send_message:) withObject:self afterDelay: 0.0];
    [_photo_view setHidden:YES];
    [_sticker_view setHidden:YES];
}


- (IBAction)HideImage:(id)sender
{
    ShowImageView.hidden = YES;
    //   [ShowImageView removeFromSuperview];
    
    //    [UIView animateWithDuration:0.5 animations:^{
    //        ShowImageView.alpha = 0;
    //    } completion: ^(BOOL finished) {//creates a variable (BOOL) called "finished" that is set to *YES* when animation IS completed.
    //        ShowImageView.hidden = finished;//if animation is finished ("finished" == *YES*), then hidden = "finished" ... (aka hidden = *YES*)
    //    }];
    
}


- (void)ImageButtn:(UIButton *)Sender
{
    ShowImageView.hidden = NO;
    [self.view bringSubviewToFront:ShowImageView];
    NSLog(@"%@",sortedArray);
    NSLog(@"%@",url);
 //   ShowImage.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%@",url]];
    
    ShowImage.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[sortedArray objectAtIndex:[Sender tag]] valueForKey:@"user_pic"]]];
    
    //    ShowImageView.alpha = 0;
    //    [UIView animateWithDuration:0.5 animations:^{
    //        ShowImageView.alpha = 1;
    //    }];
    
    
}


-(void)ImageButton:(UIButton *)btn
{
    NSLog(@"%ld",(long)btn.tag);
    NSLog(@"IMAGEBUTTON PRESSED");
    
}



-(void)scrollToBottom
{
    CGFloat yOffset = 0;
    if (chattable.contentSize.height > chattable.bounds.size.height)
    {
        yOffset = chattable.contentSize.height - chattable.bounds.size.height;
    }
    
    [chattable setContentOffset:CGPointMake(0, yOffset) animated:NO];
}




/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
//static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 166;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.1;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.2;
double animatedDistance;



-(void)textViewDidBeginEditing:(UITextView *)textView
{
    NSLog(@"begin");
    
    
    CGRect textFieldRect = [self.view.window convertRect:self.view.bounds fromView:self.view];
    CGRect viewRect = [self.view.window convertRect:self.view.bounds fromView:self.view];
    
    CGFloat midline = textFieldRect.origin.y + 3.0 * textFieldRect.size.height;
    CGFloat numerator = midline - viewRect.origin.y - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator = (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION) * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    
    if(heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if(heightFraction > 1.0)
    {
        heightFraction = 1.0;
    }
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        if(orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown)
        {
            animatedDistance = floor(215 * heightFraction);
        }
        else
        {
            animatedDistance = floor(215 * heightFraction);
        }
    }
    
    else
    {
        if(orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown)
        {
            animatedDistance = floor(225 * heightFraction);
        }
        else
        {
            animatedDistance = floor(225 * heightFraction);
        }
        
        
    }
    
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
    
    
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    
    
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
    
    
}
- (IBAction)demotest:(id)sender
{
    [self viewDidLoad];
}



@end
