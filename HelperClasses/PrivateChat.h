//
//  PrivateChat.h
//  Havoc
//
//  Created by Preeti Malhotra on 7/26/14.
//  Copyright (c) 2014 Preeti Malhotra. All rights reserved.
//

#import "ViewController.h"
BOOL CHANNEL,PRIVATE;
@interface PrivateChat : UIViewController<UIScrollViewDelegate,UITextViewDelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UIImagePickerControllerDelegate>
{
    
    
    IBOutlet UIScrollView *tempScrollView;
    NSDictionary *json,*json1;
    NSMutableArray *messages,*chatter_name;
    NSArray *sortedArray ;
    CGRect frame;
    NSMutableArray *string_chat;
    NSString *str_chat;
    UIView* msgLblContainer;
    UIView* msgLblContainer1;
    UILabel* msgLbl;
    NSString *str_member_id,*user_idd;
     NSMutableArray *heightarray;
    IBOutlet UIView *bottom_view;
    
    NSString *str_friend_id;
    
    IBOutlet UILabel *title_name;
    IBOutlet UIImageView *top_pro_pic;
    
    UIImageView *Imageview;
    NSMutableArray *arr_msg_type;
    UIButton *ImageButton;
    UIImageView *arrowImgVw;
    UILabel *namelbl;
    UIButton *NameButton;
    UILabel *timeLbl;
    UILabel *timeLbl1;
    UILabel *timeLbl2;
    UIImageView *personImgVw;
      float height;
    int item;
    NSString *encryptedString;
    IBOutlet UITableView *chattable;
    NSData *dataImage;
   // IBOutlet UIButton *btn;
    
    IBOutlet UIView *ShowImageView;
    IBOutlet UIView *camera_pop_up;
    UIImageView *camera_image;
    NSString *stickername;
    
    IBOutlet UIImageView *ShowImage;
    NSString *url;
    UIButton *ImageButtn;
    UIImageView *profile_picture;
    
}
@property (strong, nonatomic)  NSString *str_serviceProviderId;


@property (strong, nonatomic) IBOutlet UIScrollView *sticker_scroll_view;
@property (strong, nonatomic) IBOutlet UIView *sticker_view;
@property (weak, nonatomic) IBOutlet UIView *bottom_View;
- (IBAction)send_message:(id)sender;

@property (strong, nonatomic) IBOutlet UITextView *txtx_view;

@property (strong, nonatomic) IBOutlet UIView *Noushad_cameraView;

@property (weak, nonatomic) IBOutlet UIButton *cancle_btn;
@property (weak, nonatomic) IBOutlet UIView *photo_view;
@property (weak, nonatomic) IBOutlet UIButton *capture_btn;
@property (weak, nonatomic) IBOutlet UIButton *open_galary_btn;


@end
