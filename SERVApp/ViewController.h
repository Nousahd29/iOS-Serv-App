//
//  ViewController.h
//  SERVApp
//
//  Created by Surender Kumar on 22/01/15.
//  Copyright (c) 2015 trigma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController



@property(nonatomic,strong)IBOutlet UIButton *radioBtn_serviceProvide;
@property(nonatomic,strong)IBOutlet UIButton *radioBtn_customer;
@property(nonatomic,strong)IBOutlet UIImageView *image_serviceProvide;
@property(nonatomic,strong)IBOutlet UIImageView *image_customer;
@property (nonatomic, strong)   NSString                *str_userType;



@property(nonatomic,strong)IBOutlet UIView *view_popUp;



@end

