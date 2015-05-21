//
//  JobDetailsViewController.h
//  ServApp_provider
//
//  Created by TRun ShRma on 12/02/15.
//  Copyright (c) 2015 Tarun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JobDetailsViewController : UIViewController
{
    IBOutlet UIImageView *StatusBackgroundImage;
    IBOutlet UIButton *CloseViewButton;
    IBOutlet UIView *ChangeStatusView;
    NSString *str_jobStatus;
}

@property (strong, nonatomic) IBOutlet UIButton *option_btnOne;
@property (strong, nonatomic) IBOutlet UIButton *option_btntwo;
@property (strong, nonatomic) IBOutlet UIButton *option_btnthree;
@property(nonatomic,strong)IBOutlet UIImageView *image_completed;
@property(nonatomic,strong)IBOutlet UIImageView *image_underProcess;
@property(nonatomic,strong)IBOutlet UIImageView *image_pending;

@property (strong, nonatomic) IBOutlet UILabel *lbl_coterogy;
@property (strong, nonatomic) IBOutlet UILabel *lbl_requestTime;
@property (strong, nonatomic) IBOutlet UILabel *lbl_requestDate;
@property (strong, nonatomic) IBOutlet UILabel *lbl_location;
@property (strong, nonatomic) IBOutlet UILabel *lbl_contactNo;
@property (strong, nonatomic) IBOutlet UITextView *txtView_description;

@property (strong, nonatomic) IBOutlet UILabel *lbl_status;
@property(strong ,nonatomic) NSString *str_categoryID;





@end
